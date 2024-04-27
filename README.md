# M. Okun SLAC HPC Linux Eng excercise
# Relion app containerization

# TODO
 * use cuda-enabled base image

### README

* Building the container image

* Running tests via Docker

* Running the Tutorial interactively via Apptainer

* Pushing (publishing) the local image to the Github Container Registry (ghcr.io)

* Pushing custom app code

* Github actions CI/CD
  * runs tests
  * publishes (pushes) image to registry if tests pass

* Auto-Publishing the image via Github 


* Deployment
  * Container Runtime considerations
  * MPI
  * SLURM
  * GPU enabled images and runtimes
    * CUDA (relion ships with support by default)
    * AMD ROCm (compile option)
    * Intel SYCL (compile option)


