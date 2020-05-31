function convertNELdirM2MAT(data_dir,filetypes2convert)
% General code to initialize an entire NEL data directory by converting all
% m files to mat files.
% Can be called from ANY directory, and will be returned to that diretcory.
% Passed: 
%  data_dir: directory to get data from
%  filetypes2convert: cell array with a list of specific filetypes to
%    process (e.g., filetypes2convert ={'CAP','CALIB'}). If not passed, all
%    file types will be processed
%
% Data file types processed:
% CAP, CALIB
% ANF, OAE, ABR, FFR, others?
% 
% saves as picData.xxxxx

%% find file types to process
if ~exist('filetypes2convert', 'var')
    filetypes2convert = {'CALIB','CAP','OAE','ANF', 'ABR'};
end
%% use current directory if directories not passed 
if ~exist(data_dir, 'dir')
    data_dir=pwd;
end

%% TODO
% 1) use NEL core files when possible
% 2) setup CAP and calib for now (we'll do rest later)
% 3) use you CAP_setup to handle your directory structure
% 4) save whole structure as picData.xxxxx
    
curr_dir = pwd;  % saves current directoty to allow return at end

cd(data_dir) %moves to directory with data files

save_fldr = 'MAT Files';
save_dir = fullfile(data_dir, save_fldr);

if ~exist(save_dir, 'dir') %checks if directory exists
    mkdir(save_dir) %if it doesn't exist, creates directory for MAT files
end

%% Adds folder with loadPic to path for later

addpath('Y:\Users\Caitlin\CAP data\testINITm2mat'); 

% May need to change/fix so more general 
% Can you assume directory where called (pwd) has loadPic ???
% so then just: addpath(curr_dir); ??

%% Sets which conditions to convert
if sum(strcmp('CAP', filetypes2convert)) > 0
    CAP = 1;
else
    CAP = 0; %won't convert cap files
end

if sum(strcmp('CALIB', filetypes2convert)) > 0
    CALIB = 1;
else
    CALIB = 0; %won't convert calib files
end

% Do other conditions as well

%% CAP conversion
if CAP == 1 %checks if need to convert cap files
    %finds cap files
    E = dir(fullfile(data_dir, '*_CAP*')); %CAP files in current directory
    cap = {E(~[E.isdir]).name}; %CAP file names
    
    cap_num = cell(size(cap));
    for i = 1:length(cap)
        num = regexp(cap{i}, '\d\d\d\d', 'match'); %finds pic num
        cap_num{i} = num{1}; %saves pic num
    end
    
    %loads .m files and resaves as .mat files
    for i = 1:length(cap_num)
        pic_num = str2double(cap_num{i}); %converts string to double
        picData = loadPic(pic_num);
                
        name = cap{i}; %finds file name
        filename = name(1:end-2); %drops .m from name
        %saves structs as .mat files
        save(fullfile(save_dir, filename), 'picData');
    end
    
end

%% CALIB conversion
if CALIB == 1
    %finds calib files
    E = dir(fullfile(data_dir, '*_calib*')); %calibration files in current dir
    calib = {E(~[E.isdir]).name}; %calibration file names
    
    calib_num = cell(size(calib));
    for j = 1:length(calib)
        calib_num{j} = regexp(calib{j}, '\d\d\d\d', 'match'); %save calib pic num
    end
    
    %loads .m files and resaves as .mat files
    for i = 1:length(calib_num)
        pic_num = str2double(calib_num{i}); %converts string to double
        picData = loadPic(pic_num);
                
        name = calib{i}; %finds file name
        filename = name(1:end-2); %drops .m from name
        %saves structs as .mat files
        save(fullfile(save_dir, filename), 'picData');
    end
    
end

%% Other conversions


%% Moves back to initial directory where called
cd(curr_dir) 
