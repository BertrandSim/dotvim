source("./commonline functions.R") # to evaluate the proposed rotations via calculated common lines
source("./gs_mixtures_generate.R") # test with gaussian mixtures
source("./fourier transform.R")    # to convert 2d images in spatial domain to the fourier domain
library(tictoc)   # to check run times

set.seed(1) # for reproducibility

# *** change if needed ***
proj <- proj_pana[c(1,3,5)]
fproj <- fproj_pana[c(1,3,5)]
rot <- rot_pana[c(1,3,5)]

### Special case ----
# case of N=2 projection images with 2 known rotations,
# with \Phi_1 = I
# and \Phi_2 =  rbind(c(0,1,0), c(0,0,1), c(1,0,0))

nsamples <- 2

Q1_truth <- diag(3)
Q2_truth <- rbind(c(0,1,0), c(0,0,1), c(1,0,0))

# *** change if needed ***
Q2_truth <- rot_pana[[2]]
fproj <- fproj_pana

## code missing##


# Sampling P(\Phi | \Pi), N=2----
## using the Rejection Sampler

Q1 <- diag(3) #WLOG
Q2 <- list() # list containing Q_{2,t}'s
t <- 0
K <- 100 # number of samples
count <- 0 # to keep track of acceptance rate of proposed Y's

xmin <- -5
xmax <- 5
npix <- 101
gr <- seq(xmin,xmax,length=npix) #assume square fourier image.

while(t < K) {
  
  Y <- rso3unif()
  
  cline <- commonline(Q1,Y)
  
  line1 <- cbind(gr*cline$p1[1], gr*cline$p1[2])
  line1 <- coord2idx(line1, xmin, xmax, npix)
  line2 <- cbind(gr*cline$p2[1], gr*cline$p2[2])
  line2 <- coord2idx(line2, xmin, xmax, npix)
  
  #v1 <- fprojm[[1]][line1]
  #v2 <- fprojm[[2]][line2]
  v1 <- fproj[[1]][line1]
  v2 <- fproj[[2]][line2]
  
  val_Y <- sum( Mod(v1-v2)^2 ) ##L_2 "distance"
  val_Y <- exp(-val_Y)
  
  U <- runif(1, min=0, max=1)
  
  #update
  if ( U <= val_Y ) {
    Q2[[t+1]] <- Y
    t <- t+1
  } 
  count <- count +1
  
  #printing
  if ((count %% 1000) == 0) 
    print(paste(t, "samples successful, ", count, "samples generated."))
  
}

prop_accept <- K/count
prop_accept <- round(prop_accept,5)
print(paste("The proportion accepted is ", prop_accept, "."))

  
## Sampling, general case ----
{text)s
ss}
sample_rot_img <- fnction(nimages, images, reso=129, endpoints=c(-5,5), interp.method='bicubic',
                           nsamples, npropose = NULL) awe
{
  # Inputs
  #   nimages: number of data / projected images
  #   images: list consisting of n 2D images
  #   reso: image resolution. Number of pixels in each axis
  #   endpoints: evaluate over what interval in each axis.
  #   nsamples: number of samples we wish to get
  #   npropose: number of samples to propose. Useful if nsamples not reached

  # Output: list containing
  #   samp_rot: list of lists of sampled rotations for corresponding to each image, R[[t]][[n]]
  #             R[[t]][[n]], t=1,..,nsamples, n=1,..,nimages,  with R[[t]][[1]] = Id
  #   prop_accept: Acceptance rate of the rejection sampler
  
  from <- endpoints[1]; to <- endpoints[2]
  gr <- seq(from,to, len=reso)
  
  fimages <-  lapply(images, fft_mid)  #fourier images
    # fimages[[i]] <- fft_mid(images[[i]])

  count_accept <- 0
  Q <- vector("list", nsamples)  # Each element to contain a proposed vector of rotations.
  count_propose <- 0 # to keep track of number of proposed Y's
  
  while( (count_accept < nsamples) && 
         ( is.null(npropose) || (count_propose < npropose)) ) {
    
    Y <- rso3unif(nimages)
    Y[[1]] <- diag(3)
    

    vals <- combn(nimages,2, function(nn) {
              eval_cline(fimages[[nn[1]]], fimages[[nn[2]]], Y[[nn[1]]], Y[[nn[2]]], gr,
                         interp.method = interp.method)})
    val_Y <- exp(-mean(vals))

    # val <- matrix(0, nrow = nimages, ncol=nimages)  #store distances for every pair of proposed rotations
    # for (m in 1:(nimages-1)) {
    #   for (n in (m+1):nimages) {
    #     val[m,n] <- eval_cline(fimages[[m]], fimages[[n]], Y[[m]], Y[[n]], gr,
    #                            interp.method = interp.method)  #L2 distance
    # 
    #   }
    # }
    # val_Y <- exp( - sum(val) )
    # val_Y <- exp( - sum(val) / choose(nimages,2) ) #need this additioanal nc2 term?
    
    U <- runif(1, min=0, max=1)
    
    #update
    if ( U <= val_Y ) {
      Q[[count_accept+1]] <- Y
      count_accept <- count_accept+1
    } 
    count_propose <- count_propose + 1
  
    #printing
    #if ((count_propose %% 1000) == 0) 
    if ((count_propose %% 100) == 0)
      print(paste(count_accept, "out of", count_propose, "samples accepted."))
    
  }
  
  prop_accept <- nsamples/count_propose
    
  return (list(samp_rot = Q, prop_accept = prop_accept))
}
  
  
# **testdriver  ----

  set.seed(20)
  nimages <- 2 # number of images we have, aka sample size.
  reso <- 129
  endpoints <- c(-5,5)
  nsamples <- 100    # number of times to sample from distribution.  
  snr <- 2 #signal to noise ratio
  
  gs_mix_data <- gen_gs_mix(nimages, rhop_pana, reso, endpoints)
  true_rots <- gs_mix_data$rot
  images_clean <- gs_mix_data$proj
  
  #images_noisy <- lapply(images_clean, addnoise_snr, snr=snr)
  
  samples <- sample_rot_img(nimages, images_clean, reso, endpoints, nsamples = nsamples) 
  #samples <- sample_rot_img(nimages, images_noisy, reso, endpoints, nsamples = nsamples) #doesn't work for noisy images :(
  
  str(samples)
  

