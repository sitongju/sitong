function processfile(inputFile,outputfile)
%PROCESSFILE Converts data into correct format for exploremap
% This function will take the data that is outputted by the site:
% https://topex.ucsd.edu/cgi-bin/get_data.cgi and process the data so that
% it is in the right file format. The inputFile must be the file generated
% from the website. The outputfile will be the name of the file generated.
% The function will sort the data so that when plotted, the data is in the
% correct format for the exploremap function to process and produce the
% same plot every time with the first row and first column in the top left
% corner. It will add the dimensions of the data as the first row of the
% output file so the HW9 script file can read it.

if ~isfile(inputFile)
    error('File not found!')
end

data = dlmread(inputFile);

data = sortrows(data,1);

numRow = sum(data(:,1) == data(1,1));
numCol = length(data)/numRow;

dlmwrite(outputfile,[numRow, numCol],' ');
dlmwrite(outputfile,data,'-append','delimiter', ' ');

