
close all;
clc;
clearvars settings;

global settings;
settings.mfrm = 12;          %minimum no of frames
settings.T   = 20;           %Maximum Time
settings.raw_video = false;  %raw video off

global gui ;                 % enable global variable
gui = gui_class();           % starting 


