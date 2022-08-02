#library(glmnet)
library(biglasso)

args     = commandArgs(trailingOnly=TRUE)
inputXfile=args[1]
inputYfile=args[2]
print(paste('input files:',inputXfile,inputYfile))

numlam=100
numiter=100
numcores=as.integer(args[3])
dobm=args[4]   #TRUE
print(paste('Info, numlam, numiter,numcores',numlam,numiter,numcores,dobm))


print(paste('Info, dobm set to ',dobm))

slurmjobid=Sys.getenv(c("SLURM_JOB_ID"))
print(paste('Info, env vars:',slurmjobid  ) )

if (dobm){
   #f it fit in memory you might try:  X.bm=read.big.matrix(inputXfile,sep = ",")
   Y.bm=read.big.matrix(inputYfile,sep = ",")
   print(paste("willuse:  /scratch/p4rodrig/job_",slurmjobid,"/",sep=""))
   X.bm=setupX(inputXfile,sep=",",
	  type="double",
          backingfile    = "x.bin",  
          descriptorfile = "x.desc")  #wking

   print('Xbm file setup ')
             

} else {
   X.bm =as.matrix(read.csv(inputXfile,sep = ",",header=FALSE))
   Y.bm =as.matrix(read.csv(inputYfile,sep = ",",header=FALSE))
}

xsize = format(object.size(get('X.bm')),unit='auto') #for later
print(paste("INFO, Xbm dim",dim(X.bm)," Xbm size is:",format(object.size(get('X.bm')),unit='auto'))) #print size of X
print(paste("INFO, Ybm dim",dim(Y.bm)," Ybm size is:",format(object.size(get('Y.bm')),unit='auto')))


ptm <- proc.time()               #get time stamp

if (dobm){
bl_results=biglasso( X.bm, Y.bm,
  row.idx = 1:nrow(X.bm),
  penalty = c("lasso"), #, "ridge", "enet"),
  family = c("gaussian"), # , "binomial", "cox", "mgaussian"),
  #alg.logistic = c("Newton", "MM"),
  #screen = c("Adaptive", "SSR", "Hybrid", "None"),
  #safe.thresh = 0,
  #update.thresh = 1,
  ncores = numcores, #for small jobs, less cores could be better? num of openMP thrds
  alpha = 1,
  #lambda.min = ifelse(nrow(X) > ncol(X), 0.001, 0.05),
  nlambda = numlam,
  #lambda.log.scale = TRUE,
  #lambda,
  eps = 1e-07,
  max.iter = numiter,
  #dfmax = ncol(X) + 1,
  #penalty.factor = rep(1, ncol(X)),
  #warn = TRUE,
  #output.time = FALSE,
  return.time = TRUE,
  verbose = TRUE)
bltime=proc.time() - ptm        #get timing info
}else{
      myfit_result=glmnet(X.bm,Y.bm,alpha = 1, nlambda = numlam, maxit = numiter)
  }
bltime=proc.time() - ptm        #get timing info

print(paste('INFO,',xsize,numiter,numlam,
           round(bltime[3],5),sep=","))
print(bl_results)
exit()

