clear;clc;

load('C:\Users\wang1\Downloads\FCM.mat')
for j = 1:length(FCM.Matrix)
    aaa = FCM.Matrix{j};
    for i = 1:500
    [M(:,i),Q(i,1)] = community_louvain(aaa,1,[],'negative_asym');
    end
    M_time_window{j} = M;
    Q_time_window{j} = Q;
    clear M Q aaa
end

save(['M_time_window.mat'],...
    'M_time_window');
save(['Q_time_window.mat'],...
    'Q_time_window');