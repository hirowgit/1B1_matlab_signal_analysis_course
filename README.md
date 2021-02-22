# 1A_matlab_basic_course
https://github.com/hirowgit/1A0_matlab_basic_course
For basic things to use MATLAB.
 
# Lecture 1
## < FFT analysis >

### 1) EEG open data  
[1] Andrzejak et al. (2001): Indications of nonlinear deterministic and finite-dimensional structures in time series of brain electrical activity: dependence on recording region and brain state, Phys Rev E Stat Nonlin Soft Matter Phys. 2001 Dec;64(6 Pt 1):061907.
https://pubmed.ncbi.nlm.nih.gov/11736210/
http://users.fs.cvut.cz/ivo.bukovsky/PROJEKT/Data/Realna/BIO/EEG/reference/PRE61907.pdf

### 2) Check the website 
[2] http://epileptologie-bonn.de/cms/upload/download/pdf/Broschre_engl_20.11.pdf
According to the article [1], 
EEG time series were derived from  
http://www.meb.uni-bonn.de/epileptologie/science/physik/eegdata.html

Note: EEG data was obtained in an intracranial EEG recording
  
### 3) Download EEG data first
Files need to be saved in the follwoing  way 

~~
For each set (A-E) there is a ZIP-file containing 100 TXT-files. Each TXT-file consists of 4096 samples of one EEG time series in ASCII code. SET A Z.zip with Z000.txt - Z100.txt (564 kB)

SET A     Z.zip      with     Z000.txt - Z100.txt     (564 kB)  -> "A-Z" folder
SET B      O.zip     with     O000.txt - O100.txt     (611 kB) -> "B-O" folder
SET C     N.zip      with     N000.txt - N100.txt      (560 kB) -> "C-N" folder
SET D     F.zip       with     F000.txt - F100.txt      (569kB) -> "D-F" folder
SET E     S.zip      with     S000.txt - S100.txt      (747kB) -> "E-S" folder

~~

### 3) Run "freqPlotEEG_Gold.m"  as main file
type the file path of the folder "A-Z" and so on,
or put all above folder in the same folder of the main m file.
