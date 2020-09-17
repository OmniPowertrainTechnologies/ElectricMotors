%% Vehicle static simulation
clc; close all;
clearvars;
load('..\motorData\motorData.mat')
%[file, path] = uigetfile('..\..\Customer_Related\*.xlsx');
% prompt = {'rpm-torque duty cycle? - yes/no','Simulate gear ratio? - yes/no'};
% dlgtitle = 'Input';
% dims = [1 35];
% definput = {'yes','yes'};
% answer = inputdlg(prompt,dlgtitle,dims,definput);
[settings, button] = settingsdlg(...
    'Description', 'This dialog will set the parameters used for motor sizing',...
    'title'      , 'Motor Sizing Option',...
    {'Customer Name';'custname'}, 'Customer 1', ...
    {'Application Name';'applname'}, 'Application Name', ...
    'separator'  , 'For High Voltage Application Only',...
    {'This is a High Voltage Application'; 'Check'}, [false true],...
    {'Max Application Voltage';'hv_volt'}, 380,...
    {'Number of Turns';'hv_not'}, 4,...
    'separator'  , 'Gear Ratio', ...
    {'I know the Gear Ratio'; 'gear_check'}, [false, true], ...
    {'Gear Ratio'; 'gearratio'}, 140, ...
    'separator'  , 'Rolling Radius', ...
    {'I know the Rolling Radius'; 'rr_check'}, [false, true], ...
    {'Rolling Radius'; 'rr'}, 0.584, ...
    'separator'  , 'Other parameters',...
    {'Number of Motors in the application';'numMotors'}, 2, ...
    {'Motor max efficiency speeed';'hefrpm'}, 2500, ...
    {'Vehicle Gross Weight [kg]';'vehmass'}, 351, ...
    {'Coefficient of Rolling Resistance';'crr'}, 0.2, ...
    {'Coefficient of Wind Drag';'cd'}, 0.32, ...
    {'Maximum Grade [%]';'grademax'}, 57 ...
    );
dutycycledata = inputdlg({'Wheel speed [rpm]', 'Vehicle Speed [m/s]', 'Grade [%]', 'Wheel Torque [Nm]', 'Motor Speed [rpm]', 'Motor Torque [Nm]'},...
    'Duty Cycle (provide any two appropriate combinations)', [1 100]);
index = find(~cellfun(@isempty,dutycycledata));
index_prod = prod(index);
%% INPUT DATA 1: inl_vehicle
massVcw             = settings.vehmass; % vehicle curbWeight, kg
gearRatio_cust      = settings.gearratio;
rpmTire_cust        = str2num(dutycycledata{1}); % rpm
velVeh_cust         = str2num(dutycycledata{2}); % m/s
grade_cust          = str2num(dutycycledata{3}); % grade(%)
torqueTire_cust     = str2num(dutycycledata{4}); % Nm
rpmmotor_cust       = str2num(dutycycledata{5}); % rpm
torquemotor_cust    = str2num(dutycycledata{6}); % Nm
Crr                 = settings.crr;     % Crr, rolling resistance
Cd                  = settings.cd;   % dragCoeffcient 0.25-0.45
gradeMax            = settings.grademax;	% max gradeability requirement in percent
if settings.rr_check
    rollradius = settings.rr; % meter
    circTire  = 2*pi*rollradius; % meter
    wheelDiaTire = 2*rollradius; % meter
else
    %% B4: COMPUTING TIRE TORQUE CONSTSNT, Cttc:
    tireWidth       = 0.2;     % tire width, meter
    tireAR          = 75;        % tire aspect ratio=(SecH/width)*100
    rimDia          = 0.45;        % rimDia -- Rim diameter, meter
    sectHeightTire     = tireWidth * (tireAR/100); % meter
    wheelDiaTire       = 2 * sectHeightTire + rimDia; % meter
    Ctif               = 0.9;  % Ctif, Tire inflation factor
    circTire           = 3.14 * Ctif * wheelDiaTire; % meter
end
revPerMeter  = 1 / circTire;
%%% Al. Vehicle Information
% vehicleModelName: fwd aerodynamic small car-2
A               = 2.5;    % frontArea, m^2
Cbas            = 0.005;     % Cbas, breaking and steering
massRemoved     = 270;       % weight removed, : engine+ehaust.., Kg
massAdded       = 135;       % Wmisc, misc weight Added, Kg