## visualizing----

  # visualize 2nd rot.
  Qsamp <- lapply(samples$samp_rot, "[[", 2)  # extract 2nd orientation from each sample
  plotso3(Qsamp)
  plotso3( list(true_rots[[2]]), add=TRUE, col='red', size=5)
  
  # for n=2 case
  plotso3(Qsamp)
  plotso3(list(rot[[2]]), add=T, col='red', size=5)
  
# old methods... without plotso3()
vecs <- matrix(0,nrow=3,ncol=K)
for (i in 1:K) {
  vecs[,i] <- point_mat(Q2[[i]])
}
open3d() #new plot
plot3d(t(vecs), aspect=F, xlab = 'x', ylab='y', zlab='z')
#spheres3d(0,0,0,radius=1, alpha=0.3) #add a sphere to 3d plot
shade3d(ellipse3d(diag(3), t=1), alpha = 0.5, col='grey') #add a unit sphere to 3d plot
points3d(0,0,0)
points3d(t(point_mat(Q2_truth)), size = 10, col='red')  #truth


#add noise to break overlaps
jvecs <- jitter(vecs,amount=0.05)

open3d() #new plot
plot3d(t(jvecs), aspect=F, xlab = 'x', ylab='y', zlab='z')
#spheres3d(0,0,0,radius=1, alpha=0.3) #add a sphere to 3d plot
shade3d(ellipse3d(diag(3), t=1), alpha = 0.5, col='grey') #add a unit sphere to 3d plot
points3d(0,0,0)
points3d(t(point_mat(Q2_truth)), size = 10, col='red')  #truth


# another way
vecs1 <- matrix(0, nrow = 3, ncol = K)
for (i in 1:K) {
  vecs1[,i] <- Q2[[i]] %*% c(0,0,1) 
}
open3d()
plot3d(t(vecs1), aspect=F, xlab = 'x', ylab='y', zlab='z')
#spheres3d(0,0,0,radius=1, alpha=0.3) #add a sphere to 3d plot
shade3d(ellipse3d(diag(3), t=1), alpha = 0.5, color='grey') #add a unit sphere to 3d plot
points3d(t(Q2_truth %*% c(0,0,1)), size = 10, col='red')  #truth
points3d(0,0,0)




## rej sampler in action ----

  reso=129
  endpoints=c(-5,5)
  
  set.seed(1000)
  #panaretos (2009) example
  pana_data <- gen_gs_mix(20, rhop_pana, reso, endpoints)
  true_rots <- pana_data$rot
  images_clean <- pana_data$proj
  
  
  tic("rej sampler, n=2, bicubic")  #acceptance rate: 100/4776 = 0.02093802, run time: 184.47s
    set.seed(10)
    samples2 <- sample_rot_img(nimages=2, images_clean, reso, endpoints, nsamples=100  )
    (praccept2 <- samples2$prop_accept)
  toc()
  
  tic("rej sampler, n=2, bilinear") #acceptance rate: 100/10234 = 0.00977135, run time: 44.54s
    set.seed(10)
    samples2a <- sample_rot_img(nimages=2, images_clean, reso, endpoints, nsamples=100, interp.method='bilinear'  )
    (praccept2a <- samples2a$prop_accept)
  toc()
  
  
  tic("rej sampler, n=3, bicubic")  #acceptance rate: 8/26700 = 2.996e-04, runtime: 3,098s
    set.seed(10)  
    samples3 <- sample_rot_img(nimages=3, images_clean, reso, endpoints, nsamples=100, npropose=1e5 )
    (praccept3 <- samples3$prop_accept)
  toc()

  tic("rej sampler, n=3, bilinear") #acceptance rate: 5/26900 = 1.859e-04, runtime: 342.78s
    set.seed(10)  
    samples3 <- sample_rot_img(nimages=3, images_clean, reso, endpoints, 
                               interp.method = 'bilinear', nsamples=100, npropose=1e7  )
    (praccept3 <- samples3$prop_accept)
  toc()
  
  #previous bilinear interp with fields::interp.surface()
  #n=2, acceptance rate = 6.64e-04
  #n=3, acceptance rate = 0/1e06
  # not sure what explains the huge difference... is due to interp.surface() using cplx values instead of Mod()?
  
  
  set.seed(10)  
  samples5 <- sample_rot_img(nimages=5, images_clean, reso, endpoints, 
                             interp.method = 'bilinear', nsamples=100, npropose=1e7 )
  praccept5 <- samples5$prop_accept
  #n=5. acceptance rate: 0/15900
  
  set.seed(10)  
  samples10 <- sample_rot_img(nimages=10, images_clean, reso, endpoints, nsamples=100, npropose=1e7 )
  praccept10 <- samples10$prop_accept
  #n=10. acceptance rate:
