%%
file = readtable("EOG_S1.txt");
%%
iSample = 10000;
nSample = 5000;
eog = file.EOG(iSample:iSample + nSample);
eog_hp = detrend(eog);
gaze = file.GAZE_INTERPOLATED(iSample:iSample + nSample);
time = file.TIME(iSample:iSample + nSample);

%%
eog_fft = fft(eog);
eog_hp_fft = fft(eog_hp);
hold on
plot(linspace(0,83.34, length(time)), 20*log10(abs(eog_fft)))
plot(linspace(0,83.34, length(time)), 20*log10(abs(eog_hp_fft)))
hold off
title("FFT")
ylabel("PSD(dB)")
xlabel("frequency(Hz)")
%xlim([0,50])
legend("raw", "highpassed")
%%
close all
subplot(3,1,1)
plot(time, eog)
title("Raw eog signal")
ylabel("eog signal(mV)")
xlabel("time(s)")
subplot(3,1,2)
plot(time, eog_hp)
title("Eog signal with removed drift")
ylabel("eog signal(mV)")
xlabel("time(s)")
subplot(3,1,3)
plot(time, gaze)
title("Horizontal gaze angle")
ylabel("gaze angle(deg)")
xlabel("time(s)")
%% Extract signal
sig_1 = file.EOG(file.TIME > 10 & file.TIME < 20);
time_1 = file.TIME(file.TIME > 10 & file.TIME < 20);
gaze_1 = file.GAZE_INTERPOLATED(file.TIME > 10 & file.TIME < 20);

sig_2 = file.EOG(file.TIME > 120 & file.TIME < 130);
time_2 = file.TIME(file.TIME > 120 & file.TIME < 130);
gaze_2 = file.GAZE_INTERPOLATED(file.TIME > 120 & file.TIME < 130);

sig_1 = [sig_1(1:end); sig_1(end:-1:1)];
time_1 = [time_1(1:end); time_1(1:end) + time_1(end)-time_1(1)];
gaze_1 = [gaze_1(1:end); gaze_1(end:-1:1)];

sig_2 = [sig_2(1:end); sig_2(end:-1:1)];
time_2 = [time_2(1:end); time_2(1:end) + time_2(end)-time_2(1)];
gaze_2 = [gaze_2(1:end); gaze_2(end:-1:1)];


writematrix(sig_1, "./testSignal/sig_1.csv")
writematrix(time_1, "./testSignal/time_1.csv")
writematrix(gaze_1, "./testSignal/gaze_1.csv")

writematrix(sig_2, "./testSignal/sig_2.csv")
writematrix(time_2, "./testSignal/time_2.csv")
writematrix(time_2, "./testSignal/gaze_2.csv")

%%
subplot(2,1,1)
plot(time_1, sig_1)
xlabel("time(s)")
ylabel("eog signal(mV)")
subplot(2,1,2)
plot(time_1, gaze_1)
ylabel("gaze angle(deg)")
xlabel("time(s)")
max(sig_1)
min(sig_1)
off1 = 0.5*(max(sig_1) + min(sig_1)) %28.83mV
amp1 = max(sig_1) - off1 %0.068mV

%%
subplot(2,1,1)
plot(time_2, sig_2)
xlabel("time(s)")
ylabel("eog signal(mV)")
subplot(2,1,2)
plot(time_2, gaze_2)
ylabel("gaze angle(deg)")
xlabel("time(s)")
max(sig_2)
min(sig_2)

off2 = 0.5*(max(sig_2) + min(sig_2))%26.35mV
amp2 = max(sig_2) - off2 %0.21mV
%% Validation-sig1
close all
figure()

T_pause = 1/83.34;
nT = length(gaze_1);
pause()
% count down
for iT = 1:10
    scatter(ones(1, iT), 1:iT)
    ylim([0,11])
    yline(10)
    pause(1)
end

tic
iT = 1;
t = time_1(1);
while t ~= time_1(end)
    plot(time_1(1:iT), gaze_1(1:iT),'w');
    set(gca,'Color','k')
    yline(0);
    ([time_1(iT) - 5, time_1(iT) + 5])
    xlim([time_1(iT) - 5, time_1(iT) + 5])
    ylim([-40, 40])
    
    t_ = time_1(time_1 < toc +  time_1(1));
    t = t_(end);
    iT = find(time_1 == t);
    pause(T_pause)
end

%% Validation-sig2
close all
figure()
T_pause = 1/83.34;
nT = length(gaze_2);
pause()
% count down
for iT = 1:10
    scatter(ones(1, iT), 1:iT)
    ylim([0,11])
    yline(10)
    pause(1)
end
tic
iT = 1;
t = time_2(1);
while t ~= time_2(end)
    plot(time_2(1:iT), gaze_2(1:iT),'w');
    set(gca,'Color','k')

    yline(0);
    xlim([time_2(iT) - 5, time_2(iT) + 5])
    ylim([-40, 40])
    
    t_ = time_2(time_2 < toc +  time_2(1));
    t = t_(end);
    iT = find(time_2 == t);
    pause(T_pause)
end


