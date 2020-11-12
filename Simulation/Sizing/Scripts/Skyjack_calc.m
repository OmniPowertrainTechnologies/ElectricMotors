% conservation of energy
mass_wheel = 3; % kg
radius_wheel = 0.101; % meter
width_wheel = 0.075; % meter
speed_wheel = linspace(1,5000/57, 20); % rpm
theta_wheel = 0.0001; % radian

I_wheel = mass_wheel*radius_wheel^2/4 + mass_wheel*width_wheel^2/12;
speed_wheel_radps = speed_wheel.*2*pi/60; % rad/s

torque_wheel = 0.5*I_wheel*speed_wheel_radps.^2/theta_wheel;

%% plot
plot(speed_wheel, torque_wheel, '.-');
xlabel('Speed of wheel [RPM]')
ylabel('Torque [Nm]')