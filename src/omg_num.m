function [omg] = omg_num(ox, fs, k, df)
n = length(ox);
x = 1:n;
[px, ff] = periodogram(ox,hamming(length(ox)), length(ox) , fs);
px = px/max(px);
[B,I] = sort(px,'descend');
omg = ff(I(1));
% if k == 1
%     omg = ff(I(1))
% else
%     for i = 2:(length(ff)-1)
%            omg = ff(I(k));
%         if (abs(omg - omg_res(k-1)) > df)
%             break;
%         else
%             omg = ff(I(i+1))
%         end
%     end
% end
