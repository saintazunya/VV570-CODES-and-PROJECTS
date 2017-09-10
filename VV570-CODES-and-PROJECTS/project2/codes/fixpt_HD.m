function [sol,P,err] = fixpt_HD(g,p0,tol,max1)

%Input   -  g is the iteration function
%           -  p0 is the initial guess for the fixed-point, p0=[p1;p2]
%           -  tol is the tolerance
%           -  max1 is the maximum number of iterations
%Output-  k is the number of iterations
%           -  p is the approximation to the fixed-point
%           - err is the error in the approximation
%           -  P' contains the sequence {pn}

%If g is defined as an M-file function use the @ notation
% call [k,p,err,P]=fixedpoint(@g,p0,tol,max1).
%If g is defined as an anonymous function use the
% call [k,p,err,P]=fixedpoint(g,p0,tol,max1).

%  NUMERICAL METHODS: Matlab Programs
% (c) 2004 by John H. Mathews and Kurtis D. Fink
%  Complementary Software to accompany the textbook:
%  NUMERICAL METHODS: Using Matlab, Fourth Edition
%  ISBN: 0-13-065248-2
%  Prentice-Hall Pub. Inc.
%  One Lake Street
%  Upper Saddle River, NJ 07458
P=zeros(length(p0),max1);

P(:,1)= p0;

for k=2:max1
	P(:,k)=g(P(1,k-1),P(2,k-1),P(3,k-1));
	err(k-1)=norm(P(:,k)-P(:,k-1));
	%relerr=err/(abs(P(:,k))+eps);
	
	if (err(k-1)<tol),break;end
end

sol=P(:,k);

