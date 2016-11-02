# naturalist-docker , branch  naturalist-integrated

This is the naturalist integrated with the mediaserver, hence the name of the branch 'naturalist-integrated'.

# dependencies
start up the mediaserver ( branch media_enhanced , https://github.com/DINA-Web/media-docker/tree/media_enhanced )


# Usage

Use `make` to manage this docker composition of services:

See the Makefile for available commands.

	- `make init` is required for starting and will load image data and database dumps
	- `make clean` stops and removes all running services (leaving host data dirs with persisted data)
	- `make up` will start the system (once "prepared" ie data was initially loaded)

# Gotcha

The system will not start without having data loaded, so you need to have database dumps and image files available (mounted at /media/buffalo ...)


