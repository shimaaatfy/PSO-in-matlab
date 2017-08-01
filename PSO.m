function gbest = PSO(X, Y, varargin)
%% parameter description:
% X         ---- Training data(each row represents an instance/size: R¡ÁC)
% Y         ---- Label of training data(class or continuous value/size:R¡Á1)
% maxiter   ---- The maximum of iteration
% parnum    ---- The number of particles
% pmax      ---- The maximum of elements in particle(size: 1¡ÁC)
% vmax      ---- The maximum of elements in velocity(size: 1¡ÁC)
% inertw    ---- Inertia weight
% c1        ---- cognitive parameter
% c2        ---- social parameter
% return : gbest -the best solution we have got
%% handle of parameters
    if nargin < 2
        error(message('stats:PSO:TooFewInputs'));
    end
    if ~isreal(X)||~isreal(Y)
        error(message('stats:PSO:ComplexData'));
    end
    num_feature = size(X,2);
    pnames = {'maxiter', 'parnum', 'pmax', 'vmax', 'inertw', 'c1', 'c2'};
    dflts = {100,20,ones(1,num_feature)*10,ones(1,num_feature)*2,0.7968,1.4962,1.4962};
    [maxiter, parnum, pmax, vmax, inertw, c1, c2] = ...
        internal.stats.parseArgs(pnames, dflts, varargin{:});
    
%% Initialize velocity and position of particles
    swarm = rand(parnum, num_feature)*diag(pmax); %deposit the position of particles
    matfit = zeros(parnum,1); %deposit the fitness value of each particles
    vstep = rand(parnum,num_feature); % the velocity of each particles
    %initialize velocity and gbest|pbest
    for j = 1:parnum
        if(rand > 0.5)
            vstep(j,:) = vstep(j,:).*vmax;
        else
            vstep(j,:) = -vstep(j,:).*vmax;
        end
        matfit(j,1) = fitness(X,Y,swarm(j,:));
    end
    fpbest = matfit;
    pbest = swarm;
    [fgbest, temp] = min(matfit);
    gbest = swarm(temp,:);
%% Iteration
    for i = 1:maxiter
        for j = 1:parnum
            %updating formula
            vstep(j,:) = inertw * vstep(j,:) + c1*rand*(pbest(j,:)-swarm(j,:))...
                + c2*rand*(gbest-swarm(j,:));
            a = abs(vstep(j,:))-vmax>0;
            vstep(j,a) = sign(vstep(j,a)).*vmax(a);
            swarm(j,:) = swarm(j,:)+vstep(j,:);
            a = swarm(j,:)-pmax>0;
            swarm(j,a) = pmax(a);
            a = swarm(j,:)<0;
            swarm(j,a) = 0;
            
            matfit(j) = fitness(X,Y,swarm(j,:));
            if(matfit(j)<fpbest(j))
                fpbest(j) = matfit(j);
                pbest(j,:) = swarm(j,:);
            end
            if(matfit(j)<fgbest)
                fgbest = matfit(j);
                gbest = swarm(j,:);
            end
        end
    end
end