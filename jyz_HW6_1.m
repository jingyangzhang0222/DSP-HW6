clear
close all

load ecg_lfn.dat
x = ecg_lfn;
fs = 1000;
b = [1 -1];
r1 = -0.1; r2 = -0.5; r3 = -0.9;
a1 = [1 r1]; a2 = [1 r2]; a3 = [1 r3];
[H1,w1] = freqz(b,a1);[H2,w2] = freqz(b,a2);[H3,w3] = freqz(b,a3);
y1 = filter(b,a1,x);y2 = filter(b,a2,x);y3 = filter(b,a3,x);

figure(1)
subplot(2,2,1)
plot(w1/pi,abs(H1))
xlabel('omega (*pi)')
title('Filter Magnitude When r = 0.1')
subplot(2,2,2)
zplane(b,a1,'k')
xlim([-1.1,1.1]);ylim([-1.1,1.1]);
title('Pole-Zero Diagram When r = 0.1')
subplot(2,2,[3,4])
plot((0:length(x)-1),x,'g--',(0:length(y1)-1),y1,'r')
xlim([0,length(x)-1])
legend('Original Signal', 'Filtered Signal')

figure(2)
subplot(2,2,1)
plot(w2/pi,abs(H2))
xlabel('omega (*pi)')
title('Filter Magnitude When r = 0.5')
subplot(2,2,2)
zplane(b,a2,'k')
xlim([-1.1,1.1]);ylim([-1.1,1.1]);
title('Pole-Zero Diagram When r = 0.5')
subplot(2,2,[3,4])
plot((0:length(x)-1),x,'g--',(0:length(y2)-1),y2,'r')
xlim([0,length(x)-1])
legend('Original Signal', 'Filtered Signal')

figure(3)
subplot(2,2,1)
plot(w3/pi,abs(H3))
xlabel('omega (*pi)')
title('Filter Magnitude When r = 0.9')
subplot(2,2,2)
zplane(b,a3,'k')
xlim([-1.1,1.1]);ylim([-1.1,1.1]);
title('Pole-Zero Diagram When r = 0.9')
subplot(2,2,[3,4])
plot((0:length(x)-1),x,'g--',(0:length(y3)-1),y3,'r')
xlim([0,length(x)-1])
legend('Original Signal', 'Filtered Signal')