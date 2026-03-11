#!/usr/bin/env bash
# Adds the ALU public key to the ubuntu user on the server and fixes permissions

# Replace this with your actual server IP
SERVER_IP="54.211.178.57"

# ALU public key to add
ALU_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDNdtrNGtTXe5Tp1EJQop8mOSAuRGLjJ6DW4PqX4wId/Kawz35ESampIqHSOTJmbQ8UlxdJuk0gAXKk3Ncle4safGYqM/VeDK3LN5iAJxf4kcaxNtS3eVxWBE5iF3FbIjOqwxw5Lf5sRa5yXxA8HfWidhbIG5TqKL922hPgsCGABIrXRlfZYeC0FEuPWdr6smOElSVvIXthRWp9cr685KdCI+COxlj1RdVsvIo+zunmLACF9PYdjB2s96Fn0ocD3c5SGLvDOFCyvDojSAOyE70ebIElnskKsDTGwfT4P6jh9OBzTyQEIS2jOaE5RQq4IB4DsMhvbjDSQrP0MdCLgwkN"

# Ensure your private key exists locally
if [ ! -f ~/.ssh/school ]; then
    echo "Private key ~/.ssh/school not found. Please create it first with ssh-keygen."
    exit 1
fi

# Add ALU public key to the server
ssh -i ~/.ssh/school ubuntu@$SERVER_IP "mkdir -p ~/.ssh && echo '$ALU_KEY' >> ~/.ssh/authorized_keys && chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys"

# Test connection
echo "Testing SSH connection..."
ssh -i ~/.ssh/school ubuntu@$SERVER_IP "echo 'SSH login successful!'"
