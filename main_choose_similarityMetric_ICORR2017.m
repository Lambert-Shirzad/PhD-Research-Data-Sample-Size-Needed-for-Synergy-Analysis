% This is the main function used for deciding which similarity metrics 
% can be included in the ICORR 2017 paper.

% Written by Navid Lambert-Shirzad 20170112


function main_choose_similarityMetric_ICORR2017
    %load the data in a usable format
    for SubjectIDs = 1:10
        if SubjectIDs < 10
            SubjID = strcat('0', num2str(SubjectIDs));
        else
            SubjID = num2str(SubjectIDs);
        end
        SubjID
              
        figure(1)
        subplot(2,10,SubjectIDs)
        load(strcat('EMG_Healthy', SubjID, '.mat'))
        plot([time_reconsErr_Strong(:,1) time_reconsErr_Weak(:,1)])
        hold on
        load(strcat('EMG_Stroke', SubjID, '.mat'))
        plot([time_reconsErr_Strong(:,1) time_reconsErr_Weak(:,1)])
        if SubjectIDs == 5
            title('Recons-Err')
        end
        
        subplot(2,10,SubjectIDs+10)
        load(strcat('KIN_Healthy', SubjID, '.mat'))
        plot([time_reconsErr_Strong(:,1) time_reconsErr_Weak(:,1)])
        hold on
        load(strcat('KIN_Stroke', SubjID, '.mat'))
        plot([time_reconsErr_Strong(:,1) time_reconsErr_Weak(:,1)])
        if SubjectIDs == 10
            legend('Hlt-Stg','Htl-Wk','Srk-Stg','Srk-Stg')
            %savefig(figure(1), 'Metric1.fig')
        end
        
        figure(2)
        subplot(2,10,SubjectIDs)
        load(strcat('EMG_Healthy', SubjID, '.mat'))
        plot([time_corelCoeff_Strong(:,1) time_corelCoeff_Weak(:,1)])
        hold on
        load(strcat('EMG_Stroke', SubjID, '.mat'))
        plot([time_corelCoeff_Strong(:,1) time_corelCoeff_Weak(:,1)])
        if SubjectIDs == 5
            title('Corel-Coeff')
        end
        
        subplot(2,10,SubjectIDs+10)
        load(strcat('KIN_Healthy', SubjID, '.mat'))
        plot([time_corelCoeff_Strong(:,1) time_corelCoeff_Weak(:,1)])
        hold on
        load(strcat('KIN_Stroke', SubjID, '.mat'))
        plot([time_corelCoeff_Strong(:,1) time_corelCoeff_Weak(:,1)])
        if SubjectIDs == 10
            legend('Hlt-Stg','Htl-Wk','Srk-Stg','Srk-Stg')
            %savefig(figure(2), 'Metric2.fig')
        end
        
        figure(3)
        subplot(2,10,SubjectIDs)
        load(strcat('EMG_Healthy', SubjID, '.mat'))
        plot([time_RSquared_Strong(:,1) time_RSquared_Weak(:,1)])
        hold on
        load(strcat('EMG_Stroke', SubjID, '.mat'))
        plot([time_RSquared_Strong(:,1) time_RSquared_Weak(:,1)])
        if SubjectIDs == 5
            title('RSquared')
        end
        
        subplot(2,10,SubjectIDs+10)
        load(strcat('KIN_Healthy', SubjID, '.mat'))
        plot([time_RSquared_Strong(:,1) time_RSquared_Weak(:,1)])
        hold on
        load(strcat('KIN_Stroke', SubjID, '.mat'))
        plot([time_RSquared_Strong(:,1) time_RSquared_Weak(:,1)])
        if SubjectIDs == 10
            legend('Hlt-Stg','Htl-Wk','Srk-Stg','Srk-Stg')
            %savefig(figure(3), 'Metric3.fig')
        end
        
        figure(4)
        subplot(2,10,SubjectIDs)
        load(strcat('EMG_Healthy', SubjID, '.mat'))
        plot([time_AvgValueDP_Strong(:,1) time_AvgValueDP_Weak(:,1)])
        hold on
        load(strcat('EMG_Stroke', SubjID, '.mat'))
        plot([time_AvgValueDP_Strong(:,1) time_AvgValueDP_Weak(:,1)])
        if SubjectIDs == 5
            title('AvgValueDP')
        end
        
        subplot(2,10,SubjectIDs+10)
        load(strcat('KIN_Healthy', SubjID, '.mat'))
        plot([time_AvgValueDP_Strong(:,1) time_AvgValueDP_Weak(:,1)])
        hold on
        load(strcat('KIN_Stroke', SubjID, '.mat'))
        plot([time_AvgValueDP_Strong(:,1) time_AvgValueDP_Weak(:,1)])
        if SubjectIDs == 10
            legend('Hlt-Stg','Htl-Wk','Srk-Stg','Srk-Stg')
            %savefig(figure(4), 'Metric4.fig')
        end
        
        figure(5)
        subplot(2,10,SubjectIDs)
        load(strcat('EMG_Healthy', SubjID, '.mat'))
        plot([time_nCommonM2_Strong(:,1) time_nCommonM2_Weak(:,1)])
        hold on
        load(strcat('EMG_Stroke', SubjID, '.mat'))
        plot([time_nCommonM2_Strong(:,1) time_nCommonM2_Weak(:,1)])
        if SubjectIDs == 5
            title('nCommonM2')
        end
        
        subplot(2,10,SubjectIDs+10)
        load(strcat('KIN_Healthy', SubjID, '.mat'))
        plot([time_nCommonM2_Strong(:,1) time_nCommonM2_Weak(:,1)])
        hold on
        load(strcat('KIN_Stroke', SubjID, '.mat'))
        plot([time_nCommonM2_Strong(:,1) time_nCommonM2_Weak(:,1)])
        if SubjectIDs == 10
            legend('Hlt-Stg','Htl-Wk','Srk-Stg','Srk-Stg')
            %savefig(figure(5), 'Metric5.fig')
        end

    end
    
    

    