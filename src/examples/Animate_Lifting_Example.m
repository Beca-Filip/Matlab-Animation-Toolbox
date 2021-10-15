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
q(1, :) = linspace(pi/4, 3*pi/4, N);
q(2, :) = linspace(pi/2, -pi/2, N);
q(3, :) = linspace(pi/4, -pi/4, N);

L = ones(N_joints, 1);

options.show_grid = true;
options.show_legend = true;
options.title = "A robot moving a box";
options.xlabel = "This is the X axis";
options.ylabel = "This is Y";
options.legend_entry = "3DOF";
options.body_thickness = 2;
options.joint_size = 10;
options.box_legend = 'little\_box';
options.box_offset_X = 0.2;
options.box_rotation_flag = true;
options.box_lifting_index = 250;
Animate_Lifting(q, L, Ts, options);