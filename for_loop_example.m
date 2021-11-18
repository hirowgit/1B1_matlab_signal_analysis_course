% for loop example

s=0;
for i=1:5
    s=s+2*i-1;
    display(s)
end
display(s)


% matrix calc example
a=[1,2; 3 4];
b=[5,6; 7 8];
y=a*b

syms a1 b1
a1=a
% latex(a1)

syms x
M = [x,x; x x];
chrM = latex(M)
b = [x; x];
chrM = latex(b)