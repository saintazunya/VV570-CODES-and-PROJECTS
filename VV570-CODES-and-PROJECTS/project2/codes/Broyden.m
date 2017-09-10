function [p1,err,k,Y]=Broyden(f,df,X1,X2,delta,max1)

%Input    - f is the object function 
%            - p0 and p1 are the initial approximations to a zero of f        
%	         - delta is the tolerance for p1
%	         - epsilon is the tolerance for the function values y
%	         - max1 is the maximum number of iterations
%Output - p1 is the secant method approximation to the zero
%	         - err is the error estimate for p1
%	         - k is the number of iterations
%	         - y is the function value f(p1)

%If f is defined as an M-file function use the @ notation
% call [c,err,yc]=bisect(@f,a,b,delta).
%If f is defined as an anonymous function use the
% call [c,err,yc]=bisect(f,a,b,delta).

%  NUMERICAL METHODS: Matlab Programs
% (c) 2004 by John H. Mathews and Kurtis D. Fink
%  Complementary Software to accompany the textbook:
%  NUMERICAL METHODS: Using Matlab, Fourth Edition
%  ISBN: 0-13-065248-2
%  Prentice-Hall Pub. Inc.
%  One Lake Street
%  Upper Saddle River, NJ 07458
max1=max1+1;
len=length(X1);
S=zeros(len,max1);
S(:,1)=X2-X1;
Y=zeros(len,max1);
Y(:,1)=f(X2)-f(X1);
A=zeros(len,len,max1);
A(:,:,1)=df(X1)+(f(X2)-f(X1)-df(X1)*(X2-X1))*(X2-X1)'/norm(X2-X1)^2;
X=zeros(len,max1);
p1=zeros(len,max1);
X(:,1)=X1;
X(:,2)=X2;
A(:,:,1)=inv(A(:,:,1));% A is the inverse of A, we calculate it directly in the iteration
for k=2:max1
    S(:,k)=X(:,k)-X(:,k-1);
    Y(:,k)=f(X(:,k))-f(X(:,k-1));
    A(:,:,k)=A(:,:,k-1)+((S(:,k)-A(:,:,k-1)*Y(:,k))*S(:,k)'*A(:,:,k-1))/(S(:,k)'*A(:,:,k-1)*Y(:,k));
    %A(:,:,k)
    w=A(:,:,k)*f(X(:,k));
    X(:,k+1)=X(:,k)-w;
    err(k-1)=norm(Y(:,k));
    p1(:,k-1)=X(:,k+1); 
	if err(k-1)<delta
       break;
    end
end
end


