# NRFR - Network Reconstruction via Feature Ranking


## About

This is a method for reconstructing dynamical networks via feature ranking. It was published in the [Chaos journal](https://aip.scitation.org/journal/cha), the paper is available at [https://aip.scitation.org/doi/10.1063/1.5092170](https://aip.scitation.org/doi/10.1063/1.5092170). Please cite as: Marc Grau Leguia, Zoran LevnajiÄ, LjupÄo Todorovski, Bernard Åœenko. Reconstructing dynamical networks via feature ranking, Chaos 29, 093107 (2019), DOI: 10.1063/1.5092170.


## Contents

The repository includes the Matlab code of the method and the data used in the paper (or scripts for generating them). We also provide an R implementation that should give idential results as the original Matlab implementation.



## Usage - data generation

The function Coupled_maps_generator.m can be used to simulate a network of coupled maps as in the paper. To call the function you need the following imputs:

 - points = max data points of the generated coupled maps
 - epsi = coupling strength between maps (epsilon in the paper)
 - nodes = number of nodes in the network
 - rho = link density of the random network
 - llav2 = seed for replication
 - map = type of map for the calculation (map=1 logistic map, map=2 Ikeda map)

Additionally the code allows to save the trajectories and the adjacency matrix if you provide a path and uncomment the save command at the end of the program.


## Disclaimer and contact

Before publishing the original source code we have cleaned and simplified it. We are confident that, also with these simplifications and changes, the source code contains no bugs. However, if you encounter problems or bugs, please contact mgrauleg@gmail.com.


## License

[MIT](LICENSE)
