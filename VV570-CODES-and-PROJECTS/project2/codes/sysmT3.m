function [ p ] = sysmT3( para )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%para=[a;b;r]
global X Y
p=zeros(length(X),1);
a=para(1);
b=para(2);
r=para(3);
%Y=[34780;28610;23650;19630;16370;13720;11540;9744;8261;7030;6005;5147;4427;3820;3307;2872];
for i=1:length(X)
    p(i)=Y(i)-a*exp(b/(X(i)+r));
end

