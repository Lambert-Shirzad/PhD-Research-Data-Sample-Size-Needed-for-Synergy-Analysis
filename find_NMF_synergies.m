%the function takes in two dataset and find NMF synergies of the two
%datasets with training criteria as :
%VAF > 90, DOF_VAF > 60, Delta_VAF < 5
%The function returns synergy vectors of the two datasets

%Written by Navid Lambert-Shirzad
%20170105

function [Synergies_Tr, Synergies_Val] = find_NMF_synergies(DOF, TrFullSet, ValFullSet)

    GoodTrainTr = 0; GoodTrainVal=0; 
    numSynergy = 1;
    while numSynergy < DOF-1
        %perform NNMF on data
        true = 0; count = 1;
        while true == 0 && count < 10 && GoodTrainTr == 0
            [ScoresTrTemp, SynergiesTrAll] = nnmf(TrFullSet, numSynergy); 
            if rank(SynergiesTrAll) == numSynergy
                true = 1; %not underfitting or stuck in local minima
            end
            count = count + 1;
            if count == 10
                clear SynergiesTrAll
            end
        end
        true = 0; count = 1;
        while true == 0 && count < 10 && GoodTrainVal == 0
            [ScoresValTemp, SynergiesValAll] = nnmf(ValFullSet, numSynergy); 
            if rank(SynergiesValAll) == numSynergy
                true = 1; %not underfitting or stuck in local minima
            end
            count = count + 1;
            if count == 10
                SynergiesValAll = zeros(size(SynergiesValAll));
            end
        end


        if GoodTrainTr == 0 || GoodTrainVal == 0
            TrApprox = ScoresTrTemp * SynergiesTrAll;
            TrVAF(numSynergy,1) = 100*(1 - (sum(sum((TrFullSet - TrApprox).^2,2),1)) / (sum(sum((TrFullSet).^2,2),1))); %1-SSE/SST
            ValApprox = ScoresValTemp * SynergiesValAll;
            ValVAF(numSynergy,1) = 100*(1 - (sum(sum((ValFullSet - ValApprox).^2,2),1)) / (sum(sum((ValFullSet).^2,2),1))); %1-SSE/SST
            if numSynergy ~= 1
                DeltaTrVAF(numSynergy,1)=TrVAF(numSynergy,1)-TrVAF(numSynergy-1,1);
                DeltaValVAF(numSynergy,1)=ValVAF(numSynergy,1)-ValVAF(numSynergy-1,1);
            else
                DeltaTrVAF(numSynergy,1)=TrVAF(numSynergy,1);
                DeltaValVAF(numSynergy,1)=ValVAF(numSynergy,1);
            end
            TrDOF_VAF(numSynergy,:) = 100*(1 - sum((TrFullSet - TrApprox).^2,1) ./ sum((TrFullSet).^2,1));
            ValDOF_VAF(numSynergy,:) = 100*(1 - sum((ValFullSet - ValApprox).^2,1) ./ sum((ValFullSet).^2,1));
        end

        if GoodTrainTr==0 & TrVAF(numSynergy,1)>90 & DeltaTrVAF(numSynergy,1)<5 % & TrDOF_VAF(numSynergy,:)>60
%             ndim_Tr = numSynergy;
%             VAF_Tr = TrVAF(numSynergy,1);
%             DeltaVAF_Tr = DeltaTrVAF(numSynergy,1);
%             DOF_VAF_Tr = TrDOF_VAF(numSynergy,:);
            GoodTrainTr = 1;
            Synergies_Tr = SynergiesTrAll;
            %Scores_Tr = ScoresTrTemp;
        end
        if GoodTrainVal==0 & ValVAF(numSynergy,1)>90 & DeltaValVAF(numSynergy,1)<5 %& ValDOF_VAF(numSynergy,:)>60
%             ndim_Val = numSynergy;
%             VAF_Val = ValVAF(numSynergy,1);
%             DeltaVAF_Val = DeltaValVAF(numSynergy,1);
%             DOF_VAF_Val = ValDOF_VAF(numSynergy,:);
            GoodTrainVal = 1;
            Synergies_Val = SynergiesValAll;
            %Scores_Val = ScoresValTemp;
        end

        numSynergy = numSynergy+1;
        if numSynergy == DOF-1
            if GoodTrainTr==0 || GoodTrainVal==0 
                numSynergy = 1;
            end
        end
        if GoodTrainTr==1 && GoodTrainVal==1 
                numSynergy = DOF-1; %terminate training
        end
    end 