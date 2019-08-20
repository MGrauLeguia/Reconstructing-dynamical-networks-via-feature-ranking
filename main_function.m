function main_function(work_index)
  % Compute maps for different coupling strengths, nodes and rng seeds
  %%%%%seed%%%%
    llav = 1:10;
  %%%%%%%%% coupling strength  
    forzaconexio = 0.1:0.1:0.9;
   %%%%%%%%%%%%%%%%%%%%Nodes%%%%%%%% 
    nodes=[12 25 50 100];
   points=12800;
    vect = combvec (llav, forzaconexio,nodes);
    
    mapscluster(points,vect(2,(work_index)),vect(3,(work_index)),rho,vect(1,(work_index)))	

end
