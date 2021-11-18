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
% # @File    : lec3D_B1_LRmatNuImp_Normal.m

%%  Main program
% clear all

p3D=genPos3D; % 
% after running of "lec3D_B1_flatPlane_Copper.m"
px=p3D(1,:)'; py=p3D(2,:)'; pz=p3D(3,:)'; 
xx=px'*px;
yy=py'*py;
xy=px'*py;
yz=py'*pz;
xz=px'*pz;

D=xx*yy-xy*xy;
a=(yz*xy-xz*yy)./D;
b=(xy*xz-xx*yz)./D;
n_vec=[a; b; 1]

d=(-sum(pz)-(a*sum(px)+b*sum(py)))./dN;
d
% D=xx*yy-xy*xy;
% a=(yz*xy-xz*yy);
% b=(xy*xz-xx*yz);
% n_vec=[a; b; D]


