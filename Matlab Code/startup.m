

%Set data paths
global chardata;
addpath('Data_path', '-begin');
addpath('..',        '-begin');
disp('Initilation of data');
load('character_recognize.mat');

%add library for process_frame();

disp('Load DIPlib 2.7');
run('C:\Program Files\DIPimage 2.7\dipstart.m');
disp('DIPlib 2.7 Loaded successfully ');
