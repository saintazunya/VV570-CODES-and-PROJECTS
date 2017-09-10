function [ G_X ] = G_T1( X )
%UNTITLED Summary of this function goes here
%   X=[x1;x2]
%   G=[y1;y2]
G_X=[1/100*(X(1)^2-X(2))+X(1);
        1/100*(X(1)^2+X(2)^2-1)+X(2)];
end

