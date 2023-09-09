all:
	exit 0

install:
	exit 0

niv-update:
	nix-shell -p niv --run "niv update"
