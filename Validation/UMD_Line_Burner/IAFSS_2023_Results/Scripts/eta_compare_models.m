% McDermott
% 1-9-2017, updated 26 Jan 2023 for IAFSS
% eta_compare_models.m
%
% Plot combustion efficiency for UMD Line Burner cases.

close all
clear all

Lf_pts = 50;
Lf_min = 0;
Lf_max = 1;
Lf_dz  = (Lf_max-Lf_min)/(Lf_pts-1);
Lf_z   = Lf_min:Lf_dz:Lf_max;
Lf_fac = 0.97;
Lf_dt  = 10;

plot_style

expdir = '../../../../../exp/Submodules/macfp-db/Extinction/UMD_Line_Burner/Experimental_Data/';
outdir_1 = '../Baseline/';
outdir_2 = '~/blaze_home/rmcdermo/GitHub/FireModels_rmcdermo/fds/Validation/UMD_Line_Burner/IAFSS_2023_Results/TRI_MODEL/';
pltdir = '../Plots/';

exp_fname    = {'CH4_A_Data.csv','C3H8_A_Data.csv'};
exp_Lf_fname = {'CH4_A_Lf_Data.csv','C3H8_A_Lf_Data.csv'};
fuel_name    = {'methane','propane'};
Fuel_name    = {'Methane','Propane'};
fuel_hoc     = [50010.3475,46334.6246]; % from .out file
git_tag_ext  = '_dx_1p25cm_git.txt';

line_fmt = {'bo-','ro-'};
key_fmt  = {'Baseline {\it W/dx}=4','TRI {\it W/dx}=4'};

i_fuel = 1

% experimental results
EXP = importdata([expdir,exp_fname{i_fuel}],',',1);
XO2   = EXP.data(:,find(strcmp(EXP.colheaders,'XO2')));
q_R   = EXP.data(:,find(strcmp(EXP.colheaders,'q_R')));
Chi_R = EXP.data(:,find(strcmp(EXP.colheaders,'Chi_R')));
S_XO2 = EXP.data(:,find(strcmp(EXP.colheaders,'S_XO2'))); % uncertainty
eta   = EXP.data(:,find(strcmp(EXP.colheaders,'eta')));
S_eta = EXP.data(:,find(strcmp(EXP.colheaders,'S_eta')));

EXP_Lf = importdata([expdir,exp_Lf_fname{i_fuel}],',',1);
XO2_Lf = EXP_Lf.data(:,find(strcmp(EXP_Lf.colheaders,'XO2_Lf')));
Lf     = EXP_Lf.data(:,find(strcmp(EXP_Lf.colheaders,'Lf')));
S_Lf   = EXP_Lf.data(:,find(strcmp(EXP_Lf.colheaders,'S_Lf')));

is_case_1_run=1; if ~exist([outdir_1,fuel_name{i_fuel},'_dx_1p25cm_hrr.csv']); is_case_1_run=0; end
is_case_2_run=1; if ~exist([outdir_2,fuel_name{i_fuel},'_dx_1p25cm_hrr.csv']); is_case_2_run=0; end
is_case_run=0; if (is_case_1_run | is_case_2_run); is_case_run=1; end

row_start = 5;

