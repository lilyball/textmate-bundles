#!/bin/bash

## exec 2> /tmp/java_templatize.stderr
## exec > /tmp/java_templatize.stdout
## 
## set -x
## 
## echo ">>>> set"
## set
## echo "<<<< set"
## 
## echo ">>>> env"
## env
## echo "<<<< env"

template="$1"
classname=${TM_NEW_FILE_BASENAME%.java}
projname=`basename "$TM_PROJECT_DIRECTORY"`

## find package name
if [ -z "${org_bravo5_Java_pkgregexp}" ]; then
    org_bravo5_Java_pkgregexp="^.*(src|test)/"
    echo "using default package regexp: ${org_bravo5_Java_pkgregexp}"
fi

pkg_name=$(echo $TM_NEW_FILE_DIRECTORY | sed -E -e "s#${org_bravo5_Java_pkgregexp}##g" -e 's#/#.#g')

## build @author
author=$(defaults read AddressBookMe 2>/dev/null | awk -f "$TM_BUNDLE_SUPPORT/addrbook.awk")

sed -E \
    -e "s#@@CLASSNAME@@#${classname}#g" \
    -e "s#@@PACKAGE@@#${pkg_name}#g" \
    -e "s#@@PROJECT@@#${projname}#g" \
    -e "s#@@AUTHOR@@#${author}#g" \
    < ${template} > "${TM_NEW_FILE}"

## env >> "${TM_NEW_FILE}"
