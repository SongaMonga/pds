%% R1.a)
killing_me_softly = audioread('fugee.wav');
soundsc(killing_me_softly);

%% R1.b)
t = 1:length(killing_me_softly);
plot(t, killing_me_softly);

%% R1.c)
w = -pi:2*pi/length(killing_me_softly):pi;
w = w(:, 1:end-1);
semilogy(w, fftshift(abs(fft(killing_me_softly))));

%% R2.a)
[b, a] = butter(10, 0.5);
[h, w] = freqz(b, a);
plot(w, abs(h));

%% R2.b)
killing_me_softly_butter = filter(b, a, killing_me_softly);

%% R2.c)
plot(t, killing_me_softly, 'b');
hold on;
plot(t, killing_me_softly_butter, 'r');

%% R2.d)
w = -pi:2*pi/length(killing_me_softly):pi;
w = w(:, 1:end-1);
semilogy(w, fftshift(abs(fft(killing_me_softly))), 'b');
hold on
semilogy(w, fftshift(abs(fft(killing_me_softly_butter))), 'r');

%% R2.e)
soundsc(killing_me_softly_butter); %Butterworth only takes out the high frequency noises
                                   %along with the high pitch notes (treble
                                   %sounds), so the signal sounds muffled
                                   %and not that better than the unfiltered
                                   %one since it is still possible to hear
                                   %the random noise, i.e., the vinyl noise
                                   

