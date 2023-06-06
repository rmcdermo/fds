% McDermott
% 1-9-2017, updated 26 Jan 2023 for IAFSS
% eta_compare_models.m
%
% Plot combustion efficiency and radiative fraction for UMD Line Burner cases.

close all
clear all

plot_style

expdir = '../../../../../exp/Submodules/macfp-db/Extinction/UMD_Line_Burner/Experimental_Data/';
outdir = '~/burn_home/rmcdermo/GitHub/FireModels_rmcdermo/fds/Validation/UMD_Line_Burner/IAFSS_2023_Results/AIT_ZONE_2/';
% outdir = '../Thermally_Thick_Burner/';
pltdir = '../Plots2/';

exp_fname    = {'CH4_A_Data.csv','C3H8_A_Data.csv'};
fuel_name    = {'methane','propane'};
Fuel_name    = {'Methane','Propane'};
fuel_hoc     = [50010.3475,46334.6246]; % from .out file
git_tag_ext  = '_dx_1p25cm_git.txt';

line_fmt = {'r--','g--','b--'};
key_fmt  = {'{\it W/dx}=4','{\it W/dx}=8','{\it W/dx}=16'};

i_fuel = 2

% experimental results
EXP = importdata([expdir,exp_fname{i_fuel}],',',1);
XO2   = EXP.data(:,find(strcmp(EXP.colheaders,'XO2')));
q_R   = EXP.data(:,find(strcmp(EXP.colheaders,'q_R')));
Chi_R = EXP.data(:,find(strcmp(EXP.colheaders,'Chi_R')));
S_XO2 = EXP.data(:,find(strcmp(EXP.colheaders,'S_XO2'))); % uncertainty
eta   = EXP.data(:,find(strcmp(EXP.colheaders,'eta')));
S_eta = EXP.data(:,find(strcmp(EXP.colheaders,'S_eta')));

row_start = 5;

HRR1 = importdata([outdir,fuel_name{i_fuel},'_dx_1p25cm_hrr.csv'],',',2);
HRR2 = importdata([outdir,fuel_name{i_fuel},'_dx_p625cm_hrr.csv'],',',2);
HRR3 = importdata([outdir,fuel_name{i_fuel},'_dx_p3125cm_hrr.csv'],',',2);

DEV1 = importdata([outdir,fuel_name{i_fuel},'_dx_1p25cm_devc.csv'],',',2);
DEV2 = importdata([outdir,fuel_name{i_fuel},'_dx_p625cm_devc.csv'],',',2);
DEV3 = importdata([outdir,fuel_name{i_fuel},'_dx_p3125cm_devc.csv'],',',2);

Time_FDS_1 = DEV1.data(row_start:end,find(strcmp(DEV1.colheaders,'Time')));
Time_FDS_2 = DEV2.data(row_start:end,find(strcmp(DEV2.colheaders,'Time')));
Time_FDS_3 = DEV3.data(row_start:end,find(strcmp(DEV3.colheaders,'Time')));

XO2_FDS_1 = DEV1.data(row_start:end,find(strcmp(DEV1.colheaders,'"XO2"')));
XO2_FDS_2 = DEV2.data(row_start:end,find(strcmp(DEV2.colheaders,'"XO2"')));
XO2_FDS_3 = DEV3.data(row_start:end,find(strcmp(DEV3.colheaders,'"XO2"')));

q_R_FDS_1 = 0.5*( DEV1.data(row_start:end,find(strcmp(DEV1.colheaders,'"qrad1"'))) + DEV1.data(row_start:end,find(strcmp(DEV1.colheaders,'"qrad2"'))) );
q_R_FDS_2 = 0.5*( DEV2.data(row_start:end,find(strcmp(DEV2.colheaders,'"qrad1"'))) + DEV2.data(row_start:end,find(strcmp(DEV2.colheaders,'"qrad2"'))) );
q_R_FDS_3 = 0.5*( DEV3.data(row_start:end,find(strcmp(DEV3.colheaders,'"qrad1"'))) + DEV3.data(row_start:end,find(strcmp(DEV3.colheaders,'"qrad2"'))) );

HRR_FDS_1 = HRR1.data(row_start:end,find(strcmp(HRR1.colheaders,'HRR')));
HRR_FDS_2 = HRR2.data(row_start:end,find(strcmp(HRR2.colheaders,'HRR')));
HRR_FDS_3 = HRR3.data(row_start:end,find(strcmp(HRR3.colheaders,'HRR')));

switch i_fuel
    case 1
        MLR_FDS_1 = HRR1.data(row_start:end,find(strcmp(HRR1.colheaders,'MLR_METHANE')));
        MLR_FDS_2 = HRR2.data(row_start:end,find(strcmp(HRR2.colheaders,'MLR_METHANE')));
        MLR_FDS_3 = HRR3.data(row_start:end,find(strcmp(HRR3.colheaders,'MLR_METHANE')));
    case 2
        MLR_FDS_1 = HRR1.data(row_start:end,find(strcmp(HRR1.colheaders,'MLR_PROPANE')));
        MLR_FDS_2 = HRR2.data(row_start:end,find(strcmp(HRR2.colheaders,'MLR_PROPANE')));
        MLR_FDS_3 = HRR3.data(row_start:end,find(strcmp(HRR3.colheaders,'MLR_PROPANE')));
end

