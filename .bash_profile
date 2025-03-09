exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
exec sudo -E -u root /bin/sh -
