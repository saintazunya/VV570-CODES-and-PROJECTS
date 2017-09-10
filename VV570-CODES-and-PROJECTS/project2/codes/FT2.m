function [ y ] = FT2( X )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
y=[ 3*X(1)-cos(X(2)*X(3))-1/2;
        X(1)^2-625*X(2)^2-1/4;
            exp(-X(1)*X(2))+20*X(3)-(3-10*pi)/(3)
            ];

end

