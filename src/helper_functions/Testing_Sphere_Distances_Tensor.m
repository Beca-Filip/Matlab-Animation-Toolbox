%TESTING_SPHERE_DISTANCES lol

close all;
addpath ../animation_functions/

q = zeros(6, 1);
L = ones(6, 1);
CMP = [0.5*ones(1,6); zeros(2,6)];

spheres.centers = CMP;
spheres.radii = 0.5 * ones(1, 6);
spheres.parent_segment = 1 : 6;

figure;
animopt.show_legend = true;
Animate_nDOF_Spheres(q, L, spheres, Ts, animopt);
ylim([-3, 3])

%%

CTR = Points_FKM_nDOF_Tensor(q, L, spheres.centers, spheres.parent_segment);
D = Spheres_nDOF_Distances(CTR, spheres)

%%

q = zeros(6, 1);
q(4) = -pi/2;   % Change this
L = ones(6, 1);
CMP = [0.5*ones(1,6); zeros(2,6)];

spheres.centers = CMP;
spheres.radii = 0.5 * ones(1, 6);
spheres.parent_segment = 1 : 6;

figure;
animopt.show_legend = true;
Animate_nDOF_Spheres(q, L, spheres, Ts, animopt);
xlim([-1, 4])

%%

CTR = Points_FKM_nDOF_Tensor(q, L, spheres.centers, spheres.parent_segment);
D = Spheres_nDOF_Distances(CTR, spheres)