if is_case_1_run % case 1 if
    HRR1 = importdata([outdir_1,fuel_name{i_fuel},'_dx_1p25cm_hrr.csv'],',',2);
    DEV1 = importdata([outdir_1,fuel_name{i_fuel},'_dx_1p25cm_devc.csv'],',',2);

    Time_FDS_1 = DEV1.data(row_start:end,find(strcmp(DEV1.colheaders,'Time')));
    XO2_FDS_1 = DEV1.data(row_start:end,find(strcmp(DEV1.colheaders,'"XO2"')));
    q_R_FDS_1 = 0.5*( DEV1.data(row_start:end,find(strcmp(DEV1.colheaders,'"qrad1"'))) + DEV1.data(row_start:end,find(strcmp(DEV1.colheaders,'"qrad2"'))) );
    HRR_FDS_1 = HRR1.data(row_start:end,find(strcmp(HRR1.colheaders,'HRR')));
    switch i_fuel
        case 1
            MLR_FDS_1 = HRR1.data(row_start:end,find(strcmp(HRR1.colheaders,'MLR_METHANE')));
        case 2
            MLR_FDS_1 = HRR1.data(row_start:end,find(strcmp(HRR1.colheaders,'MLR_PROPANE')));
    end
    eta_FDS_1 = HRR_FDS_1./(MLR_FDS_1*fuel_hoc(i_fuel));
    QR_FDS_1 = abs(HRR1.data(row_start:end,find(strcmp(HRR1.colheaders,'Q_RADI'))));
    GLOB_CHI_R_1 = QR_FDS_1./(MLR_FDS_1*fuel_hoc(i_fuel)); % Q in denom based on definition of X_rad in James White thesis
    L_F_1 = DEV1.data(row_start:end,find(strcmp(DEV1.colheaders,'"L_F"')));

    % % flame height
    % colLf01 = find(strcmp(DEV1.colheaders,'"Lf-1"'));
    % colLf50 = find(strcmp(DEV1.colheaders,'"Lf-50"'));
    % Lf_FDS_1 = zeros(1,length(Time_FDS_1));
    % for n=1:length(Time_FDS_1)
    %     hrrpul = DEV1.data(n,colLf01:colLf50);
    %     q_total = sum(hrrpul);
    %     q_sum = 0.;
    %     for i=1:Lf_pts
    %         q_sum = q_sum+hrrpul(i);
    %         if q_sum>Lf_fac*q_total
    %             Lf_FDS_1(n) = Lf_z(i);
    %             break;
    %         end
    %     end
    % end
    % Lf_tmp = Lf_FDS_1;
    % for n=1:length(Time_FDS_1)
    %     indx_range = [find(Time_FDS_1>(Time_FDS_1(n)-Lf_dt),1):n];
    %     Lf_FDS_1(n) = mean(Lf_tmp(indx_range));
    % end
end % case 1 if

if is_case_2_run % case 2 if
    HRR2 = importdata([outdir_2,fuel_name{i_fuel},'_dx_1p25cm_hrr.csv'],',',2);
    DEV2 = importdata([outdir_2,fuel_name{i_fuel},'_dx_1p25cm_devc.csv'],',',2);

    Time_FDS_2 = DEV2.data(row_start:end,find(strcmp(DEV2.colheaders,'Time')));
    XO2_FDS_2 = DEV2.data(row_start:end,find(strcmp(DEV2.colheaders,'"XO2"')));
    q_R_FDS_2 = 0.5*( DEV2.data(row_start:end,find(strcmp(DEV2.colheaders,'"qrad1"'))) + DEV2.data(row_start:end,find(strcmp(DEV2.colheaders,'"qrad2"'))) );
    HRR_FDS_2 = HRR2.data(row_start:end,find(strcmp(HRR2.colheaders,'HRR')));
    switch i_fuel
        case 1
            MLR_FDS_2 = HRR2.data(row_start:end,find(strcmp(HRR2.colheaders,'MLR_METHANE')));
        case 2
            MLR_FDS_2 = HRR2.data(row_start:end,find(strcmp(HRR2.colheaders,'MLR_PROPANE')));
    end
    eta_FDS_2 = HRR_FDS_2./(MLR_FDS_2*fuel_hoc(i_fuel));
    QR_FDS_2 = abs(HRR2.data(row_start:end,find(strcmp(HRR2.colheaders,'Q_RADI'))));
    GLOB_CHI_R_2 = QR_FDS_2./(MLR_FDS_2*fuel_hoc(i_fuel)); % Q in denom based on definition of X_rad in James White thesis
    L_F_2 = DEV2.data(row_start:end,find(strcmp(DEV2.colheaders,'"L_F"')));

    % % flame height
    % colLf01 = find(strcmp(DEV2.colheaders,'"Lf-1"'));
    % colLf50 = find(strcmp(DEV2.colheaders,'"Lf-50"'));
    % Lf_FDS_2 = zeros(1,length(Time_FDS_2));
    % for n=1:length(Time_FDS_2)
    %     hrrpul = DEV2.data(n,colLf01:colLf50);
    %     q_total = sum(hrrpul);
    %     q_sum = 0.;
    %     for i=1:Lf_pts
    %         q_sum = q_sum+hrrpul(i);
    %         if q_sum>Lf_fac*q_total
    %             Lf_FDS_2(n) = Lf_z(i);
    %             break;
    %         end
    %     end
    % end
    % Lf_tmp = Lf_FDS_2;
    % for n=1:length(Time_FDS_2)
    %     indx_range = [find(Time_FDS_2>(Time_FDS_2(n)-Lf_dt),1):n];
    %     Lf_FDS_2(n) = mean(Lf_tmp(indx_range));
    % end
