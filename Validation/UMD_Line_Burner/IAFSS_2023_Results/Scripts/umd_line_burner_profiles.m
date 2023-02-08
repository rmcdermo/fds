% McDermott
% updated 25 Jan 2023
% umd_line_burner_profiles.m
%
% Plots for 2023 IAFSS paper

close all
clear all

plot_style
Marker_Size = 10;
Line_Width=2;

% return

expdir = '../../../../../exp/Submodules/macfp-db/Extinction/UMD_Line_Burner/Experimental_Data/';
outdir = '../Baseline/';
% outdir = '~/blaze_home/rmcdermo/GitHub/FireModels_rmcdermo/fds/Validation/UMD_Line_Burner/IAFSS_2023_Results/Baseline/';
pltdir = '../Plots/';

F1 = importdata([outdir,'methane_XO2_18_dx_1p25cm_line.csv'],',',2);
F2 = importdata([outdir,'methane_XO2_18_dx_p625cm_line.csv'],',',2);
F3 = importdata([outdir,'methane_XO2_18_dx_p3125cm_line.csv'],',',2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% mean temperature at z=0.125 m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure
set(gca,'Units',Plot_Units)
set(gca,'Position',[Plot_X Plot_Y Plot_Width Plot_Height])

M1 = importdata([expdir,'TC_Data.csv'],',',1);

y1 = M1.data(:,find(strcmp(M1.colheaders,'x_125')));
T1 = M1.data(:,find(strcmp(M1.colheaders,'TC_125')));

H(1)=plot(y1,T1,'ksq','MarkerSize',Marker_Size); hold on

% z = 0.125 m

yc1 = F1.data(:,find(strcmp(F1.colheaders,'y')));
TC1 = F1.data(:,find(strcmp(F1.colheaders,'TC_125')));

yc2 = F2.data(:,find(strcmp(F2.colheaders,'y')));
TC2 = F2.data(:,find(strcmp(F2.colheaders,'TC_125')));

yc3 = F3.data(:,find(strcmp(F3.colheaders,'y')));
TC3 = F3.data(:,find(strcmp(F3.colheaders,'TC_125')));

H(2) = plot(yc1,TC1,'b--','LineWidth',Line_Width); % dx = 1.25 cm
H(3) = plot(yc2,TC2,'r--','LineWidth',Line_Width); % dx = 0.625 cm
H(4) = plot(yc3,TC3,'k--','LineWidth',Line_Width); % dx = 0.3125 cm

xmin = -0.25;
xmax = 0.25;
ymin = 0;
ymax = 1200;
xt = xmin + .03*(xmax-xmin);
yt = ymin + .92*(ymax-ymin);
text(xt,yt,'UMD Line Burner, Methane','FontName',Font_Name,'FontSize',Title_Font_Size,'Interpreter',Font_Interpreter)
xt = xmin + .03*(xmax-xmin);
yt = ymin + .84*(ymax-ymin);
text(xt,yt,'18 % Oxygen, z=0.125 m','FontName',Font_Name,'FontSize',Title_Font_Size,'Interpreter',Font_Interpreter)

axis([xmin xmax ymin ymax])
xlabel('Position (m)','FontName',Font_Name,'FontSize',Label_Font_Size,'Interpreter',Font_Interpreter)
ylabel('TC Temperature (°C)','FontName',Font_Name,'FontSize',Label_Font_Size,'Interpreter',Font_Interpreter)
lh = legend(H,'Exp','FDS W/dx=4','FDS W/dx=8','FDS W/dx=16');
set(lh,'FontName',Font_Name,'FontSize',Key_Font_Size,'Interpreter',Font_Interpreter)

% add Git revision if file is available
git_file = [outdir,'methane_dx_1p25cm_git.txt'];
addverstr(gca,git_file,'linear')

set(gca,'FontName',Font_Name)
set(gca,'FontSize',Label_Font_Size)
set(gcf,'Visible',Figure_Visibility);
set(gcf,'Units',Paper_Units);
set(gcf,'PaperUnits',Paper_Units);
set(gcf,'PaperSize',[Paper_Width Paper_Height]);
set(gcf,'Position',[0 0 Paper_Width Paper_Height]);

% print to pdf
print(gcf,'-dpdf',[pltdir,'methane_O2_p18_TC_z_p125'])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% mean temperature at z=0.250 m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure
set(gca,'Units',Plot_Units)
set(gca,'Position',[Plot_X Plot_Y Plot_Width Plot_Height])

M1 = importdata([expdir,'TC_Data.csv'],',',1);

y1 = M1.data(:,find(strcmp(M1.colheaders,'x_250')));
T1 = M1.data(:,find(strcmp(M1.colheaders,'TC_250')));

H(1)=plot(y1,T1,'ksq','MarkerSize',Marker_Size); hold on

% z = 0.250 m

yc1 = F1.data(:,find(strcmp(F1.colheaders,'y')));
TC1 = F1.data(:,find(strcmp(F1.colheaders,'TC_250')));

yc2 = F2.data(:,find(strcmp(F2.colheaders,'y')));
TC2 = F2.data(:,find(strcmp(F2.colheaders,'TC_250')));

yc3 = F3.data(:,find(strcmp(F3.colheaders,'y')));
TC3 = F3.data(:,find(strcmp(F3.colheaders,'TC_250')));

H(2) = plot(yc1,TC1,'b--','LineWidth',Line_Width); % dx = 1.25 cm
H(3) = plot(yc2,TC2,'r--','LineWidth',Line_Width); % dx = 0.625 cm
H(4) = plot(yc3,TC3,'k--','LineWidth',Line_Width);  % dx = 0.3125 cm

% % write data to a table file
% Tbl = table([yc1',TC1']);
% writetable(Tbl,[pltdir,'methane_O2_p18_TC_z_p250_table.csv'])

xmin = -0.25;
xmax = 0.25;
ymin = 0;
ymax = 1200;
xt = xmin + .03*(xmax-xmin);
yt = ymin + .92*(ymax-ymin);
text(xt,yt,'UMD Line Burner, Methane','FontName',Font_Name,'FontSize',Title_Font_Size,'Interpreter',Font_Interpreter)
xt = xmin + .03*(xmax-xmin);
yt = ymin + .84*(ymax-ymin);
text(xt,yt,'18 % O2, {\it z} = 0.250 m','FontName',Font_Name,'FontSize',Title_Font_Size,'Interpreter',Font_Interpreter)

axis([xmin xmax ymin ymax])
xlabel('Position (m)','FontName',Font_Name,'FontSize',Label_Font_Size,'Interpreter',Font_Interpreter)
ylabel('TC Temperature (°C)','FontName',Font_Name,'FontSize',Label_Font_Size,'Interpreter',Font_Interpreter)
lh=legend(H,'Exp','FDS W/dx=4','FDS W/dx=8','FDS W/dx=16');
set(lh,'FontName',Font_Name,'FontSize',Key_Font_Size,'Interpreter',Font_Interpreter)

% add Git revision if file is available
git_file = [outdir,'methane_dx_1p25cm_git.txt'];
addverstr(gca,git_file,'linear')

set(gca,'FontName',Font_Name)
set(gca,'FontSize',Label_Font_Size)
set(gcf,'Visible',Figure_Visibility);
set(gcf,'Units',Paper_Units);
set(gcf,'PaperUnits',Paper_Units);
set(gcf,'PaperSize',[Paper_Width Paper_Height]);
set(gcf,'Position',[0 0 Paper_Width Paper_Height]);

% print to pdf
print(gcf,'-dpdf',[pltdir,'methane_O2_p18_TC_z_p250'])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% O2 concentration at z=0.125 m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure
set(gca,'Units',Plot_Units)
set(gca,'Position',[Plot_X Plot_Y Plot_Width Plot_Height])

M1 = importdata([expdir,'O2_Data.csv'],',',1);

y1 = M1.data(:,find(strcmp(M1.colheaders,'x_125')));
O21 = M1.data(:,find(strcmp(M1.colheaders,'XO2_125')));

y1 = M1.data(:,find(strcmp(M1.colheaders,'x_125')));
O21 = M1.data(:,find(strcmp(M1.colheaders,'XO2_125')));

H(1)=plot(y1,O21,'ko','MarkerSize',Marker_Size); hold on

% z = 0.125 m

yc1 = F1.data(:,find(strcmp(F1.colheaders,'y')));
O2_1 = F1.data(:,find(strcmp(F1.colheaders,'XO2_125')));

yc2 = F2.data(:,find(strcmp(F2.colheaders,'y')));
O2_2 = F2.data(:,find(strcmp(F2.colheaders,'XO2_125')));

yc3 = F3.data(:,find(strcmp(F3.colheaders,'y')));
O2_3 = F3.data(:,find(strcmp(F3.colheaders,'XO2_125')));

H(2) = plot(yc1,O2_1,'b--','LineWidth',Line_Width); % dx = 1.25 cm
H(3) = plot(yc2,O2_2,'r--','LineWidth',Line_Width); % dx = 0.625 cm
H(4) = plot(yc3,O2_3,'k--','LineWidth',Line_Width); % dx = 0.3125 cm

xmin = -0.25;
xmax = 0.25;
ymin = 0.05;
ymax = 0.25;
xt = xmin + .03*(xmax-xmin);
yt = ymin + .92*(ymax-ymin);
text(xt,yt,'UMD Line Burner, Methane','FontName',Font_Name,'FontSize',Title_Font_Size,'Interpreter',Font_Interpreter)
xt = xmin + .03*(xmax-xmin);
yt = ymin + .84*(ymax-ymin);
text(xt,yt,'18 % O2, z=0.125 m','FontName',Font_Name,'FontSize',Title_Font_Size,'Interpreter',Font_Interpreter)

axis([xmin xmax ymin ymax])
xlabel('Position (m)','FontName',Font_Name,'FontSize',Label_Font_Size,'Interpreter',Font_Interpreter)
ylabel('O2 (vol frac)','FontName',Font_Name,'FontSize',Label_Font_Size,'Interpreter',Font_Interpreter)
lh=legend(H,'Exp','FDS W/dx=4','FDS W/dx=8','FDS W/dx=16','Location','Southwest');
set(lh,'FontName',Font_Name,'FontSize',Key_Font_Size,'Interpreter',Font_Interpreter)

% add Git revision if file is available
git_file = [outdir,'methane_dx_1p25cm_git.txt'];
addverstr(gca,git_file,'linear')

set(gca,'FontName',Font_Name)
set(gca,'FontSize',Label_Font_Size)
set(gcf,'Visible',Figure_Visibility);
set(gcf,'Units',Paper_Units);
set(gcf,'PaperUnits',Paper_Units);
set(gcf,'PaperSize',[Paper_Width Paper_Height]);
set(gcf,'Position',[0 0 Paper_Width Paper_Height]);

% print to pdf
print(gcf,'-dpdf',[pltdir,'methane_O2_p18_O2_z_p125'])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% O2 concentration at z=0.250 m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure
set(gca,'Units',Plot_Units)
set(gca,'Position',[Plot_X Plot_Y Plot_Width Plot_Height])

M1 = importdata([expdir,'O2_Data.csv'],',',1);

y1 = M1.data(:,find(strcmp(M1.colheaders,'x_250')));
O21 = M1.data(:,find(strcmp(M1.colheaders,'XO2_250')));

H(1)=plot(y1,O21,'ko','MarkerSize',Marker_Size); hold on

% z = 0.250 m

yc1 = F1.data(:,find(strcmp(F1.colheaders,'y')));
O2_1 = F1.data(:,find(strcmp(F1.colheaders,'XO2_250')));

yc2 = F2.data(:,find(strcmp(F2.colheaders,'y')));
O2_2 = F2.data(:,find(strcmp(F2.colheaders,'XO2_250')));

yc3 = F3.data(:,find(strcmp(F3.colheaders,'y')));
O2_3 = F3.data(:,find(strcmp(F3.colheaders,'XO2_250')));

H(2) = plot(yc1,O2_1,'b--','LineWidth',Line_Width); % dx = 1.25 cm
H(3) = plot(yc2,O2_2,'r--','LineWidth',Line_Width);  % dx = 0.625 cm
H(4) = plot(yc3,O2_3,'k--','LineWidth',Line_Width);  % dx = 0.3125 cm

xmin = -0.25;
xmax = 0.25;
ymin = 0.05;
ymax = 0.25;
xt = xmin + .03*(xmax-xmin);
yt = ymin + .92*(ymax-ymin);
text(xt,yt,'UMD Line Burner, Methane','FontName',Font_Name,'FontSize',Title_Font_Size,'Interpreter',Font_Interpreter)
xt = xmin + .03*(xmax-xmin);
yt = ymin + .84*(ymax-ymin);
text(xt,yt,'18 % O2, z=0.250 m','FontName',Font_Name,'FontSize',Title_Font_Size,'Interpreter',Font_Interpreter)

axis([xmin xmax ymin ymax])
xlabel('Position (m)','FontName',Font_Name,'FontSize',Label_Font_Size,'Interpreter',Font_Interpreter)
ylabel('O2 (vol frac)','FontName',Font_Name,'FontSize',Label_Font_Size,'Interpreter',Font_Interpreter)
lh=legend(H,'Exp','FDS W/dx=4','FDS W/dx=8','FDS W/dx=16','Location','Southwest');
set(lh,'FontName',Font_Name,'FontSize',Key_Font_Size,'Interpreter',Font_Interpreter)

% add Git revision if file is available
git_file = [outdir,'methane_dx_1p25cm_git.txt'];
addverstr(gca,git_file,'linear')

set(gca,'FontName',Font_Name)
set(gca,'FontSize',Label_Font_Size)
set(gcf,'Visible',Figure_Visibility);
set(gcf,'Units',Paper_Units);
set(gcf,'PaperUnits',Paper_Units);
set(gcf,'PaperSize',[Paper_Width Paper_Height]);
set(gcf,'Position',[0 0 Paper_Width Paper_Height]);

% print to pdf
print(gcf,'-dpdf',[pltdir,'methane_O2_p18_O2_z_p250'])
