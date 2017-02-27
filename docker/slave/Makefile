

update.key:
	rndc-confgen -a -c update.key -k update-key

test_env: test_env.template update.key
	cp test_env.template test_env
	M=`docker inspect --format "{{.NetworkSettings.IPAddress}}" dns-master`
	echo "MASTERS=[$M]">> test_env
	echo -n "UPDATE_KEY=" >> test_env
	grep secret update.key | awk '{print $$2}' | tr -d \; | tr -d \" >> test_env

build:
	docker build -t markllama/bind-slave .

run: update.key
	docker run -d -p 53/udp --env-file test_env --name dns-slave-0 \
	  -e MASTERS="['"$(docker inspect --format "{{.NetworkSettings.IPAddress}}" dns-master)"']" \
	  markllama/bind-slave

shell:
	docker run -it --rm markllama/bind-master /bin/bash
