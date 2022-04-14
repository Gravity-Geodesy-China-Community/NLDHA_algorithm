clc;clear;
clc;clear;
test = textread('3.dat');
data = test(:,7).';% * -792
y = data;

%figure
%plot(data);%Ïàµ±ÓÚtest(1:end,3:3)
global PI;
global omg;
global lbd;
PI = 3.141592654;
N  = 744; %points
% N = 7200;
%y = signal(N, PI);

ox = y';
%plot(ox);
% ox = data;
x = 0:(N-1);
x = x';
coefficient=polyfit(x,ox,1);
yn=polyval(coefficient,x);
figure(55)
ox = ox - yn;
hold on;
plot(x,ox,'g');
ox = ox';
% index = verticalMigration(ox);
% index_1 = index(1);
% index_2 = index(2);
% deduct_signal = deduct_signal(index_1,  , ox);
% ox = deduct_signal;
% figure;
% plot(ox);
rms_r(1) = rms(ox);
for i = 1:20
    omg = omg_math(ox, PI);
    lbd = lbd_math(ox, PI, omg);
    swing = swing_num(omg, lbd, ox);
    swcos = swing(2);
    swsin = swing(1);
    % ft = fittype( 'ccff(a,b,s,c,x)' );
    % [fun,gof,out] = fit(x,ox',ft,'StartPoint',[0.1 0.1 0.1 0.1 ]);
    % nh = ccff(fun.a,fun.b,fun.s,fun.c,x');
    nh = ccff(swsin, swcos, ox);
    res = ox' - nh;
    omg_bfgs(i) = omg;
    lbd_bfgs(i) = lbd;
    figure('Name',num2str(i));
    plot(ox,'g')
    hold on;
    plot(nh,'r');
    ox = res';
    hold on;
    plot(ox,'b');
    rms_r(i+1) = rms(ox);
end
figure('Name','rms');
plot(rms_r,'-r*');


