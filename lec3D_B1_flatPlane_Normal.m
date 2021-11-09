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
% # @File    : lec3D_B1_flatPlane_Normal.m

%%  Main program
% clear all

dimN=3;

dN=5;
Fig1pos= [50 1200];
FigSize=1000*ones(1,2);

posDot=rand(dimN,dN);

figNum=1;
figure(figNum); clf
plot3(posDot(1,:),posDot(2,:),posDot(3,:),'.', 'MarkerSize',32);
grid on;
set(figNum,'Position',[Fig1pos FigSize]);
axis equal;

% making a test data to reconstruct a flat plane
scaleM=100;
PatN=1; % PatN=3;
dimNt=dimN-1;
basePos=scaleM.*rand(dimNt,PatN); % base Position
rangeSpOccp=scaleM*0.1;
genPos2D=basePos+rangeSpOccp.*rand(dimNt,dN); gP2D=genPos2D;
genGrad=10*rand(dimNt,PatN);
rangVari=10; % range of Variance
genRd=rangeSpOccp.*rand(1,dN);
repmat(genGrad,[1,dN]).*genPos2D+repmat(genGrad,[1,dN]).*g

% ax+by+cz+d=0;  
% (a/c)x+(b/c)y+z+(d/c)=0; => cf[2]*x+cf[3]*y+z+cf[1]=0; 
% => z=-(cf[2]*x+cf[3]*y+cf[1])
genRd=genGrad.*gP2D(1,*)

dN=5;
figNum=figNum+1;
figure(figNum); clf
plot3(posDot(:,1),posDot(:,2),posDot(:,3),'.', 'MarkerSize',32);
grid on;
set(figNum,'Position',[Fig1pos FigSize]);
axis equal;