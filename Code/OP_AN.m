function F_gammad = OP_AN(Q_dB,gamma_th,Omega,m,b,Pp,Pt,FIG,lamdabs, lamdabp,d1,d2)
 betasp    = 1/(2*b);
 alphasp   = (((2*b*m)/(2*b*m + Omega)).^m)./(2.*b);
 deltasp     = Omega/(2*b*(2*b*m + Omega));
 
 path_loss = 3;
 lamdabs   = d1.^path_loss;
 lamdabp   = d2.^path_loss;
 
 gammap    = Pp;
 Q         = 10.^(Q_dB/10); 
 bggp      = betasp + lamdabs*gamma_th.*gammap./Pt;
 TP1       = Integralform(m,bggp,deltasp); %PDF IS CORRECT 
 
 TP2       = zeros(1,length(Q));   
 igammap   = lamdabs./gammap;
 gQg       = (lamdabs*gamma_th + lamdabp*Q)./(gamma_th.*gammap);
 for qq=1:length(Q_dB) 
   TP2(qq) = Integralform2(m,bggp,igammap,gQg(qq),deltasp,lamdabs); %PDF IS CORRECT 
 end
 
 F_gammad = 1 - alphasp.*exp(-lamdabs*gamma_th./Pt).*TP1 + alphasp.*exp(-(lamdabs*gamma_th+lamdabp*Q)./Pt).*TP2;
   %NOTE: sua lai F_gammad
 if (FIG==1) 
       F_gammad
       semilogy(Q_dB, F_gammad,'-r');
       grid on; hold on;      
       xlabel ('Qdb')
       ylabel ('Fgammad')
 end
 
end

function value = Integralform(m,bggp,deltasp)
    syms x;
    f1       = exp(-bggp*x);
    f2       = Kummer(m,1,deltasp*x);
    f        = f1*f2;
    answer   = int(f,x,0,Inf);
    value    = vpa(answer,10);
end

function value = Integralform2(m,bggp,igammap,gQg,deltasp,lamdabs)
syms y;
    f1       = lamdabs*y + igammap;
    f2       = exp(-bggp*y);
    f3       = Kummer(m,1,deltasp*y);
    f4       = lamdabs*y + gQg;
    f        = f1*f2*f3/f4;
    answer   = int(f,y,0,Inf);
    value    = vpa(answer,10);
end
 
 