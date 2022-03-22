
%% all analysis (for 19chan together)  -- need the 'condition_index' and 'sbj'
load condition_index_and_confidence_levels.mat  %
%% for  Lempel-Ziv complexity (calculate each channel )

allsub_alltrial_eachChan_LZC = cell(1,25);

for sub=1:25
    Subject=(sbj(sub).name);  % to get the subject order from "sbj"
    loaddata = ['load ...path\' Subject '.mat']; %  load data from the corresponding folder
    eval(loaddata);
    
    tr = size(OUTEEG_clean.data,3); %  trial numbers
    LZCTemp = NaN(19,tr);% 19 channels
    
    for i=1:tr % i = trial index
        for ch=1:19 % each channel
            tempdata = OUTEEG_clean.data(ch,:,i); % 1:19 channels
            
            % For LZC:
            Sdata = (tempdata>median(tempdata));  % Sdata: the binary sequence   (Data Could be a raw vector)
            [LZCTemp(ch,i), ~, ~]= calc_lz_complexity(Sdata, 'exhaustive', 1);
            
        end
    end
    
    allsub_alltrial_eachChan_LZC{1,sub} = LZCTemp;
    
    clear OUTEEG_clean
    
end

save allsub_alltrial_eachChan_LZC  allsub_alltrial_eachChan_LZC

