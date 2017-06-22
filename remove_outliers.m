%to keep data withing 95 percentile

function goodData = remove_outliers(badData)
meanValue = mean(badData);
sdValue = std(badData);
lowerBound = find(badData > meanValue-1*sdValue);
upperBound = find(badData < meanValue+1*sdValue); 
goodData = badData(intersect(upperBound, lowerBound));

    

