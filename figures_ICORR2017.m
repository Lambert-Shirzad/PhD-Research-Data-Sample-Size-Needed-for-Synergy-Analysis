function figures_ICORR2017
    gaussEqn = 'a*exp(-x/b)+c-d/x';
    startPoints = [2 2 2 2];
    syms x            
%% Figure 1 equation fitting            


%     load(strcat('EMG_Stroke08.mat'))
%     dataset = smooth(time_AvgValueDP_Strong(:,1),7);
%     dataset(3:5) = [0.9195 0.9289 0.9412];
%     dataset = dataset*0.95;
%     f3 = fit([1:size(time_AvgValueDP_Strong(:,1))]', dataset, ... 
%         gaussEqn,'Start', startPoints, 'Lower',[-300,-300,-300,-300],'Upper',[300,300,300,300]);%smooth(time_AvgValueDP_Strong(:,1),7),
%     figure(1)
%     plot(f3,[1:size(time_AvgValueDP_Strong(:,1))]',dataset)%smooth(time_AvgValueDP_Strong(:,1),7)

        
%% Figure 2
for SubjectIDs = 1:10
        if SubjectIDs < 10
            SubjID = strcat('0', num2str(SubjectIDs));
        else
            SubjID = num2str(SubjectIDs);
        end
        SubjID

        figure(2)
        load(strcat('EMG_Healthy', SubjID, '.mat'))
        f1 = fit([1:size(time_AvgValueDP_Strong(:,1))]',smooth(time_AvgValueDP_Strong(:,1),7),...
            gaussEqn,'Start', startPoints, 'Lower',[-300,-300,-300,-300],'Upper',[300,300,300,300]);
        for k=1:90
            data(k) = f1.a*exp(-k/f1.b)+f1.c-f1.d/k;
        end
        subplot(2,4,1)
        plot(data)
        axis([0,100,0.86,1.01])
        hold on
        %plot(f1,[1:size(time_AvgValueDP_Strong(:,1))]',smooth(time_AvgValueDP_Strong(:,1),7))
        f2 = fit([1:size(time_AvgValueDP_Weak(:,1))]',smooth(time_AvgValueDP_Weak(:,1),7),...
            gaussEqn,'Start', startPoints, 'Lower',[-300,-300,-300,-300],'Upper',[300,300,300,300]);
        for k=1:90
            data(k) = f2.a*exp(-k/f2.b)+f2.c-f2.d/k;
        end
        subplot(2,4,2)
        plot(data)
        axis([0,100,0.86,1.01])
        hold on
        %plot(f2, [1:size(time_AvgValueDP_Weak(:,1))]',smooth(time_AvgValueDP_Weak(:,1),7))
        
        load(strcat('EMG_Stroke', SubjID, '.mat'))
        f3 = fit([1:size(time_AvgValueDP_Strong(:,1))]',smooth(time_AvgValueDP_Strong(:,1),7),...
            gaussEqn,'Start', startPoints, 'Lower',[-300,-300,-300,-300],'Upper',[300,300,300,300]);
        
        for k=1:90
            data(k) = f3.a*exp(-k/f3.b)+f3.c-f3.d/k;
        end
        subplot(2,4,3)
        plot(data)
        axis([0,100,0.86,1.01])
        hold on
        %plot(f3,[1:size(time_AvgValueDP_Strong(:,1))]',smooth(time_AvgValueDP_Strong(:,1),7))
        f4 = fit([1:size(time_AvgValueDP_Weak(:,1))]',smooth(time_AvgValueDP_Weak(:,1),7),...
            gaussEqn,'Start', startPoints, 'Lower',[-300,-300,-300,-300],'Upper',[300,300,300,300]);
        for k=1:90
            data(k) = f4.a*exp(-k/f4.b)+f4.c-f4.d/k;
        end
        subplot(2,4,4)
        plot(data)
        axis([0,100,0.86,1.01])
        hold on
        %plot(f4, [1:size(time_AvgValueDP_Weak(:,1))]',smooth(time_AvgValueDP_Weak(:,1),7))

        
        load(strcat('KIN_Healthy', SubjID, '.mat'))
        f5 = fit([1:size(time_AvgValueDP_Strong(:,1))]',smooth(time_AvgValueDP_Strong(:,1),7),...
            gaussEqn,'Start', startPoints, 'Lower',[-300,-300,-300,-300],'Upper',[300,300,300,300]);
        for k=1:90
            data(k) = f5.a*exp(-k/f5.b)+f5.c-f5.d/k;
        end
        subplot(2,4,5)
        plot(data)
        axis([0,100,0.86,1.01])
        hold on
        %plot(f5,[1:size(time_AvgValueDP_Strong(:,1))]',smooth(time_AvgValueDP_Strong(:,1),7))
        f6 = fit([1:size(time_AvgValueDP_Weak(:,1))]',smooth(time_AvgValueDP_Weak(:,1),7),...
            gaussEqn,'Start', startPoints, 'Lower',[-300,-300,-300,-300],'Upper',[300,300,300,300]);
        for k=1:90
            data(k) = f6.a*exp(-k/f6.b)+f6.c-f6.d/k;
        end
        subplot(2,4,6)
        plot(data)
        axis([0,100,0.86,1.01])
        hold on
        %plot(f6, [1:size(time_AvgValueDP_Weak(:,1))]',smooth(time_AvgValueDP_Weak(:,1),7))
        
        load(strcat('KIN_Stroke', SubjID, '.mat'))
        f7 = fit([1:size(time_AvgValueDP_Strong(:,1))]',smooth(time_AvgValueDP_Strong(:,1),7),...
            gaussEqn,'Start', startPoints, 'Lower',[-300,-300,-300,-300],'Upper',[300,300,300,300]);
        for k=1:90
            data(k) = f7.a*exp(-k/f7.b)+f7.c-f7.d/k;
        end
        subplot(2,4,7)
        plot(data)
        axis([0,100,0.86,1.01])
        hold on
        %plot(f7,[1:size(time_AvgValueDP_Strong(:,1))]',smooth(time_AvgValueDP_Strong(:,1),7))
        f8 = fit([1:size(time_AvgValueDP_Weak(:,1))]',smooth(time_AvgValueDP_Weak(:,1),7),...
            gaussEqn,'Start', startPoints, 'Lower',[-100,-100,-100,-100],'Upper',[100,100,100,100]);
        for k=1:90
            data(k) = f8.a*exp(-k/f8.b)+f8.c-f8.d/k;
        end
        subplot(2,4,8)
        plot(data)
        axis([0,100,0.86,1.01])
        hold on
        %plot(f8, [1:size(time_AvgValueDP_Weak(:,1))]',smooth(time_AvgValueDP_Weak(:,1),7))
end