%%%%%%%%%%%%%%%%%%%%% Part Two: Task 1 %%%%%%%%%%%%%%
%% Μελέτη σήματος θορύβου στις μεσαίες συχνότητες. %%

% Δημιουργία λευκού θορύβου
N=200; white_noise=randn(1,N);

% Δημιουργία Band-Pass FIR φίλτρου που διατηρεί τις μεσαίες συχνότητες
%   και εξασθενίζει τις άλλες.
middle_fs_filter = fir1(20, [0.4 0.6]);

% Δημιουργία θορύβου στις μεσαίες συχνότητες με χρήση του
%   παραπάνω FIR φίλτρου.
filtered_noise = filter(middle_fs_filter, 1, white_noise);

figure(1), clf;
subplot(1, 2, 1), plot(white_noise), title('White noise'), xlabel('time'), 
  ylim([-3 3]);
subplot(1, 2, 2), plot(filtered_noise), title('Filtered noise'), xlabel('time'),
  ylim([-3 3]); 

% Σήμα λευκού θορύβου σε όλες τις συχνότητες
figure(2), clf;
white_noise_f_magnitude = abs(fft(white_noise));
subplot(2, 2, 1), hist(white_noise,100), title('White noise histogram'), 
  xlim([-4 4]);
subplot(2, 2, 2), stem(white_noise_f_magnitude(1:(N/2))), 
  title('White noise spectrum'), ylabel('magnitude'), xlabel('frequency');

% Σήμα θορύβου στις μεσαίες συχνότητες
filtered_noise_f_magnitude = abs(fft(filtered_noise));
subplot(2, 2, 3), hist(filtered_noise,100), title('Filtered noise histogram'), 
  xlim([-4 4]);
subplot(2, 2, 4), stem(filtered_noise_f_magnitude(1:(N/2))), 
  title('Filtered noise spectrum'), ylabel('magnitude'), xlabel('frequency');
  
% Φάσεις σημάτων
figure(3), clf;
white_noise_f_phase = angle(fft(white_noise));
filtered_noise_f_phase = angle(fft(filtered_noise));
subplot(2, 1, 1), stem(white_noise_f_phase(1:(N/2))),title('White noise phase'),
  xlabel('frequency');
subplot(2, 1, 2), stem(filtered_noise_f_phase(1:(N/2))),
  title('Filtered noise phase'), xlabel('frequency');


%%%%%% Part Two: Task 2 %%%%%%
%% Μελέτη δοθέντος φίλτρου. %%

% Το δοθέν FIR φίλτρο b
b = [-0.0415 0.1642 0.8156 0.1642 -0.0415];

    % Ερώτημα α: Περιγραφή του τύπου του φίλρου
figure(1), clf;
freqz(b);

    % Ερώτημα β: Υπολογισμός της κρουστικής απόκρισης του φίλτρου.
figure(2), clf;
delta = [1 0 0 0 0 0 0 0 0];
h = filter(b, 1, delta)
stem(h), title('Impulse response');

    % Ερώτημα γ: Φιλτράρισμα του σήματος.
load brainwaves.mat;
segment = x_left(1: 1000);

% Σήματα στον άξονα του χρόνου
figure(3), clf;
subplot(2, 1, 1), plot(segment), title('Original signal'), xlabel('time');
subplot(2, 1, 2), plot(filter(b ,1, segment)), title('Filtered signal'), 
  xlabel('time');

figure(4), clf;
% Συχνοτικό περιεχόμενο του αρχικού σήματος
pre_filter_f_magnitude = abs(fft(segment));
subplot(2, 2, 1), plot(pre_filter_f_magnitude(1:500)), 
  title('Original signal spectrum'), xlabel('normalized frequency'), 
  ylabel('magnitude');
subplot(2, 2, 2), plot(pre_filter_f_magnitude(200:500)), 
  title('Original signal spectrum, high frequencies'), 
  xlabel('normalized frequency'), ylabel('magnitude');

% Συχνοτικό περιεχόμενο του τελικού σήματος  
post_filter_f_magnitude = abs(fft(filter(b ,1, segment)));
subplot(2, 2, 3), plot(post_filter_f_magnitude(1:500)), 
  title('Filtered signal spectrum'), xlabel('normalized frequency'), 
  ylabel('magnitude');
subplot(2, 2, 4), plot(post_filter_f_magnitude(200:500)), 
  title('Filtered signal spectrum, high frequencies'), 
  xlabel('normalized frequency'), ylabel('magnitude');
  

%%%%%%%%%% Part Two: Task 3 %%%%%%%%%%%%%%
%% Μελέτη φίλτρου κινούμενου ελαχίστου. %%

    % Ερώτημα α: Φιλτράρισμα με εύρος παραθύρου = 5.
t = 1:500;
signal = sin(t) + 5*cos(3*t) + 2*cos(15*t+4) + 7*cos(25*t+4) + 3*randn(1, 500);

figure(1), clf;
subplot(2, 1, 1), plot(signal), title('Original signal'), xlabel('time');
subplot(2, 1, 2), plot(minfilter(signal, 5)), title('Filtered signal, w=5'), 
  xlabel('time');
  
    % Ερώτημα β: Φιλτράρισμα με εύρος παραθύρου = 15.
figure(2), clf;
subplot(2, 3, 1), plot(signal), title('Original signal'), xlabel('time');
subplot(2, 3, 2), plot(minfilter(signal, 5)), title('Filtered signal, w=5'), 
  xlabel('time');
subplot(2, 3, 4), plot(abs(fft(signal))(1:250)), 
  title('Original signal spectrum'), xlabel('frequency'), ylabel('magnitude');
subplot(2, 3, 5), plot(abs(fft(minfilter(signal, 5)))(1:250)), 
  title('Filtered signal spectrum, w=5'), xlabel('frequency'), 
  ylabel('magnitude');
subplot(2, 3, 3), plot(minfilter(signal, 15)), title('Filtered signal, w=15'), 
  xlabel('time');
subplot(2, 3, 6), plot(abs(fft(minfilter(signal, 15)))(1:250)), 
  title('Filtered signal spectrum, w=15'), xlabel('frequency'), 
  ylabel('magnitude');
  
    % Ερώτημα γ: απόδειξη (αντιπαράδειγμα) ότι το σύστημα δεν είναι ΓΧΑ (γραμμικό-χρονοαμετάβλητο).
t = 1:500;
x = sin(5*t);
y = cos(t + 1);

figure(3), clf;    
r1 = minfilter(x + y, 5); subplot(2,1,1), plot(r1), ylim([-2.5 0.5]), 
  title('Filtered (x+y)'); 

r2 = minfilter(x, 5) + minfilter(y, 5); subplot(2,1,2), plot(r2), 
  ylim([-2.5 0.5]), title('Filtered x + Filtered y'); 
    
    
    
    
