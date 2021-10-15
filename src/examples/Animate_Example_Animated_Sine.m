%ANIMATE_EXAMPLE_ANIMATED_SINE animates a sine function appearing.
clear all;
close all;
clc;

addpath("../animation_functions/");

N = 1000;
Ts = 0.01;

t = 0 : Ts : (N-1) * Ts;

x = t;
y = sin(t);

figure;
h = plot(x(1),y(1));    % Initialize plot handle
xlabel('x');
ylabel('y');
title('Animated sine');
grid;
xlim([min(x), max(x)]);
ylim([min(y), max(y)]);

options.save_path = "Animated_Sine";
Animate(@(ii)anim_fun(ii,h,x,y), N, Ts, options);

function anim_fun(ii, h, x, y)
    h.XData = [h.XData x(ii)];
    h.YData = [h.YData y(ii)];
end