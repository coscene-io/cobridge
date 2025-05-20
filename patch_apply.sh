#!/bin/bash

set -e

VENDOR_DIR="vendor"
PATCH_DIR="patches"

apply_patches() {
    echo "applying patches..."
    
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
    
    for patch_file in "${PATCHES[@]}"; do
        echo "applying patch: ${patch_file}"
        
        if ! patch -d "${VENDOR_DIR}" -p1 < "${patch_file}"; then
            echo "error: failed to apply changes from ${patch_file}"
            echo "please manually check vendor directory state"
            exit 1
        fi
    done
    
    echo "all patches have been applied!"
    echo "vendor directory has been modified, run patch_revert.sh to restore original state"
}

apply_patches
