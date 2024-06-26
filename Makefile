run_without_login: 
	apptainer run docker://ghcr.io/ac6y/slac_exc/relion-app:latest

run_bash_without_login:
	apptainer run docker://ghcr.io/ac6y/slac_exc/relion-app:latest bash

docker_build:
	docker build -t ghcr.io/ac6y/slac_exc/relion-app .

docker_login:
	echo $(GITHUB_CR_TOKEN) | docker login ghcr.io -u $(GITHUB_USER) --password-stdin

docker_run: docker_login
	docker run -it ghcr.io/ac6y/slac_exc/relion-app bash

docker_push: docker_login
	docker push ghcr.io/$(GITHUB_USER)/slac_exc/relion-app:latest

apptainer_login:
	echo $(GITHUB_CR_TOKEN) | apptainer registry login --username $(GITHUB_USER) docker://ghcr.io

apptainer_run_with_login: apptainer_login
	apptainer run docker://ghcr.io/$(GITHUB_USER)/slac_exc/relion-app:latest

test:
	docker run -it relion-app tests/relion_test.sh
