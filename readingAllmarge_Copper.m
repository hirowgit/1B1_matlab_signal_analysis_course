%% MATLAB programming course for beginners, supported by Wagatsuma Lab@Kyutech 
%
% /* 
% The MIT License (MIT): 
% Copyright (c) 2017 Hiroaki Wagatsuma and Wagatsuma Lab@Kyutech
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
% # @Time    : 2017-2-20 
% # @Author  : Hiroaki Wagatsuma
% # @Site    : https://github.com/hirowgit/1B1_matlab_signal_analysis_course
% # @IDE     : MATLAB R2018a
% # @File    : readingAllmarge_Copper.m

%%  Sub program

% t_folder=source_folder;
cd(source_folder);

flist0 = dir; rfields = {'date','bytes','isdir','datenum'}; flist0=rmfield(flist0,rfields);
tag=cell(size({flist0(:).name})); tag(:)={'txt'}; 
flag=cellfun(@strfind,{flist0(:).name},tag,'UniformOutput', false);
flist1 = struct2cell(flist0(~cellfun(@isempty,flag))); 
flist1=flist1(1,:);

 tag(:)={'TXT'}; 
flag=cellfun(@strfind,{flist0(:).name},tag,'UniformOutput', false);
flist2 = struct2cell(flist0(~cellfun(@isempty,flag))); 
flist2=flist2(1,:);

NN=length(flist1); NN2=length(flist2); flist=flist1;
flist(NN+1:NN2)=flist2;
disp(flist);

data_all=[];

for k2=1:length(flist)
    eegdata=importdata(flist{k2});
%     eegdata=importdata(flist{1,k2});
    data_all=[data_all, eegdata];
end 
cd(currdir);
disp(size(data_all));


fout_name=[source_folder,'_','marge.txt'];
fout2_name=strrep(fout_name,'-','_');

% save(fout2_name,'data_all','-ascii','-tabs');