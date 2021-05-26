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
% # @File    : lec2D_A0_lineGen_Normal.m

%%  Main program
% clear all

a=1; b=2; 
% dT=0.25;
dT=0.75;
rdN=100;
dN=100;
dNs=20;
t=0:pi/dN:pi;
gridP=0:dNs;

rangeXY=[0 20; 0 20]; %[xmin, xmax; ymin, ymax];
labelF={'line','random','line+random','hough trans. for line','discrete vote','voting contour map'};
fignum=1;


x=0:dT:rangeXY(1,2);
lgen=@(x) a*x+b;


figure(fignum); clf
set(fignum,'name',labelF{fignum},'Position',[500   920   550   500]);
plot(x,lgen(x),'b.','MarkerSize',24);
title(labelF{fignum});
grid on;
axis equal;
fignum=fignum+1;

rdPos=repmat(diff(rangeXY'),[rdN 1]).*rand(rdN,2)+repmat(rangeXY(:,1)',[rdN 1]);

figure(fignum); clf
set(fignum,'name',labelF{fignum},'Position',[1050   850   550   500]);

plot(rdPos(:,1),rdPos(:,2),'r.','MarkerSize',24);
set(gca,'xlim',rangeXY(1,:),'ylim',rangeXY(2,:));
title(labelF{fignum});
grid on;
axis equal;
fignum=fignum+1;

mD=[x',lgen(x'); rdPos];
% mD=[x',lgen(x'); ];

figure(fignum); clf
set(fignum,'name',strrep(labelF{fignum},'+','_'),'Position',[1600   850   550   500]);

plot(mD(:,1),mD(:,2),'k.','MarkerSize',24);
set(gca,'xlim',rangeXY(1,:),'ylim',rangeXY(2,:));
title(labelF{fignum});
grid on;
axis equal;
fignum=fignum+1;




% datafname='pict_res';
% save_fig;
