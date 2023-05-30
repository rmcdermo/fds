% McDermott
% 4-11-2019
% rad_frac.m

close all
clear all

plot_style
figure
set(gca,'Units',Plot_Units)
set(gca,'Position',[Plot_X Plot_Y Plot_Width Plot_Height])

datadir = '/Volumes/rmcdermo-1/GitHub/FireModels_rmcdermo/fds/Validation/Heskestad_Flame_Height/Test_TRI_Model/';
listing = dir([datadir 'Qs*_hrr.csv']);

for i=1:length(listing)

    M = importdata([datadir listing(i).name],',',2);

    RI_IND = strfind(listing(i).name,'R');
    RI = listing(i).name(RI_IND+3:RI_IND+4);

    QS = listing(i).name(4:RI_IND-2);
    if QS(1)=='p'
        qs = str2num(['.',QS(2:end)]);
    else
        qs = str2num(QS);
    end

    N = length(M.data(:,1));
    q_range = round(N/2):N-1;
    t = M.data(:,1);
    HRR = M.data(:,2);
    Q_RADI = -M.data(:,3);

    % plot(t,HRR); hold on
    % plot(t,Q_RADI)

    CHI_R = mean(Q_RADI(q_range))/mean(HRR(q_range));

    switch RI
        case '05'; h(1)=semilogx(qs,CHI_R,'ksq'); hold on
        case '10'; h(2)=semilogx(qs,CHI_R,'r^'); hold on
        case '20'; h(3)=semilogx(qs,CHI_R,'go'); hold on
    end

end

axis([0.1 1e4 0 0.4])

xlabel('\itQ*' ,'Interpreter',Font_Interpreter,'FontSize',Label_Font_Size)
ylabel('\chi_r','Interpreter',Font_Interpreter,'FontSize',Label_Font_Size)

set(gca,'FontName',Font_Name)
set(gca,'FontSize',Label_Font_Size)

lh=legend(h,'\it{D*/\deltax}=5','\it{D*/\deltax}=10','\it{D*/\deltax}=20');
set(lh,'FontName',Font_Name,'FontSize',Key_Font_Size)

set(gcf,'Visible','on');
set(gcf,'Units',Paper_Units);
set(gcf,'PaperUnits',Paper_Units);
set(gcf,'PaperSize',[Paper_Width Paper_Height]);
set(gcf,'Position',[0 0 Paper_Width Paper_Height]);
print(gcf,'-dpdf','Heskestad_Rad_Frac');







