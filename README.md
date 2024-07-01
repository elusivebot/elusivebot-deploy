# elusivebot-deploy

## Local

Tools for running a test environment on the local machine without
Docker - potentially easier for development work on individual
services.

Note all local utilities are intended to be run from the local
directory.  *cd local* and then *./bin/whatever/script*.

## Vagrant

* [Install Vagrant](https://developer.hashicorp.com/vagrant/downloads)
* From this directory, run *vagrant up*
	* This pick a reasonble VM host.  Configured to use 4cpus and 4gb on VirtualBox or HyperV.
* Enter the vm with *vagrant ssh*
* From the VM run *elusivebot bootstrap* to initialize and build the dev packages
	* This script, and Vagrant, expect all repositories to be located in the same parent directory as this repository.  I.e. if elusivebot-deploy is checked out to **C:/Users/elusivebot/Documents/git/elusivebot/elusivebot-deploy/**, then elusivebot-direct should be in **C:/Users/elusivebot/Documents/git/elusivebot/elusivebot-direct/**.
* Run *elusivebot docker up* to launch the dev stack.

## Dev

The elusivebot script should work both in Vagrant and a standard UNIXy environment.

