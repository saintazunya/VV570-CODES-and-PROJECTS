%% task 1 a
%[sol,P]=fixpt_HD(@G_T1,[1;2],1e-7,100);
%% task 1 b
% [p,err,k,y]=newton_HD(@F_T1,@J_F,[0.1;0.2],1e-7,100);
% k=8;
% for i=2:9
%     rate(i-1)=norm(p(:,i-1)-p(:,i));
% end
% rate./err
%% task 1 c
[p1,err,k,Y]=Broyden(@F_T1,@J_F,[0.1;0.2],[0.3;0.4],1e-7,200);
k=12;
for i=2:12
    rate(i-1)=norm(p1(:,i-1)-p1(:,i));
end
b=rate./err
