# lfs/ch4/setup-environment.sh
# cannot run this as shell script in Dockerfile

exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