%% INPUT DATA 2: in2_electricElements
%%% Bl. Electric Components - Motor:
% motorModelName: ADC-XP1227: 28-120-8-15.5
numMotors        = settings.numMotors;
etaDrivetrain    = 0.92;   % driveTrainEfficiency @ 2500 rpm
motorRPMbestEff  = settings.hefrpm; % rpm
maxVoltMotor     = 48.0;              % motorMaxVolts;
massMot          = 9.0;               % motor mass i Kg
kWmotor          = 6.7;               % motor power in kW
maxRPMmotor      = 4500.0;             % motor Max Rpm
Kv               = 200; % half of the peak to peak emf
motorA           = 21163.0;            % motor constant A
motorB           = 0.19;               % motorconstant B
motorC           = -4664;              % motor constant C
motorD           = 192;                % motor constant D
motorK           = 0.0282;             % motor constant K
motorN           = 1.37;               % motor constant N
effMotor         = 0.94;               % motorEff
%* B2. Electric Components - Battery
% batteryModelName: Trojan T-105
voltBatt         = 6.0;      % batteryVolts
massBatt         = 25.0;     % indivisual battery wt
peukertExp       = 1.25;     % peukertExp
peukertAmps      = 200.0;	  % peukertAmps
maxAmpBatt       = 140.0;	  % batteryMaxAmps
ohmsBatt         = 0.005;	  % batteryOhms
ampHrsBatt       = 140.00;	    % batteryAmpHrs
numBatPerString  = 8;       % numPerString
numBatStrings	 = 1;          % num0fStrings
%* B3. Electric Components - Controller
% controllerModelName: Curtis 1231C-7701
minVoltController = 45;    % controller min volt
maxVoltController = 48;   % controller max volt
maxAmpController  = 140;   % controller max amps
massController    = 3;    % controller Weight, Kg
effController     = 0.95;  % controller efficiency
%* B4. Electric Components - Charger
% chargerModelName: Zivan
minVoltCharger    = 40;     % charger Min Volts
maxVoltCharger    = 48;    % charger Max Volts
maxAmpsCharger    = 50;     % charger Max Amps
massCharger       = 50;     % chargerWeight Wch

%% INPUT DATA 3: in3_environmental
% Environmental Conditions:
velWind            = 5.5;	% Uw, windSpeed, meter/sec
Crw                = 1.3;	% Crw, Relative wind factor
Ecc                = 0.139;  % vehicle energy consumption constant wh km-1 kg-1
%% B1. Calculation of Overall Vehicle Weight
massBattPack   = massBatt * numBatPerString * numBatStrings;
massTot    = massMot + massBattPack + massController + massCharger +massAdded;
massGain = massTot - massRemoved;
massNet  = massVcw + massGain;
%% B2. Battery pack overall parameters:
maxVoltBattPack  = voltBatt * numBatPerString;
maxAmpsBattPack   = maxAmpBatt * numBatStrings;
ohmsBattPack      = ohmsBatt * numBatPerString / numBatStrings;
%% B3. BATTERY PACK ENERGY & VEHICLE EPA MILEAGE
kwhBattpack      = (ampHrsBatt * numBatPerString * numBatStrings)/1000.0;
vehRangeAvg = (kwhBattpack * 1000) / (Ecc * massNet);
%Cttmf             = 840.34 / revPerMeter; % ****
%% Compute Drag forces etc
%velMax = readmatrix([path, file],'Sheet','Duty Cycle','Range','B11:B11', 'OutputType', 'double'); % max vehicle speeed meter/sec
if index_prod == 4 % wheel speed - torque
    rpmTire = rpmTire_cust;
    torqueTire = torqueTire_cust;
    velVeh = rpmTire/revPerMeter/60; % m/s
    gearRatio = motorRPMbestEff./rpmTire;
elseif index_prod == 6 % vehicle speed - grade
    velVeh = velVeh_cust; % m/s
    gradeCont = grade_cust; % grade(%)
    % Static Drag forces calculations
    phi = 45*(gradeCont/100)*pi/180;
    forceRR = (Crr + Cbas) * massNet * cos(phi); % Rolling resistance
    forceGrade  =  massNet * sin(phi); % Drag force due to grade
    % Dynamic Drag forces calculations
    forceAero    = Cd * A * velVeh .* velVeh;
    xcoeff     = velWind./velVeh;
    Crwf  = (0.98 * xcoeff.^2 + 0.6 * xcoeff) * Crw - 0.4 * xcoeff;
    forceSkinFriction    = (Crwf .* forceAero);
    forceTot  = forceRR + forceGrade + forceAero + forceSkinFriction; % N
    torqueTire = 0.5 * wheelDiaTire * forceTot; % Nm
    powerTire  = torqueTire .* velVeh * revPerMeter *2*pi; % watt
    %% Compute gear results
    % Calculaions of Motor Parameters
    rpmTire = velVeh * revPerMeter * 60;
    gearRatio = motorRPMbestEff./rpmTire;
