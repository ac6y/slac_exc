M. Okun SLAC HPC Linux Eng exercise

Relion app containerization


# TODO
 * use cuda-enabled base image


README
======

## Building the container image

```
make docker_build
```

## Set up authentication secrets file

Create an env file you can source, eg from your .ssh directory with your github container registry token,
replacing `<your-secret-token>` with your actual token string and 
replacing `<your-github-username>` with your github username

```
echo "export GITHUB_CR_TOKEN=<your-secret-token>" >> ~/.ssh/github_cr_token
echo "export GITHUB_USER=<your-github-username>" >> ~/.ssh/github_cr_token
export APPTAINER_DOCKER_PASSWORD=<your-secret-token>" >> ~/.ssh/github_cr_token
export APPTAINER_DOCKER_USERNAME=<your-github-username>" >> ~/.ssh/github_cr_token
```

Make the secret file owner-readable only:

```
chmod 600 ~/.ssh/github_cr_token
```


## Push (publishing) the local image to the Github Container Registry (ghcr.io)

Source the secret env vars created above (TODO: there is likely a more secure way to pass this token that avoids echoing it in logs):

```
source ~/.ssh/github_cr_token
```

The next command automatically performs `make docker_login`, then pushes the image.
You can use `make docker_login` alone to work with the registry manually.

Push the image to the Github Container Registry
  
```
make docker_push
```

## Authenticate Apptainer to Github Container Registry (ghcr)

```
make apptainer_login
```

## Run Relion via Apptainer (automatically runs `make apptainer_login` and pulss image as needed)

```
make apptainer_run
```

## Running tests via Docker (TODO)
```
make test
```

## Running the Tutorial interactively via Apptainer

## Github actions CI/CD (TODO)
* builds image
* runs tests
* auto-publishes (pushes) image to registry if tests pass

Deployment Considerations
=========================

## Container Runtime considerations
## MPI
## SLURM
## GPU enabled images and runtimes
* CUDA (relion ships with support by default)
* AMD ROCm (compile option)
* Intel SYCL (compile option)

 ## MPI/CUDA env enablement

   https://relion.readthedocs.io/en/latest/Installation.html#edit-the-environment-set-up


 * OpenMPI Slurm

    Using mpirun is the recommended method for launching Open MPI jobs in Slurm jobs.  mpirun’s Slurm support should always be available, regardless of how Open MPI or Slurm was installed.

    https://docs.open-mpi.org/en/v5.0.x/launching-apps/slurm.html

 * SLURM Submit Scripts

    https://docs.rcc.fsu.edu/software/relion/#starting-the-relion-gui

 * Environment Loaders (LMod)

    https://docs.rcc.fsu.edu/software/relion/

