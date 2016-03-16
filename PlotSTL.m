% Function created by umhau, September-October 2014
% Updated by umhau March 2016
%
% Input the location of a NON-BINARY STL file, and this script will:
%  - read the file,
%  - convert it to a single 'obj' matrix,
%  - rotate and transform the matrix according to predefined perameters
%
% INPUTS:
% filename    = name of STL file, within same directory
% plot_graph  = Boolean, 'true' plots graph of STL file after import
% trans       = matrix of transformations to perform on matrix, one for
%               each axis: [X, Y, Z]
% rotation    = matrix of rotations to perform on matrix, one for each
%               axis: [X, Y, Z]
%
% OUTPUTS:
% obj         = matrix representing STL information, able to be rotated and
%               oriented according to standard matrix manipulation
%               procedures.

function obj = PlotSTL(filename, plot_graph, trans, rotation)

% open stl file
fid = fopen(filename);
fgetl(fid);  
data = fscanf(fid,'  facet normal %e %e %e\n    outer loop\n    vertex %e %e %e  vertex %e %e %e  vertex %e %e %e\n  endloop\n  endfacet\n');
fclose(fid);

% define transformations
transX = trans(1);
transY = trans(2);
transZ = trans(3);

% define angles of rotation
THx = rotation(1);
THy = rotation(2);
THz = rotation(3);

% cull the x,y & z coordinates from data matrix + apply transformations
i = data(1:3:length(data)) + transX;
j = data(2:3:length(data)) + transY;
k = data(3:3:length(data)) + transZ;

% define rotation matrices
Rx = [cosd(THx) sind(THx) 0; -sind(THx) cosd(THx) 0; 0 0 1];
Ry = [cosd(THy),0,sind(THy);0,1,0;-sind(THy),0,cosd(THy)];
Rz = [cosd(THz),-sind(THz),0;sind(THz),cosd(THz),0;0,0,1];

% combine i,j,k into one object matrix & rotate
obj = [i,j,k]*Rx*Ry*Rz;


if plot_graph == true
    clf %clears the current figure
    hold on % make sure all the panels stay put 
    
    % define the RGB value of the color used
    C = [0.5, 0.5, 0.5];

    % define axes
    xlabel('X')
    ylabel('Y')
    zlabel('Z')
    axis equal

    % one count for every panel in in the object.  There are 4 items: note
    % the first is overlooked in how the m-counter is used.
    for m = 1:4:length(obj)
        fig1 = fill3(obj((1+m:3+m),1),obj((1+m:3+m),2),obj((1+m:3+m),3),C);
    end

    % allows future panels to replace current ones
    hold off
end

fprintf('File read successfully.\n\n');