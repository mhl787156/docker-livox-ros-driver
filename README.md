# Livox ROS Driver Container

Clone this repository into a user directory 

```
git clone https://github.com/mhl787156/docker-livox-ros-driver.git
```

And run one of the following commands

## Build Container

```
make build
```

## Build and Run Container in the Background 

```
make run
```

This will start the container in the background

The `config/MID360_config.json` is loaded into the container and overwrites the default configuration file. Change this to appropraite values

You can also build, run and view output of the container by using `make view`

You can also build, run and then get a shell inside the container by using `make exec`

## Stop the container

```
make stop
```
