%%
file = readtable("EOG_S1.txt");
%%
nSample = 5000;
eog = file.EOG(1:nSample);
eog_hp = detrend(eog);
gaze = file.GAZE_INTERPOLATED(1:nSample);
time = file.TIME(1:nSample);
%%
close all
subplot(3,1,1)
plot(time, eog)
title("Raw eog signal")
xlabel("eog signal(mV)")
ylabel("time(s)")
subplot(3,1,2)
plot(time, eog_hp)
title("Eog signal with removed drift")
xlabel("eog signal(mV)")
ylabel("time(s)")
subplot(3,1,3)
plot(time, gaze)
title("Horizontal gaze angle")
xlabel("gaze angle(deg)")
ylabel("time(s)")