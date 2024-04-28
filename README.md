### M. Okun SLAC HPC Linux Eng exercise
### Relion app containerization

### TODO
 * use cuda-enabled base image


### README

* Building the container image

* Running tests via Docker

* Running the Tutorial interactively via Apptainer

* Pushing (publishing) the local image to the Github Container Registry (ghcr.io)

* Pushing custom app code

* Github actions CI/CD
    - runs tests
    - publishes (pushes) image to registry if tests pass

* Auto-Publishing the image via Github 


* Deployment
    * Container Runtime considerations
    * MPI
    * SLURM
    * GPU enabled images and runtimes
        * CUDA (relion ships with support by default)
        * AMD ROCm (compile option)
        * Intel SYCL (compile option)

 * MPI/CUDA env enablement

    https://relion.readthedocs.io/en/latest/      Installation.html#edit-the-environment-set-up


 * OpenMPI Slurm

    Using mpirun is the recommended method for launching Open MPI jobs in Slurm jobs.  mpirun’s Slurm support should always be available, regardless of how Open MPI or Slurm was installed.

    https://docs.open-mpi.org/en/v5.0.x/launching-apps/slurm.html

 * SLURM Submit Scripts

    https://docs.rcc.fsu.edu/software/relion/#starting-the-relion-gui

 * Environment Loaders (LMod)

    https://docs.rcc.fsu.edu/software/relion/

