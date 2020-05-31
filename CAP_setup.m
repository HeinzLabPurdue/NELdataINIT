% File: CAP_setup

% Date: April 1, 2020
% By: Caitlin Heffner
% Updated: May 14, 2020

wrk_dir = pwd; %directory where CAP analysis codes stored together
main_dir = 'Y:\Users\Caitlin\'; %main directory where files are stored
main_fldr = 'test_CAP_Project\Data'; %main folder where subfolders of individual experiments are
curr_fldr = 'DA-2015_08_31-ChinQ199_acute_carboplatin'; %specific data folder you want to look at
data_dir = fullfile(main_dir, main_fldr, curr_fldr); 
% save_fldr = 'Mat files';
% save_dir = fullfile(main_dir, main_fldr, save_fldr, curr_fldr);
% 
% if ~exist(save_dir, 'dir') %checks if directory exists
%     mkdir(save_dir) %if it doesn't exist, creates directory
% end

filetypes2convert = {'CALIB', 'CAP'};

% convertNELdirM2MAT(data_dir, {'CAP'});
convertNELdirM2MAT(data_dir, filetypes2convert);
