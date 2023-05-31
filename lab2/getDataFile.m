function [x,y, sigma] = getDataFile(path)
    %GETDATAFILE returns data from file with coloumns [x y sigma]
    fid = fopen(path,'r');
    data = fscanf(fid, '%g %g %g', [3 inf]);
    data = data';
    x = data(:,1);
    y = data(:,2);
    sigma = data(:,3);
end

