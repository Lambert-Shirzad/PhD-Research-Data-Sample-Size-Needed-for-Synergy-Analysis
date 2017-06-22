% This is the main function used for my ICORR 2017 paper.

% Written by Navid Lambert-Shirzad 20170105


function main_calculations_ICORR2017
    
    %everything will be done for all participants
    for SubjectIDs = 1:10
        
        totalFold = 45;
        %% LOAD THE DATA
        if SubjectIDs < 10
            SubjID = strcat('0', num2str(SubjectIDs));
        else
            SubjID = num2str(SubjectIDs);
        end
        
        %%%%Healthy EMG%%%%
        load(strcat('EMG_H', SubjID, '_Left.mat'))
        load(strcat('EMG_H', SubjID, '_Right.mat'))
        strongHand = ones(10,1);
        if strongHand(SubjectIDs) == 1
            weakSide = ProcessedLeftSide(:,2:9);  %column 1 has time, not useful for this study   
            strongSide = ProcessedRightSide(:,2:9); 
        else
            strongSide = ProcessedLeftSide(:,2:9); 
            weakSide = ProcessedRightSide(:,2:9); 
        end
        totalTime = ProcessedRightSide(end,1);
        dataType = 'EMG';
        populationType = 'Healthy';
        DOF = 8;
        dataFrequency = 100; %Hz
        epochlength = 5;

        
        %%%Stroke EMG%%%%
%         load(strcat('EMG_SS', SubjID, '_Left.mat'))
%         load(strcat('EMG_SS', SubjID, '_Right.mat'))
%         strongHand = [0 1 1 1 1 0 1 0 0 1];
%         if strongHand(SubjectIDs) == 1
%             weakSide = ProcessedLeftSide(:,2:9);  %column 1 has time, not useful for this study   
%             strongSide = ProcessedRightSide(:,2:9); 
%         else
%             strongSide = ProcessedLeftSide(:,2:9); 
%             weakSide = ProcessedRightSide(:,2:9); 
%         end
%         totalTime = ProcessedRightSide(end,1);
%         dataType = 'EMG';
%         populationType = 'Stroke';
%         DOF = 8;
%         dataFrequency = 100; %Hz
%         epochlength = 10;

        
        %%%%Healthy Kin%%%%
%         load(strcat('FullSet_H', SubjID, '_Kin.mat'))
%         strongHand = ones(10,1);
%         if strongHand(SubjectIDs) == 1
%             weakSide = [FullSet(:,2:4) FullSet(:,13:14) FullSet(:,16:20)];  %column 1 has time, not useful for this study   
%             strongSide = [FullSet(:,2:6) FullSet(:,8:12)];
%         else
%             strongSide = [FullSet(:,2:4) FullSet(:,13:14) FullSet(:,16:20)];
%             weakSide = [FullSet(:,2:6) FullSet(:,8:12)]; %10DOFs
%         end
%         dataType = 'KIN';
%         populationType = 'Healthy';
%         DOF = 10;
%         dataFrequency = 30; %Hz
%         totalTime = size(FullSet,1)/dataFrequency;
%         %make sure data is non-negative
%         strongSide = repmat([90 90 90 90 0 90 0 90 10 70],size(strongSide,1),1) + strongSide; %[90 90 90 90 0 90 0 90 10 70] from OpenSim model, abs(lower bound) of each DOF
%         weakSide = repmat([90 90 90 90 0 90 0 90 10 70],size(weakSide,1),1) + weakSide;
        
        %%%%Stroke Kin%%%%
%         load(strcat('FullSet_SS', SubjID, '_Kin.mat'))
%         strongHand = [0 1 1 1 1 0 1 0 0 1];
%         if strongHand(SubjectIDs) == 1
%             weakSide = [NumericData(:,2:4) NumericData(:,13:14) NumericData(:,16:20)];  %column 1 has time, not useful for this study   
%             strongSide = [NumericData(:,2:6) NumericData(:,8:12)];
%         else
%             strongSide = [NumericData(:,2:4) NumericData(:,13:14) NumericData(:,16:20)];
%             weakSide = [NumericData(:,2:6) NumericData(:,8:12)]; %10DOFs
%         end
%         dataType = 'KIN';
%         populationType = 'Stroke';
%         DOF = 10;
%         dataFrequency = 30; %Hz
%         totalTime = size(NumericData,1)/dataFrequency;
%         %make sure data is non-negative
%         strongSide = repmat([90 90 90 90 0 90 0 90 10 70],size(strongSide,1),1) + strongSide; %[90 90 90 90 0 90 0 90 10 70] from OpenSim model, abs(lower bound) of each DOF
%         weakSide = repmat([90 90 90 90 0 90 0 90 10 70],size(weakSide,1),1) + weakSide;
%         epochlength = 10;
        
        %% ANALYSIS
        totalEpochs = floor(totalTime/epochlength); %look at the time, how many 5s epochs are there?
        
        time_reconsErr_Strong=zeros(totalEpochs-1,10);
        time_corelCoeff_Strong=zeros(totalEpochs-1,10);
%         time_nCommonM1_Strong=zeros(totalEpochs-1,10); 
        time_RSquared_Strong=zeros(totalEpochs-1,10);
        time_AvgValueDP_Strong=zeros(totalEpochs-1,10);
        time_nCommonM2_Strong=zeros(totalEpochs-1,10);
        
        time_reconsErr_Weak=zeros(totalEpochs-1,10); 
        time_corelCoeff_Weak=zeros(totalEpochs-1,10);
