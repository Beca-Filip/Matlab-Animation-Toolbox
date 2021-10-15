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

options.show_grid = false;
options.show_legend = true;
options.title = "A robot's joints angles linearly increasing";
options.xlabel = "This is the X axis";
options.ylabel = "This is Y";
% options.legend_entry = "3DOF";
% options.body_thickness = 2;
% options.joint_size = 10;
% options.body_color = [225 0 225] / 255;
Animate_Two_nDOF(q1, L, q2, L, Ts, options);