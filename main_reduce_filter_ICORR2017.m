

% Written by Navid Lambert-Shirzad 20170113


function main_reduce_filter_ICORR2017
    gaussEqn = 'a*exp(-x/b)+c-d/x';
    startPoints = [2 2 2 2];
    syms x
    pp = 0.89; %plateau percentage
    for SubjectIDs = 1:10
        if SubjectIDs < 10
            SubjID = strcat('0', num2str(SubjectIDs));
        else
            SubjID = num2str(SubjectIDs);
        end
        SubjID
%% smoothing the data                        
%         figure(2)
%         subplot(2,10,SubjectIDs)
%         load(strcat('EMG_Healthy', SubjID, '.mat'))
%         plot([smooth(time_reconsErr_Strong(:,1),7) smooth(time_reconsErr_Weak(:,1),7)])
%         hold on
%         load(strcat('EMG_Stroke', SubjID, '.mat'))
%         plot([smooth(time_reconsErr_Strong(:,1),7) smooth(time_reconsErr_Weak(:,1),7)])
%         if SubjectIDs == 5
%             title('Recons-Err')
%         end        
%         subplot(2,10,SubjectIDs+10)
%         load(strcat('KIN_Healthy', SubjID, '.mat'))
%         plot([smooth(time_reconsErr_Strong(:,1),7) smooth(time_reconsErr_Weak(:,1),7)])
%         hold on
%         load(strcat('KIN_Stroke', SubjID, '.mat'))
%         plot([smooth(time_reconsErr_Strong(:,1),7) smooth(time_reconsErr_Weak(:,1),7)])
%         if SubjectIDs == 10
%             legend('Hlt-Stg','Htl-Wk','Srk-Stg','Srk-Stg')
%             %savefig(figure(1), 'Metric1.fig')
%         end
%                 
%         figure(4)
%         subplot(2,10,SubjectIDs)
%         load(strcat('EMG_Healthy', SubjID, '.mat'))
%         plot([smooth(time_AvgValueDP_Strong(:,1),7) smooth(time_AvgValueDP_Weak(:,1),7)])
%         hold on
%         load(strcat('EMG_Stroke', SubjID, '.mat'))
%         plot([smooth(time_AvgValueDP_Strong(:,1),7) smooth(time_AvgValueDP_Weak(:,1),7)])
%         if SubjectIDs == 5
%             title('AvgValueDP')
%         end        
%         subplot(2,10,SubjectIDs+10)
%         load(strcat('KIN_Healthy', SubjID, '.mat'))
%         plot([smooth(time_AvgValueDP_Strong(:,1),7) smooth(time_AvgValueDP_Weak(:,1),7)])
%         hold on
%         load(strcat('KIN_Stroke', SubjID, '.mat'))
%         plot([smooth(time_AvgValueDP_Strong(:,1),7) smooth(time_AvgValueDP_Weak(:,1),7)])
%         if SubjectIDs == 10
%             legend('Hlt-Stg','Htl-Wk','Srk-Stg','Srk-Stg')
%             %savefig(figure(4), 'Metric4.fig')
%         end
        
