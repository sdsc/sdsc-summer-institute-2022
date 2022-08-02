#Insall package if needed into home directory
if(!require(doParallel)){
  install.packages("doParallel",repos="http://cran.r-project.org")
}

library(doParallel)
registerDoParallel(cores=32) #<<<----- vary cores, match up to job resources
print('starting dopar test')

# Make up some random data and list out the object sizes
N=10000; #<<<<---- N rows start with say 1000
P=2000; #<<<---   P columns  200 for start

#make random data with 1 column and 1 coeffient non-zero means
X     =matrix(rnorm(N*P),N,P)
X[,1] =X[,1]+1              
B     =matrix(rnorm(P),P,1)
B[1]  =5
Y     =X %*% B +  0.1*matrix(rnorm(N),N,1)           

print(paste("X size is:",format(object.size(get('X')),unit='auto'))) #print size of X

#part 2
ptm <- proc.time()               #get time stamp

result_xloop = foreach(i = 1:32, .combine=cbind) %dopar%   
  {
    #set up simple linear model example
    samp_inds = sample(nrow(X),replace=TRUE) #a Bootstrap sample with replacement 
    Xsamp     = X[samp_inds,]
    Ysamp     = Y[samp_inds]
    lm_result = lm(Ysamp~Xsamp)                   #run a linear model
    
    
    #Get memory size of objects and list them
    my_obj_sizes       = sapply(ls(), function(n) object.size(get(n)), simplify = FALSE) 
    my_obj_sizes_list  = sapply(my_obj_sizes[order(-as.integer(my_obj_sizes))],  function(s) format(s, unit = 'auto')) 
    
    Sys.sleep(30)                  #Step 3 sleep for 30 seconds to watch memory usage in top                 
    
    print(paste("this is loop",i)) #NOTE: this won't print in a notebook
    print(my_obj_sizes_list)       #  but it will in a native R session, 
    
    return(c(lm_result$coefficients[1:3],my_obj_sizes_list)) 
  }

looptime=proc.time() - ptm        #get timing info
print(looptime)


