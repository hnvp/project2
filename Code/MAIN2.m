% %Phan tich xác su?t d?ng c?a h? th?ng theo công su?t phát t?i tr?m g?c
% clear all;
% clc;
% % syms y;  %note
% Q_dB      = 30;
% Q         = 10.^(Q_dB/10); %co dinh
% d1        =1; %Khoang cach BS t?i Su
% d2        =1; %Khoang cach BS toi Pu
% path_loss = 3;
% lamdabs   = d1.^path_loss;
% lamdabp   = d2^path_loss;
% Pt_dB     = -10:10:30;
% Pt        = 10.^(Pt_dB/10); %vecto chay
% Pp_dB     = 1;%dB
% Pp        = 10^(Pp_dB/10);
% gammap    = Pp;
% 
% bit_frame = zeros(1,length(Q_dB));
% for ii = 1:length(Q_dB)
%    bit_frame(ii)   = 10^-1*10^5;
% end
% bit_frame;
% 
% gamma_th = 3 ; % target SNR %gamma_th
% Omega    = 0.008; %0.835;   % the average power of LOS component
% m        = 0.739; %10.1; %1 or 2 % the Nakagami-m parameter ranging from 0 to infinity
% b        = 0.063; %0.126; % a half of the average power of the multipath component, ref paper
% FIG      = 2;
% OPvPt_SM = zeros(1,length(Pt_dB));
% OPvPt_AN = zeros(1,length(Pt_dB));
% 
% for kk=1:length(Pt_dB)
%     OPvPt_AN(kk) = OP_AN(Q_dB,gamma_th,Omega,m,b,Pp,Pt(kk),lamdabs, lamdabp,FIG,d1,d2);
%     OPvPt_SM(kk) = OP_SM_1(Q_dB,gamma_th,bit_frame,Omega,m,b,Pp,Pt(kk),FIG,d1,d2);    
% end
% OPvPt_AN
% semilogy(Pt_dB, OPvPt_AN,'-k');
% grid on; hold on;   
% 
% OPvPt_SM
% semilogy(Pt_dB, OPvPt_SM,'ok');
% grid on; hold on;      
% xlabel('Pt(dB)'); ylabel('Xac suat dung');
% legend ( {'Fgammad','OutSM'}, 'FontSize',8,'FontWeight','bold');
% 
% 

clear all; %xoa tat ca cac bien da khai bao tu truoc do
clc; %xoa tat ca noi dung hien thi tren Command Window truoc do

Q_dB      = 30; %khoi tao vecto Q_dB voi gia tri la 30dB
Q         = 10.^(Q_dB/10); %chuyen Q_dB sang don vi lan va gan cho Q
d1        = 1; %khoi tao bien d1 (khoang cach SD1) voi gia tri la 1
d2        = 1; %khoi tao bien d2 (khoang cach SD2) voi gia tri la 1
path_loss = 3; %khoi tao he so suy hao voi gia tri la 3
lamdabs   = d1.^path_loss; %tinh lamdabs
lamdabp   = d2^path_loss; %tinh lamdabp
Pt_dB     = -10:10:30; %khoi tao vector co gia tri tu -10dB den 30dB voi buoc nhau la 10
Pt        = 10.^(Pt_dB/10); %chuyen Pt_dB sang don vi lan va gan cho Pt
Pp_dB     = 1; %khoi tao bien Pp_dB voi gia tri la 1dB
Pp        = 10^(Pp_dB/10); %chuyen Pp_dB sang don vi lan va gan cho Pp
gammap    = Pp; %gan Pp cho gammap

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
    
    %khoi tao 2 vector OPvPt_SM va OPvPt_AN voi do dai bang voi Pt_dB, tat ca cac phan tu deu bang 0
    OPvPt_SM = zeros(1,length(Pt_dB));
    OPvPt_AN = zeros(1,length(Pt_dB));

    for kk=1:length(Pt_dB) %tao vong lap for voi bien dem kk chay tu 1 den so luong phan tu trong vector Pt_dB
        OPvPt_AN(kk) = OP_AN(Q_dB,gamma_th,Omega,m,b,Pp,Pt(kk),lamdabs, lamdabp,FIG,d1,d2); %goi ham OPvPt_AN(kk) voi cac doi so da duoc khai bao truoc va gia tri thu kk cua Pt, gan ket qua vao phan tu thu kk cua vector OPvPt_AN
        OPvPt_SM(kk) = OP_SM_1(Q_dB,gamma_th,bit_frame,Omega,m,b,Pp,Pt(kk),FIG,d1,d2); %goi ham OPvPt_SM(kk) voi cac doi so da duoc khai bao truoc va gia tri thu kk cua Pt, gan ket qua vao phan tu thu kk cua vector OPvPt_SM
    end

    semilogy(Pt_dB, OPvPt_AN); %ve do thi voi truc hoanh la Pt_dB, truc tung la OPvPt_AN su dung logarit tu nhien
    hold on; %giu nguyen cua so hien tai va cho phep them nhieu do thi vao cung 1 cua so
    semilogy(Pt_dB, OPvPt_SM, 'o'); %ve do thi voi truc hoanh la Pt_dB, truc tung la OPvPt_SM su dung logarit tu nhien, du lieu duoc bieu dien bang cac diem co dang 'o'
    hold on; %giu nguyen cua so hien tai va cho phep them nhieu do thi vao cung 1 cua so
end

xlabel('Pt(dB)'); ylabel('Xac suat dung'); %dat ten cho cac truc toa do
legend ( {'Mo phong OP b=0.251, m=5.1, omega=0.279', 'Phan tich OP b=0.251, m=5.1, omega=0.279', 'Mo phong OP b=0.063, m=0.739, omega=8.97*10^(-4)', 'Phan tich OP b=0.063, m=0.739, omega=8.97*10^(-4)'}, 'FontSize',8,'FontWeight','bold'); %tao chu thich voi kich thuoc chu la 8 va in dam