%% equation fitting        
%         figure(SubjectIDs)
%         load(strcat('EMG_Healthy', SubjID, '.mat'))
%         f1 = fit([1:size(time_reconsErr_Strong(:,1))]',smooth(time_reconsErr_Strong(:,1),7),...
%             gaussEqn,'Start', startPoints, 'Lower',[-300,-300,-300,-300],'Upper',[300,300,300,300]);
%         subplot(4,2,1)
%         plot(f1,[1:size(time_reconsErr_Strong(:,1))]',smooth(time_reconsErr_Strong(:,1),7))
%         f2 = fit([1:size(time_reconsErr_Weak(:,1))]',smooth(time_reconsErr_Weak(:,1),7),...
%             gaussEqn,'Start', startPoints, 'Lower',[-300,-300,-300,-300],'Upper',[300,300,300,300]);
%         subplot(4,2,2)
%         plot(f2, [1:size(time_reconsErr_Weak(:,1))]',smooth(time_reconsErr_Weak(:,1),7))
%         
%         load(strcat('EMG_Stroke', SubjID, '.mat'))
%         f3 = fit([1:size(time_reconsErr_Strong(:,1))]',smooth(time_reconsErr_Strong(:,1),7),...
%             gaussEqn,'Start', startPoints, 'Lower',[-300,-300,-300,-300],'Upper',[300,300,300,300]);
%         subplot(4,2,3)
%         plot(f3,[1:size(time_reconsErr_Strong(:,1))]',smooth(time_reconsErr_Strong(:,1),7))
%         f4 = fit([1:size(time_reconsErr_Weak(:,1))]',smooth(time_reconsErr_Weak(:,1),7),...
%             gaussEqn,'Start', startPoints, 'Lower',[-300,-300,-300,-300],'Upper',[300,300,300,300]);
%         subplot(4,2,4)
%         plot(f4, [1:size(time_reconsErr_Weak(:,1))]',smooth(time_reconsErr_Weak(:,1),7))
%          
%         load(strcat('KIN_Healthy', SubjID, '.mat'))
%         f5 = fit([1:size(time_reconsErr_Strong(:,1))]',smooth(time_reconsErr_Strong(:,1),7),...
%             gaussEqn,'Start', startPoints, 'Lower',[-300,-300,-300,-300],'Upper',[300,300,300,300]);
%         subplot(4,2,5)
%         plot(f5,[1:size(time_reconsErr_Strong(:,1))]',smooth(time_reconsErr_Strong(:,1),7))
%         f6 = fit([1:size(time_reconsErr_Weak(:,1))]',smooth(time_reconsErr_Weak(:,1),7),...
%             gaussEqn,'Start', startPoints, 'Lower',[-300,-300,-300,-300],'Upper',[300,300,300,300]);
%         subplot(4,2,6)
%         plot(f6, [1:size(time_reconsErr_Weak(:,1))]',smooth(time_reconsErr_Weak(:,1),7))
%         
%         load(strcat('KIN_Stroke', SubjID, '.mat'))
%         f7 = fit([1:size(time_reconsErr_Strong(:,1))]',smooth(time_reconsErr_Strong(:,1),7),...
%             gaussEqn,'Start', startPoints, 'Lower',[-300,-300,-300,-300],'Upper',[300,300,300,300]);
%         subplot(4,2,7)
%         plot(f7,[1:size(time_reconsErr_Strong(:,1))]',smooth(time_reconsErr_Strong(:,1),7))
%         f8 = fit([1:size(time_reconsErr_Weak(:,1))]',smooth(time_reconsErr_Weak(:,1),7),...
%             gaussEqn,'Start', startPoints, 'Lower',[-100,-100,-100,-100],'Upper',[100,100,100,100]);
%         subplot(4,2,8)
%         plot(f8, [1:size(time_reconsErr_Weak(:,1))]',smooth(time_reconsErr_Weak(:,1),7))
        

        figure(1)
        load(strcat('EMG_Healthy', SubjID, '.mat'))
        f1 = fit([1:size(time_AvgValueDP_Strong(:,1))]',smooth(time_AvgValueDP_Strong(:,1),7),...
            gaussEqn,'Start', startPoints, 'Lower',[-300,-300,-300,-300],'Upper',[300,300,300,300]);
        subplot(4,2,1)
        plot(f1,[1:size(time_AvgValueDP_Strong(:,1))]',smooth(time_AvgValueDP_Strong(:,1),7))
        f2 = fit([1:size(time_AvgValueDP_Weak(:,1))]',smooth(time_AvgValueDP_Weak(:,1),7),...
            gaussEqn,'Start', startPoints, 'Lower',[-300,-300,-300,-300],'Upper',[300,300,300,300]);
        subplot(4,2,2)
        plot(f2, [1:size(time_AvgValueDP_Weak(:,1))]',smooth(time_AvgValueDP_Weak(:,1),7))
        
        load(strcat('EMG_Stroke', SubjID, '.mat'))
        f3 = fit([1:size(time_AvgValueDP_Strong(:,1))]',smooth(time_AvgValueDP_Strong(:,1),7),...
            gaussEqn,'Start', startPoints, 'Lower',[-300,-300,-300,-300],'Upper',[300,300,300,300]);
        subplot(4,2,3)
        plot(f3,[1:size(time_AvgValueDP_Strong(:,1))]',smooth(time_AvgValueDP_Strong(:,1),7))
        f4 = fit([1:size(time_AvgValueDP_Weak(:,1))]',smooth(time_AvgValueDP_Weak(:,1),7),...
            gaussEqn,'Start', startPoints, 'Lower',[-300,-300,-300,-300],'Upper',[300,300,300,300]);
        subplot(4,2,4)
        plot(f4, [1:size(time_AvgValueDP_Weak(:,1))]',smooth(time_AvgValueDP_Weak(:,1),7))

        
        load(strcat('KIN_Healthy', SubjID, '.mat'))
        f5 = fit([1:size(time_AvgValueDP_Strong(:,1))]',smooth(time_AvgValueDP_Strong(:,1),7),...
            gaussEqn,'Start', startPoints, 'Lower',[-300,-300,-300,-300],'Upper',[300,300,300,300]);
        subplot(4,2,5)
        plot(f5,[1:size(time_AvgValueDP_Strong(:,1))]',smooth(time_AvgValueDP_Strong(:,1),7))
        f6 = fit([1:size(time_AvgValueDP_Weak(:,1))]',smooth(time_AvgValueDP_Weak(:,1),7),...
            gaussEqn,'Start', startPoints, 'Lower',[-300,-300,-300,-300],'Upper',[300,300,300,300]);
        subplot(4,2,6)
        plot(f6, [1:size(time_AvgValueDP_Weak(:,1))]',smooth(time_AvgValueDP_Weak(:,1),7))
        
        load(strcat('KIN_Stroke', SubjID, '.mat'))
        f7 = fit([1:size(time_AvgValueDP_Strong(:,1))]',smooth(time_AvgValueDP_Strong(:,1),7),...
            gaussEqn,'Start', startPoints, 'Lower',[-300,-300,-300,-300],'Upper',[300,300,300,300]);
        subplot(4,2,7)
        plot(f7,[1:size(time_AvgValueDP_Strong(:,1))]',smooth(time_AvgValueDP_Strong(:,1),7))
        f8 = fit([1:size(time_AvgValueDP_Weak(:,1))]',smooth(time_AvgValueDP_Weak(:,1),7),...
            gaussEqn,'Start', startPoints, 'Lower',[-100,-100,-100,-100],'Upper',[100,100,100,100]);
        subplot(4,2,8)
        plot(f8, [1:size(time_AvgValueDP_Weak(:,1))]',smooth(time_AvgValueDP_Weak(:,1),7))
        
%% calculating plateau time
%         load(strcat('EMG_Healthy', SubjID, '.mat'))
%         f = fit([1:size(time_reconsErr_Strong(:,1))]',smooth(time_reconsErr_Strong(:,1),7),...
%             gaussEqn,'Start', startPoints, 'Lower',[-300,-300,-300,-300],'Upper',[300,300,300,300]);
%         metric1_Strong_EMG_Healthy(SubjectIDs,1) = solve(f.a*exp(-x/f.b)+f.c-f.d/x == (f.a*exp(-1/f.b)+f.c-f.d/1)+pp*(f.c - (f.a*exp(-1/f.b)+f.c-f.d/1)));
%         f = fit([1:size(time_reconsErr_Weak(:,1))]',smooth(time_reconsErr_Weak(:,1),7),...
%             gaussEqn,'Start', startPoints, 'Lower',[-300,-300,-300,-300],'Upper',[300,300,300,300]);
%         metric1_Weak_EMG_Healthy(SubjectIDs,1) = solve(f.a*exp(-x/f.b)+f.c-f.d/x == (f.a*exp(-1/f.b)+f.c-f.d/1)+pp*(f.c - (f.a*exp(-1/f.b)+f.c-f.d/1)));        
% 
%         load(strcat('EMG_Stroke', SubjID, '.mat'))
%         f = fit([1:size(time_reconsErr_Strong(:,1))]',smooth(time_reconsErr_Strong(:,1),7),...
%             gaussEqn,'Start', startPoints, 'Lower',[-300,-300,-300,-300],'Upper',[300,300,300,300]);
%         metric1_Strong_EMG_Stroke(SubjectIDs,1) = solve(f.a*exp(-x/f.b)+f.c-f.d/x == (f.a*exp(-1/f.b)+f.c-f.d/1)+pp*(f.c - (f.a*exp(-1/f.b)+f.c-f.d/1)));
%         f = fit([1:size(time_reconsErr_Weak(:,1))]',smooth(time_reconsErr_Weak(:,1),7),...
%             gaussEqn,'Start', startPoints, 'Lower',[-300,-300,-300,-300],'Upper',[300,300,300,300]);
%         metric1_Weak_EMG_Stroke(SubjectIDs,1) = solve(f.a*exp(-x/f.b)+f.c-f.d/x == (f.a*exp(-1/f.b)+f.c-f.d/1)+pp*(f.c - (f.a*exp(-1/f.b)+f.c-f.d/1)));
% 
%         load(strcat('KIN_Healthy', SubjID, '.mat'))
%         f = fit([1:size(time_reconsErr_Strong(:,1))]',smooth(time_reconsErr_Strong(:,1),7),...
%             gaussEqn,'Start', startPoints, 'Lower',[-300,-300,-300,-300],'Upper',[300,300,300,300]);
%         metric1_Strong_KIN_Healthy(SubjectIDs,1) = solve(f.a*exp(-x/f.b)+f.c-f.d/x == (f.a*exp(-1/f.b)+f.c-f.d/1)+pp*(f.c - (f.a*exp(-1/f.b)+f.c-f.d/1)));
%         f = fit([1:size(time_reconsErr_Weak(:,1))]',smooth(time_reconsErr_Weak(:,1),7),...
%             gaussEqn,'Start', startPoints, 'Lower',[-300,-300,-300,-300],'Upper',[300,300,300,300]);
%         metric1_Weak_KIN_Healthy(SubjectIDs,1) = solve(f.a*exp(-x/f.b)+f.c-f.d/x == (f.a*exp(-1/f.b)+f.c-f.d/1)+pp*(f.c - (f.a*exp(-1/f.b)+f.c-f.d/1)));
% 
%         load(strcat('KIN_Stroke', SubjID, '.mat'))
%         f = fit([1:size(time_reconsErr_Strong(:,1))]',smooth(time_reconsErr_Strong(:,1),7),...
%             gaussEqn,'Start', startPoints, 'Lower',[-300,-300,-300,-300],'Upper',[300,300,300,300]);
%         metric1_Strong_KIN_Stroke(SubjectIDs,1) = solve(f.a*exp(-x/f.b)+f.c-f.d/x == (f.a*exp(-1/f.b)+f.c-f.d/1)+pp*(f.c - (f.a*exp(-1/f.b)+f.c-f.d/1)));
%         f = fit([1:size(time_reconsErr_Weak(:,1))]',smooth(time_reconsErr_Weak(:,1),7),...
%             gaussEqn,'Start', startPoints, 'Lower',[-100,-100,-100,-100],'Upper',[100,100,100,100]);
%         metric1_Weak_KIN_Stroke(SubjectIDs,1) = solve(f.a*exp(-x/f.b)+f.c-f.d/x == (f.a*exp(-1/f.b)+f.c-f.d/1)+pp*(f.c - (f.a*exp(-1/f.b)+f.c-f.d/1)));
%         
% 
% 
%         load(strcat('EMG_Healthy', SubjID, '.mat'))
%         f = fit([1:size(time_AvgValueDP_Strong(:,1))]',smooth(time_AvgValueDP_Strong(:,1),7),...
%             gaussEqn,'Start', startPoints, 'Lower',[-300,-300,-300,-300],'Upper',[300,300,300,300]);
%         metric2_Strong_EMG_Healthy(SubjectIDs,1) = solve(f.a*exp(-x/f.b)+f.c-f.d/x == (f.a*exp(-1/f.b)+f.c-f.d/1)+pp*(f.c - (f.a*exp(-1/f.b)+f.c-f.d/1)));
%         f = fit([1:size(time_AvgValueDP_Weak(:,1))]',smooth(time_AvgValueDP_Weak(:,1),7),...
%             gaussEqn,'Start', startPoints, 'Lower',[-300,-300,-300,-300],'Upper',[300,300,300,300]);
%         metric2_Weak_EMG_Healthy(SubjectIDs,1) = solve(f.a*exp(-x/f.b)+f.c-f.d/x == (f.a*exp(-1/f.b)+f.c-f.d/1)+pp*(f.c - (f.a*exp(-1/f.b)+f.c-f.d/1)));
% 
%         load(strcat('EMG_Stroke', SubjID, '.mat'))
%         f = fit([1:size(time_AvgValueDP_Strong(:,1))]',smooth(time_AvgValueDP_Strong(:,1),7),...
%             gaussEqn,'Start', startPoints, 'Lower',[-300,-300,-300,-300],'Upper',[300,300,300,300]);
%         metric2_Strong_EMG_Stroke(SubjectIDs,1) = solve(f.a*exp(-x/f.b)+f.c-f.d/x == (f.a*exp(-1/f.b)+f.c-f.d/1)+pp*(f.c - (f.a*exp(-1/f.b)+f.c-f.d/1)));
%         f = fit([1:size(time_AvgValueDP_Weak(:,1))]',smooth(time_AvgValueDP_Weak(:,1),7),...
%             gaussEqn,'Start', startPoints, 'Lower',[-300,-300,-300,-300],'Upper',[300,300,300,300]);
%         metric2_Weak_EMG_Stroke(SubjectIDs,1) = solve(f.a*exp(-x/f.b)+f.c-f.d/x == (f.a*exp(-1/f.b)+f.c-f.d/1)+pp*(f.c - (f.a*exp(-1/f.b)+f.c-f.d/1)));
%         
%         load(strcat('KIN_Healthy', SubjID, '.mat'))
%         f = fit([1:size(time_AvgValueDP_Strong(:,1))]',smooth(time_AvgValueDP_Strong(:,1),7),...
%             gaussEqn,'Start', startPoints, 'Lower',[-300,-300,-300,-300],'Upper',[300,300,300,300]);
%         metric2_Strong_KIN_Healthy(SubjectIDs,1) = solve(f.a*exp(-x/f.b)+f.c-f.d/x == (f.a*exp(-1/f.b)+f.c-f.d/1)+pp*(f.c - (f.a*exp(-1/f.b)+f.c-f.d/1)));
%         f = fit([1:size(time_AvgValueDP_Weak(:,1))]',smooth(time_AvgValueDP_Weak(:,1),7),...
%             gaussEqn,'Start', startPoints, 'Lower',[-300,-300,-300,-300],'Upper',[300,300,300,300]);
%         metric2_Weak_KIN_Healthy(SubjectIDs,1) = solve(f.a*exp(-x/f.b)+f.c-f.d/x == (f.a*exp(-1/f.b)+f.c-f.d/1)+pp*(f.c - (f.a*exp(-1/f.b)+f.c-f.d/1)));
%         
%         load(strcat('KIN_Stroke', SubjID, '.mat'))
%         f = fit([1:size(time_AvgValueDP_Strong(:,1))]',smooth(time_AvgValueDP_Strong(:,1),7),...
%             gaussEqn,'Start', startPoints, 'Lower',[-300,-300,-300,-300],'Upper',[300,300,300,300]);
%         metric2_Strong_KIN_Stroke(SubjectIDs,1) = solve(f.a*exp(-x/f.b)+f.c-f.d/x == (f.a*exp(-1/f.b)+f.c-f.d/1)+pp*(f.c - (f.a*exp(-1/f.b)+f.c-f.d/1)));
%         f = fit([1:size(time_AvgValueDP_Weak(:,1))]',smooth(time_AvgValueDP_Weak(:,1),7),...
%             gaussEqn,'Start', startPoints, 'Lower',[-100,-100,-100,-100],'Upper',[100,100,100,100]);
%         metric2_Weak_KIN_Stroke(SubjectIDs,1) = solve(f.a*exp(-x/f.b)+f.c-f.d/x == (f.a*exp(-1/f.b)+f.c-f.d/1)+pp*(f.c - (f.a*exp(-1/f.b)+f.c-f.d/1)));
%         
    end
%     
% 
%     figure()
%     boxplot(double([metric1_Strong_EMG_Healthy, metric1_Weak_EMG_Healthy, metric1_Strong_EMG_Stroke, metric1_Weak_EMG_Stroke, ...
%         metric1_Strong_KIN_Healthy, metric1_Weak_KIN_Healthy, metric1_Strong_KIN_Stroke, metric1_Weak_KIN_Stroke]))
%     mean(double([metric1_Strong_EMG_Healthy, metric1_Weak_EMG_Healthy, metric1_Strong_EMG_Stroke, metric1_Weak_EMG_Stroke, ...
%         metric1_Strong_KIN_Healthy, metric1_Weak_KIN_Healthy, metric1_Strong_KIN_Stroke, metric1_Weak_KIN_Stroke]))
%     figure()
%     boxplot(double([metric2_Strong_EMG_Healthy, metric2_Weak_EMG_Healthy, metric2_Strong_EMG_Stroke, metric2_Weak_EMG_Stroke, ...
%         metric2_Strong_KIN_Healthy, metric2_Weak_KIN_Healthy, metric2_Strong_KIN_Stroke, metric2_Weak_KIN_Stroke]))
%     mean(double([metric2_Strong_EMG_Healthy, metric2_Weak_EMG_Healthy, metric2_Strong_EMG_Stroke, metric2_Weak_EMG_Stroke, ...
%         metric2_Strong_KIN_Healthy, metric2_Weak_KIN_Healthy, metric2_Strong_KIN_Stroke, metric2_Weak_KIN_Stroke]))
%     
%     AllinOneMetric2 = double([metric2_Strong_EMG_Healthy, metric2_Weak_EMG_Healthy, metric2_Strong_EMG_Stroke, metric2_Weak_EMG_Stroke, ...
%         metric2_Strong_KIN_Healthy, metric2_Weak_KIN_Healthy, metric2_Strong_KIN_Stroke, metric2_Weak_KIN_Stroke]);
%     
%     xlswrite('AllinOneMetric2.xls', AllinOneMetric2);
%     
%     metric2_Strong_EMG_Healthy = double(metric2_Strong_EMG_Healthy);
%     metric2_Weak_EMG_Healthy = double(metric2_Weak_EMG_Healthy);
%     metric2_Strong_EMG_Stroke = double(metric2_Strong_EMG_Stroke);
%     metric2_Weak_EMG_Stroke = double(metric2_Weak_EMG_Stroke);
%     metric2_Strong_KIN_Healthy = double(metric2_Strong_KIN_Healthy);
%     metric2_Weak_KIN_Healthy = double(metric2_Weak_KIN_Healthy);
%     metric2_Strong_KIN_Stroke = double(metric2_Strong_KIN_Stroke);
%     metric2_Weak_KIN_Stroke = double(metric2_Weak_KIN_Stroke);
%     save('AllinOneMetric2.mat', 'metric2_Strong_EMG_Healthy', 'metric2_Weak_EMG_Healthy', 'metric2_Strong_EMG_Stroke', 'metric2_Weak_EMG_Stroke', ...
%         'metric2_Strong_KIN_Healthy', 'metric2_Weak_KIN_Healthy', 'metric2_Strong_KIN_Stroke', 'metric2_Weak_KIN_Stroke')
%     
    

    