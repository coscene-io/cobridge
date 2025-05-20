#!/bin/bash

VENDOR_DIR="vendor"
PATCH_DIR="patches"

mkdir -p ${PATCH_DIR}

if ! git rev-parse --is-inside-work-tree &> /dev/null; then
    echo "Error: Not in a git repository"
    exit 1
fi

if [ ! -d "${VENDOR_DIR}" ]; then
    echo "Error: vendor directory ${VENDOR_DIR} does not exist"
    exit 1
fi

echo "Checking for modified files in vendor directory..."
MODIFIED_FILES=$(git status --porcelain -- "${VENDOR_DIR}" | grep -E "^ M|^MM" | awk '{print $2}')

STAGED_FILES=$(git status --porcelain -- "${VENDOR_DIR}" | grep -E "^M |^MM" | awk '{print $2}')

ALL_MODIFIED_FILES=$(echo "${MODIFIED_FILES}"$'\n'"${STAGED_FILES}" | sort | uniq)

if [ -z "${ALL_MODIFIED_FILES}" ]; then
    echo "No modified files found in vendor directory"
    exit 0
fi

echo "Modified files found in vendor directory:"
echo "${ALL_MODIFIED_FILES}"
echo ""

SERIES_FILE="${PATCH_DIR}/series"
> "${SERIES_FILE}"

PATCH_NUMBER=1

for FILE in ${ALL_MODIFIED_FILES}; do
    REL_PATH=${FILE#${VENDOR_DIR}/}
    
    PATCH_NAME=$(basename ${FILE} | sed 's/\./_/g')-fix.patch
    PATCH_FILE="${PATCH_DIR}/${PATCH_NAME}"
    
    echo "Generating patch file for ${FILE}..."
    
    git diff --no-prefix ${FILE} > "${PATCH_FILE}"
    
    if echo "${STAGED_FILES}" | grep -q "${FILE}"; then
        git diff --cached --no-prefix ${FILE} >> "${PATCH_FILE}"
    fi
    
    if [ -s "${PATCH_FILE}" ]; then
        echo "Saving patch to ${PATCH_FILE}"
        echo "${PATCH_NAME}" >> "${SERIES_FILE}"
        PATCH_NUMBER=$((PATCH_NUMBER + 1))
    else
        echo "Warning: ${FILE} did not generate a valid patch, skipping"
        rm "${PATCH_FILE}"
    fi
done

echo "Patch generation complete! ${PATCH_NUMBER} patches generated"
echo "Patch list saved to ${SERIES_FILE}"
