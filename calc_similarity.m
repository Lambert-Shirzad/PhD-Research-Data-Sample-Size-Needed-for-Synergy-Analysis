%this function calculates 3 similarity metrics that relate an expected
%synergy set (Tr) to the actual synergy set (Val) of a dataset

%Navid Lambert-Shirzad 20170105


function [AvgReconsErr_Val, RegCoeff_Val, RSquared_Val, AvgValueDP, nCommonMethod2] = calc_similarity(DOF, ValFullSet, Synergies_Tr, Synergies_Val) %nCommonMethod1, 

    %% reconstruct the data 
    ValApprox = (ValFullSet/Synergies_Tr)*Synergies_Tr;

    %% avg reconstruction error of each data point (degrees)
    AvgReconsErr_Val = (1/size(ValFullSet,1))*sum((1/DOF*sum((ValFullSet -ValApprox).^2,2)).^0.5); 

    %% correlation coefficient (slope) and R-squared
    Allregcoeff = zeros(DOF,1);
    AllRSquared = zeros(DOF,1);
    for temp = 1:DOF %10 DOFs
       [B,~,~,~,STATS] = regress(ValApprox(:,temp), horzcat(ones(size(ValFullSet(:,temp),1),1), ValFullSet(:,temp)) );
       Allregcoeff(temp) = B(2);
       AllRSquared(temp) = STATS(1);
    end
    Allregcoeff = ones(size(Allregcoeff)) - abs(ones(size(Allregcoeff))-Allregcoeff);
    RegCoeff_Val = max(Allregcoeff);
    RSquared_Val = max(AllRSquared);

    %% dim of common subspace (weak measure)
%     AllCommonCoeff = zeros(size(Synergies_Tr,1), size(Synergies_Val,1));
%     for i = 1:size(Synergies_Tr,1)
%         for j = 1:size(Synergies_Val,1)
%             AllCommonCoeff(i,j) = regress(Synergies_Tr(i,:)', Synergies_Val(j,:)');
%         end
%     end
%     nCommonMethod1 = 0; 
%     for i = 1:size(Synergies_Tr,1) %ndim
%         if max(abs(AllCommonCoeff(i,:)))>0.8
%             nCommonMethod1 = nCommonMethod1+1;
%         end
%     end
%     nCommonMethod1 = nCommonMethod1/max(size(Synergies_Val,1), size(Synergies_Tr,1));
    
    %% dim of common subspace (strong measure)

    %calculate dot products between all synergy vectors
    DP_All = zeros(size(Synergies_Tr,1), size(Synergies_Val,1)); %DP for dot product
    for i = 1:size(Synergies_Tr,1) 
        for j = 1:size(Synergies_Val,1)
            DP_All(i,j) = Synergies_Tr(i,:)*Synergies_Val(j,:)'; 
        end
    end      
    %match synergy vectors, i.e. which ones have the highest DP (matching
    %on the rows)
    NumMatched = 0;
    NumDPSimilar = 0;
    while NumMatched < min(size(Synergies_Tr,1),size(Synergies_Val,1))
        for RowNum = 1:size(Synergies_Tr,1) 
            %find the max DP in the row
            [MaxDPRow, IndRow] = max(DP_All(RowNum,:));
            %check to see if the max in row is also max in column
            %if so it is a match
            [~, IndCol] = max(DP_All(:,IndRow));
            if MaxDPRow ~= 0 %this row is not previously matched
                if IndCol == RowNum
                    %this is a match
                    NumMatched = NumMatched+1;
                    DPvalue_Matched_Syn(NumMatched) = MaxDPRow;
                    if DPvalue_Matched_Syn(NumMatched) >= 0.8%similarity_range_DP
                        NumDPSimilar = NumDPSimilar + 1;
                    end
                    DP_All(RowNum,:) = zeros(size(DP_All(RowNum,:)));
                    DP_All(:,IndRow) = zeros(size(DP_All(:,IndRow)));                                             
                end
                if NumMatched == min(size(Synergies_Tr,1),size(Synergies_Val,1))
                    break
                end
            end
        end    
    end
    AvgValueDP = mean(DPvalue_Matched_Syn);
    nCommonMethod2 = NumDPSimilar / max(size(Synergies_Tr,1),size(Synergies_Val,1));
    
    
