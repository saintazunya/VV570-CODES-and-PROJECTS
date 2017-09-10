function [ J ] = JT2( X )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
J=[3,sin(X(2)*X(3))*X(3),sin(X(2)*X(3))*X(2);
        2*X(1), -1250*X(2),0;
                -X(2)*exp(-X(1)*X(2)),-X(1)*exp(-X(1)*X(2)),20
    ];

end

