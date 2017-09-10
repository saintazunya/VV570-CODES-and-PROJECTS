%% p1 a
% syms t
% equation = 'Dy = (y+t)/(y-t)';
% initial = 'y(0) = 1';
% y = dsolve(equation, initial, 't');
% pretty(y)
% y =t + 2^(1/2)*(t^2 + 1/2)^(1/2);
% t = linspace( 0, 1, 20);
% z = eval(vectorize(y));
% plot(t,z)
%% p1 b/c/d/e/f
clear all
f=@(t,y)  (y+t)/(y-t);
ff=@(t,y) (t + y)/(t - y)^2 - 1/(t - y);
fff=@(t,y)2/(t - y)^2 - (2*(t + y))/(t - y)^3;
ffff=@(t,y)(6*(t + y))/(t - y)^4 - 6/(t - y)^3;
a=0;
b=1;
ya=1;
j=1;
% for M=[10,100,1000,10000]
%     E=euler(f,a,b,ya,M);
%     E_h=heun(f,a,b,ya,M);
%     tvalue=E(:,1);
%     yvalue=E(:,2);
%     tvalue_h=E_h(:,1);
%     yvalue_h=E_h(:,2);
%     t=tvalue;
%     t_h=tvalue_h;
%     yy_real=t+2^(1/2)*(t.^2 + 1/2).^(1/2);
%     yy_real_h=t_h+2^(1/2)*(t_h.^2 + 1/2).^(1/2);
%     %local_e(j)=yy_real(M)-yvalue(M);
%     %max_local_t(j)=max(abs(local_e));
%     %global_e(j)=sum(local_e);
%     %local_e_h(j)=yy_real_h(M)-yvalue_h(M);
%     %max_local_t_h(j)=max(abs(local_e_h));
%     %global_e_h(j)=sum(local_e_h);
% %     [ t_ab, y_ab ] = ab2 ( f, [a,b], ya, M );
% %     yy_real_ab=t_ab+2^(1/2)*(t_ab.^2 + 1/2).^(1/2);
% %     local_e_ab(j)=yy_real_ab(M)-y_ab(M);
% %     %max_local_t_ab(j)=max(abs(local_e_ab));
% %     %global_e_ab(j)=sum(local_e_ab);
% %     j=j+1;
% end
for M=[10,100,1000,10000]
    E= rk4(f,a,b,ya,M);
    t_=E(:,1);
    y_=E(:,2);
    yy_real_=t_+2^(1/2)*(t_.^2 + 1/2).^(1/2);
    local_e_(j)=yy_real_(M)-y_(M);
    %max_local_t_(j)=max(abs(local_e_));
    %global_e_(j)=sum(local_e_);
    j=j+1;
end
% df={f, ff, fff, ffff};
% for M=[10,100,1000,10000]
%     E= taylor(df,a,b,ya,M);
%     t_=E(:,1);
%     y_=E(:,2);
%     yy_real_=t_+2^(1/2)*(t_.^2 + 1/2).^(1/2);
%     local_e_=yy_real_-y_;
%     max_local_t_(j)=max(abs(local_e_));
%     global_e_(j)=sum(local_e_);
%     j=j+1;
% end
%% p2
% f=@(t,y)  (y+t)/(y-t);
% Y0=1;
% a=0;
% b=1;
% ya=1;
% j=1;
% for M=[10,100,1000,10000]
% TSPAN=linspace(a,b,M);
% [TOUT,YOUT] = ode23(f,TSPAN,Y0);
% yy_real_=TOUT+2^(1/2)*(TOUT.^2 + 1/2).^(1/2);
% local_e_(j)=yy_real_(M)-YOUT(M)
% %max_local_t_(j)=max(abs(local_e_));
% %global_e_(j)=sum(local_e_);
% j=j+1;
% end
%% 2 b
%phi_2b(1,[1,2,3])
%% 2 c/d
% clear all
% f=@phi_2b;
% a=0;
% b=20;
% ya=[-8 10 27];
% j=1;
% for M=[100]
% TSPAN=linspace(a,b,M);
% [TOUT,YOUT] = ode45(f,TSPAN,ya);
% X=YOUT;
% end
% t=TSPAN;
% plot(X(:,1), X(:,2))
% plot(X(:,1), X(:,3))
% plot(X(:,2), X(:,3))
% subplot(3,1,1)
% plot(t,X(:,1))
% subplot(3,1,2)
% plot(t,X(:,2))
% subplot(3,1,3)
% plot(t,X(:,3))
%% p3
% clear all
% close all
% h = 0.1; % mesh size
% [x,y] = meshgrid ( 0:h:2*pi, -1:h:1 );
% px = ones ( size ( x ) );
% py = stiff2ode ( x, y );
% quiver ( x, y, px, py )
% axis tight equal
% hold on
% x1=(0:h:2*pi);
% y1=stiff2solution(x1);
% plot(x1,y1,'r')
% % hold off
%% 3 b
% f=@stiff2ode;
% a=0;
% b=2*pi;
% ya=0;
% M=40;
% E=euler(f,a,b,ya,M);
%% 3 c
% f=@stiff2ode;
% a=0;
% b=2*pi;
% ya=0;
% M=400000;
% E=rk4(f,a,b,ya,M);
%% 3 d
% clear all
% f=@stiff2ode;
% a=0;
% b=2*pi;
% ya=0;
% j=1;
% for M=[1000]
% TSPAN=linspace(a,b,M);
% [TOUT,YOUT] = ode15s(f,TSPAN,ya);
% X=YOUT;
% end
% YOUT(1000)
%% 4 a

% solinit=bvpinit(linspace(0,1,10),[1 0]);
% sol= bvp4c(@twonode,@twobc,solinit);
% x=linspace(0,1,100);
% y=deval(sol,x);
% plot(x,y(1,:))
%% 4 b
% y = shooting( 0,1,[0,1],1e-6 )
%% 4 c
%y=

       
        