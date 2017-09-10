%% a)
%x=[1 2 3 4 5 6 ];
%y=[66 66 65 64 63 63];
%lagrinterpol(x,y,4.5);
%% b)
%poly([2,3,5,7,9])
%   poly(V), when V is a vector, is a vector whose elements are
%     the coefficients of the polynomial whose roots are the
%     elements of V . For vectors, ROOTS and poly are inverse
%     functions of each other, up to ordering, scaling, and
%     roundoff error.
%% c)
%v=[2 7 1 8 2 8];
%poly(v)
%% d)
% a = [2 7 1 8 2 8];
% P = poly([a(1) a(2) a(3)]);
% Q = poly([a(4) a(5) a(6)]);
% conv(P,Q)
% help conv
%% e)
% a = [2 7 1 8 2 8];
% coeff=[a(1) a(2) a(3)];
% polyval(coeff,[a(4) a(5) a(6)])
% help polyval
%  Y = polyval(P,X) returns the value of a polynomial P evaluated at X. P
%     is a vector of length N+1 whose elements are the coefficients of the
%     polynomial in descending powers.
%  
%         Y = P(1)*X^N + P(2)*X^(N-1) + ... + P(N)*X + P(N+1)
%  
%     If X is a matrix or vector, the polynomial is evaluated at all
%     points in X.  See POLYVALM for evaluation in a matrix sense.
%% f)
% x=[1 2 3 4 5 6];
% y=[66 66 65 64 63 63];
% [a,coeff]=findfirstdiffcoeff(x,y);
% xx=linspace(1,6,10000);
% %yy=poly2sym(coeff);
% yy=(46912496118445*xx.^4)/562949953421312 - (10262108525909*xx.^3)/8796093022208 + 6*xx.^2 - (7375890502997*xx)/549755813888 + 2744197770991/274877906944;
% plot(xx,yy)
%% 2
%% a,b)
% clear all;
% close all;
% N=5;
% xdata=linspace(0,1000,N+1);
% ydata=randn([1,N+1]);
% tic
% Cnewton=newpoly(xdata,ydata);
% toc
% tic
% Clagrange= lagrinterpolde(xdata,ydata);
% toc
%% c)
% N=10;
% xdata=linspace(0,1000,N+1);
% rng(0)
% ydata=randn([1,N+1]);
% Cnewton=newpoly(xdata,ydata);
% Clagrange= lagrinterpolde(xdata,ydata);
% x_plot_points =linspace(0,1000,500);
% plot(xdata,ydata,'.')
% hold on
% plot(x_plot_points,polyval(Cnewton,x_plot_points),'b')
% plot(x_plot_points,polyval(Clagrange,x_plot_points),'-.r')
% hold off
% N=30;
% xdata=linspace(0,1000,N+1);
% rng(0)
% ydata=randn([1,N+1]);
% Cnewton=newpoly(xdata,ydata);
% Clagrange= lagrinterpolde(xdata,ydata);
% x_plot_points =linspace(0,1000,500);
% plot(xdata,ydata,'.')
% hold on
% plot(x_plot_points,polyval(Cnewton,x_plot_points),'b')
% plot(x_plot_points,polyval(Clagrange,x_plot_points),'-.r')
% hold off
%% 3
%% a)
% clear all;
% close all;
% syms x
% f=symfun(1/(1+25*x^2),x);
% N=10;
% xdata= linspace(-1,1,N+1);
% ydata=double(f(xdata));
% polyfit(xdata,ydata,N)
%% b)
% clear all;
% close all;
% syms x
% f=symfun(1/(1+25*x^2),x);
% N=20;
% xdata= linspace(-1,1,N+1);
% ydata=double(f(xdata));
% coeff20=polyfit(xdata,ydata,N);
% ff=symfun(poly2sym(coeff20),x);
% yy=double(ff(xdata));
% plot(xdata,yy,'-.g')
% hold on
% N=40;
% xdata= linspace(-1,1,N+1);
% f=symfun(1/(1+25*x^2),x);
% ydata=double(f(xdata));
% coeff40=polyfit(xdata,ydata,N);
% fff=symfun(poly2sym(coeff40),x);
% yyy=double(fff(xdata));
% plot(xdata,yyy,'-.b')
% axis=[-1 1 -5 5];
%% c)
% clear all;
% close all;
% syms x
% f=symfun(1/(1+25*x^2),x);
% N=20;
% for i=1:N
%     xdata(i)=cos((2*i-1)/(2*N)*pi);
% end
% ydata=double(f(xdata));
% coeff20=polyfit(xdata,ydata,N);
% ff=symfun(poly2sym(coeff20),x);
% yy=double(ff(xdata));
% plot(xdata,yy,'-.g')
% hold on
% N=40;
% for i=1:N
%     xdata(i)=cos((2*i-1)/(2*N)*pi);
% end
% f=symfun(1/(1+25*x^2),x);
% ydata=double(f(xdata));
% coeff40=polyfit(xdata,ydata,N);
% fff=symfun(poly2sym(coeff40),x);
% yyy=double(fff(xdata));
% plot(xdata,yyy,'-.b')
% axis=[-1 1 -5 5];
%% d)
% clear all;
% close all;
% for N=[5,10,15,20]
% xdata=linspace(-1,1,N+1);
% syms x
% f=symfun(1/(1+25*x^2),x);
% ydata=double(f(xdata));
% [coeff,c]=newpoly(xdata,ydata);
%  ff=symfun(poly2sym(coeff),x);
%  yy=double(ff(xdata));
%  plot(xdata,yy)
%  hold on
%  axis=[-1,1,0,1];
% end
%% e)
clear all;
close all;
for N=[5,10,15,20]
    for i=1:N
        xdata(i)=cos((2*i-1)/(2*N)*pi);
    end
syms x
f=symfun(1/(1+25*x^2),x);
ydata=double(f(xdata));
[coeff,c]=newpoly(xdata,ydata);
 ff=symfun(poly2sym(coeff),x);
 yy=double(ff(xdata));
 plot(xdata,yy)
 hold on
 axis=[-1,1,0,1];
end

    