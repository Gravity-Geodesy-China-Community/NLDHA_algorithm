function [omg] = omg_num(ox, fs, k, df)
% n = length(ox);
% x = 1:n;
global omg_res;
[px, ff] = periodogram(ox,hamming(length(ox)), length(ox) , fs);
px = px/max(px);
[~,I] = sort(px,'descend');
% omg = ff(I(k));
if k == 1
    omg = ff(I(1));
else
    omg = ff(I(1));
    for i = 1:(length(ff)-1)
        if (numel(find(omg_res==omg)) == 3)
            omg = ff(I(i+1));
            continue;
        end

%         if (ismember(omg, omg_res))
%             
%         end  
        if (abs(omg - omg_res(k-1)) > df)
            break;
        else
            omg = ff(I(i+1));
        end
    end
end