%         time_nCommonM1_Weak=zeros(totalEpochs-1,10);
        time_RSquared_Weak=zeros(totalEpochs-1,10);
        time_AvgValueDP_Weak=zeros(totalEpochs-1,10);
        time_nCommonM2_Weak=zeros(totalEpochs-1,10);
            
        for includedEpochs = 1:totalEpochs-1 %for steps every 5s
            [SubjectIDs includedEpochs]
            
            %do a k-fold analysis of k=totalFold 
            reconsErr_Strong = zeros(totalFold,1); corelCoeff_Strong = zeros(totalFold,1); %nCommonM1_Strong=zeros(totalFold,1);
            RSquared_Strong = zeros(totalFold,1); AvgValueDP_Strong = zeros(totalFold,1); nCommonM2_Strong = zeros(totalFold,1);
            reconsErr_Weak = zeros(totalFold,1); corelCoeff_Weak = zeros(totalFold,1); %nCommonM1_Weak=zeros(totalFold,1);
            RSquared_Weak = zeros(totalFold,1); AvgValueDP_Weak = zeros(totalFold,1); nCommonM2_Weak = zeros(totalFold,1);
            for foldCount = 1:totalFold 
                %%%%%%%%%%%%%%%%foldCount
                %create the training and validation data
                [strongSideTr, strongSideVal]  = dissect_data(strongSide, totalEpochs, includedEpochs, dataFrequency);             
                [weakSideTr, weakSideVal] = dissect_data(weakSide, totalEpochs, includedEpochs, dataFrequency);
                %train the NMF synergies
                [syn_Strong_Tr, syn_Strong_Val] = find_NMF_synergies(DOF, strongSideTr, strongSideVal);
                [syn_Weak_Tr, syn_Weak_Val] = find_NMF_synergies(DOF, weakSideTr, weakSideVal);       
                %compare the synergies for this fold and find fold's similarity metrics
                [reconsErr_Strong(foldCount), corelCoeff_Strong(foldCount), ... %, nCommonM1_Strong(foldCount)
                    RSquared_Strong(foldCount), AvgValueDP_Strong(foldCount), nCommonM2_Strong(foldCount)] = calc_similarity(DOF, strongSideVal, syn_Strong_Tr, syn_Strong_Val);
                [reconsErr_Weak(foldCount), corelCoeff_Weak(foldCount), ... %, nCommonM1_Weak(foldCount)
                    RSquared_Weak(foldCount), AvgValueDP_Weak(foldCount), nCommonM2_Weak(foldCount)] = calc_similarity(DOF, weakSideVal, syn_Weak_Tr, syn_Weak_Val);            
            end
            
            %find the average performance metric over folds of this trainingtime
            %trainingtime = includedEpochs*5s (amount of data used for
            %training the NMF). Also remove the outliers.
            
            time_reconsErr_Strong(includedEpochs) = mean(remove_outliers(reconsErr_Strong));
            time_corelCoeff_Strong(includedEpochs) = mean(remove_outliers(corelCoeff_Strong));
%             time_nCommonM1_Strong(includedEpochs) = mean(remove_outliers(nCommonM1_Strong)); 
            time_RSquared_Strong(includedEpochs) = mean(remove_outliers(RSquared_Strong));
            time_AvgValueDP_Strong(includedEpochs) = mean(remove_outliers(AvgValueDP_Strong));
            time_nCommonM2_Strong(includedEpochs) = mean(remove_outliers(nCommonM2_Strong));
            
            time_reconsErr_Weak(includedEpochs) = mean(remove_outliers(reconsErr_Weak)); 
            time_corelCoeff_Weak(includedEpochs) = mean(remove_outliers(corelCoeff_Weak));
%             time_nCommonM1_Weak(includedEpochs) = mean(remove_outliers(nCommonM1_Weak)); 
            time_RSquared_Weak(includedEpochs) = mean(remove_outliers(RSquared_Weak));
            time_AvgValueDP_Weak(includedEpochs) = mean(remove_outliers(AvgValueDP_Weak));
            time_nCommonM2_Weak(includedEpochs) = mean(remove_outliers(nCommonM2_Weak));
            
        end
        
        figure(SubjectIDs)
        subplot(2,6,1)
        plot(time_reconsErr_Strong)
        subplot(2,6,2)
        plot(time_corelCoeff_Strong)
%         subplot(2,6,3)
%         plot(time_nCommonM1_Strong)
        subplot(2,6,4)
        plot(time_RSquared_Strong)
        subplot(2,6,5)
        plot(time_AvgValueDP_Strong)
        subplot(2,6,6)
        plot(time_nCommonM2_Strong)
        
        subplot(2,6,7)
        plot(time_reconsErr_Weak)
        subplot(2,6,8)
        plot(time_corelCoeff_Weak)
%         subplot(2,6,9)
%         plot(time_nCommonM1_Weak)
        subplot(2,6,10)
        plot(time_RSquared_Weak)
        subplot(2,6,11)
        plot(time_AvgValueDP_Weak)
        subplot(2,6,12)
        plot(time_nCommonM2_Weak)
        
        savefig(figure(SubjectIDs), strcat(dataType, '_', populationType, SubjID, '.fig'))
        
        fileName = strcat(dataType, '_', populationType, SubjID, '.mat');
        save(fileName, 'time_reconsErr_Strong', 'time_corelCoeff_Strong', ... %'time_nCommonM1_Strong',
        'time_RSquared_Strong', 'time_AvgValueDP_Strong', 'time_nCommonM2_Strong', ...
        'time_reconsErr_Weak', 'time_corelCoeff_Weak',  ... %'time_nCommonM1_Weak',
        'time_RSquared_Weak', 'time_AvgValueDP_Weak', 'time_nCommonM2_Weak')
        
    end
    

