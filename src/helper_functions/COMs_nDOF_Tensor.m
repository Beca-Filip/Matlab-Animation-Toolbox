function [COMs, varargout] = COMs_nDOF_Tensor(q,L,CMP,varargin)
%COMS_NDOF_TENSOR implements the forward kinematic equations of the center
%of mass for an n-DOF planar manipulator on a vectorized input of joint 
%angles. Returns the a tensor whose slices are matrices corresponding to
%the position vectors of different segments' centers of mass along the
%trajectory. 
%Assumes the proximal Denavit-Hartenberg assignement of coordinate systems.
%
%   COMs = COMS_NDOF_TENSOR(q,L,CMP) takes in the matrix of joint angles 
%   (Number of Joints x Number of samples) alongside the nD vector of 
%   segment lengths and a 3xn matrix of center of mass relative positions
%   and returns a tensor COMs of dimension (3 x Number of Samples x Number 
%   of Segments).
%
%   [COMs, COM] = COMS_NDOF_TENSOR(q,L,CMP,M) also takes in the matrix of
%   segment masses and produces the total center of mass within a 3 x
%   Number of Samples matrix.
    
% Exctract useful constants
n = size(q, 1); % Number of Segments
N = size(q, 2); % Number of Samples

% Prealocate output tensor of COM forward kinematics
COMs = zeros(3, N, n);  % Prealocate output

% Compute positions

% For the first joint
jj = 1;
sum_q = q(jj, :);
cq = cos(sum_q);
sq = sin(sum_q);

Xc = CMP(1, jj);    % X coordinate of the COM (along the segment)
Yc = CMP(2, jj);    % Y coordinate of the COM (perpendicular to the segment)

% Calculate the global X and Y coordinates of the 1st COM
COMs(1, :, jj) = Xc .* cq - Yc .* sq;
COMs(2, :, jj) = Xc .* sq + Yc .* cq;

% Calculate the global X and Y coordinates of the 1st distal segment
% end, otherwise known as the center of the 2nd joint
Gx = L(jj) .* cq;
Gy = L(jj) .* sq;

% For subsequent joints, you must also take into account the position
% of the segment referential frame
for jj = 2 : n
    % Sum the joint angles from 1 to jj       
    sum_q = sum(q(1:jj, :), 1);
    cq = cos(sum_q);
    sq = sin(sum_q);
    
    Xc = CMP(1, jj);    % X coordinate of the COM (along the segment)
    Yc = CMP(2, jj);    % Y coordinate of the COM (perpendicular to the segment)

    % Calculate the global X and Y coordinates of the jjth COM by
    % adding its position relative to the local segment frame to the
    % global position of the segment frame
    COMs(1, :, jj) = Gx + Xc .* cq - Yc .* sq;
    COMs(2, :, jj) = Gy + Xc .* sq + Yc .* cq;
    
    % Update the global position of the local segment frame to the
    % distal end of the jjth segment, otherwise known as the center of
    % the (jj+1)th joint
    Gx = Gx + L(jj) .* cq;
    Gy = Gy + L(jj) .* sq;
end

% If additionnal arguments are passed
if ~isempty(varargin)
    % Get the mass
    M = varargin{1};
end

% If additional arguments are demanded
if nargout > 1
    % Get the whole center of mass
    COM =sum(COMs .* reshape(M, [1, 1, length(M)]), 3);
    
    % Assign it
    varargout{1} = COM;
end

end

