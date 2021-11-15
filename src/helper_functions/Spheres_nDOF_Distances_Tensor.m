function D = Spheres_nDOF_Distances_Tensor(CTR, spheres)
%SPHERES_NDOF_DISTANCES_TENSOR calculates the distances between collision 
%spheres in a planar nDOF kinematic chain across time, given the forward 
%kinematics of the sphere centers and the spheres structure containing 
%sphere parameters.
%
%   D = SPHERES_NDOF_DISTANCES_TENSOR(CTR, spheres) takes in the tensor of 
%   sphere centers' kinematics (3 x Number of samples x Number of spheres)
%   alongside a structure containing the spheres radii and parent segments.
%   Returns a tensor D whose slices are matrices containing distances
%   between spheres with corresponding indices.
%   A spheres structure contains fields:
%       - centers: (3 x Number of spheres) matrix of sphere centers' relative 
%       positions with respect to their parent segment.
%       - radii : (1 x Number of spheres) vector containin the radii of the
%       spheres.
%       - parent_segment: and a (1 x Number of spheres) vector containing 
%       indices of the parent segments of the spheres.

    
% Exctract useful constants
Ns = size(CTR, 3);  % Num. spheres
N = size(CTR, 2);   % Num. samples

% Prealocate output tensor of distances across time
D = zeros(Ns, Ns, N);  % Prealocate output

% For all spheres calculate distances to spheres that were not checked yet
for ss1 = 1 : Ns - 1
    % Get current sphere 1
    C1 = squeeze(CTR(:, :, ss1));
    
    % Spheres that have not yet been compared to current sphere 1
    for ss2 = ss1 + 1 : Ns
        % Get current sphere 2
        C2 = squeeze(CTR(:, :, ss2));
        
        % Calculate the distance as the distance between the centers minus
        % the sum of the radii
        D(ss1, ss2, :) = sqrt(sum((C1-C2).^2)) - (spheres.radii(ss1) + spheres.radii(ss2));        
    end
end
end

