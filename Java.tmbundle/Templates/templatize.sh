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

## find package name
if [ -z "${org_bravo5_Java_pkgregexp}" ]; then
    org_bravo5_Java_pkgregexp="^.*src/"
    echo "using default package regexp: ${org_bravo5_Java_pkgregexp}"
fi

pkg_name=$(echo $TM_NEW_FILE_DIRECTORY | sed -e "s#${org_bravo5_Java_pkgregexp}##g" -e 's#/#.#g')
package="package ${pkg_name};"

## build @author
author=$(defaults read AddressBookME 2>/dev/null | awk -f ../addrbook.awk)

sed -e "s#@@CLASSNAME@@#${classname}#g" \
    -e "s#@@PROJECT@@#${package}#g" \
    -e "s#@@AUTHOR@@#${author}#g" \
    < ${template} > "${TM_NEW_FILE}"

## env >> "${TM_NEW_FILE}"
