# NRFR - Network Reconstruction via Feature Ranking


## About

This is a method for reconstructing dynamical networks via feature ranking. It was published in the [Chaos journal](https://aip.scitation.org/journal/cha), the paper is available at [https://aip.scitation.org/doi/10.1063/1.5092170](https://aip.scitation.org/doi/10.1063/1.5092170). Please cite as: Marc Grau Leguia, Zoran Levnajić, Ljupčo Todorovski, Bernard Ženko. Reconstructing dynamical networks via feature ranking, _Chaos_ 29, 093107 (2019), DOI: 10.1063/1.5092170.


## Contents

The repository includes the Matlab code of the method and the data used in the paper (or scripts for generating them). We also provide an R implementation that should give idential results as the original Matlab implementation.


## Method parameters
The method reconstructs a network using in principle any feature ranking approach, the code implements two (Random Forest and RReliefF) for which the following parameters need to be set:

#Random Forest:

	-Nº Tree's =1000;
	-N features =sqrt(Nº nodes);
#RreliefF:

	-NearNeigh=10;


## Usage - R version

We implemented the R code with R version 3.5.1. The code requires three standard CRAN packages of CORElearn, pROC, and randomForest. Please check the source code and the accompanying CSV files for an example of use. The example aims at reconstructing a network of 25 nodes (its adjacency matrix is in the file A1str025N25.csv) from trajectories observed at 3200 time points (file ts1str025N25.csv). The result of the reconstruction (matrix F of the link propensities; see formula (6) in the article) is compared with the given adjacency matrix using the area under the ROC curve (check the last subsection "Measuring reconstruction quality" of the second section of the article).

```r
# example of use

# read in the trajectories (in rows) for the network nodes (in columns)
ts = read_trajectory("ts1str025N25.csv")

# read in the adjecency matrix for the "true" network 
A = read_adjacency_matrix("A1str025N25.csv")

# reconstruct the network from the trajectories using the Randorm Forest method
Frf = nrfr(ts, method = "rf")
# compare the reconstructed with the "true" network using the area under the ROC curve
# (see the "Measuring reconstruction quality" subsection of the Section 2 of the article)
auc = roc(as.factor(A), as.vector(Frf), levels = c(0, 1), direction = "<")$auc
print(auc)

# reconstruct the network from the trajectories using the RELIEF method
Frelief = nrfr(ts, method = "relief")
# compare the reconstructed with the "true" network using the area under the ROC curve
auc = roc(as.factor(A), as.vector(Frelief), levels = c(0, 1), direction = "<")$auc
print(auc)
```





## Usage - data generation

The function Coupled_maps_generator.m can be used to simulate a network of coupled maps as in the paper. To call the function you need the following imputs:

 - points = max data points of the generated coupled maps
 - epsi = coupling strength between maps (epsilon in the paper)
 - nodes = number of nodes in the network
 - rho = link density of the random network
 - llav2 = seed for replication
 - map = type of map for the calculation (map=1 logistic map, map=2 Ikeda map)
 - Place where you want to save your data



## Disclaimer and contact

Before publishing the original source code we have cleaned and simplified it. We are confident that, also with these simplifications and changes, the source code contains no bugs. However, if you encounter problems or bugs, please contact mgrauleg@gmail.com.


## License

[MIT](LICENSE)
