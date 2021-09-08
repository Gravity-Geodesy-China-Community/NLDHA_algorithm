%调用 Fun_NLDHA
%程序说明：
%	fit_NLDHA_main.m为主函数，调用Fun_NLDHA函数，其中用到拟合曲线，拟合的函数为ccff.m文件中函数。
%	主函数中用load读取数据，数据中应只含有数据部分，不要有头文件之类的。
%	Fun_NLDHA函数的参数为数据的数组，应为横向的，返回值为 角速度w（omg欧密嘎） 和 衰减因子（lbd兰博打）
%程序不足：
%	Fun_NLDHA函数中不应该对数据的时间间隔进行判断和处理，应该只对数据进行处理，这样函数更加符合规范。
%	不然如果数据的时间间隔变了，需要对 代码进行修改，不好。
%	数据的读取应该更加完善。
%	
clc;clear;

global PI;
PI = 3.141592654;
%————————————————读取数据——————————————————————————  
% filename = 'ST1103s0(processed).ggs';
% delimiterIn = ' ';
% headerlinesIn = 21;
% data = importdata(filename,delimiterIn,headerlinesIn);
% % cut the data before earthquake 3.11
% y = data.data(1:864000,7);
% clear data
% n = length(y);

%% Parameters
fs = 1/60; %sampling rate
N  = 60 * 60; %points
zp = N;    %points of zero-padding

t  = [1:N]/fs; % time
dt = t(2)-t(1);% time interval
f1  = 0.1 * 10^(-3); % frequency
f2 = 0.45 * 10^(-3);
f3 = 0.8 * 10^(-3) ;
dr = - 8 * 10^(-6);     % decay rate
SNR=20;% signal to noise ratio

stacking_num = 60;
Q = [];

%% generate signal
x =  exp(dr.*t).*(5*sin(2*pi*f1*t)) + exp(dr.*t).*(4*sin(2*pi*f2*t)) + exp(dr.*t).*(sin(2*pi*f3*t));

y = awgn(x,SNR,0,40)'; %wgn/randn also can add noise

   %%
    %——————————————     剪掉信号    ——————————————
    global lbd;
    global omg; 
    global omg_bfgs;
    global lbd_bfgs;
    global y;
    global t;
     ox = y';   
     for i = 1:10
    [omg, lbd] = Fun_NLDHA(ox, fs);    %得到omg  和  lmd 后，需要最小二乘来得到s 和 c    ————————omg不应该在函数中计算具体的值，应该有调用者自己计算，这样函数简单

    %% BFGS to find omega
options = optimoptions('fminunc');
%% Modify options setting
options = optimoptions(options,'Algorithm', 'quasi-newton');
omg_bfgs = fminunc(@fun_omega,omg,options) 

%% BFGS to find lambda
options = optimoptions('fminunc');
%% Modify options setting
options = optimoptions(options,'Algorithm', 'quasi-newton');
lbd_bfgs = fminunc(@fun_lbd,lbd,options) 

    %ft = fittype( 'ccff(a,b,d,s,c,x)' );  
%     ft = fittype( 'ccff1(a,b,s,c,x)' );     
%     [fun,gof,out] = fit(x,t',ft,'StartPoint',[0 0 0 0])     %函数中是以小时为单位，
%        %得到的结果是 cph，此处的单位时间为h，拟合的ccff函数是2*PI*omg，所以此处应该用cph
%    % nh = ccff(fun.a,fun.b,fun.d,fun.s,fun.c,t');
%    nh = ccff1(fun.a,fun.b,fun.s,fun.c,t');

% ft = fittype( 'ccff1(a,b,s,c,x)' );    
% [fun,gof,out] = fit(t',x,ft,'StartPoint',[0.1 0.1 0.1 0.1])  
% nh = ccff1(fun.a,fun.b,fun.s,fun.c,t');    

ft = fittype( 'ccff2(s,c,x)' );    
[fun,gof,out] = fit(t',x,ft,'StartPoint',[0.1 0.1]) 
nh = ccff2(fun.s,fun.c,t');    
%     figure 
%     plot(x./n,abs(fft(nh)));
    
    res = ox' - nh;
    
    figure;
    plot(res,'g');
    
    hold on;
   plot(fun,x,ox);
    plot(nh,'r');
    
    hold on;
    plot(ox,'b');
   % xsfun = [ num2str(fun.a),'+',num2str(fun.b),'*x+e^(-',num2str(lbd),'*x) * (',num2str(fun.s),'*sin(2*PI*',num2str(omg),'*x)+',num2str(fun.c),'*cos(2*PI*',num2str(omg),'*x))'];
    ci = ['第',num2str(i),'次'];
  %  tit = [ci,'    ',xsfun];
 %   title(tit);
    legend('res','拟合曲线','原始曲线');
    name = ['g的',ci,'.jpg'];
    saveas(gcf,name);
    ox = res';
    end

    
    
    
