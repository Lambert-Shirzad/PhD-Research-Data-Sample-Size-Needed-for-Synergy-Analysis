% function to dissect the fulldataset into a "includedEpochs*5s" Tr and Val
% datasets (within a 10s epoch, assign 50% of data to Tr and 50% to Val)

function [dissectedDataTr, dissectedDataVal] = dissect_data(fullData, totalEpochs, includedEpochs, frequency)

chosenEpochs = sort(randperm(totalEpochs-1, includedEpochs));

for i = 1:includedEpochs
    epochData = fullData( (chosenEpochs(i)-1)/2*(frequency*10)+1 : chosenEpochs(i)/2*(frequency*10)+(frequency*5) ,:); %for healthy
    %epochData = fullData( (chosenEpochs(i)-1)*(frequency*10)+1 : chosenEpochs(i)*(frequency*10) ,:); %for stroke
    cutOff = randperm( floor(size(epochData,1)/2) , 1 ); %I am putting the cutoff point in the first 5s of the epoch
    TrChunk = epochData(cutOff:cutOff+frequency*5-1,:);
    ind = setdiff(1:frequency*10, cutOff:cutOff+frequency*5-1);
    ValChunk = epochData(ind,:);
    if i == 1
       tempTr = TrChunk;
       tempVal = ValChunk;       
    else
       tempTr = vertcat(tempTr,TrChunk);
       tempVal = vertcat(tempVal,ValChunk);
    end
end

dissectedDataTr = tempTr;
dissectedDataVal = tempVal;
return