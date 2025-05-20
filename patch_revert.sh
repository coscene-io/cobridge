#!/bin/bash

set -e

VENDOR_DIR="vendor"
PATCH_DIR="patches"

revert_patches() {
    echo "reverting patches..."
    
    if [ ! -d "${PATCH_DIR}" ]; then
        echo "error: patch directory ${PATCH_DIR} does not exist"
        exit 1
    fi
    
    if [ ! -f "${PATCH_DIR}/series" ]; then
        echo "error: ${PATCH_DIR}/series file does not exist"
        echo "have you run patch_generate.sh to generate patches?"
        exit 1
    fi
    
    PATCHES=()
    while read -r patch_file; do
        [[ -z "${patch_file}" || "${patch_file}" =~ ^#.*$ ]] && continue
        
        if [ -f "${PATCH_DIR}/${patch_file}" ]; then
            PATCHES+=("${PATCH_DIR}/${patch_file}")
        else
            echo "warning: patch file ${PATCH_DIR}/${patch_file} does not exist, skipping"
        fi
    done < "${PATCH_DIR}/series"
    
    if [ ${#PATCHES[@]} -eq 0 ]; then
        echo "no valid patch files found"
        exit 0
    fi
    
    for ((i=${#PATCHES[@]}-1; i>=0; i--)); do
        patch_file="${PATCHES[$i]}"
        echo "reverting patch: ${patch_file}"
        
        if ! patch -d "${VENDOR_DIR}" -p1 -R < "${patch_file}"; then
            echo "error: failed to revert changes from ${patch_file}"
            echo "please manually check vendor directory state"
            exit 1
        fi
    done
    
    echo "all changes have been reverted!"
    echo "vendor directory has been restored to original state"
}

revert_patches
