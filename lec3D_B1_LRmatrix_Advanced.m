%% MATLAB programming course for beginners, supported by Wagatsuma Lab@Kyutech 
%
% /* 
% The MIT License (MIT): 
% Copyright (c) 2021 Hiroaki Wagatsuma and Wagatsuma Lab@Kyutech
% 
% Permission is hereby granted, free of charge, to any person obtaining a
% copy of this software and associated documentation files (the
% "Software"), to deal in the Software without restriction, including
% without limitation the rights to use, copy, modify, merge, publish,
% distribute, sublicense, and/or sell copies of the Software, and to permit
% persons to whom the Software is furnished to do so, subject to the
% following conditions:
% 
% The above copyright notice and this permission notice shall be included
% in all copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
% OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
% MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN
% NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
% DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
% OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
% USE OR OTHER DEALINGS IN THE SOFTWARE. */
%% Specifications and requirements
% # @Time    : 2021-5-26 
% # @Author  : Hiroaki Wagatsuma
% # @Site    : https://github.com/hirowgit/1B1_matlab_signal_analysis_course
% # @IDE     : MATLAB R2018a
% # @File    : lec3D_B1_LRmatrix_Puls.m

%%  Main program
% clear all

% N=3;
% after running of "lec3D_B1_flatPlane_Copper.m"
N=dN;
syms a b c d x y z 
% xj = sym('x',[1 N]);
% yj = sym('y',[1 N]);
% zj = sym('z',[1 N]);

xj = sym('x',[N 1]);
yj = sym('y',[N 1]);
zj = sym('z',[N 1]);

x0 = sym('x0');
y0 = sym('y0');
z0 = sym('z0');

xjp=[x0; xj];
yjp=[y0; xj];
zjp=[z0; xj];
unit1=ones(N+1,1);
vecT=[a; b; d];

Amat=[xjp yjp unit1];
bvec=-zjp;
ansM=solve(Amat*vecT==bvec,{a,b,d});
ansM.a
ansM.b
ansM.d

ansMa=matlabFunction(ansM.a)
ansMb=matlabFunction(ansM.b)

A2=transpose(Amat)*Amat*vecT
b2=transpose(Amat)*bvec

ansM2=solve(A2==b2,{a,b,d});
ansM2

D=(transpose(xj)*xj)*(transpose(yj)*yj)-(transpose(xj)*yj)*(transpose(xj)*yj);
a_res=((transpose(yj)*zj)*(transpose(xj)*yj)-(transpose(xj)*zj)*(transpose(yj)*yj))/D;
b_res=(transpose(xj)*yj)*(transpose(xj)*zj)-(transpose(xj)*xj)*(transpose(yj)*zj)/D;
n_res=[a_res; b_res; D];

a_num=matlabFunction(a_res);
b_num=matlabFunction(b_res);

p3D=genPos3D; 
px=p3D(1,:)'; py=p3D(2,:)'; pz=p3D(3,:)'; 
St_p={};
labelL={'px','py','pz'};
    
% for 1:length(labelL)   
for j=1:length(labelL)
    preSt=''; 
    for i=1:size(p3D,2)
        St_p{j}=[preSt,',',labelL{j},'(',num2str(i),')']; 
        preSt=St_p{j};
    end
end
% for i=1:size(p3D,2)
%     for j=1:length(labelL)
%         if j>1 preSt=St_p{j}; else preSt=''; end
%         St_p{j}=[preSt,',',labelL{j},'(',num2str(i),')'];   
%     end
%     
% end
stLa=['a_num(',St_p{1}(2:end),St_p{2},St_p{3},')'];
eval(stLa)
stLb=['b_num(',St_p{1}(2:end),St_p{2},St_p{3},')'];
eval(stLb)

% St_L='';
%     for j=1:length(labelL)
%         St_L=[St_L,St_p{j}];   
%     end
%     stLa=['a_num(',St_L,')'];
%     eval(stLa);  
    
% fsample(1,2)
% 
% function a = mymean(v)
% n = length(v);
% a = sum(v)/n;
% end


