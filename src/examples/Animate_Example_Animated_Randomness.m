clear all;
close all;
clc;

addpath("../animation_functions/");

N = 300;
Ts = 0.01;

t = 0 : Ts : (N-1) * Ts;

x = randn(1, length(t));
y = randn(1, length(t));

figure;
h = plot(x(1),y(1), 'ro');
xlabel('x');
ylabel('y');
title('Animated randomness');
grid;
xlim([min(x), max(x)]);
ylim([min(y), max(y)]);

options.save_path = "Animated_Randomness";
Animate(@(ii)anim_fun(ii,h,x,y), N, Ts, options);

function anim_fun(ii, h, x, y)
    h.XData = [h.XData x(ii)];
    h.YData = [h.YData y(ii)];
end