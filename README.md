# ubuntu-docker-workstation
With this Dockerfile, you can easily create a graphical Ubuntu workstation on any Docker host.

To build this dockerfile, use the following command:

```bash
docker build -t workstation .
```

To run this dockerfile, use the following command:

```bash
docker run -d -p "5901:5901" workstation
```

If you want to have a persistent volume between different runs, use this command instead:

```bash
docker run -d -v /home/$USER/.workstation:/home/wsuser -p "5901:5901" workstation
```
