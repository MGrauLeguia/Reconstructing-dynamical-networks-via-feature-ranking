# rdn-fr
Codes from Leguia et al, Chaos 29, 093107 (2019).

Source codes:
 
In order to understand the source codes in, you should first read the following document. If you encounter problems or bugs, please contact mgrauleg@gmail.com


Function Coupled_maps_generator:

It simulates a network of coupled maps as in Leguia et al, Chaos 29, 093107 (2019).
To call the function you need the following imputs:
(points,epsi,nodes,rho,llav2,map)

%%% points= max data points of the generated coupled maps

%%% epsi = coupling strength between maps (\epsilon in the paper)

%%% nodes = number of nodes in the network

%%% rho = link density of the random network

%%% llav2 = seed for replication

%%% map = type of map for the calculation map==1 logitic map, map==2 ikeda map

%%% Place where you want to save your data%%%%
