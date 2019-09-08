# net reconstruction via feature ranking

library(randomForest) # for feature ranking with Random Forest
library(CORElearn) # for feature ranking with RReliefF
library(pROC) # for calculating the area under ROC curve


# read single trajectory from a CSV file fname, where:
#   - each column corresponds to a network node
#   - rows correspond to consequtive time points

read_trajectory = function(fname) {
  return(read.csv(fname, header = FALSE, sep = ","))
}


# read the network adjacency matrix from a CSV file fname

read_adjacency_matrix = function(fname) {
  return(as.matrix(read.csv(fname, header=F)))
}


# from trajectories ts to a data set for performing regression and calculating feature ranking

ts2ds = function(ts) {
  
  tslen = nrow(ts)
  nnodes = ncol(ts)
  ds = cbind(ts[1:(tslen - 1), ], ts[2:tslen, ])
  colnames(ds) = c(paste0("x", 1:nnodes), paste0("y", 1:nnodes))
  return(ds)
}

# the core procedure
# takes the observed trajectories ts in the network nodes as input
# calculates feature ranking for each node and collects the scores in Fmatrix
# returns Fmatrix, which corresponds to matrix F from formula (6) in the article
#
# argument method selects a method for calculating the feature ranking "rf" or "relief"
# argument rseed set the seed value for the pseudo random generator

nrfr = function(ts, method = "rf", rseed = 42) {
  
  set.seed(rseed)
  nnodes = ncol(ts)
  ds = ts2ds(ts)
  xs = paste0("x", 1:nnodes)
  Fmatrix = matrix(0, nrow = nnodes, ncol = nnodes)
  
  if (method == "rf") {
    for (node in 1:nnodes) {
      print(sprintf("Calculating RF ranking for node %d", node))
      f = reformulate(xs, paste0("y", node))
      rfmodel = randomForest(f, data = ds, ntree = 1000, mtry = floor(sqrt(nnodes)), importance = TRUE)
      Fmatrix[node,] = rfmodel$importance[, 1]
    }
  }
  if (method == "relief") {
    for (node in 1:nnodes) {
      print(sprintf("Calculating RRELIEFF ranking for node %d", node))
      f = reformulate(xs, paste0("y", node))
      Fmatrix[node,] = attrEval(f, data = ds, estimator = "RReliefFequalK", kNearestEqual = 10)
    }
  }
  return(Fmatrix)
}


# example of use

# read in the trajectories (in rows) for the network nodes (in columns)
ts = read_trajectory("ts1str025N25.csv")

# read in the adjecency matrix for the "true" network 
A = read_adjacency_matrix("A1str025N25.csv")

# reconstruct the network from the trajectories using the Randorm Forest method
Frf = nrfr(ts, method = "rf")
# compare the reconstructed with the "true" network using the area under the ROC curve (see the "Measuring reconstruction quality" subsection of the Section 2 of the article)
auc = roc(as.factor(A), as.vector(Frf), levels = c(0, 1), direction = "<")$auc
print(auc)

# reconstruct the network from the trajectories using the RELIEF method
Frelief = nrfr(ts, method = "relief")
# compare the reconstructed with the "true" network using the area under the ROC curve
auc = roc(as.factor(A), as.vector(Frelief), levels = c(0, 1), direction = "<")$auc
print(auc)