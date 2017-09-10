function [ B ] = cholcomp( A )
% by  Cholesky¨CBanachiewicz algorithm
% revise A and return A as L(lower triangle)
len=length(A);
for i=1:len
    for m=1:i-1
       A(i,i)=A(i,i)-A(m,i)^2; 
    end
    A(i,i)=sqrt(A(i,i));% diagonal  values
%     if A(i,i)==0
%         A(i,i)=1e-10;
%     end
    for j=i+1:len
        for m=1:i-1
            A(i,j)=A(i,j)-A(m,i)*A(m,j);
        end
        A(i,j)=A(i,j)/A(i,i);
    end
end
   B = triu(A)';
end