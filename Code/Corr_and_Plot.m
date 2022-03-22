
% Correlation analysis and plot for nonlinear results and drowsiness

%% Nonlinear metrics values and drowsiness level, without MTC
% sbj-order: [1:16, 18:20, 23:25]
sbj_drow = [1:16, 18:20, 23:25];  % total 22 subjects

% NL Values were from cluster statistics and grand average data:
% (all: MW - BF, i.e., mind wandering - breath focus)
NLdiff_drow(:,1) = HFDdiff(sbj_drow,1);
NLdiff_drow(:,2) = LZCdiff(sbj_drow,1);
NLdiff_drow(:,3) = SENdiff(sbj_drow,1);
drowlevel_drow = drowlevel(sbj_drow,1);

%% Nonlinear metrics values and drowsiness level, for Trial-balanced (MTC)
% sbj-order: [2,3,4,6,7,9,10,12:16, 18:20, 25];
TB_sbj_drow = [1:12, 14:16, 19]; % total 16 subjects
TB_NLdiff_drow(:,1) = TB_HFDdiff(TB_sbj_drow,1);
TB_NLdiff_drow(:,2) = TB_LZCdiff(TB_sbj_drow,1);
TB_NLdiff_drow(:,3) = TB_SENdiff(TB_sbj_drow,1);
TB_drowlevel_drow = TB_drowlevel(TB_sbj_drow,1);

%% fit and scatter plot //  note: here use 'Type'--'Kendall'
% (Here the code is for MTC, same method for without MTC)

X = TB_drowlevel_drow; % Note: remove the "TB_" for non-MTC
Ylist={ 'TB_ HFDdiff','TB_ LZCdiff', 'TB_ SENdiff'};

figure,
set(gcf,'outerposition',get(0,'screensize')); % to use the big screen
for k=1:3
    
    Ystr=Ylist{k};
    Y = TB_NLdiff_drow(:,k);  % Note: remove the "TB_" for non-MTC
    
    % corr:
    [coef, pval] = corr(X, Y,'Type','Kendall'); % corr is only for column
    p = polyfit(X, Y, 1); % fitted coefficient p
    yFit = polyval(p, X); % estimate fitted Y with X and p.
    
    % plot
    subplot(2,3,k);
    scatter(X, Y, 25,'k','filled');
    hold on
    curve=plot(X,yFit,'k','linewidth',2);
    
    xlabel('TB_ Drowsiness level');  % Note: remove the "TB_" for non-MTC
    ylabel(Ystr);
    xlim([1-0.1*(7-1)  7+0.1*(7-1)]);
    ylim([min(Y)-0.1*(max(Y)-min(Y))  max(Y)+0.1*(max(Y)-min(Y))]);
    title(['Kendall coef tau = ',num2str(coef), ', p = ',num2str(pval)]); hold off
    
end