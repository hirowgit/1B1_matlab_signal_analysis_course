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

figNum=2; 
figure(figNum); 

genPos3Drecn=genPos3D;
% prx=genPos3Drecn(1,:)+0.01;
% pry=genPos3Drecn(2,:)+0.01;
prx=genPos3Drecn(1,:);
pry=genPos3Drecn(2,:);
prz=-(a.*prx+b.*pry+d);
genPos3Drecn(3,:)=prz;

plot3(genPos3Drecn(1,:),genPos3Drecn(2,:),genPos3Drecn(3,:),'r.-', 'MarkerSize',32);
grid on;
set(figNum,'Position',[Fig1pos FigSize]);
axis equal;

% 
% % for my_az=-90:1:90
% for my_az=-45:1:45
%     figure(figNum);
%     view(my_az,30);
%     drawnow;
%     % ~~~~~~~~~VideoWriter <add a frame> (start)~~~~~~~~~~~~~~
%     if Flag_write_Movie == 1
%         frameV = getframe(gcf);
%         writeVideo(my_video,frameV);
%     end
%     % ~~~~~~~~~VideoWriter (end)~~~~~~~~~~~~~~
% end
% 
% [caz,cel] = view()

lec3D_B1_VideoOutF(2,FigSize,30,'outputMoviePlane_k_',6);



