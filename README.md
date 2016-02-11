# dw-system

Integration project with DINA-Web applications including for example The Naturalist, The Media Server, Loan, Inventory, DNA Key and Naturarv

# Usage

Use `make` to manage this docker composition of services:

See the Makefile for available commands.

	- `make init` is required for starting and will load image data and database dumps
	- `make clean` stops and removes all running services (leaving host data dirs with persisted data)
	- `make up` will start the system (once "prepared" ie data was initially loaded)

# Gotcha

The system will not start without having data loaded, so you need to have database dumps and image files available (mounted at /media/buffalo ...)


