% %Phan tich xác su?t d?ng c?a h? th?ng theo kho?ng cách t? BS t?i SU, PU
% clear all;
% clc;
% % syms y;  %note
% Q_dB      = 30;
% Q         = 10.^(Q_dB/10); %co dinh
% d1        = 1:0.1:1.5; %Khoang cach Bs toi SU
% d2        = 2; %Khoang cach Bs toi Pu
% path_loss = 3;
% lamdabs   = d1.^path_loss;
% lamdabp   = d2^path_loss;
% Pt_dB     = 1;
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
% Omega    = 0.835;   % the average power of LOS component
% m        = 10.1; %1 or 2 % the Nakagami-m parameter ranging from 0 to infinity
% b        = 0.126; % a half of the average power of the multipath component, ref paper
% FIG      = 3;
% OPvd_SM = zeros(1,length(d1));
% OPvd_AN = zeros(1,length(d1));
% 
% for kk=1:length(d1)
%     OPvd_AN(kk) = OP_AN(Q_dB,gamma_th,Omega,m,b,Pp,Pt,FIG,lamdabs,lamdabp,d1(kk),d2);
%     OPvd_SM(kk) = OP_SM_1(Q_dB,gamma_th,bit_frame,Omega,m,b,Pp,Pt,FIG,d1(kk),d2);    
% end
% OPvd_AN
% semilogy(d1, OPvd_AN,'-b');
% grid on; hold on;   
% 
% OPvd_SM
% semilogy(d1, OPvd_SM,'+b');
% grid on; hold on;      
% xlabel('d1'); ylabel('Xac suat dung');
% legend ( {'Mo phong OP b=0.251, m=5.1, omega=0.279', 'Phan tich OP bb=0.251, m=5.1, omega=0.279'}, 'FontSize',8,'FontWeight','bold');
% 
% %ch?a ch?nh l?i tích phân file AN
% 
%Phan tich xác su?t d?ng c?a h? th?ng theo kho?ng cách t? BS t?i SU, PU

clear all; %xoa tat ca cac bien da khai bao tu truoc do
clc; %xoa tat ca noi dung hien thi tren Command Window truoc do

Q_dB      = 30; %khoi tao vecto Q_dB voi gia tri la 30
Q         = 10.^(Q_dB/10); %chuyen Q_dB sang don vi lan va gan cho Q
d1        = 1:0.1:1.5; %khoi tao vector d1 (khoang cach SD1) co gia tri tu 1 den 1.5 voi buoc nhau la 0.1
d2        = 2; %khoi tao bien d2 (khoang cach SD2) voi gia tri la 2
path_loss = 3; %khoi tao he so suy hao voi gia tri la 3
lamdabs   = d1.^path_loss; %tinh lamdabs
lamdabp   = d2^path_loss; %tinh lamdabp
Pt_dB     = 1; %khoi tao bien Pt_dB voi gia tri la 1dB
Pt        = 10.^(Pt_dB/10); %chuyen Pt_dB sang don vi lan va gan cho Pt
Pp_dB     = 1; %khoi tao bien Pp_dB voi gia tri la 1dB
Pp        = 10^(Pp_dB/10); %chuyen Pp_dB sang don vi lan va gan cho Pp
gammap    = Pp; %gan Pp cho gammap

bit_frame = zeros(1,length(Q_dB)); %tao vector bit_frame voi do dai bang voi Q_dB va co tat ca cac phan tu deu bang 0
for ii = 1:length(Q_dB) %vong lap for, bien dem ii chay tu 1 den do dai cua vecto Q_dB
   bit_frame(ii)   = 10^4; %doi voi moi gia tri cua ii, no gan gia tri 10^4 cho phan tu thu ii cua vector bit_frame
end

gamma_th = 3 ; %khoi tao bien gamma_th voi gia tri la 3

%khoi tao bo so Shadowed - Rician
Omega    = 0.279;
m        = 5.1;
b        = 0.251;

FIG      = 3; %khoi tao bien FIG voi gia tri la 1

%khoi tao 2 vector OPvd_SM va OPvd_AN voi do dai bang voi d1, tat ca cac phan tu deu bang 0
OPvd_SM = zeros(1,length(d1));
OPvd_AN = zeros(1,length(d1));

for kk=1:length(d1) %tao vong lap for voi bien dem kk chay tu 1 den so luong phan tu trong vector d1
    OPvd_AN(kk) = OP_AN(Q_dB,gamma_th,Omega,m,b,Pp,Pt,FIG,lamdabs,lamdabp,d1(kk),d2); %goi ham OPvd_AN(kk) voi cac doi so da duoc khai bao truoc va gia tri thu kk cua d1, gan ket qua vao phan tu thu kk cua vector OPvd_AN
    OPvd_SM(kk) = OP_SM_1(Q_dB,gamma_th,bit_frame,Omega,m,b,Pp,Pt,FIG,d1(kk),d2); %goi ham OPvd_SM(kk) voi cac doi so da duoc khai bao truoc va gia tri thu kk cua d1, gan ket qua vao phan tu thu kk cua vector OPvd_SM    
end
OPvd_AN
semilogy(d1, OPvd_AN,'-b'); %ve do thi voi truc hoanh la d1, truc tung la OPvd_AN su dung logarit tu nhien, bieu dien bang duong net lien mau xanh duong
grid on; hold on; %hien thi luoi va giu nguyen cua so do thi hien tai de cho phep them nhieu do thi vao cung 1 cua so  

OPvd_SM
semilogy(d1, OPvd_SM,'+b'); %ve do thi voi truc hoanh la d1, truc tung la OPvd_SM su dung logarit tu nhien, bieu dien bang cac dau + mau xanh duong
grid on; hold on; %hien thi luoi va giu nguyen cua so do thi hien tai de cho phep them nhieu do thi vao cung 1 cua so        

xlabel('d1'); ylabel('Xac suat dung'); %dat ten cho cac truc toa do
legend ( {'Mo phong OP b=0.251, m=5.1, omega=0.279', 'Phan tich OP bb=0.251, m=5.1, omega=0.279'}, 'FontSize',8,'FontWeight','bold'); %tao chu thich voi kich thuoc la 8 va in dam




