% 模拟信号定义
function y = signal(fs, N, zp, t, dt, f1, f2, f3, dr, SNR, stacking_num)

x =  exp(dr.*t).*(sin(2*pi*f1*t)) + exp(dr.*t).*(4*sin(2*pi*f2*t)) + exp(dr.*t).*(sin(2*pi*f3*t));
%wgn/randn also can add noise
y = awgn(x,SNR,0,40)'; 