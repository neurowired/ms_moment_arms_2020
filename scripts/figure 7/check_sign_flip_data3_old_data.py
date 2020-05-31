#python3
import numpy
import pylab
import scipy.io
import os.path
import sys
import csv

# # Arm Paths
DATA_DIRNAME = 'Old Model Data'

muscle2data_fname = lambda x: x + 'MomentArm.mat'

def muscleid2name(muscleid):
    # with open(os.path.join(sMusclepath, 'leg_metaMuscle_copy.csv')) as f:
    with open('arm_metaMuscle.csv') as f:
        fd = csv.DictReader(f)
        for line in fd:
            if int(line['idMuscle'].split()[0]) == muscleid:
                return line['sMuscle']
    raise ValueError('Incorrect muscle id supplied')


def analyze_muscle(filedata, dof_constraints={}):
    x = filedata['metaData']['nDOF'][0][0]
    x = x.tolist()

    mom_arms = [i for i in filedata['metaData']['nMomArm'][0][0]]
    sDOFlist = list(str(i[0]) for i in filedata['metaData']['sDOFlist'][0][0][0])

    contraintsubset = [key for key in dof_constraints.keys() if key in sDOFlist]
    cs_idxs = [sDOFlist.index(key) for key in contraintsubset]
    def topop(xv):
        if len(contraintsubset) < 1:
            return False
        for cs, cs_idx in zip(contraintsubset, cs_idxs):
            if abs(xv[cs_idx] - dof_constraints[cs]) > 1e-4:
                return True
            # else:
            #     print(cs, cs_idx, dof_constraints[cs], xv[cs_idx])
        return False

    if len(dof_constraints.items()) > 0:
        for i in reversed(range(len(x))):
            if topop(x[i]):
                x.pop(i)
                mom_arms.pop(i)

    num_zerocross = 0
    crossing_avg = []
    crossing_avg_desc = []
    for i, dof in enumerate(sDOFlist):
        # if dof in contraintsubset:
        #     continue
        mom_arm = [j[i] for j in mom_arms]
        min_val = min(mom_arm)
        min_ind = mom_arm.index(min_val)
        max_val = max(mom_arm)
        max_ind = mom_arm.index(max_val)
        if min_val * max_val < 0:
            print('\t{} {}'.format(i, dof))
            print('\t\tmin_val = {}, max_val = {}'.format(min_val, max_val))
            print('\t\tat points:')
            sl = '\t\t'
            smi = '\t\tmin'
            sma = '\t\tmax'
            for j in range(len(sDOFlist)):
                # if sDOFlist[j] in contraintsubset:
                #     continue
                sl += '\t{:10s}'.format(sDOFlist[j])
                smi += '\t{:>+10.6f}'.format(x[min_ind][j]*180/3.14)
                sma += '\t{:>+10.6f}'.format(x[max_ind][j]*180/3.14)
            print(sl)
            print(smi)
            print(sma)
            num_zerocross += 1

            minpos = min([(i if i >= 0 else numpy.inf) for i in mom_arm])
            maxneg = max([(i if i <= 0 else -numpy.inf) for i in mom_arm])
            minpos_i = mom_arm.index(minpos)
            maxneg_i = mom_arm.index(maxneg)

            minpos_x = x[minpos_i][i]
            maxneg_x = x[maxneg_i][i]

            minrom = min(xi[i] for xi in x)
            rom = max(xi[i] for xi in x) - minrom

            crossing_avg.append(((minpos_x+maxneg_x)/2. - minrom) / rom)
            crossing_avg_desc.append(dof)

    return (num_zerocross, crossing_avg, crossing_avg_desc)


def main():
    # muscle_ids = [5]
    # muscle_ids = [27, 28, 29]
    # muscle_ids = [42, 43, 44, 45, 46]
    muscle_ids = list(range(24, 53))

    dof_constraints = {
        # 'RA2R_RA3M_Z': 0,
        # 'RA2R_RA3M_X': 0,
    }

    print('Constraining following DOFs to the values:')
    for k, i in dof_constraints.items():
        print('\t{}: {}'.format(k, i))

    muscle_names = [muscleid2name(i) for i in muscle_ids]
    muscle_fnames = [
        os.path.join(DATA_DIRNAME, muscle2data_fname(muscleid2name(i)))
        for i in muscle_ids]

    print(muscle_fnames)

    num_zerocross = 0
    crossing_avg = []
    crossing_avg_desc = []
    for muscle_name, muscle_fname in zip(muscle_names, muscle_fnames):
        print(muscle_name)
        filedata = scipy.io.loadmat(muscle_fname)
        buf = analyze_muscle(filedata, dof_constraints)
        num_zerocross += buf[0]
        crossing_avg += buf[1]
        crossing_avg_desc += [muscle_name+' '+i for i in buf[2]]
    print('Total number of zero crossings: {}'.format(num_zerocross))
    for ca, cad in zip(crossing_avg, crossing_avg_desc):
        print('{}: {}'.format(cad, ca))

    print('Crossing of zero in terms of rom percent: {}'.format(crossing_avg))
    pylab.figure()
    pylab.hist([i*100 for i in crossing_avg], color='k', bins=numpy.linspace(0, 100, 21))
    pylab.xlim([0, 100])
    pylab.ylim([0, 6])
    pylab.xlabel('Position of zero crossing, %% of ROM')
    pylab.ylabel('Number of crossings')
    pylab.show()



if __name__ == '__main__':
    main()
