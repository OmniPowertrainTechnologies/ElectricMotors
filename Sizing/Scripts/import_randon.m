%% Plot Randon data
close all;
clc;
if exist('randondata', 'var') == 1
    disp('The required data is alrady loaded')
else
    randondata = readmatrix('.\CustomerData\Randon\dutycicle.xlsx');
end

time = randondata(:,1);
speed = randondata(:,2)*60/2/pi;
torque = randondata(:,3)/12.25;
%
yyaxis left
plot(time, speed, 'Color',[0,0,1], 'LineStyle','--','Marker','.', 'DisplayName', 'Speed');
title('Randon duty cycle', 'Interpreter', 'none')
ylim([0 4000]);
ylabel('Motor Speed [RPM]')
xlabel('Time [s]');
legend()
grid('on')
zoom('xon')
yyaxis right
plot(time, torque, 'Color',[0,0.5,0], 'LineStyle','--','Marker','.', 'DisplayName', 'Torque');
ylim([-450 450]);
ylabel('Motor Torque [Nm]')
xlabel('Time [s]');
legend()
grid('on')
zoom('xon')