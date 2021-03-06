clc;
close all; clearvars;
%% M11 Motor
volt_m11 = readmatrix('motorData.xlsx','Sheet','M11','Range','I2:I43', 'OutputType', 'double');
%
rpm_pktq_m11 = readmatrix('motorData.xlsx','Sheet','M11','Range','A2:A45', 'OutputType', 'double');
pknm_m11 = readmatrix('motorData.xlsx','Sheet','M11','Range','B2:B45', 'OutputType', 'double');
%
rpm_cttq_m11 = readmatrix('motorData.xlsx','Sheet','M11','Range','C2:C43', 'OutputType', 'double');
ctnm_m11 = readmatrix('motorData.xlsx','Sheet','M11','Range','D2:D43', 'OutputType', 'double');
%
rpm_pkkw_m11 = readmatrix('motorData.xlsx','Sheet','M11','Range','E2:E45', 'OutputType', 'double');
pkkw_m11 = readmatrix('motorData.xlsx','Sheet','M11','Range','F2:F45', 'OutputType', 'double');
%
rpm_ctkw_m11 = readmatrix('motorData.xlsx','Sheet','M11','Range','G2:G43', 'OutputType', 'double');
ctkw_m11 = readmatrix('motorData.xlsx','Sheet','M11','Range','H2:H43', 'OutputType', 'double');
%% M13 Motor
volt_m13 = readmatrix('motorData.xlsx','Sheet','M13','Range','I2:I109', 'OutputType', 'double');
%
rpm_pktq_m13 = readmatrix('motorData.xlsx','Sheet','M13','Range','A2:A93', 'OutputType', 'double');
pknm_m13 = readmatrix('motorData.xlsx','Sheet','M13','Range','B2:B93', 'OutputType', 'double');
%
rpm_cttq_m13 = readmatrix('motorData.xlsx','Sheet','M13','Range','C2:C109', 'OutputType', 'double');
ctnm_m13 = readmatrix('motorData.xlsx','Sheet','M13','Range','D2:D109', 'OutputType', 'double');
%
rpm_pkkw_m13 = readmatrix('motorData.xlsx','Sheet','M13','Range','E2:E110', 'OutputType', 'double');
pkkw_m13 = readmatrix('motorData.xlsx','Sheet','M13','Range','F2:F110', 'OutputType', 'double');
%
rpm_ctkw_m13 = readmatrix('motorData.xlsx','Sheet','M13','Range','G2:G73', 'OutputType', 'double');
ctkw_m13 = readmatrix('motorData.xlsx','Sheet','M13','Range','H2:H73', 'OutputType', 'double');
%% M15 Motor
volt_m15 = readmatrix('motorData.xlsx','Sheet','M15','Range','I2:I22', 'OutputType', 'double');
%
rpm_pktq_m15 = readmatrix('motorData.xlsx','Sheet','M15','Range','A2:A22', 'OutputType', 'double');
pknm_m15 = readmatrix('motorData.xlsx','Sheet','M15','Range','B2:B22', 'OutputType', 'double');
%
rpm_cttq_m15 = readmatrix('motorData.xlsx','Sheet','M15','Range','C2:C22', 'OutputType', 'double');
ctnm_m15 = readmatrix('motorData.xlsx','Sheet','M15','Range','D2:D22', 'OutputType', 'double');
%
rpm_pkkw_m15 = readmatrix('motorData.xlsx','Sheet','M15','Range','E2:E22', 'OutputType', 'double');
pkkw_m15 = readmatrix('motorData.xlsx','Sheet','M15','Range','F2:F22', 'OutputType', 'double');
%
rpm_ctkw_m15 = readmatrix('motorData.xlsx','Sheet','M15','Range','G2:G22', 'OutputType', 'double');
ctkw_m15 = readmatrix('motorData.xlsx','Sheet','M15','Range','H2:H22', 'OutputType', 'double');
%% M17 Motor
volt_m17 = readmatrix('motorData.xlsx','Sheet','M17','Range','I2:I111', 'OutputType', 'double');
%
rpm_pktq_m17 = readmatrix('motorData.xlsx','Sheet','M17','Range','A2:A100', 'OutputType', 'double');
pknm_m17 = readmatrix('motorData.xlsx','Sheet','M17','Range','B2:B100', 'OutputType', 'double');
%
rpm_cttq_m17 = readmatrix('motorData.xlsx','Sheet','M17','Range','C2:C78', 'OutputType', 'double');
ctnm_m17 = readmatrix('motorData.xlsx','Sheet','M17','Range','D2:D78', 'OutputType', 'double');
%
rpm_pkkw_m17 = readmatrix('motorData.xlsx','Sheet','M17','Range','E2:E111', 'OutputType', 'double');
pkkw_m17 = readmatrix('motorData.xlsx','Sheet','M17','Range','F2:F111', 'OutputType', 'double');
%
rpm_ctkw_m17 = readmatrix('motorData.xlsx','Sheet','M17','Range','G2:G92', 'OutputType', 'double');
ctkw_m17 = readmatrix('motorData.xlsx','Sheet','M17','Range','H2:H92', 'OutputType', 'double');
%% M19 Motor
volt_m19 = readmatrix('motorData.xlsx','Sheet','M19P','Range','B2:D3', 'OutputType', 'double');
not_m19 = unique(readmatrix('motorData.xlsx','Sheet','M19P','Range','B4:M4', 'OutputType', 'double'));
rpm_m19 = readmatrix('motorData.xlsx','Sheet','M19P','Range','A6:A25', 'OutputType', 'double');
nm_m19_3 = readmatrix('motorData.xlsx','Sheet','M19P','Range','B6:D25', 'OutputType', 'double');
nm_m19_4 = readmatrix('motorData.xlsx','Sheet','M19P','Range','E6:G25', 'OutputType', 'double');
nm_m19_5 = readmatrix('motorData.xlsx','Sheet','M19P','Range','H6:J25', 'OutputType', 'double');
nm_m19_6 = readmatrix('motorData.xlsx','Sheet','M19P','Range','K6:M25', 'OutputType', 'double');
%
[rpmgrd_m19, voltgrd_m19, notgrd_m19] = ndgrid(rpm_m19, volt_m19, not_m19);
%
kw_m19_3 = rpm_m19.* nm_m19_3 * 2*pi/60/1000; % kW
kw_m19_4 = rpm_m19.* nm_m19_4 * 2*pi/60/1000; % kW
kw_m19_5 = rpm_m19.* nm_m19_5 * 2*pi/60/1000; % kW
kw_m19_6 = rpm_m19.* nm_m19_6 * 2*pi/60/1000; % kW
%
nm_m19 = zeros(20,3,4);
nm_m19(:,:,1) = nm_m19_3;
nm_m19(:,:,2) = nm_m19_4;
nm_m19(:,:,3) = nm_m19_5;
nm_m19(:,:,4) = nm_m19_6;
fnm_m19 = griddedInterpolant(rpmgrd_m19, voltgrd_m19, notgrd_m19, nm_m19);
%
kw_m19 = zeros(20,3,4);
kw_m19(:,:,1) = kw_m19_3;
kw_m19(:,:,2) = kw_m19_4;
kw_m19(:,:,3) = kw_m19_5;
kw_m19(:,:,4) = kw_m19_6;
fkw_m19 = griddedInterpolant(rpmgrd_m19, voltgrd_m19, notgrd_m19, kw_m19);
%% M21 motor
volt_m21 = readmatrix('motorData.xlsx','Sheet','M21P','Range','B2:D3', 'OutputType', 'double');
not_m21 = unique(readmatrix('motorData.xlsx','Sheet','m21P','Range','B4:M4', 'OutputType', 'double'));
rpm_m21 = readmatrix('motorData.xlsx','Sheet','m21P','Range','A6:A25', 'OutputType', 'double');
nm_m21_3 = readmatrix('motorData.xlsx','Sheet','m21P','Range','B6:D25', 'OutputType', 'double');
nm_m21_4 = readmatrix('motorData.xlsx','Sheet','m21P','Range','E6:G25', 'OutputType', 'double');
nm_m21_5 = readmatrix('motorData.xlsx','Sheet','m21P','Range','H6:J25', 'OutputType', 'double');
nm_m21_6 = readmatrix('motorData.xlsx','Sheet','m21P','Range','K6:M25', 'OutputType', 'double');
%
[rpmgrd_m21, voltgrd_m21, notgrd_m21] = ndgrid(rpm_m21, volt_m21, not_m21);
%
kw_m21_3 = rpm_m21.* nm_m21_3 * 2*pi/60/1000; % kW
kw_m21_4 = rpm_m21.* nm_m21_4 * 2*pi/60/1000; % kW
kw_m21_5 = rpm_m21.* nm_m21_5 * 2*pi/60/1000; % kW
kw_m21_6 = rpm_m21.* nm_m21_6 * 2*pi/60/1000; % kW
%
nm_m21 = zeros(20,3,4);
nm_m21(:,:,1) = nm_m21_3;
nm_m21(:,:,2) = nm_m21_4;
nm_m21(:,:,3) = nm_m21_5;
nm_m21(:,:,4) = nm_m21_6;
fnm_m21 = griddedInterpolant(rpmgrd_m21, voltgrd_m21, notgrd_m21, nm_m21);
%
kw_m21 = zeros(20,3,4);
kw_m21(:,:,1) = kw_m21_3;
kw_m21(:,:,2) = kw_m21_4;
kw_m21(:,:,3) = kw_m21_5;
kw_m21(:,:,4) = kw_m21_6;
fkw_m21 = griddedInterpolant(rpmgrd_m21, voltgrd_m21, notgrd_m21, kw_m21);
%% M24 motor
volt_m24 = readmatrix('motorData.xlsx','Sheet','M24P','Range','B2:D3', 'OutputType', 'double');
not_m24 = unique(readmatrix('motorData.xlsx','Sheet','m24P','Range','B4:M4', 'OutputType', 'double'));
rpm_m24 = readmatrix('motorData.xlsx','Sheet','m24P','Range','A6:A25', 'OutputType', 'double');
nm_m24_3 = readmatrix('motorData.xlsx','Sheet','m24P','Range','B6:D25', 'OutputType', 'double');
nm_m24_4 = readmatrix('motorData.xlsx','Sheet','m24P','Range','E6:G25', 'OutputType', 'double');
nm_m24_5 = readmatrix('motorData.xlsx','Sheet','m24P','Range','H6:J25', 'OutputType', 'double');
nm_m24_6 = readmatrix('motorData.xlsx','Sheet','m24P','Range','K6:M25', 'OutputType', 'double');
%
[rpmgrd_m24, voltgrd_m24, notgrd_m24] = ndgrid(rpm_m24, volt_m24, not_m24);
%
kw_m24_3 = rpm_m24.* nm_m24_3 * 2*pi/60/1000; % kW
kw_m24_4 = rpm_m24.* nm_m24_4 * 2*pi/60/1000; % kW
kw_m24_5 = rpm_m24.* nm_m24_5 * 2*pi/60/1000; % kW
kw_m24_6 = rpm_m24.* nm_m24_6 * 2*pi/60/1000; % kW
%
nm_m24 = zeros(20,3,4);
nm_m24(:,:,1) = nm_m24_3;
nm_m24(:,:,2) = nm_m24_4;
nm_m24(:,:,3) = nm_m24_5;
nm_m24(:,:,4) = nm_m24_6;
fnm_m24 = griddedInterpolant(rpmgrd_m24, voltgrd_m24, notgrd_m24, nm_m24);
%
kw_m24 = zeros(20,3,4);
kw_m24(:,:,1) = kw_m24_3;
kw_m24(:,:,2) = kw_m24_4;
kw_m24(:,:,3) = kw_m24_5;
kw_m24(:,:,4) = kw_m24_6;
fkw_m24 = griddedInterpolant(rpmgrd_m24, voltgrd_m24, notgrd_m24, kw_m24);
%% M27 motor
volt_m27 = readmatrix('motorData.xlsx','Sheet','M27P','Range','B2:D3', 'OutputType', 'double');
not_m27 = unique(readmatrix('motorData.xlsx','Sheet','m27P','Range','B4:M4', 'OutputType', 'double'));
rpm_m27 = readmatrix('motorData.xlsx','Sheet','m27P','Range','A6:A25', 'OutputType', 'double');
nm_m27_3 = readmatrix('motorData.xlsx','Sheet','m27P','Range','B6:D25', 'OutputType', 'double');
nm_m27_4 = readmatrix('motorData.xlsx','Sheet','m27P','Range','E6:G25', 'OutputType', 'double');
nm_m27_5 = readmatrix('motorData.xlsx','Sheet','m27P','Range','H6:J25', 'OutputType', 'double');
nm_m27_6 = readmatrix('motorData.xlsx','Sheet','m27P','Range','K6:M25', 'OutputType', 'double');
%
[rpmgrd_m27, voltgrd_m27, notgrd_m27] = ndgrid(rpm_m27, volt_m27, not_m27);
%
kw_m27_3 = rpm_m27.* nm_m27_3 * 2*pi/60/1000; % kW
kw_m27_4 = rpm_m27.* nm_m27_4 * 2*pi/60/1000; % kW
kw_m27_5 = rpm_m27.* nm_m27_5 * 2*pi/60/1000; % kW
kw_m27_6 = rpm_m27.* nm_m27_6 * 2*pi/60/1000; % kW
%
nm_m27 = zeros(20,3,4);
nm_m27(:,:,1) = nm_m27_3;
nm_m27(:,:,2) = nm_m27_4;
nm_m27(:,:,3) = nm_m27_5;
nm_m27(:,:,4) = nm_m27_6;
fnm_m27 = griddedInterpolant(rpmgrd_m27, voltgrd_m27, notgrd_m27, nm_m27);
%
kw_m27 = zeros(20,3,4);
kw_m27(:,:,1) = kw_m27_3;
kw_m27(:,:,2) = kw_m27_4;
kw_m27(:,:,3) = kw_m27_5;
kw_m27(:,:,4) = kw_m27_6;
fkw_m27 = griddedInterpolant(rpmgrd_m27, voltgrd_m27, notgrd_m27, kw_m27);
%% M30 motor
volt_m30 = readmatrix('motorData.xlsx','Sheet','M30P','Range','B2:D3', 'OutputType', 'double');
not_m30 = unique(readmatrix('motorData.xlsx','Sheet','m30P','Range','B4:M4', 'OutputType', 'double'));
rpm_m30 = readmatrix('motorData.xlsx','Sheet','m30P','Range','A6:A25', 'OutputType', 'double');
nm_m30_3 = readmatrix('motorData.xlsx','Sheet','m30P','Range','B6:D25', 'OutputType', 'double');
nm_m30_4 = readmatrix('motorData.xlsx','Sheet','m30P','Range','E6:G25', 'OutputType', 'double');
nm_m30_5 = readmatrix('motorData.xlsx','Sheet','m30P','Range','H6:J25', 'OutputType', 'double');
nm_m30_6 = readmatrix('motorData.xlsx','Sheet','m30P','Range','K6:M25', 'OutputType', 'double');
%
[rpmgrd_m30, voltgrd_m30, notgrd_m30] = ndgrid(rpm_m30, volt_m30, not_m30);
%
kw_m30_3 = rpm_m30.* nm_m30_3 * 2*pi/60/1000; % kW
kw_m30_4 = rpm_m30.* nm_m30_4 * 2*pi/60/1000; % kW
kw_m30_5 = rpm_m30.* nm_m30_5 * 2*pi/60/1000; % kW
kw_m30_6 = rpm_m30.* nm_m30_6 * 2*pi/60/1000; % kW
%
nm_m30 = zeros(20,3,4);
nm_m30(:,:,1) = nm_m30_3;
nm_m30(:,:,2) = nm_m30_4;
nm_m30(:,:,3) = nm_m30_5;
nm_m30(:,:,4) = nm_m30_6;
fnm_m30 = griddedInterpolant(rpmgrd_m30, voltgrd_m30, notgrd_m30, nm_m30);
%
kw_m30 = zeros(20,3,4);
kw_m30(:,:,1) = kw_m30_3;
kw_m30(:,:,2) = kw_m30_4;
kw_m30(:,:,3) = kw_m30_5;
kw_m30(:,:,4) = kw_m30_6;
fkw_m30 = griddedInterpolant(rpmgrd_m30, voltgrd_m30, notgrd_m30, kw_m30);
%% M34 motor
volt_m34 = readmatrix('motorData.xlsx','Sheet','M34P','Range','B2:D3', 'OutputType', 'double');
not_m34 = unique(readmatrix('motorData.xlsx','Sheet','m34P','Range','B4:M4', 'OutputType', 'double'));
rpm_m34 = readmatrix('motorData.xlsx','Sheet','m34P','Range','A6:A25', 'OutputType', 'double');
nm_m34_3 = readmatrix('motorData.xlsx','Sheet','m34P','Range','B6:D25', 'OutputType', 'double');
nm_m34_4 = readmatrix('motorData.xlsx','Sheet','m34P','Range','E6:G25', 'OutputType', 'double');
nm_m34_5 = readmatrix('motorData.xlsx','Sheet','m34P','Range','H6:J25', 'OutputType', 'double');
nm_m34_6 = readmatrix('motorData.xlsx','Sheet','m34P','Range','K6:M25', 'OutputType', 'double');
%
[rpmgrd_m34, voltgrd_m34, notgrd_m34] = ndgrid(rpm_m34, volt_m34, not_m34);
%
kw_m34_3 = rpm_m34.* nm_m34_3 * 2*pi/60/1000; % kW
kw_m34_4 = rpm_m34.* nm_m34_4 * 2*pi/60/1000; % kW
kw_m34_5 = rpm_m34.* nm_m34_5 * 2*pi/60/1000; % kW
kw_m34_6 = rpm_m34.* nm_m34_6 * 2*pi/60/1000; % kW
%
nm_m34 = zeros(20,3,4);
nm_m34(:,:,1) = nm_m34_3;
nm_m34(:,:,2) = nm_m34_4;
nm_m34(:,:,3) = nm_m34_5;
nm_m34(:,:,4) = nm_m34_6;
fnm_m34 = griddedInterpolant(rpmgrd_m34, voltgrd_m34, notgrd_m34, nm_m34);
%
kw_m34 = zeros(20,3,4);
kw_m34(:,:,1) = kw_m34_3;
kw_m34(:,:,2) = kw_m34_4;
kw_m34(:,:,3) = kw_m34_5;
kw_m34(:,:,4) = kw_m34_6;
fkw_m34 = griddedInterpolant(rpmgrd_m34, voltgrd_m34, notgrd_m34, kw_m34);
%% Torque factor
tf_m19 = readmatrix('motorData.xlsx','Sheet','M19P','Range','O6:O25', 'OutputType', 'double');
tf_m21 = readmatrix('motorData.xlsx','Sheet','M21P','Range','O6:O25', 'OutputType', 'double');
tf_m24 = readmatrix('motorData.xlsx','Sheet','M24P','Range','O6:O25', 'OutputType', 'double');
tf_m27 = readmatrix('motorData.xlsx','Sheet','M27P','Range','O6:O25', 'OutputType', 'double');
tf_m30 = readmatrix('motorData.xlsx','Sheet','M30P','Range','O6:O25', 'OutputType', 'double');
tf_m34 = readmatrix('motorData.xlsx','Sheet','M34P','Range','O6:O25', 'OutputType', 'double');
%% saving in a mat file
save('motorData.mat')