function [p,err,k,y,sol]=newton_HD(f,df,p0,delta,max1)

%Input    - f is the object function 
%            - df is the derivative of f 
%            - p0 is the initial approximation to a zero of f
%	         - delta is the tolerance for p0
%	         - epsilon is the tolerance for the function values y
%	         - max1 is the maximum number of iterations
%Output - p0 is the Newton-Raphson approximation to the zero
%	         - err is the error estimate for p0
%	         - k is the number of iterations
%	         - y is the function value f(p0)

%If f and df are defined as M-file functions use the @ notation
% call [p0,err,k,y]=newton(@f,@df,p0,delta,epsilon,max1).
%If f and df are defined as anonymous functions use the
% call  [p0,err,k,y]=newton(f,df,p0,delta,epsilon,max1).



%  NUMERICAL METHODS: Matlab Programs
% (c) 2004 by John H. Mathews and Kurtis D. Fink
%  Complementary Software to accompany the textbook:
%  NUMERICAL METHODS: Using Matlab, Fourth Edition
%  ISBN: 0-13-065248-2
%  Prentice-Hall Pub. Inc.
%  One Lake Street
%  Upper Saddle River, NJ 07458
len=length(p0);
y=zeros(len,max1);
w=zeros(len,max1);
p=zeros(len,max1);
p(:,1)=p0;
for k=1:max1-1	
	y(:,k)=-f(p(:,k));
    w(:,k)=df(p(:,k))\y(:,k);
    p(:,k+1)=p(:,k)+w(:,k);
    err(k)=norm(y(:,k));
	if err(k)<delta
       sol=p(:,k+1); 
       break;
    end
end
sol=p(:,k+1);
end
%a=1

