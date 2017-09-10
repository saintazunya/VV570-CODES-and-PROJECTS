close all
y = wavread('Track 1.wav');
len=length(y)/50;
for i=1:len
   % lower sample rate
   yy(i)=y(i*50);
end
%plot(1:len,yy);
sigpot=13000;
for i=1:100
    t = clock;
    coeff=linearpredictor( 50, yy,sigpot+i);
    T(i)=etime(clock, t);
    t = clock;
    coeff_=linearpredictor_corr(50,yy',sigpot+i);
    T_(i)=etime(clock, t);
    test_sample=yy(:,sigpot-50+1+i:sigpot+i);
    k=fliplr(test_sample);
    E(i)=k*coeff-yy(sigpot+1+i);% ERROR matrix: predicted value- real value.
    E_corr(i)=k*coeff_-yy(sigpot+1+i);
end
Tavg=mean(T);
T_avg=mean(T_);
x_axis=1:100;
plot(x_axis,log10(E),'-r')
hold on 
plot(x_axis,log10(E_corr))
axis([1,100,-30,10])
xlabel('Signal index')
ylabel('Error (log10)')
legend('covariance method','autocorrelation method')