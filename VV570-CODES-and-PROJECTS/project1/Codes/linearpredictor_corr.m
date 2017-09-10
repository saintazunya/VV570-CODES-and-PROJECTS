function [ coeffs ] = linearpredictor_corr( p,audio,stp)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% p is how many signals we use
audio=audio(stp:stp+p+2);
R=zeros(p+1,1);
for i=1:p+1
    for j=1:p+1
        if i-j<0
            
        else
        R(i)=R(i)+audio(j+1)*audio(i-j+1);
        end
    end
end
r=R(1:p);
r_rest=R(2:p+1);
coeffs=LevinsonDurbin (r_rest, r)';
end



