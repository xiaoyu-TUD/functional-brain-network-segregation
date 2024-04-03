clear;clc;

load('C:\Users\wang1\Downloads\M_time_window.mat')
for i = 1:length(M_time_window)
    D = agreement(M_time_window{i});
    cell_D{i} = D./500;
    clear D 
    for j = 1:length(cell_D)
    cell_consensus{j} = consensus_und(cell_D{j},0,1000);
    end  
end


load('C:\Users\wang1\Downloads\FCM.mat')
for j = 1:length(cell_consensus)
    WT(:,j) = module_degree_zscore(FCM.Matrix{j},cell_consensus{j},0);
    BT(:,j) = participation_coef_sign(FCM.Matrix{j},cell_consensus{j});
end

save(['WT.mat'],...
    'WT');
save(['BT.mat'],...
    'BT');
    

