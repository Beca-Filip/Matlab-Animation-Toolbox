clear all;
close all;
clc;

addpath("../animation_functions/");
addpath("../helper_functions/");

N = 1000;
Ts = 0.01;

t = 0 : Ts : (N-1) * Ts;

N_joints = 3;
q = repmat(linspace(0, pi/2, N), N_joints, 1);
L = ones(N_joints, 1);

T = FKM_nDOF_Tensor(q, L);

X = squeeze(T(1, 4, :, :));
Y = squeeze(T(2, 4, :, :));

figure;
hold all;
h_seg = plot(X(:, 1), Y(:, 1), 'k', 'LineWidth', 2);
h_jnt = plot(X(:, 1), Y(:, 1), 'ko', 'MarkerSize', 10, 'LineWidth', 1);
xlabel('x');
ylabel('y');
title('Animated Planar nDOF');
grid;

% Here's the difference
xlim([min(X, [], 'all'), max(X, [], 'all')]);
ylim([min(Y, [], 'all'), max(Y, [], 'all')]);
axis equal

options.save_path = "../../videos/Animated_Planar_nDOF_Moving_Square_Frame";
Animate(@(ii)anim_fun(ii,h_seg,h_jnt,X,Y), N, Ts, options);

function anim_fun(ii,h_seg,h_jnt,X,Y)
    Planar_nDOF_Callback(ii, h_seg, X, Y);
    Planar_nDOF_Callback(ii, h_jnt, X, Y);
end