function [ J ] = J_T3( para )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
global X
a=para(1);
b=para(2);
r=para(3);  
J1=@(x)exp(b/(r+x));
J2=@(x)exp(a*exp(b/(r+x)))/(r+x);
J3=@(x)-1/(r+x)^2*(a*b*exp(b/(r+x)));
J=zeros(16,3);%dim:10*3
for i=1:length(X)
    J(i,1)=-J1(X(i));J(i,2)=-J2(X(i));J(i,3)=-J3(X(i));
end
end

