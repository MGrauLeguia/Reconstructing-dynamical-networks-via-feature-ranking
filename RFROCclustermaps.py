#!/usr/bin/python
# -*- coding: latin-1 -*-
import os, sys
import scipy as sp
import numpy as np
import math
import matplotlib.pyplot as plt
from sklearn import metrics
from sklearn.ensemble import RandomForestRegressor
from sklearn.ensemble import ExtraTreesRegressor
from sklearn import tree
#from sklearn.feature_selection import SelectFromModel
#from sklearn.feature_selection import f_regression
from sklearn.metrics import mean_squared_error
from sklearn.datasets import make_friedman1
from sklearn.ensemble import GradientBoostingRegressor
from sklearn.metrics import mean_squared_error
from sklearn.datasets import make_friedman1
from sklearn.ensemble import GradientBoostingRegressor
from sklearn.metrics import confusion_matrix
from sklearn.metrics import roc_auc_score

def RFROCclustermaps(index):
	#path='/homedtic/mgrau/home_old/RandomForest/savesmaps/Paper'
	#path='/Users/mgrau/Desktop/RandomForest/saves/maps'
	os.chdir(path)
	Nran=1
	Ns=[12, 25, 50, 100]
	ll=np.arange(1,5,1,dtype=np.int)
	#ep=[0.01, 0.02, 0.05, 0.10, 0.25, 0.50]
	ep=[0.6, 0.7, 0.8]
	point=[50, 200, 800, 3200, 12800]
	rho=0.1
	llav2=1
	work=np.stack(np.meshgrid(ll,ep,point,Ns),-1).reshape(-1,4)
	llav=int(work[index-1,0])
	epsi=work[index-1,1]
	points=int(work[index-1,2])
	N=int(work[index-1,3])


	aload='A'+str(llav)+'den'+str(rho)+'N'+str(N)+'.txt'
	tload='time-series'+str(llav)+'str'+'{:.2f}'.format(epsi)+'den'+str(rho)+'N'+str(N)+'.txt'
	nomafea='Afea'+str(llav)+'str'+'{:.2f}'.format(epsi)+'den'+str(rho)+'N'+str(N)+'Lp'+str(points)+'.txt'
	flag=os.path.isfile(nomafea)






	if flag is False:
		tau=0.001
		Nran=1
		Adj = np.loadtxt(aload)

		a = np.loadtxt(tload)
		y = np.zeros((len(a)-1,N+1),dtype='f')
		x = np.zeros((len(a)-1,2*N+1),dtype='f')
		for j in range(N):
			for i in range(len(a)-1):
				 x[i,j+N]=a[i+1,j]
				 x[i,j]=a[i,j]
				 x[i,2*N]=i*tau



		x = x[:points]
	
		xfit = np.zeros((len(x),N))
		for j in range(N):
			for i in range(len(x)):
				xfit[i,j]=x[i,j]

		for reset in range(Nran):
			Afea= np.zeros((N,N))
			llistaf = np.zeros(N*N+1)
			llistAr = np.zeros(N*N)
			cont=0
			for u in range(N):
				y0p=x[:,N+u]
				y0p = np.array(y0p).astype(float)
				pea = np.zeros(N)


				steps = 0
				for t in range(1000,1040,50):
					estimator = RandomForestRegressor(n_estimators=t,max_features='sqrt')

	
					a = estimator.fit(xfit,y0p)
					fea = a.feature_importances_
					std = np.std([a.feature_importances_ for a in estimator.estimators_],axis=0)
					for k in range(N):
						Afea[k][u]=fea[k]
						llistAr[cont]=fea[k]
						cont=cont+1
					k=0

					steps=steps+1
					
			
			con=0

                
			np.savetxt(nomafea,Afea)
			



	return




if __name__ == '__main__':
    x = int(sys.argv[1])
    sys.stdout.write(str(RFROCclustermaps(x)))