eta_FDS_1 = HRR_FDS_1./(MLR_FDS_1*fuel_hoc(i_fuel));
eta_FDS_2 = HRR_FDS_2./(MLR_FDS_2*fuel_hoc(i_fuel));
eta_FDS_3 = HRR_FDS_3./(MLR_FDS_3*fuel_hoc(i_fuel));

QR_FDS_1 = abs(HRR1.data(row_start:end,find(strcmp(HRR1.colheaders,'Q_RADI'))));
QR_FDS_2 = abs(HRR2.data(row_start:end,find(strcmp(HRR2.colheaders,'Q_RADI'))));
QR_FDS_3 = abs(HRR3.data(row_start:end,find(strcmp(HRR3.colheaders,'Q_RADI'))));

% Q in denom based on definition of X_rad in James White thesis
GLOB_CHI_R_1 = QR_FDS_1./(MLR_FDS_1*fuel_hoc(i_fuel));
GLOB_CHI_R_2 = QR_FDS_2./(MLR_FDS_2*fuel_hoc(i_fuel));
GLOB_CHI_R_3 = QR_FDS_3./(MLR_FDS_3*fuel_hoc(i_fuel));

clear H
figure
set(gca,'Units',Plot_Units)
set(gca,'Position',[Plot_X Plot_Y Plot_Width Plot_Height])

% steel_blue = [0 0.447 0.741];
% H(1)=plot(XO2,eta,'.','MarkerSize',10); hold on
% set(H(1),'Color',steel_blue)
% subr= 1:10:length(XO2);
% h=errorbar(XO2(subr),eta(subr),-S_eta(subr),S_eta(subr),-S_XO2(subr),S_XO2(subr),'.','MarkerSize',10); hold on
% set(h,'Color',steel_blue)

H(1)=plot(XO2,eta,'ko','MarkerSize',5,'LineWidth',1.5); hold on
subr= 1:10:length(XO2);
h=errorbar(XO2(subr),eta(subr),-S_eta(subr),S_eta(subr),-S_XO2(subr),S_XO2(subr),'ko','MarkerSize',5); hold on

H(2)=plot(XO2_FDS_1,eta_FDS_1,line_fmt{1},'LineWidth',2);
H(3)=plot(XO2_FDS_2,eta_FDS_2,line_fmt{2},'LineWidth',2);
H(4)=plot(XO2_FDS_3,eta_FDS_3,line_fmt{3},'LineWidth',2);

axis([0.09 0.21 0 1.2 ])
xlabel('O2 (vol frac)','Interpreter',Font_Interpreter,'FontSize',Label_Font_Size)
ylabel('\eta','Interpreter',Font_Interpreter,'FontSize',Label_Font_Size)
text(0.095,1.12,[Fuel_name{i_fuel},' Combustion Efficiency'],'FontName',Font_Name,'FontSize',Title_Font_Size)

set(gca,'FontName',Font_Name)
set(gca,'FontSize',Label_Font_Size)

lh=legend(H,'Exp',key_fmt{:},'Location','SouthEast');
set(lh,'FontName',Font_Name,'FontSize',Key_Font_Size)

git_file=[outdir,fuel_name{i_fuel},git_tag_ext];
addverstr(gca,git_file,'linear');

set(gcf,'Visible',Figure_Visibility);
set(gcf,'Units',Paper_Units);
set(gcf,'PaperUnits',Paper_Units);
set(gcf,'PaperSize',[Paper_Width Paper_Height]);
set(gcf,'Position',[0 0 Paper_Width Paper_Height]);
print(gcf,'-dpdf',[pltdir,fuel_name{i_fuel},'_eta']);


% plot actual global radiative fraction
figure
clear H
set(gca,'Units',Plot_Units)
set(gca,'Position',[Plot_X Plot_Y Plot_Width Plot_Height])
H(1)=plot(XO2,Chi_R,'ko','MarkerSize',5,'LineWidth',1.5); hold on

H(2)=plot(XO2_FDS_1,GLOB_CHI_R_1,line_fmt{1},'LineWidth',2);
H(3)=plot(XO2_FDS_2,GLOB_CHI_R_2,line_fmt{2},'LineWidth',2);
H(4)=plot(XO2_FDS_3,GLOB_CHI_R_3,line_fmt{3},'LineWidth',2);

axis([0.10 0.21 0 0.35 ])
xlabel('O2 (vol frac)','Interpreter',Font_Interpreter,'FontSize',Label_Font_Size)
ylabel('\chi_R','Interpreter',Font_Interpreter,'FontSize',Label_Font_Size)
text(0.105,0.325,[Fuel_name{i_fuel},' Radiative Fraction'],'FontName',Font_Name,'FontSize',Title_Font_Size)
set(gca,'FontName',Font_Name)
set(gca,'FontSize',Label_Font_Size)
lh=legend(H,'Exp',key_fmt{:},'Location','SouthEast');
set(lh,'FontName',Font_Name,'FontSize',Key_Font_Size)
git_file=[outdir,fuel_name{i_fuel},git_tag_ext];
addverstr(gca,git_file,'linear');

set(gcf,'Visible',Figure_Visibility);
set(gcf,'Units',Paper_Units);
set(gcf,'PaperUnits',Paper_Units);
set(gcf,'PaperSize',[Paper_Width Paper_Height]);
set(gcf,'Position',[0 0 Paper_Width Paper_Height]);
print(gcf,'-dpdf',[pltdir,fuel_name{i_fuel},'_global_Chi_R']);


