#!/bin/bash

set -e -x

PATH=$PATH:$(npm bin)

ivy-ngcc fesm2015,esm2015
# Did it add the appropriate build markers?
ls node_modules/@angular/common | grep __modified_by_ngcc_for_fesm2015
if [[ $? != 0 ]]; then exit 1; fi
ls node_modules/@angular/common | grep __modified_by_ngcc_for_esm2015
if [[ $? != 0 ]]; then exit 1; fi

ngc -p tsconfig-app.json

# Did it compile the main.ts correctly?
grep "directives: \[\S*\.NgIf\]" dist/src/main.js
if [[ $? != 0 ]]; then exit 1; fi
