% clear all;
% clc;
% % syms y;  %note
% Q_dB      = -10:10:40;
% d1        =1; %Khoang cach BS toi Su
% d2        =1; %Khoang cach BS toi Pu
%     path_loss = 3;
%     lamdabs   = d1.^path_loss;
%     lamdabp   = d2^path_loss;
% Pp_dB     = 1;%dB
% Pp        = 10^(Pp_dB/10); %Wat
% gammap    = Pp;  
% Pt_dB     = 20;
% Pt        = 10^(Pt_dB/10);
% 
% bit_frame = zeros(1,length(Q_dB));
% for ii = 1:length(Q_dB)
%    bit_frame(ii)   = 10^-1*10^5;
% end
% bit_frame;
% 
% gamma_th = 3 ; % target SNR %gamma_th
% Omega    = 0.005; %0.835;   % the average power of LOS component
% m        = 0.739; %10.1; %1 or 2 % the Nakagami-m parameter ranging from 0 to infinity
% b        = 0.1;%0.279; %0.126; % a half of the average power of the multipath component, ref paper
% 
% FIG=1;
% % Outage Probability
%     OP_SM_1(Q_dB,gamma_th,bit_frame,Omega,m,b,Pp,Pt,FIG,d1,d2);
%     OP_AN(Q_dB,gamma_th,Omega,m,b,Pp,Pt,FIG,d1,d2,lamdabs, lamdabp);
%     xlabel('Q(dB)'); ylabel('Xac suat dung');
%     legend ( {'OutSM', 'Fgammad'}, 'FontSize',8,'FontWeight','bold');
% 

clear all; %xoa tat ca cac bien da khai bao tu truoc do
clc; %xoa tat ca noi dung hien thi tren Command Window truoc do

Q_dB      = 5:5:30; %khoi tao vector co gia tri tu 5dB den 30dB voi buoc nhau la 5
d1        = 1; %khoi tao bien d1 (khoang cach SD1) voi gia tri la 1
d2        = 1; %khoi tao bien d2 (khoang cach SD2) voi gia tri la 1
path_loss = 3; %khoi tao he so suy hao voi gia tri la 3
lamdabs   = d1.^path_loss; %tinh lamdabs
lamdabp   = d2^path_loss; %tinh lamdabp
PS_dB     = 1; %khoi tao bien PS_dB voi gia tri la 1dB
PS        = 10^(PS_dB/10); %chuyen PS_dB sang don vi lan va gan cho PS
gammap    = PS; %gan PS cho gammap
Pt_dB     = 20; %khoi tao bien Pt_dB voi gia tri la 20dB
Pt        = 10^(Pt_dB/10); %chuyen Pt_dB sang don vi lan va gan cho Pt

bit_frame = zeros(1,length(Q_dB)); %tao vector bit_frame voi do dai bang voi Q_dB va co tat ca cac phan tu deu bang 0
for ii = 1:length(Q_dB) %vong lap for, bien dem ii chay tu 1 den do dai cua vecto Q_dB
   bit_frame(ii)   = 10^4; %doi voi moi gia tri cua ii, no gan gia tri 10^4 cho phan tu thu ii cua vector bit_frame
end

gamma_th = 3; %khoi tao bien gamma_th voi gia tri la 3

%khoi tao 2 bo so Shadowed - Rician
Omega_values = [0.279, 8.97*10^(-4)];
m_values     = [5.1, 0.739];
b_values     = [0.251, 0.063];

FIG=1; %khoi tao bien FIG voi gia tri la 1
figure(FIG); %tao ra 1 cua so do thi voi so hieu la 1, neu da ton tai thi lenh nay se dua cua o do len tren cung, con khong thi se tao ra 1 cua so do thi moi

for i = 1:length(Omega_values) %tao vong lap for voi bien dem i chay tu 1 den so luong phan tu trong vector Omega_values
    Omega = Omega_values(i); %gan gia tri phan tu thu i cua vector Omega_values cho bien Omega
    m     = m_values(i); %gan gia tri phan tu thu i cua vector m_values cho bien m
    b     = b_values(i); %gan gia tri phan tu thu i cua vector b_values cho bien b
    
    %doi voi moi lan lap, vong lap for se goi 2 ham OP_SM_1 va OP_AN voi cac doi so da duoc khai bao de tinh toan xac suat dung va sau do ve cac do thi tuong ung
    OP_SM_1(Q_dB,gamma_th,bit_frame,Omega,m,b,PS,Pt,FIG,d1,d2);
    OP_AN(Q_dB,gamma_th,Omega,m,b,PS,Pt,FIG,d1,d2,lamdabs,lamdabp);
    hold on; %giu nguyen cua so hien tai va cho phep them nhieu do thi vao cung 1 cua so
end

xlabel('Q(dB)'); ylabel('Xác suất dừng OP'); %dat ten cho cac truc toa do
legend ({'Mô phỏng OP b=0.251, m=5.1, omega=0.279', 'Phân tích OP b=0.251, m=5.1, omega=0.279', 'Mô phỏng OP b=0.063, m=0.739, omega=8.97*10^(-4)', 'Phân tích OP b=0.063, m=0.739, omega=8.97*10^(-4)'}, 'FontSize',8,'FontWeight','bold'); %tao chu thich voi kich thuoc chu la 8 va in dam

