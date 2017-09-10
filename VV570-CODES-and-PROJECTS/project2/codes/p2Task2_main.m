% % syms x1 x2 x3
% % g=[3*x1-cos(x2*x3);
% %     x1^2-625*x2^2-1/4;
% %     exp(-x1*x2)+20*x3-(3-10*pi)/3];
% % J=jacobian(g,[x1,x2,x3]);
% gg=@(x1,x2,x3)[1/3*cos(x2*x3)+1/6;
%         1/25*sqrt(abs(x1^2-1/4));
%             -1/20*exp(-x1*x2)+1/60*(3-10*pi)
%     ];
% %JJ=jacobian(gg,[x1,x2,x3])
% [sol,P,err] =fixpt_HD(gg,[0.1,0.1,0.1],1e-7,100);
% format SHORTE
% b=diff(err);
% format short
% for i=1:length(b)-1
%     c(i)=abs(b(i)/b(i+1)^(2));
%     cc(i)=abs(b(i)/b(i+1)^(1));
% end
% matrix2latex([cc',c'],'anothermatrix.txt')
% %err
%% fixed point
% %G=@(X) FT2(X)/(100)+X;
% %[sol,P] =fixpt_HD(G,[1;2;3],1e-7,100);
%% newton's method
% f=@(X) FT2(X);
% df=@(X) JT2(X);
% f([1;2;3]);
% [p,err,k,y,sol]=newton_HD(f,df,[1;2;3],1e-7,100);
% a=[p(:,2:20)',err'];
% matrix2latex(a,'matrix.txt');
% format SHORTE
% b=diff(err);
% format short
% for i=1:length(b)-1
%     c(i)=abs(b(i)/b(i+1)^(2));
%     cc(i)=abs(b(i)/b(i+1)^(1));
% end
% matrix2latex([cc',c'],'anothermatrix.txt')
%% Broyden's method
f=@(X) FT2(X);
df=@(X) JT2(X);
[p1,err,k,Y]=Broyden(f,df,[1;2;3],[4;5;6],1e-7,100);
a=[p1(:,1:28)',err'];
matrix2latex(a,'matrix.txt');
format SHORTE
b=diff(err);
format short
for i=1:length(b)-1
    c(i)=abs(b(i)/b(i+1)^(2));
    cc(i)=abs(b(i)/b(i+1)^(1));
end
matrix2latex([cc',c'],'anothermatrix.txt')