function omg = omg_math(ox, PI)
ymean = 0.0;
osquare = 0.0;
n = length(ox);
for i = 1:n
    ymean = ymean + ox(i);
end
ymean = ymean / n;
for i = 1:n
    osquare = osquare + (ox(i) - ymean)^2;
end
osquare = osquare / n;

px = zeros(4*n,1);
for w = 1:4*n
    s2sum = 0.0;
    c2sum = 0.0;
    ww = w/(4*n);
    for jj = 0:n-1
        s2sum = s2sum + sin(4*PI*ww*jj);
        c2sum = c2sum + cos(4*PI*ww*jj);
    end
    t = round(atan(s2sum / c2sum)/(2*PI*ww));
    hct = 0;
    hst = 0;
    cwt = 0;
    swt = 0;
    for kk = 1:n
        hct = hct + (ox(kk) - ymean)*cos(2*ww*PI*(kk-t));
        hst = hst + (ox(kk) - ymean)*sin(2*ww*PI*(kk-t));
        cwt = cwt + (cos(2*ww*PI*(kk-t)))^2;
        swt = swt + (sin(2*ww*PI*(kk-t)))^2;
    end
    px(w) = ((hct^2)/cwt + (hst^2)/swt)/(2*osquare);
end
spectrumk0 = px;
ff = linspace(0,1,4*n);
HalfSpec = [spectrumk0(1:2*n)];
a = HalfSpec/(4*n);
[omg zf]=find(HalfSpec == max(max(HalfSpec)) );
omg = omg/(4*n);
end