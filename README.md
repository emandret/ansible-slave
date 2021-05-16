# ansible-slave

You can rebuild the image to install a different Ansible version:

```console
$ docker build --build-arg ANSIBLE_VERSION=2.9 -t emandret/ansible-slave:latest .
```

You can create a bind-mount volume to access your local playbooks:

```console
$ docker run -d --name ansible-test -v /path/to/play:/home/ansible-workdir emandret/ansible-slave
$ docker exec -it ansible-test /bin/sh
```
