function [ coeffs ] = linearpredictor(len, audio,stp)
%UNTITLED4 Summary of this function goes here
%   len: number of samples used for the predictor.
%   audio: vioce sample.
%   stp: start point in the voice sample. 
%   returns coefficients a_i 
%   dependency: cholcomp.m
%   index with reference to p1
phi=zeros(len,len+1);
for k=1:len
    for i=0:len
        sigmaa=0;
        for j=1:len
            sigmaa =sigmaa+  audio(stp+j-k)*audio(stp+j-i);
        end
        phi(k,i+1)=sigmaa;
    end
end
vector_phizero=phi(:,1);
matrix_equation=phi(:,2:len+1);
L=cholcomp(matrix_equation);
y=L\vector_phizero;
x=L'\y;
%x=matrix_equation\vector_phizero;
coeffs=x;
end

