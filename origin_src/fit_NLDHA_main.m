%���� Fun_NLDHA
%����˵����
%	fit_NLDHA_main.mΪ������������Fun_NLDHA�����������õ�������ߣ���ϵĺ���Ϊccff.m�ļ��к�����
%	����������load��ȡ���ݣ�������Ӧֻ�������ݲ��֣���Ҫ��ͷ�ļ�֮��ġ�
%	Fun_NLDHA�����Ĳ���Ϊ���ݵ����飬ӦΪ����ģ�����ֵΪ ���ٶ�w��omgŷ�ܸ£� �� ˥�����ӣ�lbd������
%�����㣺
%	Fun_NLDHA�����в�Ӧ�ö����ݵ�ʱ���������жϺʹ���Ӧ��ֻ�����ݽ��д��������������ӷ��Ϲ淶��
%	��Ȼ������ݵ�ʱ�������ˣ���Ҫ�� ��������޸ģ����á�
%	���ݵĶ�ȡӦ�ø������ơ�
%	
clc;clear;

global PI;
PI = 3.141592654;
%����������������������������������ȡ���ݡ���������������������������������������������������  
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
    %����������������������������     �����ź�    ����������������������������
    global lbd;
    global omg; 
    global omg_bfgs;
    global lbd_bfgs;
    global y;
    global t;
     ox = y';   
     for i = 1:10
    [omg, lbd] = Fun_NLDHA(ox, fs);    %�õ�omg  ��  lmd ����Ҫ��С�������õ�s �� c    ����������������omg��Ӧ���ں����м�������ֵ��Ӧ���е������Լ����㣬����������

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
%     [fun,gof,out] = fit(x,t',ft,'StartPoint',[0 0 0 0])     %����������СʱΪ��λ��
%        %�õ��Ľ���� cph���˴��ĵ�λʱ��Ϊh����ϵ�ccff������2*PI*omg�����Դ˴�Ӧ����cph
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
    ci = ['��',num2str(i),'��'];
  %  tit = [ci,'    ',xsfun];
 %   title(tit);
    legend('res','�������','ԭʼ����');
    name = ['g��',ci,'.jpg'];
    saveas(gcf,name);
    ox = res';
    end

    
    
    
