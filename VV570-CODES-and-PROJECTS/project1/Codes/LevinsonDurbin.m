function x = LevinsonDurbin (r, b)
% Tx = b;    
% r is the left most cloumn of T
% init the variables
% https://en.wikipedia.org/wiki/Levinson_recursion
%r=r';
r_0=r(1);
len_r=length(r);
r_rest=(r(2:len_r)/r(1))';
p=length(b); 
y=zeros(p,1);
y(1)=-r_rest(1);  
x=zeros(p,1);
v=zeros(p,1);
z=zeros(p,1);
x(1)=b(1); 
alpha=-r_rest(1);
beta=1;
   for k=1:p-2%loop
       beta=(1-alpha^2)*beta;
       esp=(b(k+1)-r_rest(1:k)*x(k:-1:1))/beta;
       v(1:k)=x(1:k)+esp*y(k:-1:1);
       x(1:k+1)=[v(1:k);esp];
       alpha=-(r_rest(k+1)+r_rest(1:k)*y(k:-1:1))/beta;
       z(1:k)=y(1:k)+alpha*y(k:-1:1);
       y(1:k+1)=[z(1:k);alpha];
   end
x = (x/r_0)';
end