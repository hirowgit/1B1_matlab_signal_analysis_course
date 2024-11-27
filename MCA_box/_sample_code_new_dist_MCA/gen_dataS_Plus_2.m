

Nd=48410;
dstDn=10;
setN=10;

dd2={};
td=1:Nd;

kd=1;
dd2{kd}=-0.02*td+7;

for kd2=kd:kd+setN-1
    alpha=rand()*50;
    beta=rand()*100;
    gamma=rand()/20;
    dd2{kd2}=alpha*sin(gamma*(td+beta));
end

yd=[];
kd=1;
yd=dd2{kd};
for kd2=kd:kd+setN-1
    yd=yd+dd2{kd2};
end


figure(111);
clf

plot(yd);
grid on;

figure(112);
clf

yd2=50*sin(0.002*(td));

yd2(1:28400)=0;

yd2(39000:48410)=0;

yd2b=yd2-0.02*td+7;

plot(yd2b);
grid on;

figure(113);
clf

yd3=yd2+yd;
plot(yd3);
grid on;