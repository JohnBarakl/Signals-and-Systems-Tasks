%%%%%%%%%%%%%%%%%%%%% Part One: Task 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Εξέταση αντιμεταθετικής ιδιότητας για συσχέτιση και συνέλιξη. %%

signal1 = [zeros(1, 10) ones(1, 10) zeros(1, 10)];
signal2 = [zeros(1, 10) 1:5 5*ones(1, 15) ];

figure(1);
subplot(2, 1, 1); stem(signal1); ylim([0 1.5]); title('signal1');
subplot(2, 1, 2); stem(signal2); ylim([0 10]); title('signal2');

% Συνέλιξη

conv1 = conv(signal1, signal2);
conv2 = conv(signal2, signal1);

figure(2);
subplot(2, 1, 1); stem(conv1); ylim([0 60]); title('signal1 * signal2');
subplot(2, 1, 2); stem(conv2); ylim([0 60]); title('signal2 * signal1');

    % Ελέγχω αν τα αποτελέσματα των δύο πράξεων συνέλιξης είναι ίσα.
    % Αν η διαφορά τους επιστρέψει μηδενικό διάνυσμα, τότε είναι ίσα και
    %   επιβεβαιώνεται η αντιμεταθετική ιδιότητα της συνέλιξης για αυτά τα
    %   δύο σήματα.
conv1 - conv2

% Συσχέτιση

corr1 = xcorr(signal1, signal2);
corr2 = xcorr(signal2, signal1);

figure(3);
subplot(2, 1, 1); stem(corr1); ylim([0 60]); 
title('xcorr(signal1, signal2)');

subplot(2, 1, 2); stem(corr2); ylim([0 60]); 
title('xcorr(signal2, signal1)');

    % Ελέγχω αν τα αποτελέσματα των δύο πράξεων συσχέτισης είναι ίσα.
    % Αν η διαφορά τους επιστρέψει μηδενικό διάνυσμα, τότε είναι ίσα και
    %   επιβεβαιώνεται η αντιμεταθετική ιδιότητα της συσχέτισης για αυτά τα
    %   δύο σήματα.
corr1 - corr2

clear;
%%%%%%%%%%%%%%%%%%%%% Part One: Task 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Μελέτη δράσης συστήματος κινούμενου μέσου σε σχέση με το εύρος παραθύρου. %%

% Αρχικός ορθογώνιος παλμός
rect_pulse = [zeros(1, 20) ones(1, 30) zeros(1, 20)];

% Ορθογώνιος παλμός με πρόσθετο θόρυβο (του οποίο οι τιμές δεν ξεπερνουν το
% +-0.5)
noisy_pulse = rect_pulse + rem(randn(1, 70), 0.5);

figure(1);
subplot(2, 1, 1); stem(rect_pulse); ylim([-1 2]); title('rect\_pulse');
subplot(2, 1, 2); stem(noisy_pulse); ylim([-1 2]); title('noisy\_pulse');

figure(2);
% Αρχικό σήμα
subplot(5, 1, 1); stem(rect_pulse); ylim([-1 2]); 
title('Original signal: rect\_pulse');

% Εύρος παραθύρου = 3
mv_avg_w3 = moving_average(noisy_pulse, 3);
subplot(5, 1, 2); stem(mv_avg_w3); ylim([-1 2]); 
title('Result of moving average with window width 3: mv\_avg\_w3');

% Εύρος παραθύρου = 5
mv_avg_w5 = moving_average(noisy_pulse, 5);
subplot(5, 1, 3); stem(mv_avg_w5); ylim([-1 2]); 
title('Result of moving average with window width 5: mv\_avg\_w5');

% Εύρος παραθύρου = 9
mv_avg_w9 = moving_average(noisy_pulse, 9);
subplot(5, 1, 4); stem(mv_avg_w9); ylim([-1 2]); 
title('Result of moving average with window width 9: mv\_avg\_w9');

% Εύρος παραθύρου = 15
mv_avg_w15 = moving_average(noisy_pulse, 15);
subplot(5, 1, 5); stem(mv_avg_w15); ylim([-1 2]); 
title('Result of moving average with window width 15: mv\_avg\_w15');



clear;
%%%%%%%%%%%%%%%%%%%%% Part One: Task 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Εφαρμογή μεταβολής ρυθμού δειγματοληψίας και μετ’ έπειτα υπολογισμός του καρδιακού ρυθμού. %%

load ECG_data

sample_x_axis = 1:100000;

time = sample_x_axis *(1/Fs);

% Αρχικό σήμα

figure(1); plot(time, signal); xlabel('sec'); title('Original signal'); 
ylim([-1 2]);
[tt,ignore] = ginput(2);
heart_rate_original = 1 / (tt(2) - tt(1))

% Μείωση ρυθμού δειγματοληψίας
figure(2);

    % Αρχικό σήμα
subplot(4, 1, 1); plot(time, signal); xlabel('sec'); 
title('Original signal'); ylim([-1 2]);

    % Μείωση ρυθμού δειγματοληψίας κατά 2
