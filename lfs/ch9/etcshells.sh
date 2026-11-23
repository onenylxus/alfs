#!/bin/bash

echo "Creating /etc/shells..."

cat > /etc/shells << "EOF"
# Begin /etc/shells

/bin/sh
/bin/bash

# End /etc/shells
EOF
