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
% # @File    : lec3D_B1_flatPlane_Copper.m

%%  Main program
% clear all
dimN=3;
 
dN=5;
Fig1pos= [50 1200];
FigSize=1000*ones(1,2);

% ~~~~~~~~~ VideoWriter <initialize> (start)~~~~~~~~~~~~~~

Flag_write_Movie=0;
Nm=4; % the serial number of the movie
% ms_size=[480 360]; % the movie screen size
ms_size=FigSize; % the movie screen size

f_folder='movie'; % the output folder of the movie
if ~isdir(f_folder); mkdir(f_folder); end
f_prefix='outputMoviePlane_k_'; % the output file name
if Flag_write_Movie == 1
%     MovieFileName = strcat(f_prefix,num2str(Nm),'.mov');
    MovieFileName = strcat(f_prefix,num2str(Nm),'.mp4');
    fprintf('Creating the movie file %s.\n', fullfile(f_folder,MovieFileName));
    fps = 30;
  
    my_video = VideoWriter(fullfile(f_folder,MovieFileName),'MPEG-4');
    my_video.FrameRate=fps;
    my_video.Quality=95;
    open(my_video);
end
% ~~~~~~~~~MakeQTMovie (end)~~~~~~~~~~~~~~



posDot=rand(dimN,dN);

figNum=1;
figure(figNum); clf
plot3(posDot(1,:),posDot(2,:),posDot(3,:),'.', 'MarkerSize',32);
grid on;
set(figNum,'Position',[Fig1pos FigSize]);
axis equal;

% making a test data to reconstruct a flat plane
dN=150;

scaleM=100; 
PatN=1; % PatN=3;
constN=1;
dimNt=dimN-constN;
rangVari=10; % range of Variance

basePos=scaleM.*(2*rand(dimNt,PatN)-1); % base Position
basePos=zeros(2,1);
rangeSpOccp=scaleM*0.1;
genPos2D=basePos+rangeSpOccp.*rand(dimNt,dN); gP2D=genPos2D;
genGrad=rangVari*rand(dimNt,PatN);  % a, b
genResidual=rangVari*rand(constN,PatN);  % c
genConst=-scaleM*rand(constN,PatN);  % d
% genConst=0;  % d

% genPos2D=[1 1 -1 -1 1;
%          -1 1 -1 1 -1];
%  genPos2D=[1 1 1 1 1;
%          -1 1 -1 1 -1];
genGrad=[5; 0];
genResidual=-5;
genConst=5;
% genRd=rangeSpOccp.*rand(1,dN);
funcP=sum(repmat(genGrad,[1,dN]).*genPos2D)+repmat(genConst,[1,dN]);

% ax+by+c   z+d=0;  
% (a/c)x+(b/c)y+z+(d/c)=0; => cf[2]*x+cf[3]*y+z+cf[1]=0; 
% => z=-(cf[2]*x+cf[3]*y+cf[1])/c
genRd=-funcP./genResidual;
genPos3D=[genPos2D;genRd];

figNum=figNum+1;
figure(figNum); clf
plot3(genPos3D(1,:),genPos3D(2,:),genPos3D(3,:),'.-', 'MarkerSize',32);
grid on;
set(figNum,'Position',[Fig1pos FigSize]);
axis equal;

% for my_az=-90:1:90
for my_az=-45:1:45
    figure(figNum);
    view(my_az,30);
    drawnow;
    % ~~~~~~~~~VideoWriter <add a frame> (start)~~~~~~~~~~~~~~
    if Flag_write_Movie == 1
        frameV = getframe(gcf);
        writeVideo(my_video,frameV);
    end
    % ~~~~~~~~~VideoWriter (end)~~~~~~~~~~~~~~
end

[caz,cel] = view()

% ~~~~~~~~~VideoWriter  <finalize> (start)~~~~~~~~~~~~~~
if Flag_write_Movie == 1
    close(my_video);
    strMessage=sprintf('Please find the generated mov file in the folder "%s" as filename "%s"',f_folder,MovieFileName);
    disp(strMessage);
end
% ~~~~~~~~~VideoWriter (end)~~~~~~~~~~~~~~




% ~~~~~~~~~VideoWriter <comment>~~~~~~~~~~~~~~
% https://jp.mathworks.com/help/matlab/ref/videowriter.html#

% ~~~~~~~~~VideoWriter (end)~~~~~~~~~~~~~~