downsampled_2 = downsample(signal, 2);
time_downsampled = sample_x_axis(1:50000) * (2/Fs);
subplot(4, 1, 2); plot(time_downsampled, downsampled_2); xlabel('sec'); 
title('Downsampled by 2'); ylim([-1 2]);
[ttd,ignore] = ginput(2);
heart_rate_downsampled_2 = 1 / (ttd(2) - ttd(1))

    % Μείωση ρυθμού δειγματοληψίας κατά 4
downsampled_4 = downsample(signal, 4);
time_downsampled = sample_x_axis(1:25000) * (4/Fs);
subplot(4, 1, 3); plot(time_downsampled, downsampled_4); xlabel('sec'); 
title('Downsampled by 4'); ylim([-1 2]);
[ttd,ignore] = ginput(2);
heart_rate_downsampled_4 = 1 / (ttd(2) - ttd(1))

    % Μείωση ρυθμού δειγματοληψίας κατά 50
downsampled_50 = downsample(signal, 50);
time_downsampled = sample_x_axis(1:2000) * (50/Fs);
subplot(4, 1, 4); plot(time_downsampled, downsampled_50); xlabel('sec'); 
title('Downsampled by 50'); ylim([-1 2]);
[ttd,ignore] = ginput(2);
heart_rate_downsampled_50 = 1 / (ttd(2) - ttd(1))

% Αύξηση ρυθμού δειγματοληψίας
figure(3);

    % Αρχικό σήμα
subplot(4, 1, 1); plot(time, signal); xlabel('sec'); 
title('Original signal');  ylim([-1 2]);

    % Αύξηση ρυθμού δειγματοληψίας κατά 2
upsampled_2 = upsample(signal, 2);
time_upsampled = [1:200000] *(1/(2*Fs));
subplot(4, 1, 2); plot(time_upsampled, upsampled_2); xlabel('sec'); 
title('Upsampled by 2'); ylim([-1 2]);
[ttu,ignore] = ginput(2);
heart_rate_upsampled_2 = 1 / (ttu(2) - ttu(1))

    % Αύξηση ρυθμού δειγματοληψίας κατά 4
upsampled_4 = upsample(signal, 4);
time_upsampled = [1:400000] *(1/(4*Fs));
subplot(4, 1, 3); plot(time_upsampled, upsampled_4); xlabel('sec'); 
title('Upsampled by 4'); ylim([-1 2]);
[ttu,ignore] = ginput(2);
heart_rate_upsampled_4 = 1 / (ttu(2) - ttu(1))

    % Αύξηση ρυθμού δειγματοληψίας κατά 50
upsampled_50 = upsample(signal, 50);
time_upsampled = [1:5000000] *(1/(50*Fs));
subplot(4, 1, 4); plot(time_upsampled, upsampled_50); xlabel('sec'); 
title('Upsampled by 50'); ylim([-1 2]);
[ttu,ignore] = ginput(2);
heart_rate_upsampled_50 = 1 / (ttu(2) - ttu(1))


 %%%%%%%%

 
% Αλλαγή ρυθμού δειγματοληψίας κατά κλάσμα
figure(4);

    % Αρχικό σήμα
subplot(5, 1, 1); plot(time, signal); xlabel('sec'); title('Original signal');  ylim([-1 2]);

    % Αλλαγή ρυθμού δειγματοληψίας κατά 2/3
resampled_2_3 = resample(signal, 2, 3);
time_resampled = [1:66667] * (3/(2*Fs));
subplot(5, 1, 2); plot(time_resampled, resampled_2_3); xlabel('sec'); title('Resampled by 2/3'); ylim([-1 2]);
[ttu,ignore] = ginput(2);
heart_rate_resampled_2_3 = 1 / (ttu(2) - ttu(1))

    % Αλλαγή ρυθμού δειγματοληψίας κατά 6/4
resampled_6_4 = resample(signal, 6, 4);
time_resampled = [1:150000] *(4/(6*Fs));
subplot(5, 1, 3); plot(time_resampled, resampled_6_4); xlabel('sec'); title('Resampled by 6/4'); ylim([-1 2]);
[ttu,ignore] = ginput(2);
heart_rate_resampled_6_4 = 1 / (ttu(2) - ttu(1))

    % Αλλαγή ρυθμού δειγματοληψίας κατά 500/9
resampled_500_9 = resample(signal, 500, 9);
time_resampled = [1:5555556] *(9/(500*Fs));
subplot(5, 1, 4); plot(time_resampled, resampled_500_9); xlabel('sec'); title('Resampled by 500/9'); ylim([-1 2]);
[ttu,ignore] = ginput(2);
heart_rate_resampled_500_9 = 1 / (ttu(2) - ttu(1))

    % Αλλαγή ρυθμού δειγματοληψίας κατά 9/500
resampled_9_500 = resample(signal, 9, 500);
time_resampled = [1:1800] *(500/(9*Fs));
subplot(5, 1, 5); plot(time_resampled, resampled_9_500); xlabel('sec'); title('Resampled by 9/500'); ylim([-1 2]);
[ttu,ignore] = ginput(2);
heart_rate_resampled_9_500 = 1 / (ttu(2) - ttu(1))
