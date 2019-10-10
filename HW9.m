%{
Sitong Ju
ITP 168 Spring 2019
Homework 9
sitongju@usc.edu
%}
clear;clc;

% inport the file
% check if the file exists
FileName = input('enter the name of the file: ');
while isfile(FileName)~=1
    fprintf('The file could not be found. Please enter a new one\n');
    FileName = input('enter the name of the file: ');
end

% read the file and reshape the longitude, latitude and elevator.
map = dlmread(FileName,' ');
nrow = map(1,1);
ncol = map(1,2);
maprest = dlmread(FileName,' ',1,0);
long = reshape(maprest(:,1),nrow,ncol);
lat = reshape(maprest(:,2),nrow,ncol);
elev = reshape(maprest(:,3),nrow,ncol);

% call the function using the given three matrix.
exploremap(long,lat,elev);


