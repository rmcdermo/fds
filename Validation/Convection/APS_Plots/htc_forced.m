% McDermott
% 11-14-2022
% htc_forced.m

close all
clear all

plot_style

outdir = '../RAYLEIGH3/';
pltdir = './';
chid = 'forced_conv_flat_plate';
vel = {'u0p1','u1','u10'};
res = {'25cm','10cm','2p5cm'};
res_style = {'b*','ksq','mo'};
u = [0.1,1,10];
dx = [0.25,0.1,0.025]; % grid resolution (m)
dx_style = {'b--','k--','m--'};

N = 32; % number of points in line device
L = 16; % domain length
rho = 1.165; % pure N2 specified in FDS input file
mu = 1E-05;  % specified in FDS input file
k = 1E-02;   % specified in FDS input file
T_w = 30;    % constant wall temperature specified
T_g = 20;    % T_infty inlet temperature specified

x = linspace(0,L,N);

for i=1:length(vel)

    Re_x = (rho/mu)*u(i)*x;
    Re_1 = (rho/mu)*u(i)*1;

    Nu_x = 0.0296 * Re_x.^0.8; % Incropera and Dewitt correlation, Eq. 7.36, Table 7.7
    Nu_1 = 0.0296 * Re_1.^0.8; % reference value for normalization of errors

    Nu_x_lam = 0.332 * Re_x.^0.5; % Holman, Eq. 5-44
    Nu_x_turb = 0.185 * log10(Re_x).^(-2.584) .* Re_x ;

    % BL_thickness = 0.37*x.*Re_x.^(-0.2);
    % BL_thickness(end)

    figure(i)
    set(gca,'Units',Plot_Units)
    set(gca,'Position',[Plot_X Plot_Y Plot_Width Plot_Height])

    H(1)=plot(Re_x,Nu_x); hold on
    H(2)=plot(Re_x,Nu_x_lam); hold on
    H(3)=plot(Re_x,Nu_x_turb); hold on
    xlabel('Re_x','Interpreter',Font_Interpreter,'FontSize',Label_Font_Size)
    ylabel('Nu_x','Interpreter',Font_Interpreter,'FontSize',Label_Font_Size)

    set(gca,'FontName',Font_Name)
    set(gca,'FontSize',Label_Font_Size)

    for j=1:length(res)

        % FDS results

        M = importdata([outdir,chid,'_',vel{i},'_',res{j},'_line.csv'],',',2);
        x_fds = M.data(:,find(strcmp(M.colheaders,'HTC-x')));
        h_fds = M.data(:,find(strcmp(M.colheaders,'HTC')));
        q_fds1 = M.data(:,find(strcmp(M.colheaders,'QCONV1')));
        q_fds2 = M.data(:,find(strcmp(M.colheaders,'QCONV1')));
        q_fds3 = M.data(:,find(strcmp(M.colheaders,'QCONV1')));
        q_fds4 = M.data(:,find(strcmp(M.colheaders,'QCONV1')));
        q_fds5 = M.data(:,find(strcmp(M.colheaders,'QCONV1')));
        q_fds6 = M.data(:,find(strcmp(M.colheaders,'QCONV1')));
        q_fds7 = M.data(:,find(strcmp(M.colheaders,'QCONV1')));
        q_fds8 = M.data(:,find(strcmp(M.colheaders,'QCONV1')));
        q_fds = (q_fds1+q_fds2+q_fds3+q_fds4+q_fds5+q_fds6+q_fds7+q_fds8)/8;
        DTMP_fds = -1000*q_fds./h_fds;
        Nu_x_fds = -1000*q_fds./(T_w-T_g).*x_fds/k;
        Re_x_fds = (rho/mu)*u(i)*x_fds;

        H(3+j)=plot(Re_x_fds,Nu_x_fds,res_style{j});
        H(3+length(res)+j)=plot(Re_x_fds,2/dx(j)*x_fds,dx_style{j});

        REL_ERROR(i,j) = abs(Nu_x(end)-Nu_x_fds(end))/Nu_x(end);

    end

    xl = get(gca,'XLim');
    yl = get(gca,'YLim');

    xtxt = xl(1) + 0.5*(xl(2)-xl(1));
    ytxt = yl(1) + 0.9*(yl(2)-yl(1));
    text(xtxt,ytxt,['Velocity = ',num2str(u(i)),' m/s'],'FontName',Font_Name,'FontSize',Title_Font_Size)

    lh=legend(H,'0.0296 Re_x^{4/5}','0.332 Re_x^{1/2}','0.185 log(Re_x)^{-2.584} Re_x',...
        'FDS \Deltax=25cm','FDS \Deltax=10cm','FDS \Deltax=2.5cm','2*1/0.25*x','2*1/0.10*x','2*1/0.025*x','location','eastoutside');
    set(lh,'FontName',Font_Name,'FontSize',Key_Font_Size)

    Git_Filename = [outdir,chid,'_',vel{i},'_25cm_git.txt'];
    addverstr(gca,Git_Filename,'linear')

    set(gcf,'Visible',Figure_Visibility);
    set(gcf,'Units',Paper_Units);
    set(gcf,'PaperUnits',Paper_Units);
    set(gcf,'PaperSize',[Paper_Width Paper_Height]);
    set(gcf,'Position',[0 0 Paper_Width Paper_Height]);
    print(gcf,'-dpdf',[pltdir,chid,'_',vel{i}]);
end

% Error test

% REF_ERROR determined from initial run
%            dx=25cm   dx=10cm   dx=2.5cm
REF_ERROR = [0.1199    0.1619    0.0410; ...
             0.3151    0.0466    0.2402; ...
             0.4046    0.2160    0.0670];

% Conclusion: At coarse resolution, forced convection is 40% error, at moderate to high resolution, 25%.

ERROR = norm(REL_ERROR-REF_ERROR); % 5e-3 tolerance

if ERROR > 5e-3
   display(['Matlab Warning: Forced convection out of tolerance. ERROR = ',num2str(ERROR)])
end
