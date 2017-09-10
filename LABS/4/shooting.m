function [ y ] = shooting(  a,b,bc,tol )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    %bc y0,y1
    while(1)
    solinit=bvpinit(linspace(0,1,10),[1 0]);
    sol= bvp4c(@twonode,@twobc_,solinit);
    x=linspace(0,1,100);
    y=deval(sol,x);
    if y(100)-bc(2)<tol
        break;
    end
    %plot(x,y(1,:))
    end
end

