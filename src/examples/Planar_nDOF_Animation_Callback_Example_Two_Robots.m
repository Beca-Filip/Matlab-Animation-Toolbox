clear all;
close all;
clc;

addpath("../animation_functions/");
addpath("../helper_functions/");

N = 1000;
Ts = 0.01;

t = 0 : Ts : (N-1) * Ts;

N_joints = 3;
q1 = repmat(linspace(0, pi/2, N), N_joints, 1);
q2 = repmat(linspace(0, pi/2-pi/6, N), N_joints, 1) ;
L = ones(N_joints, 1);

T1 = FKM_nDOF_Tensor(q1, L);
T2 = FKM_nDOF_Tensor(q2, L);

X1 = squeeze(T1(1, 4, :, :));
Y1 = squeeze(T1(2, 4, :, :));

X2 = squeeze(T2(1, 4, :, :));
Y2 = squeeze(T2(2, 4, :, :));

figure;
hold all;
h_seg1 = plot(X1(:, 1), Y1(:, 1), 'k', 'LineWidth', 2);
h_jnt1 = plot(X1(:, 1), Y1(:, 1), 'ko', 'MarkerSize', 10, 'LineWidth', 1);

h_seg2 = plot(X2(:, 1), Y2(:, 1), 'r', 'LineWidth', 1.5);
h_jnt2 = plot(X2(:, 1), Y2(:, 1), 'ro', 'MarkerSize', 10, 'LineWidth', 0.8);
xlabel('x');
ylabel('y');
title('Animated Planar nDOF : Two Robots');
grid;

% Here's the difference
axis equal
lb = min([min([X1(:); X2(:)], [], 'all'), min([Y1(:); Y2(:)], [], 'all')]);
ub = max([max([X1(:); X2(:)], [], 'all'), max([Y1(:); Y2(:)], [], 'all')]);
lim = [lb, ub];
xlim(lim);
ylim(lim);

options.save_path = "../../videos/Animated_Planar_nDOF_Two_Robots";
Animate(@(ii)anim_fun(ii,h_seg1,h_jnt1,h_seg2,h_jnt2,X1,Y1,X2,Y2), N, Ts, options);

function anim_fun(ii,h_seg1,h_jnt1,h_seg2,h_jnt2,X1,Y1,X2,Y2)
    Planar_nDOF_Callback(ii, h_seg1, X1, Y1);
    Planar_nDOF_Callback(ii, h_jnt1, X1, Y1);
    
    Planar_nDOF_Callback(ii, h_seg2, X2, Y2);
    Planar_nDOF_Callback(ii, h_jnt2, X2, Y2);
end