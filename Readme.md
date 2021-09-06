
# Deep learning Environment in docker

Image consists of tensorflow 2.5  and pytorch 1.9x

With preinstalled gpu libraries and configs with conda environment



## Try out pulling image

```bash
    docker pull prudhvi9999/dlgpuenv:latest
```

To run this image with gpus

```bash
  docker run --gpus all prudhvi9999/dlgpuenv:latest
```

Once started make sure to setup zsh using

```bash
    conda init
```

And restart the container with

```bash
    docker exec -it container_name
```

  