clc;clear
filename = 'exam1.inp';
[node, element, elementType] = readinp(filename)
% plot x-coordinate as the patch value
plotMesh(node, element, elementType, node(:,2)) 
colormap(jet); colorbar