elseif index_prod == 8 % vehicle speed - torque
    velVeh = velVeh_cust; % m/s
    rpmTire = velVeh * revPerMeter * 60;
    torqueTire = torqueTire_cust;
    gearRatio = motorRPMbestEff./rpmTire;
else
    gearRatio = gearRatio_cust;
    rpmTire = rpmmotor_cust/gearRatio;
    torqueTire = torquemotor_cust * gearRatio;
    velVeh = rpmTire/revPerMeter/60;
end
% Checking if gear ratio is provided
if settings.gear_check
    gearRatio = gearRatio_cust *ones(size(rpmTire));
end
gearRatio_all = gearRatio;
gearRatio = mean(gearRatio);   % gear ratio
rpmMotor = rpmTire * gearRatio;
torqueMotor = torqueTire /gearRatio /etaDrivetrain /numMotors; % Nm
if index_prod == 30
    rpm_motor = rpmmotor_cust;
    torqueMotor = torquemotor_cust;
end
powerMotor_mech = torqueMotor .* rpmMotor *2*pi/60/ 1000.0; % kW
currentMotor = Kv * torqueMotor / 8.3;
tempMotor = power(torqueMotor,motorB);
voltageMotor = Kv * rpmMotor;
powerMotor_elec = currentMotor .* voltageMotor / 1000.0; % kW
% Calculations of Battery-Pack Parameters
Pbp = powerMotor_elec / (effController * effMotor);
Vbpmax = voltBatt * numBatPerString;
Ibp = Pbp * 1000.0 / Vbpmax;
Rbp = ohmsBatt * numBatPerString / numBatStrings;
Vbp = Vbpmax - Rbp * Ibp;
% Calculations of Vehicle Parameters
x1 = power(Ibp,peukertExp);
IbpPkt = peukertAmps * numBatStrings;
Dvr = velVeh .* IbpPkt ./ x1;
%% gear plotting
try
histfit(gearRatio_all, length(gearRatio_all));
mu=mean(gearRatio_all);
sigma=std(gearRatio_all);
barcount_lim = [0 2];
line([mu, mu], ylim, 'Color', 'r', 'LineWidth', 1, 'LineStyle', '-.');
line([mu + sigma, mu + sigma], barcount_lim, 'Color', 'r', 'LineWidth', 1, 'LineStyle', '-.');
line([mu - sigma, mu - sigma], barcount_lim, 'Color', 'r', 'LineWidth', 1, 'LineStyle', '-.');
% Put up labels on lines
yl = barcount_lim; % Get limits of y axis so we can find a nice height for the text labels.
message = sprintf('%.1f  ', mu);
text(mu, 0.9 * yl(2), message, 'Color', 'k', 'HorizontalAlignment', 'right', 'FontSize', 15);
message = sprintf('  %.1f', mu+sigma);
text(mu+sigma, 0.9 * yl(2), message, 'Color', 'k', 'HorizontalAlignment', 'right', 'FontSize', 15);
message = sprintf('%.1f  ', mu-sigma);
text(mu-sigma, 0.9 * yl(2), message, 'Color', 'k', 'HorizontalAlignment', 'right', 'FontSize', 15);
title('Choosing a gear ratio for simulation')
xlabel('Gear Ratio')
ylabel('Count')
catch
    disp('You have chosen one gear ratio so hostogram plotting is not possible')
