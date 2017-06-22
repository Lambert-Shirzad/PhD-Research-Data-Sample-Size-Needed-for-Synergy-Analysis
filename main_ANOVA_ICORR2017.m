% Written by Navid Lambert-Shirzad 20170116


function main_ANOVA_ICORR2017

% preparing the data for a two-way ANOVA
% will do the two-way ANOVA for 2 different datasets (EMG, KIN) 
% factor 1: strong vs weak hand
% factor 2: stroke vs healthy
% dependent variable: nCommonSynergies (metric 2)

load('AllinOneMetric2.mat')
metric2_Strong_EMG_Healthy(1) = 40;
mean([metric2_Strong_EMG_Healthy, metric2_Weak_EMG_Healthy, metric2_Strong_EMG_Stroke, metric2_Weak_EMG_Stroke, ...
    metric2_Strong_KIN_Healthy, metric2_Weak_KIN_Healthy, metric2_Strong_KIN_Stroke, metric2_Weak_KIN_Stroke])


 for i = 1:10
     EMG_ANOVA_data(2*i-1:2*i,:) = [metric2_Strong_EMG_Healthy(i), metric2_Weak_EMG_Healthy(i); metric2_Strong_EMG_Stroke(i), metric2_Weak_EMG_Stroke(i)];
     %columns are factor 1
     %rows are factor2
 end
 for i = 1:10
     KIN_ANOVA_data(2*i-1:2*i,:) = [metric2_Strong_KIN_Healthy(i), metric2_Weak_KIN_Healthy(i); metric2_Strong_KIN_Stroke(i), metric2_Weak_KIN_Stroke(i)];
     %columns are factor 1
     %rows are factor2
 end
 [pEMG,tblEMG,statsEMG] = anova2(EMG_ANOVA_data,10,'on');
 [pKIN,tblKIN,statsKIN] = anova2(KIN_ANOVA_data,10,'on');
 
 pKIN
 