%%This is to visualize the data in a histogram.
%%helps to play with transformations to make
%gaussian fit more accurate

data = csvread('featureset12');
dz = data(:, 1);
indicate = data(:, [2:8]);
dataun = data(:, [9:15]);
olddata = data(:, [9:15]);
for n = 1:size(dataun)(1)
    ind = find(indicate(n, :) == 1)-1;
    if size(ind)(end) == 0
      ind = 0;
    end
    dataun(n, :) = rotatebynum((ind(end)+1),olddata(n, :));
end


stuff = exp(-1 .* (dataun(:, 2) .+ 1)) ;
hist(stuff, 10000);

