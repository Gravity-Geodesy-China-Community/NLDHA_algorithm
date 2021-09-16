function lbd = lbd_math(pi,omg,zp,ox)
k = 4.0 * zp;
atmp=zeros(3600,2);
tmpOx = ox';
for n = 1:k
    nmd = n*0.001/k;
    for i=1:zp
        atmp(i,1)=exp(nmd*i) * cos(2*pi*omg*i);
        atmp(i,2)=exp(nmd*i) * sin(2*pi*omg*i);
    end
    trans = atmp';
    R = trans * atmp;
    r = trans * tmpOx;
    rt = r';
    RR = inv(R);
    rtRR = rt * RR;
    rtRRr = rtRR * r;
    Pn(n) = rtRRr / zp;
end
ff1 = linspace(0,0.01,k);
plot(ff1, Pn);

lbd=0;