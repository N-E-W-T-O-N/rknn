# Docker Python Image

A prebuild Rknn packages based Docker image.

## Version
There are following versions available .
- py10 => 'Dockerfile'
- py10-slim-bookworm => 'py10-slim-bookworm'
- py11-slim => 'py11-slim'

## Building the Docker Image

To build the Docker image, navigate to the directory containing the `Dockerfile` and run:

```sh
docker build -f "<file>" -t rknn .
```

## Pulling the Prebuilt Image

If the image is available on a Docker registry, you can pull it using:

```sh
docker pull newton2022/rknn:py-10
```

## Running a Python Script

To execute a Python script (`script.py`) using the built or pulled Docker image, use the following command:

```sh
docker run --rm -v $(pwd):/app -w /app rknn:py-10 python script.py
```

This command:
- Mounts the current directory to `/app` inside the container.
- Sets `/app` as the working directory.
- Runs the Python script inside the container.

## Running an Interactive Python Shell

To start an interactive Python shell inside the container:

```sh
docker run --rm -it rknn:py-10 python
```

This opens a Python REPL where you can execute Python commands interactively.

## Notes
- Ensure Docker is installed and running on your machine before executing these commands.
- Adjust file paths and volume mappings as needed depending on your host operating system.


