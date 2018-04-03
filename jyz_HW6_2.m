clear
close all

del = @(n) (n == 0); % Function
nn = 0:20;
delta = del(nn);
[c, fsc] = audioread('clean.wav'); 
[n, fsn] = audioread('noisy.wav'); 
t = 0:1/fsn:(length(n)-1) / fsn;
f1a = 500-500/297; f1d = 2*pi*f1a/fsn;
f2a = 500+500/297; f2d = 2*pi*f2a/fsn;
fa = 500; fd = 2*pi*fa/fsn;
r = 0.95;
cf = fft(c(12954:13977));
nf = fft(n(12954:13977));
b = [1 -2*cos(fd) 1];
b = b/polyval(b, -1); % make peak gain = 1
a = [1 -2*r*cos(fd) r^2];
a = a/polyval(a, -1); % make peak gain = 1
[H, om] = freqz(b,a);
h = filter(b,a,delta);
y = filter(b, a, n);
yf = fft(y(12954:13977));
bFIR = conv([1 -2*cos(f1d) 1], [1 -2*cos(f2d) 1]);
bFIR = bFIR/polyval(bFIR, -1); % make peak gain = 1
aFIR = [1 0 0 0 0];
[HFIR, omFIR] = freqz(bFIR, aFIR);
yFIR = filter(bFIR, aFIR, n);
yFIRf = fft(yFIR(12954:13977));
hFIR = filter(bFIR,aFIR,delta);
bIIR = conv([1 -2*cos(f1d) 1], [1 -2*cos(f2d) 1]);
bIIR = bIIR/polyval(bIIR, -1); % make peak gain = 1
aIIR = conv([1 -2*r*cos(f1d) r^2], [1 -2*r*cos(f2d) r^2]);
aIIR = aIIR/polyval(aIIR, -1); % make peak gain = 1
[HIIR, omIIR] = freqz(bIIR, aIIR);
yIIR = filter(bIIR, aIIR, n);
yIIRf = fft(yIIR(12954:13977));
hIIR = filter(bIIR,aIIR,delta);

figure(1)
plot(om/(2*pi)*fsn, abs(H), omFIR/(2*pi)*fsn, abs(HFIR), omIIR/(2*pi)*fsn, abs(HIIR))
xlabel('Frequency(cycles/second = Hz)')
title('Frequency Response')
legend('2nd Order IIR Filter in Demo','4th Order FIR Filter','4th Order IIR Filter')

figure(2)
subplot(2,3,1)
zplane(b,a)
xlim([-1.1 1.1]);ylim([-1.1 1.1]);
title('2nd Order IIR Filter in Demo')
subplot(2,3,3)
zplane(bFIR,aFIR)
xlim([-1.1 1.1]);ylim([-1.1 1.1]);
title('4th Order FIR Filter')
subplot(2,3,5)
zplane(bIIR,aIIR)
xlim([-1.1 1.1]);ylim([-1.1 1.1]);
title('4th Order IIR Filter')
subplot(2,3,4)
zplane(bIIR,aIIR)
xlim([0.87 0.94]);ylim([0.35 0.39]);
title('4th Order IIR Filter-Zoom in 1')
subplot(2,3,6)
zplane(bIIR,aIIR)
xlim([0.87 0.94]);ylim([-0.39 -0.35]);
title('4th Order IIR Filter-Zoom in 2')

figure(3)
subplot(3,2,1)
plot(0:fsn/2/512:fsn/2-fsn/2/512, abs(cf(1:512)));
title('Spectrum of Clean Signal Segment')
xlabel('Frequency (Hz)')
subplot(3,2,2)
plot(0:fsn/2/512:fsn/2-fsn/2/512, abs(nf(1:512)));
title('Spectrum of Noisy Signal Segment')
xlabel('Frequency (Hz)')
subplot(3,2,3)
plot(0:fsn/2/512:fsn/2-fsn/2/512, abs(yf(1:512)));
title('Spectrum of Filtered Signal Segment by 2nd Order IIR Filter in Demo')
xlabel('Frequency (Hz)')
subplot(3,2,[5,6])
plot(0:fsn/2/512:fsn/2-fsn/2/512, abs(yFIRf(1:512)));
title('Spectrum of Filtered Signal Segment by 4th Order FIR Filter')
xlabel('Frequency (Hz)')
subplot(3,2,4)
plot(0:fsn/2/512:fsn/2-fsn/2/512, abs(yIIRf(1:512)));
title('Spectrum of Filtered Signal Segment by 4th Order IIR Filter')
xlabel('Frequency (Hz)')

figure(4)
subplot(3,1,1)
stem(0:20,h,'.')
xlim([-1 21])
xlabel('n')
title('Impulse Response of 2nd Order IIR Filter in Demo')
subplot(3,1,2)
stem(0:20,hFIR,'.')
xlim([-1 21])
xlabel('n')
title('Impulse Response of 4th Order FIR Filter')
subplot(3,1,3)
stem(0:20,hIIR,'.')
xlim([-1 21])
xlabel('n')
title('Impulse Response of 4th Order IIR Filter')
sound(y,fsn);pause;
sound(yFIR,fsn);pause;
sound(yIIR,fsn);pause;