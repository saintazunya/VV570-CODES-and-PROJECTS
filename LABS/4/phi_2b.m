function [ phi ] = phi_2b( t,X )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%phi=zeros(3,1);
phi(1)=10*(X(2)-X(1));
phi(2)=28*X(1)-X(2)-X(1)*X(3);
phi(3)=(-8/3)*X(3)+X(1)*X(2);
phi=phi';
end

