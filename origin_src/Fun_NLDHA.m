% NLDHA
%����˵����
%	fit_NLDHA_main.mΪ������������Fun_NLDHA�����������õ�������ߣ���ϵĺ���Ϊccff.m�ļ��к�����
%	����������load��ȡ���ݣ�������Ӧֻ�������ݲ��֣���Ҫ��ͷ�ļ�֮��ġ�
%	Fun_NLDHA�����Ĳ���Ϊ���ݵ����飬ӦΪ����ģ�����ֵΪ ���ٶ�w��omgŷ�ܸ£� �� ˥�����ӣ�lbd������
%�����㣺
%	Fun_NLDHA�����в�Ӧ�ö����ݵ�ʱ���������жϺʹ���Ӧ��ֻ�����ݽ��д��������������ӷ��Ϲ淶��
%	��Ȼ������ݵ�ʱ�������ˣ���Ҫ�� ��������޸ģ����á�
%	���ݵĶ�ȡӦ�ø������ơ�
%	
function [omg, lbd] = Fun_NLDHA(ox, fs, k, df)

global PI;
global omg_res;
n = length(ox);
    x = 1:n;
     %% corsponding to the power spectrum to find omg
    [px, ff] = periodogram(ox,hamming(length(ox)), length(ox) , fs);
    px = px/max(px);
%     %��������������ʼ��f���ҳ����ֵ��λ��  omg����ŷ���ѡ����������� 

    
%% ����Ƶ�ʷֱ��ʵ����⣬����һ��Ƶ�ʵ��׷�����Ƶ��й¶������α��
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
            
            % ��ff������Ƶ�ʱ仯����1mhz��Ƶ�ʷ���
            
        end
        
        
        
    %;
    %�����������������������õ�������ͼ������������������������
%     figure;
%     plot(ff,px);
%     str = ['max f  = ',num2str(omg),' and its normalized spectrum ',num2str(max(px))];
%     title(str);
    %axis([0 max(ff)/2  min(2*abs(px)) 1.1*max(2*abs(px))]); % ������������ָ��������

    
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
        
   %����������������������������ƽ���һЩ����������������������������     
    end
    [high, lbd]=find(Pn == max(max(Pn)) );
    lbd = lbd*0.01/(4*n) 
    ff1 = linspace(0,0.01,4*n);  
    
    %�������������������������� damping power spectrum������������������������
%     figure;
%     plot(ff1,Pn);
%     str = ['���ֵλ����  ',num2str(lbd),' Pn ',num2str(max(Pn))];
%     title(str);
    %��������������������������������������������������������������������������������


    
end
    
    

    
   

