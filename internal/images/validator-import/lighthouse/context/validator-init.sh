#!/bin/bash
set -e

# for key in /keystore/validator_keys/*; do
#   if [ -f "$key" ]; then
#     echo "Found validator key in $key"
#     echo "Importing validator..."
#     if [ $VAL_NETWORK = "custom" ]; then
#       ./lighthouse account validator import --testnet-dir /network_config --password-file /keystore/keystore_password.txt --keystore $key --reuse-password --datadir /data  
#     else
#       ./lighthouse account validator import --network $VAL_NETWORK --password-file /keystore/keystore_password.txt --keystore $key --reuse-password --datadir /data
#     fi
#     echo "Validator imported"
#   fi
# done

#!/bin/bash
set -e

for key in /keystore/validator_keys/*; do
  if [ -f "$key" ]; then
    echo "Found validator key in $key"
    echo "Importing validator..."
    
    # Extract filename without extension
    FILENAME=$(basename "$key" .json)
    
    # Check if password file exists for the key
    if [ -f "/keystore/${FILENAME}.txt" ]; then
      PASSWORD_FILE="/keystore/${FILENAME}.txt"
    else
      # Use default password file
      PASSWORD_FILE="/keystore/keystore_password.txt"
    fi
    
    if [ "$VAL_NETWORK" = "custom" ]; then
      ./lighthouse account validator import --testnet-dir /network_config --password-file "$PASSWORD_FILE" --keystore "$key" --reuse-password --datadir /data  
    else
      ./lighthouse account validator import --network "$VAL_NETWORK" --password-file "$PASSWORD_FILE" --keystore "$key" --reuse-password --datadir /data
    fi
    
    echo "Validator imported"
  fi
done