end
%% LV Plotting
figure;
if settings.Check == 0
    % yyaxis left
    subplot(2,1,1),
    % M13
    plot(rpm_pktq_m13, pknm_m13, 'Color',[0,0,1], 'LineStyle','--','Marker','^', 'DisplayName', 'M13_{P-Nm}'); hold on;
    plot(rpm_cttq_m13, ctnm_m13, 'Color',[0,0.5,0], 'LineStyle','--','Marker','^', 'DisplayName', 'M13_{C-Nm}');
    % M15
    plot(rpm_pktq_m15, pknm_m15, 'Color',[0.8,0.4,0], 'LineStyle','-', 'Marker','o','DisplayName', 'M15_{P-Nm}');
    plot(rpm_cttq_m15, ctnm_m15, 'Color',[0.3,0.3,0.3],'LineStyle','-','Marker','o', 'DisplayName', 'M15_{C-Nm}');
    % M17
    plot(rpm_pktq_m17, pknm_m17, 'Color',[0.75, 0, 0.75], 'LineStyle','-', 'Marker','>', 'DisplayName', 'M17_{P-Nm}');
    plot(rpm_cttq_m17, ctnm_m17, 'Color',[0.3,0.3,0.3],'LineStyle','-','Marker','>', 'DisplayName', 'M17_{C-Nm}');
    % Application
    plot(rpmMotor, torqueMotor, 'Color',[1, 0, 0], 'LineStyle','none', 'Marker','*', 'DisplayName', 'M17_{P-Nm}');
    %
    title([settings.custname,'::', settings.applname, '::', 'Torque map'], 'Interpreter', 'none')
    ylim([0 50]);
    ylabel('Torque [Nm]')
    xlabel('Motor Speed [rpm]');
    legend()
    grid('on')
    zoom('xon')
    %
    % yyaxis right
    subplot(2,1,2),
    plot(rpm_pkkw_m13, pkkw_m13, 'Color',[0,0,1], 'LineStyle','--','Marker','.', 'DisplayName', 'M13_{P-kW}'); hold on
    plot(rpm_ctkw_m13, ctkw_m13, 'Color',[0,0.5,0], 'LineStyle','--','Marker','.', 'DisplayName', 'M13_{C-kW}');
    %
    plot(rpm_pkkw_m15, pkkw_m15, 'Color',[0.8,0.4,0], 'LineStyle','-', 'Marker','o', 'DisplayName', 'M15_{P-kW}');
    plot(rpm_ctkw_m15, ctkw_m15, 'Color',[0.3,0.3,0.3],'LineStyle','-','Marker','o', 'DisplayName', 'M15_{C-kW}');
    % M17
    plot(rpm_pkkw_m17, pkkw_m17, 'Color',[0.75, 0, 0.75], 'LineStyle','-', 'Marker','>', 'DisplayName', 'M17_{P-kW}');
    plot(rpm_ctkw_m17, ctkw_m17, 'Color',[0.3,0.3,0.3],'LineStyle','-','Marker','>', 'DisplayName', 'M17_{C-kW}');
    % Application
    plot(rpmMotor, powerMotor_mech, 'Color',[1, 0, 0], 'LineStyle','none', 'Marker','*', 'DisplayName', 'Application');
    %
    ylim([0 25]);
    title([settings.custname,'::', settings.applname, '::', 'Power Map'], 'Interpreter', 'none')
    %
    ylabel('Power [kW]')
    xlabel('Motor Speed [rpm]');
    legend()
    grid('on')
    zoom('xon')
