this_file_tag='freqPlotEEG_Gold';

%% MATLAB programming course for beginners, supported by Wagatsuma Lab@Kyutech 
%
% /* 
% The MIT License (MIT): 
% Copyright (c) 2020 Hiroaki Wagatsuma and Wagatsuma Lab@Kyutech
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
% # @Time    : 2020-4-20 
% # @Author  : Hiroaki Wagatsuma
% # @Site    : https://github.com/hirowgit/1_matlab_basic_course
% # @IDE     : MATLAB R2018a
% # @File    : x_publish_each_codes.m

%%  Main program
%%  Publish individual codes and thier results
suffST={'m','html','pdf','latex','xml','doc','ppt'}; typeST={'MATLAB','HTML','PDF','LaTeX','XML','Microsoft Word','Microsoft PowerPoint'}; 

% this_file_tag_all={'lec1D_A1_SimplePlot_Normal','lec1D_A2_PLF_plot_Normal','lec1D_A3_PLF_solver_Normal'};
this_file_tag_all={'lec2D_A1_lineHough_Copper','lec2D_A1_lineHough_Advanced','lec2D_A0_lineGen_Normal','lec2D_A1_lineHough_Plus'};
this_file_tag=this_file_tag_all{4};
try    
    f_name(1:length(suffST))={this_file_tag};
    f_name2=cellfun(@(s1,s2) [s1,'.',s2],f_name,suffST,'UniformOutput',false);
    currT=clock; date_stamp=sprintf("%d/%d/%d",currT(1:3)); 
catch
    disp('Please do not delete the first line with "this_file_tag" ')
end

if ~exist(this_file_tag,'dir'); mkdir(this_file_tag); end
for i=2:length(suffST)   % (For doc and ppt error may happen in publish in some platform like mac) 
    try
        publish(f_name2{1},'format',suffST{i},'outputDir',this_file_tag);
        fprintf('successfully published as %s files ! See in folder "%s".\r\n',typeST{i},this_file_tag);
    catch
        fprintf('sfailed to publish into %s files ...\r\n',typeST{i});
    end

end
web([this_file_tag,'/',f_name2{2}]);
%%
