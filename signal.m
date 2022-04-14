function sign = signal(N, PI)
ox = zeros(N, 1);
for i = 1:N
%     ox(i) = exp(-0.0028*i)*cos(2*PI*0.2*i)+exp(-0.004*i)*cos(2*PI*0.4*i);
%     ox(i) = exp(-0.0006*i)*cos(2*PI*0.5*i)+exp(-0.0036*i)*cos(2*PI*0.3*i);
%     ox(i) = exp(-0.0008*i)*cos(2*PI*0.001*i) + exp(-0.0005*i)*sin(2*PI*0.0045*i);
%     ox(i) = exp(-0.0008*i)*cos(2*PI*0.001*i) + exp(-0.0005*i)*sin(2*PI*0.0045*i)+exp(-0.0004*i)*cos(2*PI*0.0032*i);
    ox(i) = exp(-0.0008*i)*3*cos(2*PI*0.001*i) + exp(-0.0005*i)*0.08*sin(2*PI*0.0045*i);
end
rz  = ox + 0.005*randn(N,1);
% sin 会出现问题 cos 不会(0.001 * i + 0.000001 * i^2) + 
sign = rz;
