function x = loadPicMAT(picNum)     % Loads mat file
% Created: Caitlin Heffner
% Modified: M. Heinz 
picSearchString = sprintf('p%04d*.mat', picNum);
picMatFile = dir(picSearchString);
if (~isempty(picMatFile))
    load(picMatFile.name); %loads mat file
    x = picData; %saves output as picData struct
else
   error = sprintf('File p%04d*.mat not found.', picNum);
   x = [];
   return;
end
