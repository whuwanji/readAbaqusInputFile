function plotMesh(nodes, elements, elementType, patchval)
% plot mesh via element data
% only support one element type 
%% Code Information
% author      :  Ji Wan
% affiliation :  Wuhan University
% date        :  2022 / 02 / 24
% e-mail      :  wanji at whu.edu.cn
%% input arguments:
% nodes: the first column is the id of node, 2~3 or 2~4 columns are x, y, and z coordinates
% elements: the first column is the id of elements, other columns are the node ids that constitute the element
% elementType: element type, e.g., 'C3D8', 'CPS3'
% patchVal: usually the field variables attached to the nodes (optional)
%% output arguments:
% not given
%% Requirement:
%% Matlab 2016b or later
%% Examples(see also in demo)
% filename = 'exam1.inp';
% [node, element, eType] = readinp(filename);
% plotMesh(nodes, elements, elementType, node(:,2)); % x coordinate
nodes = nodes(:, 2:end);
figure
hold on
e = elements;
e = e(:,2:end);
et = elementType;
switch lower(et)
    case {'cps4', 'cps4r', 'cps4i', 'cps3r', 'cps3i', 'cps3'...
            'cpe4', 'cpe4r', 'cpe4i', 'cpe3r', 'cpe3i', 'cpe3'}
        %patch('Faces',e,'Vertices',x,'FaceColor',rand(1,3))
    case {'cps8', 'cps8r', 'cps8i','cps8m', 'cpe8', 'cpe8r', 'cpe8i','cpe8m'}
        e = e(:,[1,5,2,6,3,7,4,8]);
        %patch('Faces',e(:,[1,5,2,6,3,7,4,8]),'Vertices',x,'FaceColor',rand(1,3))
    case {'cps6r', 'cps6i', 'cps6', 'cps6m', 'cpe6r', 'cpe6i', 'cpe6', 'cpe6m'}
        e = e(:,[1,4,2,5,3,6]);
        %patch('Faces',e(:,[1,4,2,5,3,6]),'Vertices',x,'FaceColor',rand(1,3))
    case {'c3d4', 'c3d4r', 'c3d4h', 'c3d4t','c3d10', 'c3d10h', 'c3d10r', 'c3d10rh', 'dc3d10', 'dc3d10e', 'c3d10p',....
            'c3d10rph', 'c3d10pt', 'ac3d10r', 'c3d10i', 'c3d10m', 'c3d10hs', 'c3d10is', 'c3d10hi'}
        e = e(:, [1,3,2, 1,2,4, 2,3,4, 3,1,4]);
        e = reshape(e', 3, numel(e)/3)';
        %patch('Faces',e,'Vertices',x,'FaceColor',rand(1,3))
    case {'c3d8', 'c3d8h', 'c3d8r', 'c3d8rh', 'dc3d8', 'dc3d8e', 'c3d8p', 'c3d8rph', 'c3d8pt', 'ac3d8r',...
            'c3d20', 'c3d20h', 'c3d20r', 'c3d20rh', 'dc3d20', 'dc3d20e', 'c3d20p',....
            'c3d20rph', 'c3d20pt', 'ac3d20r', 'c3d20i', 'c3d20m'}
        e = e(:, [1,4,3,2, 5,6,7,8, 1,2,6,5, 2,3,7,6, 3,4,8,7, 4,1,5,8]);
        e = reshape(e', 4, numel(e)/4)';

    case {'c3d6', 'f3d6', 'c3d6h'}
        p1 = [1,3,2, 4,5,6];
        p2 = [1,4,6,3,...
            1,2,5,4,...
            2,3,6,5];
        e1 = e(:,p1);
        e2 = e(:,p2);
        e1 = reshape(e1', 3, numel(e1)/3)';
        e2 = reshape(e2', 4, numel(e2)/4)';
        e = [e1, nan(size(e1,1),1); e2];
        %patch('Faces',e,'Vertices',x,'FaceColor',rand(1,3))
    case {'c3d15', 'f3d15', 'c3d15h'}
        p1 = [1,9,3,8,2,7, 4,10,5,11,6,12];
        p2 = [1,13,4,12,6,15,3,9,...
            1,7,2,14,5,10,4,13,...
            2,8,3,15,6,11,5,14];
        e1 = e(:,p1);
        e2 = e(:,p2);
        e1 = reshape(e1', 6, numel(e1)/6)';
        e2 = reshape(e2', 8, numel(e2)/8)';
        e = [e1, nan(size(e1,1),2); e2];
        %patch('Faces',e,'Vertices',x,'FaceColor',rand(1,3))
    otherwise
        warning('%s element type is not support in this program, which can not be shown in the figure!', et)
end
if( nargin==3 )
    patch('Faces',e,'Vertices',nodes,'FaceColor',rand(1,3))
elseif(nargin==4)
    patch('Faces',e,'Vertices',nodes,'FaceVertexCData', patchval, 'facecolor', 'interp')
end
if(size(nodes,2)==3)
    view(3);
end
axis equal
end