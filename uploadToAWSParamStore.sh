#!/bin/bash

PARAM_TYPE="String" # Can be String, StringList, or SecureString

# Check if arguments are provided
if [ "$#" -eq 0 ]; then
    echo "No parameters provided."
    exit 1
fi

# Loop through the arguments and upload each pair
for arg in "$@"; do
    IFS='=' read -ra PARAM <<< "$arg"
    PARAM_NAME="${PARAM[0]}"
    PARAM_VALUE="${PARAM[1]}"

    # Upload parameter
    aws ssm put-parameter \
        --name "$PARAM_NAME" \
        --value "$PARAM_VALUE" \
        --type "$PARAM_TYPE" \
        --overwrite


    # Check if the command was successful
    if [ $? -eq 0 ]; then
        echo "Uploaded parameter: $PARAM_NAME"
    else
        echo "Failed to upload parameter: $PARAM_NAME"
    fi
done
