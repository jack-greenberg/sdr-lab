load("saved-data.mat");
close all;

%% Part c

figure;
title("Fourier transform of y_I");
plot_FT(y_I, fs);

%% Part d

figure;

subplot(2, 1, 1);
axis([-100 3000000 -150 150]);
xlabel("Time");
title("Signal y_I");
hold on;
plot(y_I);
hold off;

subplot(2, 1, 2);
xlabel("Time");
title("y_I zoomed in");
axis([1.25e6 1.2505e6 -150 150]);
hold on;
plot(y_I);
hold off;

%% Part e

ddt_y_I = zeros(3e6,1);

for i=1:length(y_I)-1
    ddt_y_I(i) = y_I(i+1) - y_I(i);
    if (ddt_y_I(i) < 0)
        ddt_y_I(i) = 0;
    end
end

ddt_y_I = ddt_y_I ./ max(ddt_y_I);

figure;
xlabel("Time");
title("Derivative of y_I zoomed in");
axis([1.5e6 1.55e6 -0.1 1.1]);
hold on;
plot(ddt_y_I);
hold off;

%% Part f

ddt_y_I_filt = lowpass(ddt_y_I, 100000, fs);
ddt_y_I_filt = ddt_y_I_filt ./ max(ddt_y_I_filt);

figure;
axis([1.5e6 1.55e6 -0.1 1.1]);
xlabel("Time");
title("Signal filtered");
hold on;
plot(ddt_y_I, "DisplayName", "Derivative of original signal");
plot(ddt_y_I_filt, "DisplayName", "Low-pass filtered");
legend;
hold off;

%% Part g

ddt_y_I_filt_shifted = ddt_y_I_filt - mean(ddt_y_I_filt);
ddt_y_I_filt_shifted = ddt_y_I_filt_shifted * 0.1 ./ max(ddt_y_I_filt_shifted);

ddt_y_I_filt_shifted_decimated = decimate(ddt_y_I_filt_shifted, 4);

sound(ddt_y_I_filt_shifted_decimated, 300000/4);