M. Okun SLAC HPC Linux Eng exercise

Relion app containerization

README
======
## Clone this repository

Clone the repo and cd to the repo directory 

```
git clone https://github.com/ac6y/slac_exc.git
cd slac_exc
```


## Run the public cloud-hosted container in the Apptainer runtime
The container associated with [this repo](https://github.com/ac6y/slac_exc) has been made
[publically readable](https://ghcr.io/ac6y/slac_exc/relion-app:latest).

To pull and run it via the Apptainer runtime, first make sure Apptainer has been installed, eg
via the command provided by apptainer.org that installs it in unprivileged mode:

[Install unprivileged from pre-built binaries](https://apptainer.org/docs/admin/main/installation.html#install-unprivileged-from-pre-built-binaries)

After installation, make sure that the apptainer binary is on your environment's path.

Now you should be able to pull and run the publically available image directly
without any authentication by simply typing `make run_without_login` to run the command using the Makefile, or by
running the apptainer command manually:

```
apptainer run docker://ghcr.io/ac6y/slac_exc/relion-app:latest
```

Apptainer will run Relion in the current working directory.

## Run the Relion container but just launch a Bash shell instead of Relion, for interactive CLI access

```
make run_bash_without_login
```


## Build the container image

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
echo "export APPTAINER_DOCKER_PASSWORD=<your-secret-token>" >> ~/.ssh/github_cr_token
echo "export APPTAINER_DOCKER_USERNAME=<your-github-username>" >> ~/.ssh/github_cr_token
```

Make the secret file owner-readable only:

```
chmod 600 ~/.ssh/github_cr_token
```


## Push (publish) the local image to the Github Container Registry (ghcr.io)

Source the secret env vars created above (TODO: there is likely a more secure way to pass this
token that avoids echoing it in logs):

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
Note this is only required if you want to push images or pull non-public ones.

```
make apptainer_login
```

## Run Relion via Apptainer
Note: this automatically runs `make apptainer_login` and pulls image as needed.  Alternatively, you can
`make run_without_login` to run a public image.

```
make apptainer_run_with_login
```

## Running tests via Docker (TODO)
```
make test
```

## Github actions CI/CD
* builds image
* runs tests (TODO)
* auto-publishes (pushes) image to registry if build & tests pass




Deployment Considerations
=========================

## Container Runtime considerations
## GPU enabled images and runtimes
* CUDA (relion ships with support by default)
* AMD ROCm (compile option)
* Intel SYCL (compile option)

To run with CUDA support, for example,
1. the CUDA drivers must be installed on the docker image (or a CUDA-enabled base image used)
2. the Relion app must be compiled with CUDA support (CUDA support is enabled by default, and
additional compile options switches are available for AMD and Intel)
3. the container must be run in a CUDA-enabled runtime on hardware with a compatible NVidia GPU.

## MPI

MPI support is enabled in Relion by default and can run in parallel mode using multiple CPUs on
the host machine via Apptainer using a single container.

Apptainer can also make use of an existing multi-node MPI runtime environment already available
on the host.
* A "bind/mount" approach that binds the host MPI executable into the container.

* Alternatively, a "hybrid" approach can be
used by calling the apptainer command itself via the MPI executable.

https://apptainer.org/docs/user/main/mpi.html 
https://relion.readthedocs.io/en/latest/Installation.html#edit-the-environment-set-up


To deploy and run against multiple nodes in a static LAN cluster, some cluster configuration is
needed, eg /etc/hostnames for the nodes and ssh keys for node access.

https://mpitutorial.com/tutorials/running-an-mpi-cluster-within-a-lan/

A much more flexible way than a static cluster to manage cluster resources is via an orchestration
framework such as Kubernetes or a service like AWS EC2 with Elastic Fabric Adapter.

https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/efa-start.html

* SLURM installation and configuration

https://slurm.schedmd.com/quickstart_admin.html#debinstall

* OpenMPI Slurm

>Using mpirun is the recommended method for launching Open MPI jobs in Slurm jobs.
mpirun’s Slurm support should always be available, regardless of how Open MPI or Slurm was installed.

https://docs.open-mpi.org/en/v5.0.x/launching-apps/slurm.html

* SLURM Submit Scripts

https://docs.rcc.fsu.edu/software/relion/#starting-the-relion-gui

* Environment Loaders (LMod)

https://docs.rcc.fsu.edu/software/relion/

# TODO
* use cuda-enabled base image
* develop test package that downloads sample data and runs tutorial commands.
* ✓CI/CD auto-publish image
