#!/bin/bash

# $ bash /Users/sarahruddle/github/super_shedder/scripts/Humann3.sh

################################################################################
# SETTING UP CONDA ENV #
################################################################################

## Find modules of anaconda or conda and instructions for loading using lmod
$ module-spider conda
$ module load conda

## Build environment from yaml file

## Load environment

################################################################################
# USING SCREEN MULTIPLIERS #
################################################################################

## Log in normally
$ ssh sruddle@login.scg.stanford.edu

## Record node, e.g.,

## Start tmux (or screen) session
$ tmux new -s <session name>

## If t-money viciously closes your window:
$ ssh sruddle@login.scg.stanford.edu
$ ssh <node from before, e.g., smsh11dsu-srcf-d15-37>
$ tmux attach -t <session name>

################################################################################
# WORKING INTERACTIVELY #
################################################################################

# All work should be done on a "compute" node, not a "login" node.
## Request a node with the specifications you need
[sruddle@smsh11dsu-srcf-d15-37 ~]$ salloc --account=dmonack -p batch --mem=10G --time=2:00:00 -c 2
salloc: Granted job allocation 17477951
salloc: Waiting for resource configuration
salloc: Nodes dper730xd-srcf-d16-01 are ready for job

## Note job id above and launch a compute node
[sruddle@smsh11dsu-srcf-d15-37 ~]$ srun --jobid 17477951 --pty bash
[sruddle@dper730xd-srcf-d16-01 ~]$ # <- note change in node

## Alternatively, these two steps can be combined
srun --account=dmonack -p batch --mem=75G --time=72:00:00 -c 5 --pty bash
