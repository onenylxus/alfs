#!/bin/bash

echo "Configuring the system locale..."

# en_US.UTF-8 is the locale recommended by the book for United States English.
cat > /etc/profile << "EOF"
# Begin /etc/profile

for i in $(locale); do
  unset ${i%=*}
done

if [[ "$TERM" = linux ]]; then
  export LANG=C.UTF-8
else
  export LANG=en_US.UTF-8
fi

# End /etc/profile
EOF