else
    %% HV plotting
    % m19
    volt_com_m19 = settings.hv_volt * ones(size(rpm_m19));
    not_com_m19 = settings.hv_not * ones(size(rpm_m19));
    pknm_m19 = fnm_m19(rpm_m19, volt_com_m19, not_com_m19);
    ctnm_m19 = pknm_m19 .* tf_m19;
    pkkw_m19 = pknm_m19.* rpm_m19 *2*pi/60/1000; 
    ctkw_m19 = ctnm_m19.* rpm_m19 *2*pi/60/1000; 
    % m21
    volt_com_m21 = settings.hv_volt * ones(size(rpm_m21));
    not_com_m21 = settings.hv_not * ones(size(rpm_m21));
    pknm_m21 = fnm_m21(rpm_m21, volt_com_m21, not_com_m21);
    ctnm_m21 = pknm_m21 .* tf_m21;
    pkkw_m21 = pknm_m21.* rpm_m21 *2*pi/60/1000; 
    ctkw_m21 = ctnm_m21.* rpm_m21 *2*pi/60/1000; 
    % m24
    volt_com_m24 = settings.hv_volt * ones(size(rpm_m24));
    not_com_m24 = settings.hv_not * ones(size(rpm_m24));
    pknm_m24 = fnm_m24(rpm_m24, volt_com_m24, not_com_m24);
    ctnm_m24 = pknm_m24.* tf_m24;
    pkkw_m24 = pknm_m24.* rpm_m24 *2*pi/60/1000; 
    ctkw_m24 = ctnm_m24.* rpm_m24 *2*pi/60/1000; 
    % m27
    volt_com_m27 = settings.hv_volt * ones(size(rpm_m27));
    not_com_m27 = settings.hv_not * ones(size(rpm_m27));
    pknm_m27 = fnm_m27(rpm_m27, volt_com_m27, not_com_m27);
    ctnm_m27 = pknm_m27.* tf_m27;
    pkkw_m27 = pknm_m27.* rpm_m27 *2*pi/60/1000; 
    ctkw_m27 = ctnm_m27.* rpm_m27 *2*pi/60/1000; 
    % m30
    volt_com_m30 = settings.hv_volt * ones(size(rpm_m30));
    not_com_m30 = settings.hv_not * ones(size(rpm_m30));
    pknm_m30 = fnm_m30(rpm_m30, volt_com_m30, not_com_m30);
    ctnm_m30 = pknm_m30.* tf_m30;
    pkkw_m30 = pknm_m30.* rpm_m30 *2*pi/60/1000; 
    ctkw_m30 = ctnm_m30.* rpm_m30 *2*pi/60/1000; 
    % m34
    volt_com_m34 = settings.hv_volt * ones(size(rpm_m34));
    not_com_m34 = settings.hv_not * ones(size(rpm_m34));
    pknm_m34 = fnm_m34(rpm_m34, volt_com_m34, not_com_m34);
    ctnm_m34 = pknm_m34.* tf_m34;
    pkkw_m34 = pknm_m34.* rpm_m34 *2*pi/60/1000; 
    ctkw_m34 = ctnm_m34.* rpm_m34 *2*pi/60/1000; 
    % 
    % M19
    subplot(2,1,1),
    plot(rpm_m19, pknm_m19, 'Color',[0,0,1], 'LineStyle','--','Marker','^', 'DisplayName', 'M19_{P-Nm}'); hold on;
    plot(rpm_m19, ctnm_m19, 'Color',[0,0.5,0], 'LineStyle','--','Marker','^', 'DisplayName', 'M19_{C-Nm}');
    % M21
    plot(rpm_m21, pknm_m21, 'Color',[0.8,0.4,0], 'LineStyle','-', 'Marker','o','DisplayName', 'M21_{P-Nm}');
    plot(rpm_m21, ctnm_m21, 'Color',[0.3,0.3,0.3],'LineStyle','-','Marker','o', 'DisplayName', 'M21_{C-Nm}');
    % M24
    plot(rpm_m24, pknm_m24, 'Color',[0.8500, 0.3250, 0.0980], 'LineStyle','-', 'Marker','*', 'DisplayName', 'M24_{P-Nm}');
    plot(rpm_m24, ctnm_m24, 'Color',[0.4940, 0.1840, 0.5560],'LineStyle','-','Marker','*', 'DisplayName', 'M24_{C-Nm}');
    % M27
    plot(rpm_m27, pknm_m27, 'Color',[0.75, 0, 0.75], 'LineStyle','-', 'Marker','>', 'DisplayName', 'M27_{P-Nm}');
    plot(rpm_m27, ctnm_m27, 'Color',[0.3,0.3,0.3],'LineStyle','-','Marker','>', 'DisplayName', 'M27_{C-Nm}');
    % Application
    plot(rpmMotor, torqueMotor, 'Color',[1, 0, 0], 'LineStyle','none', 'Marker','*', 'DisplayName', 'Application');
    %
    title([settings.custname,'::', settings.applname, '::', 'Torque map'], 'Interpreter', 'none')
    %ylim([0 500]);
    ylabel('Torque [Nm]')
    xlabel('Motor Speed [rpm]');
    legend()
    grid('on')
    zoom('xon')
    % power plot
    subplot(2,1,2),
    plot(rpm_m19, pkkw_m19, 'Color',[0,0,1], 'LineStyle','--','Marker','^', 'DisplayName', 'M19_{P-kW}'); hold on;
    plot(rpm_m19, ctkw_m19, 'Color',[0,0.5,0], 'LineStyle','--','Marker','^', 'DisplayName', 'M19_{C-kW}');
    % M21
    plot(rpm_m21, pkkw_m21, 'Color',[0.8,0.4,0], 'LineStyle','-', 'Marker','o','DisplayName', 'M21_{P-kW}');
    plot(rpm_m21, ctkw_m21, 'Color',[0.3,0.3,0.3],'LineStyle','-','Marker','o', 'DisplayName', 'M21_{C-kW}');
    % M24
    plot(rpm_m24, pkkw_m24, 'Color',[0.8500, 0.3250, 0.0980], 'LineStyle','-', 'Marker','*', 'DisplayName', 'M24_{P-kW}');
    plot(rpm_m24, ctkw_m24, 'Color',[0.4940, 0.1840, 0.5560],'LineStyle','-','Marker','*', 'DisplayName', 'M24_{C-kW}');
    % M27
    plot(rpm_m27, pkkw_m27, 'Color',[0.75, 0, 0.75], 'LineStyle','-', 'Marker','>', 'DisplayName', 'M27_{P-kW}');
    plot(rpm_m27, ctkw_m27, 'Color',[0.3,0.3,0.3],'LineStyle','-','Marker','>', 'DisplayName', 'M27_{C-kW}');
    % Application
    plot(rpmMotor, powerMotor_mech, 'Color',[1, 0, 0], 'LineStyle','none', 'Marker','*', 'DisplayName', 'Application');
    %
    title([settings.custname,'::', settings.applname, '::', 'Torque map'], 'Interpreter', 'none')
    %ylim([0 500]);
    ylabel('Power [kW]')
    xlabel('Motor Speed [rpm]');
    legend()
    grid('on')
    zoom('xon')
    
    
