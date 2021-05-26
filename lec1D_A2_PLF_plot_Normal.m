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
% # @Time    : 2021-5-19 
% # @Author  : Hiroaki Wagatsuma
% # @Site    : (1) https://github.com/hirowgit/1B0_matla_optmization_course
% # @Site    : (2) https://github.com/hirowgit/1B1_matlab_signal_analysis_course
% # @IDE     : MATLAB R2018a
% # @File    : (1) TSP_lecture2.m
% # @File    : (2) lec1D_A2_PLF_plot_Normal.m

%%  Main program
% clear all
close all
% sin wave

figure(1); clf
set(1,'name','sine_wave2','Position',[720   820   870   400]);
leglabel={'piecewise linear function', 'original sine wave'};
dT=0.1;

t=0:dT:2*pi+dT;
y=sin(t);

y2=@(t) (2/pi*t).*(t<=pi/2)+(-2/pi*t+2).*(t>pi/2 & t<=pi) ...
    +(-2/pi*t+2).*(t>pi & t<=3*pi/2)+(2/pi*t-4).*(t>3*pi/2 & t<=2*pi);
% see more detail of how you can obtain this parameters in TSP_lecture3.m

plot(t,y2(t),t,y,'.-','LineWidth',2,'MarkerSize',12);
set(gca,'xlim',[0,2*pi],'ylim',[-1.2,1.2],'FontSize',14);
legend(leglabel,'best')

xtickpoint=0:pi/4:2*pi;
xlabel={'0','\pi/4','\pi/2','3\pi/4','\pi','5\pi/4','3\pi/2','7\pi/4','2\pi'};
set(gca,'xtick',xtickpoint,'xticklabel',xlabel)
title('Sine wave');
grid on;
axis equal;

datafname='m_figures';
save_fig;

