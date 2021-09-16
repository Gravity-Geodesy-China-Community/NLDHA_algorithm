clc;clear;
clc;clear;
global PI;
PI = 3.141592654;
global omg_bfgs;
global lbd_bfgs;
global omg_res;
global ox;
%% 定义变量
fs = 1/60; %sampling rate
N  = 60 * 60; %points
zp = N;    %points of zero-padding
global t;
t = (1:N)/fs; % time
dt = t(2)-t(1);% time interval
f1  = 0.1 * 10^(-3); % frequency
f2 = 0.45 * 10^(-3);
f3 = 0.8 * 10^(-3) ;
dr = - 0.8 * 10^(-2);     % decay rate
SNR=20;% signal to noise ratio
stacking_num = 60;   
omg = 0;
omg_res(1) = 0;
lbd = 0;
lbd_res(1) = 0;
df = 1*10^(-4);
%% 调用函数 返回模拟信号
global y;
y = signal(fs, N, zp, t, dt, f1, f2, f3, dr, SNR, stacking_num);
ox = y';
%% 计算 omg 
for k = 1:50
    [omg] = omg_num(ox, fs, k, df);
    omg_res(k) = omg;
    %% 计算lbd
    % 优化参数
    options = optimoptions('fminunc');
    options = optimoptions(options, 'Algorithm', 'quasi-newton');
    omg_bfgs = fminunc(@fun_omega,omg,options);
    % omg_bfgs = omg;
    omg_bfgs_res(k) = omg_bfgs;
    options = optimoptions('fminunc');
    options = optimoptions(options,'Algorithm', 'quasi-newton');
    lbd_bfgs = fminunc(@fun_lbd,lbd,options);
    lbd_bfgs = 8 * 10^(-6);
    lbd_bfgs = lbd_math(PI,omg_bfgs,zp,ox)
    lbd_bfgs_res(k) = lbd_bfgs;
    dhs(:, k) = non_fit(t,lbd_bfgs,omg_bfgs);
    ft = fittype( 'whole_fit(a,b,d,s,c,x)' );
    fun = fit(t',ox',ft,'StartPoint',[0 0 0 0 0]);
    nh(:,k) = whole_fit(fun.a,fun.b,fun.d,fun.s,fun.c,t');
    figure('Name',num2str(k));
    plot(nh(:,k));
    hold on;
    plot(ox);
    saveas(gcf, [num2str(k), '.jpg']);
    ox = ox - nh(:,k)';
    rms_index(k) = k;
    rms_show(k) = rms(ox);
end
figure('Name','rms');
plot(rms_index,rms_show,'*-');



    