end

%Display of the Motor Parameters
% fprintf('d1. Tt, ft-lbs   '); fprintf('%6.0f',torqueTire(10:10:90)); fprintf('\n');
% fprintf('d2. Pt, hp       '); fprintf('%6.1f',powerTire(10:10:90)); fprintf('\n');
% fprintf('e1. Tm, ft-lbs   '); fprintf('%6.0f',torqueMotor(10:10:90)); fprintf('\n');
% fprintf('e2. Rm, rpm      '); fprintf('%6.0f',rpmMotor(10:10:90)); fprintf('\n');
% fprintf('e3. Im, amps     '); fprintf('%6.0f',currentMotor(10:10:90)); fprintf('\n');
% fprintf('e4. Vm, volts    '); fprintf('%6.0f',voltageMotor(10:10:90)); fprintf('\n');
% fprintf('e5. Pm, volts    '); fprintf('%6.1f',powerMotor(10:10:90)); fprintf('\n');
% %Display of the B-P parameters
% fprintf('f1. Pbp, kw      '); fprintf('%6.1f',Pbp(10:10:90)); fprintf('\n');
% fprintf('f2. Ibp, amps    '); fprintf('%6.0f',Ibp(10:10:90)); fprintf('\n');
% fprintf('f3. Vbp, amps    '); fprintf('%6.0f',Vbp(10:10:90)); fprintf('\n');
% % Display of vehicle parameters
% fprintf('g1. Dvr, miles   '); fprintf('%6.0f',Dvr(10:10:90)); fprintf('\n\n');
% fprintf ('PART: D, E, G, G: DYNAMIC EQUATIONS\n');
% fprintf ('D, E, F, G: TIRE, MOTOR, BAT-PACK, VEHICLE\n');
% fprintf ('Tire parameters: \n');
% fprintf ('Tt(i) = Cttmf * Ftot(i);  \n');
% fprintf ('Pt(i) = Tt(i) * Uv(i) * revPerMile / (5252 * 60); \n');
% fprintf ('Motor parameters: \n');
% fprintf ('Tm(i) = Tt(i) / (G(k) * Nd); \n');
% fprintf ('Rm(i) = Uv(i) * G(k) * revPerMile / 60;  \n');
% fprintf ('Im(i) = power(Tm(i) / motorK, 1 / motorN);  \n');
% fprintf ('Temp1 = power (Tm(i), motorB); \n');
% fprintf ('Vm(i) = (Rm(i) * motorD) / ((motorA / Tempi) + motorC);  \n');
% fprintf ('Pm(i) = Im(i) * Vm(i) / 1000.0;  \n');
% fprintf ('Battery-pack parameters: \n');
% fprintf ('Pbp(i) = Pm(i) / (Nuc * Num); \n');
% fprintf ('Ibp(i) = Pbp(i) * 1000.0 / Vbpmax;  \n');
% fprintf ('Vbp(i) = Vbpmax - Rbp * Ibp(i);  \n');
% fprintf ('Vehicle parameters:  \n');
% fprintf ('x1 = power(Ibp(i), peukertExp); \n');
% fprintf ('Dvr(i) = Uv(i) * Ibppkt / x1; \n');
