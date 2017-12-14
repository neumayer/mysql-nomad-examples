default : nomad consul
nomad:
	wget https://releases.hashicorp.com/nomad/0.7.0/nomad_0.7.0_linux_amd64.zip
	unzip nomad_0.7.0_linux_amd64.zip
consul:
	wget https://releases.hashicorp.com/consul/1.0.1/consul_1.0.1_linux_amd64.zip
	unzip consul_1.0.1_linux_amd64.zip
start_consul:
	consul agent -server -client 127.0.0.1 -advertise 127.0.0.1 -data-dir /tmp/consul -ui -bootstrap
start_nomad:
	nomad agent -config nomad.conf
run_jobs:
	nomad run mysql-server.nomad
	nomad run dbwebapp.nomad
stop_jobs:
	nomad stop dbwebapp
	nomad stop mysql-server
