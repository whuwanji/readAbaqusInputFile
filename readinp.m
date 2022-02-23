function [node, element, eType] = readinp(filename)
% read abaqus inp file to get nodes, elements and element type of a mesh
% only support one element type 
%% Code Information
% author      :  Ji Wan
% affiliation :  Wuhan University
% date        :  2022 / 02 / 13
% e-mail      :  wanji at whu.edu.cn
%% input arguments:
% filename: the full path with your inp file name, 
% e.g., filename = 'C:/test/exam1.inp'
%% output arguments:
% node : nodes of the model
% element : elements of the model
% eType : the element type
%% Requirement:
%% Matlab 2016b or later (due to the use of 'split' function)
%% Examples(see also in demo)
% filename = 'exam1.inp';
% [node, element, eType] = readinp(filename);
s   = fileread(filename);
s   = lower(s);
q   = split(s, '*');
% read nodes
np  = arrayfun(@(i)strncmp(q{i},'node',4), 1:numel(q), 'uniform', 1);
ns  = q{np};
nsp = strfind(ns, newline);
ns  = ns(nsp(1)+1:nsp(end)-1);
node = str2num(ns);
% read elements
ep  = arrayfun(@(i)strncmp(q{i},'element',7), 1:numel(q), 'uniform', 1);
es  = q{ep};
esp = strfind(es, newline);
et  = es(1:esp(1)-1);
% get element type
n1    = strfind(et,'type=');
eType = et(n1(1)+5:end-1);
% elements
es  = es(esp(1)+1:esp(end)-1);
es  = strrep(es, char([44,13,10]), char(44));
element = str2num(es);
end