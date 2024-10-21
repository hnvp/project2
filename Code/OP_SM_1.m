function Out_SM = OP_SM_1(Q_dB,gamma_th,bit_frame,Omega,m,b,Pp,Pt,FIG,d1,d2)
CDF_SM             = zeros(1,length(Q_dB)); %?
Q                  = 10.^(Q_dB/10);
path_loss          = 3;
%hbs
Ohm1                = 1./d1^(path_loss);

%hbp
Ohm2                = 1./d2^(path_loss);

for kk=1:length(Q_dB)
     kk;  
     for bit_num = 1:bit_frame(kk)          
        Ysas  = ShadowedRicianRandGen(b,m,Omega,1); % Nagakami channel from sattelite to SU
        
        hbp  = gauss(0,Ohm2/2,1,1)+ i*gauss(0,Ohm2/2,1,1); %rayleigh channel 
        Xbp   = abs(hbp)^2;   %channel gain from BS to PU 
        
        hbs  = gauss(0,Ohm1/2,1,1)+ i*gauss(0,Ohm1/2,1,1); %rayleigh channel
        Xbs   = abs(hbs)^2;   %channel gain from BS to SU 
        
        Ps   = min(Q(kk)/Xbp, Pt );%(2)
        gammad  = Ps*Xbs/(Pp*Ysas + 1);%(3)   

        if (gammad < gamma_th) %CDF 
            CDF_SM(kk)  = CDF_SM(kk) + 1;            
        end         
      end
end
 CDF_SM    =   CDF_SM./bit_frame;
 Out_SM    = CDF_SM;
 if (FIG==1) 
       Out_SM
       semilogy(Q_dB, CDF_SM,'sr');
       grid on; hold on;      
 end
end

