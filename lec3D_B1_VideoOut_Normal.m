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
% # @File    : lec3D_B1_VideoOut_Normal.m

%%  Main program
% clear all
% ~~~~~~~~~ VideoWriter <initialize> (start)~~~~~~~~~~~~~~

Flag_write_Movie=1;
Nm=5; % the serial number of the movie
% ms_size=[480 360]; % the movie screen size
ms_size=FigSize; % the movie screen size
figNum=2;

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