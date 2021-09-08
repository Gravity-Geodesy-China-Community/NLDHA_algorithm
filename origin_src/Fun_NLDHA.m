% NLDHA
%程序说明：
%	fit_NLDHA_main.m为主函数，调用Fun_NLDHA函数，其中用到拟合曲线，拟合的函数为ccff.m文件中函数。
%	主函数中用load读取数据，数据中应只含有数据部分，不要有头文件之类的。
%	Fun_NLDHA函数的参数为数据的数组，应为横向的，返回值为 角速度w（omg欧密嘎） 和 衰减因子（lbd兰博打）
%程序不足：
%	Fun_NLDHA函数中不应该对数据的时间间隔进行判断和处理，应该只对数据进行处理，这样函数更加符合规范。
%	不然如果数据的时间间隔变了，需要对 代码进行修改，不好。
%	数据的读取应该更加完善。
%	
function [omg, lbd] = Fun_NLDHA(ox, fs, k, df)

global PI;
global omg_res;
n = length(ox);
    x = 1:n;
     %% corsponding to the power spectrum to find omg
    [px, ff] = periodogram(ox,hamming(length(ox)), length(ox) , fs);
    px = px/max(px);
%     %——————初始化f，找出最大值的位置  omg——欧米茄—————— 

    
%% 由于频率分辨率的问题，可能一个频率的谱峰由于频谱泄露，产生伪谱
        [B,I] = sort(px,'descend');
        if k == 1
            omg = ff(I(1))
        else
            for i = 2:length(ff)
                   omg = ff(I(k));
                if (abs(omg - omg_res(k-1)) > df)
                    break;
                else
                    omg = ff(I(i+1))
                end
            end
            
            % 在ff中搜索频率变化超过1mhz的频率分量
            
        end
        
        
        
    %;
    %——————————画得到的周期图————————————
%     figure;
%     plot(ff,px);
%     str = ['max f  = ',num2str(omg),' and its normalized spectrum ',num2str(max(px))];
%     title(str);
    %axis([0 max(ff)/2  min(2*abs(px)) 1.1*max(2*abs(px))]); % 设置坐标轴在指定的区间

    
    pn = zeros(4*n,0);
    atmp = zeros(n,2);
    
    for i = 1:4*n      
        nmd = (i-1)*0.01/(4*n);
        
        for t = 1:n       
            atmp(t,1) = exp(-nmd*t)*cos(2*PI*omg*t);
            atmp(t,2) = exp(-nmd*t)*sin(2*PI*omg*t);
        end
        
        trans = atmp';
        R = trans*atmp;
        tmpox = ox';
        
        r = trans*tmpox;
        rt = r';
        RR = inv(R);
        rtRR = rt*RR;
        rtRRr =rtRR*r;
        Pn(i) = rtRRr(1,1)/n;
        
   %————————————就是平差的一些东西————————————     
    end
    [high, lbd]=find(Pn == max(max(Pn)) );
    lbd = lbd*0.01/(4*n) 
    ff1 = linspace(0,0.01,4*n);  
    
    %————————————画 damping power spectrum————————————
%     figure;
%     plot(ff1,Pn);
%     str = ['最大值位置是  ',num2str(lbd),' Pn ',num2str(max(Pn))];
%     title(str);
    %————————————————————————————————————————


    
end
    
    

    
   