end % case 2 if


clear H
figure
set(gca,'Units',Plot_Units)
set(gca,'Position',[Plot_X Plot_Y Plot_Width Plot_Height])

steel_blue = [0 0.447 0.741];
H(1)=plot(XO2,eta,'.','MarkerSize',10); hold on
set(H(1),'Color',steel_blue)
subr= 1:10:length(XO2);
h=errorbar(XO2(subr),eta(subr),-S_eta(subr),S_eta(subr),-S_XO2(subr),S_XO2(subr),'.','MarkerSize',10); hold on
set(h,'Color',steel_blue)
if is_case_run
    if is_case_1_run; H(2)=plot(XO2_FDS_1,eta_FDS_1,line_fmt{1}); end
    if is_case_2_run; H(3)=plot(XO2_FDS_2,eta_FDS_2,line_fmt{2}); end
    axis([0.09 0.21 0 1.2 ])
    xlabel('O2 (vol frac)','Interpreter',Font_Interpreter,'FontSize',Label_Font_Size)
    ylabel('\eta','Interpreter',Font_Interpreter,'FontSize',Label_Font_Size)
    text(0.095,1.12,[Fuel_name{i_fuel},' Combustion Efficiency'],'FontName',Font_Name,'FontSize',Title_Font_Size)

    set(gca,'FontName',Font_Name)
    set(gca,'FontSize',Label_Font_Size)

    lh=legend(H,'Exp',key_fmt{:},'Location','SouthEast');
    set(lh,'FontName',Font_Name,'FontSize',Key_Font_Size)

    git_file=[outdir_1,fuel_name{i_fuel},git_tag_ext];
    addverstr(gca,git_file,'linear');

    set(gcf,'Visible',Figure_Visibility);
    set(gcf,'Units',Paper_Units);
    set(gcf,'PaperUnits',Paper_Units);
    set(gcf,'PaperSize',[Paper_Width Paper_Height]);
    set(gcf,'Position',[0 0 Paper_Width Paper_Height]);
    print(gcf,'-dpdf',[pltdir,fuel_name{i_fuel},'_eta_model_comparison']);
end

% plot actual global radiative fraction
figure
clear H
set(gca,'Units',Plot_Units)
set(gca,'Position',[Plot_X Plot_Y Plot_Width Plot_Height])
H(1)=plot(XO2,Chi_R,'.','MarkerSize',10); hold on
set(H(1),'Color',steel_blue)
if is_case_run
    if is_case_1_run; H(2)=plot(XO2_FDS_1,GLOB_CHI_R_1,line_fmt{1}); end
    if is_case_2_run; H(3)=plot(XO2_FDS_2,GLOB_CHI_R_2,line_fmt{2}); end
    axis([0.10 0.21 0 0.35 ])
    xlabel('O2 (vol frac)','Interpreter',Font_Interpreter,'FontSize',Label_Font_Size)
    ylabel('\chi_R','Interpreter',Font_Interpreter,'FontSize',Label_Font_Size)
    text(0.105,0.325,[Fuel_name{i_fuel},' Radiative Fraction'],'FontName',Font_Name,'FontSize',Title_Font_Size)
    set(gca,'FontName',Font_Name)
    set(gca,'FontSize',Label_Font_Size)
    lh=legend(H,'Exp',key_fmt{:},'Location','SouthEast');
    set(lh,'FontName',Font_Name,'FontSize',Key_Font_Size)
    git_file=[outdir_1,fuel_name{i_fuel},git_tag_ext];
    addverstr(gca,git_file,'linear');

    set(gcf,'Visible',Figure_Visibility);
    set(gcf,'Units',Paper_Units);
    set(gcf,'PaperUnits',Paper_Units);
    set(gcf,'PaperSize',[Paper_Width Paper_Height]);
    set(gcf,'Position',[0 0 Paper_Width Paper_Height]);
    print(gcf,'-dpdf',[pltdir,fuel_name{i_fuel},'_global_Chi_R_model_comparison']);
end

