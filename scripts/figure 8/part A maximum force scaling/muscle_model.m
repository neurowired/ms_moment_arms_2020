% Muscle model
% - activation contraction coupling
% - force-length model
% - force-velocity model (fFVCE)
% - passive element model (fFLpassive)


function nF = muscle_model(nA,nL,nROM,nFmax,dt,nFpass,nLpass,msgHeader,varargin)
% global hFigDebug
global DF % used for sending to dragonfly if sending
persistent fFVCE fFLpassive nL_prev dt_stack ndL_stack nStack indStack nTime currentSerial

in.bDebug       = 0;
in.bDebugWrite  = 0;
in.hFileDebug   = [];
in.bPlot        = 0;
if ~isempty(varargin)
    for i = 1:numel(varargin)/2
        in.(varargin{(i-1)*2+1}) = varargin{i*2};
    end
end

if isempty(nL_prev) % first run
    nStack    = 30;
    nL_prev = nL;
    dt_stack = dt*ones(1,nStack);
    ndL_stack = zeros(numel(nFmax),nStack);
    indStack = 0;
    a       = .2;
    b       = -4.25; % force velocity constants
    fFVCE   = @(x) ((1-a*(x>0)).*(1-exp(b*x/10))./(1+exp(b*x/10)))+1; % Force Velocity function

    % NOTE: x/10 scaling converts the domain of velocities
    %   from [-1 1] [nu] to [-10 10] [RL/s]

    % FORCE-VELOCITY CHECK
    %     nV = -10:.1:10;
    %     figure;
    %     plot(nV,fFVCE(nV),'-')
    %     xlabel('Velocity (RL/s)')
    %     ylabel('Force (nu)')
    nLPassPrev = nLpass;
    c       = ((nLpass-nROM(:,1))./(nROM(:,2)-nROM(:,1)));
    d       = 2; % passive force constants
    fFLpassive = @(x) (exp(d*(x-c))-1)/(exp(1)-1).*(x>=c); % Passive Force function
    fFLpassive2     = @(x) (exp((x-nLpass)./(nROM(:,2)-nLpass))-1)/(exp(1)-1).*(x>=nLpass);
    nTime   = 0;
    currentSerial = -1;
end

% added posibility of changing when the passive muscle force kicks in
% only change the passive muscle force function when there is a live change
% in the passive length kick in
% if sum(nLPassPrev-nLpass) ~= 0
%     c       = ((nLpass-nROM(:,1))./(nROM(:,2)-nROM(:,1)));
%     d       = 2; % passive force constants
%     fFLpassive = @(x) (exp(d*(x-c))-1)/(exp(1)-1).*(x>=c); % Passive Force function
%     nLPassPrev = nLpass;
% end


RL        	= (nROM(:,1)+nROM(:,2))/2;

if dt < 0.003 % neglect data values with step time over this (should not happen) causes bad data
    dt_stack(indStack+1)        = dt;
    ndL_stack(:, indStack+1)    = (nL-nL_prev); % change in length in RL
    nL_prev                     = nL;
    indStack                    = mod(indStack + 1, nStack);
end

nTime       = nTime+dt;

nV          = mean(ndL_stack,2)./RL/mean(dt_stack); % find muscle velocity [RL/s]
% nV                      = (nL-nL_prev)./RL/dt; % find muscle velocity [RL]

% Calcualte muscle force \
% HZL excitation-contraction coupling, force-length, force-velocity,
% and passive tissue model functions
nL_01                   = (nL-nROM(:,1))./(nROM(:,2)-nROM(:,1));
if sum(nL_01>1)>0
   warning(['muscle length range error ',num2str(find(nL_01'>1))])
    nL_01(nL_01>1)      = 0.999;
end

nFpassAct = fFLpassive(nL_01);
% nFpassAct = fFLpassive2(nL);
nFpassAct(nFpassAct>2)=2;

nFV             = fFVCE(nV);
nFL             = 2*nL_01.*(nL_01<=.5) + (.5*(nL_01-.5)+1).*(nL_01>.5);
nF_CE           = nA.*nFmax.*nFL.*nFV;
% nF_CE       = nA.*nFmax.*nFL;
nFP             = nFpass.*nFpassAct;
% nFP         = 0;
nF              = nF_CE + nFP;

if sum(nF<0)>0
   warning(['negative force ',num2str(find((nF'<0)))])
end

if in.bDebug
    if in.bDebugWrite
        fwrite(in.hFileDebug,[nTime;nL;nV;nFV;nFL;nF_CE;nFP],'double');
    end
    if in.bPlot
         if (~mod(msgHeader.serial_no,5)) && (msgHeader.serial_no ~= currentSerial) %Send at 100hz
            msg         = DF.MDF.MJC_FORCE_DEBUG;
            msg.header  = msgHeader;
            msg.nL_RL   = nL./RL;
            msg.nV      = single(nV');
            msg.nFV     = single(nFV');
            msg.nFL     = nFL';
            msg.nF_CE   = nF_CE';
            msg.nFP     = nFP';
            msg.t       = single(nTime);
            MT          = EnsureNumericMessageType('MJC_FORCE_DEBUG');
            %             SendMessage( MT, msg);
            UnsafeSendMessage( MT, msg);
            currentSerial = msgHeader.serial_no;
        end
    end
end


