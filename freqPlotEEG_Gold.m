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
% # @File    : readEEG_Gold.m

%%  Main program
% clear all
clc
clear all; 
currdir=pwd;

Tnum=1;
source_F={'A-Z','B-O','C-N','D-F','E-S'};
output_F={'outA-Z','outB-O','outC-N','outD-F','outE-S'};
source_Lname={'awake state when eyes were opening','awake state when eyes were closed','Presurgical + opposite zone','Presurgical + epileptogenic zone','contained seizure activity'};
source_L2name={'eye-opening','eye-closed','opposite presurgical','epileptogenic presurgical','seizure activity'};

DataFolder='';
if ~isdir(source_F{1})
    prompt = 'Please specify the path of the data folders such as "A-Z","B-O","C-N","D-F","E-S": \r\n';
    DataFolder = input(prompt,'s');
end

% input path such as "/***/+++/" to indicate in which you saved data files

all_fft=[];
for Tnum=1:length(source_F)

source_folder=fullfile(DataFolder,source_F{Tnum}); close all
output_folder=output_F{Tnum}; 
% source_file='Z001raw.txt';
% fname=fullfile(source_folder,source_file);
% output_folder='eeg_analyzed';
if ~exist('fignum','var'); fignum=0; end

fignum=0;
close all;
readingAllmarge_Copper;

%All EEG signals were recorded with the same 128- channel amplifier system, 
% using an average common refer- ence ?omitting electrodes containing pathological activity ?C, D, and E
% ? or strong eye movement artifacts ?A and B??. After 12 bit analog-to-digital conversion, the data were written continuou
% sly onto the disk of a data acquisition computer system at a sampling rate of 173.61 Hz. Band-pass filter settings were 0.53 ? 40 Hz ?12 dB/oct.?.

% 
% cd(source_folder);

ntag={'time','original','filtered'};
% eegdata=importdata(fname);
eegdata=data_all;

% tstamp=eegdata(:,1);
tstamp=importdata(fullfile(DataFolder,'timeline.txt'));

fignum=fignum+1;figure(fignum);  clf
plot(tstamp,eegdata(:,2),tstamp,eegdata(:,3));

fnn=['ts_',source_folder]; fnn=strrep(fnn, '-', '_');
set(fignum,'name',fnn);


    N           = length(tstamp);
    n           = 2^(nextpow2(N-1));
    eegsignal = eegdata(1:N,:);

%     
%     [mx,nx] = size(eegsignal);
% 
%   d = max(mx,nx);
  
fs=173.61; 
T=1/fs;
% yrange=[0 200];
yrange=[0 50];
yrange=[50 150];

xrange=[0 50];
xrange=[0 80];
 
eegs_fft=eegsignal;
fftdata=fft(eegs_fft,fs);
Cut_fft=[fftdata(1: floor(fs/2)+1,:)];
% Cut_fft=fftdata;
mag_abs=abs(Cut_fft);

freq=([0:fs/2]./(fs*T))';
freqs=repmat(freq,[1,3]);
axis_name={'Frequency (Hz)','Amplitude'};

fignum=fignum+1;figure(fignum);  clf
% ttext={'Separation of frequency '};
%s=['*','x','0','+','s','D'];
hold on
%for k2=1:6
  
%     plot(freq,20*log10(mag_abs(:,1)),'--go',freq,20*log10(mag_abs(:,2)),': r * '); 
%     plot(20*log10(mag_abs(:,1:3))); 
    plot(freq,20*log10(mag_abs)); 
    title(source_Lname{Tnum});
    
    fnn=['fft_',source_folder]; fnn=strrep(fnn, '-', '_');
    set(fignum,'name',fnn);
    xlabel('Frequency(Hz)');
    ylabel('Power');
%   set(gca,'XLabel',axis_name{1});
 %   set(gca,'YLabel',axis_name{2});
%     set(gca,'ylim',yrange,'xlim',xrange);
        set(gca,'xlim',xrange);
grid on;


    fignum=fignum+1;figure(fignum);  clf
    mag_ave=(sum(mag_abs')./size(data_all,2))';

    plot(freq,20*log10(mag_ave)); 
    title(source_Lname{Tnum});
    
    fnn=['fft_average_',source_folder]; fnn=strrep(fnn, '-', '_');
    set(fignum,'name',fnn);
    xlabel('Frequency(Hz)');
    ylabel('Power');
%     set(gca,'ylim',yrange,'xlim',xrange);
    set(gca,'xlim',xrange);
    grid on;

    all_fft(:,Tnum)=mag_ave;
%   Hleg1 = legend (  'gamma','beta','alpha','theta','delta','EOG' );
%   Hleg1 = legend (  'original','filtered' );
% hold off

datafname=output_folder;
save_fig;
cd(output_folder);
save(fout2_name,'data_all','-ascii','-tabs');
cd(currdir);

end

close all;
    fignum=fignum+1;figure(fignum);  clf
    mag_ave=(sum(mag_abs')./size(data_all,2))';

    plot(freq,20*log10(all_fft)); 
    title('FFT Comparison');
    
    fnn=['fft_all_',source_folder]; fnn=strrep(fnn, '-', '_');
    set(fignum,'name',fnn);
    xlabel('Frequency(Hz)');
    ylabel('Power');
%     set(gca,'ylim',yrange,'xlim',xrange);
        set(gca,'xlim',xrange);
grid on;
    
%     all_fft(:,Tnum)=mag_ave;
    
    Hleg1 = legend (source_L2name);
    datafname='out_all';
save_fig;

