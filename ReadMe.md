## How To Use This PSO function

1. You need **design your own fitness function** . The code here gives an example about knn fitness function. In this fitness function, I take the performance of KNN as fitness value. So the target of PSO function here is to find best feature weights in knn algorithm. In practice, you should design your own function according to your optimization target. 

   ​

2. After your fitness function is ready, you need to specify the parameters used in PSO searching process.

    X         ---- Training data(each row represents an instance/size: R×C)                                                                

    Y         ---- Label of training data(class or continuous value/size:R×1)                                                          

    maxiter   ---- The maximum of iteration  

    pmax      ---- The maximum of elements in particle(size: 1×C)

    vmax	 ---- The maximum of elements in velocity(size: 1×C)

    inertw     ---- Inertia weight

    c1            ---- cognitive parameter

    c2            ---- social parameter

  **Example:  gbest = PSO(X, Y, 'maxiter', 100, 'pmax', pmax,....);** 

   All of these parameters are optional except X and Y.  The default value of these parameters are:

   maxiter: 100 | pmax: 10\*ones(1,C) | vmax: 1\* ones(1, C) | inertw: 0.7968 | c1:  1.4962 | c2: 1.4962 (This set of parameters comes from [1])

   [1] Trelea I C. The particle swarm optimization algorithm: convergence analysis and parameter selection[M]. Elsevier North-Holland, Inc.  2003.

   ​

   ​
