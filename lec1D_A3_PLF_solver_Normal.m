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
% # @File    : (1) TSP_lecture3.m
% # @File    : (2) lec1D_A3_PLF_solver_Normal.m


%%  Main program
% clear all
close all

syms x y a b

% y==a*x+b

S1=solve(a*pi/2+b==1,a*pi+b==0);
fprintf('Solution(0): y = (%s)*x\r\n',-S1.a);
fprintf('Solution(1): y = (%s)*x + (%s)\r\n',S1.a,S1.b);

S2=solve(a*3*pi/2+b==-1,a*pi+b==0);
fprintf('Solution(2): y = (%s)*x + (%s)\r\n',S2.a,S2.b);

S3=solve(a*3*pi/2+b==-1,a*2*pi+b==0);
fprintf('Solution(3): y = (%s)*x + (%s)\r\n',S3.a,S3.b);

fprintf('\r\n \r\n');

figure(2);clf
set(2,'name','piecewise_linear','Position',[720   820   870   400]);

dT=pi/100;
t0=0:dT:pi/2;
a0=-S1.a;   b0=0;

t1=pi/2:dT:pi;
a1=S1.a; b1=S1.b;

t2=pi:dT:3*pi/2;
a2=S2.a; b2=S2.b;

t3=3*pi/2:dT:2*pi;
a3=S3.a; b3=S3.b;

plot(t0,a0*t0+b0,t1,a1*t1+b1,t2,a2*t2+b2,t3,a3*t3+b3,[t0 t1 t2 t3],sin([t0 t1 t2 t3]),'k--','LineWidth',2);

set(gca,'xlim',[0,2*pi],'ylim',[-1.2,1.2],'FontSize',14);

xtickpoint=0:pi/4:2*pi;
xlabel={'0','\pi/4','\pi/2','3\pi/4','\pi','5\pi/4','3\pi/2','7\pi/4','2\pi'};
set(gca,'xtick',xtickpoint,'xticklabel',xlabel)
title('Piecewise linear function to reconstract sine wave');
grid on;
axis equal;

datafname='m_figures';
save_fig;

