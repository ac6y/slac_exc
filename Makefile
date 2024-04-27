build:
	docker build -t relion-app .

run:
	docker run -it relion-app

login:
	echo $(GITHUB_CR_TOKEN) | docker login ghcr.io -u $(GITHUB_USER) --password-stdin

push: login
	docker push ghcr.io/ac6y/slac_exc/relion-app:latest

test:
