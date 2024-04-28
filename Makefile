docker_build:
	docker build -t ghcr.io/ac6y/slac_exc/relion-app .

docker_run:
	docker run -it relion-app

apptainer_run:
	apptainer run docker://ghcr.io/ac6y/slac_exc/relion-app:latest

docker_login:
	echo $(GITHUB_CR_TOKEN) | docker login ghcr.io -u $(GITHUB_USER) --password-stdin

docker_push: docker_login
	docker push ghcr.io/ac6y/slac_exc/relion-app:latest

test:
