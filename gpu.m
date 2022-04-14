gpuDevice(1)
A=rand(1024,1024);
B=rand(1024,1024);

tic; C = (A + B); toc;
tic; D = gather(gpuArray(A)+gpuArray(B)); toc;