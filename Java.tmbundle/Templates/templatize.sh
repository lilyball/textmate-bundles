#!/bin/bash

classname=${TM_NEW_FILE_BASENAME%.java}

## find package name
pkg_path=${TM_NEW_FILE_DIRECTORY#$TM_PROJECT_DIRECTORY/}
pkg_name=$(echo ${pkg_path} | tr / .)
package="package ${pkg_name};"

if [ -z "${pkg_path}" ] || [ "${TM_PROJECT_DIRECTORY}" = "${pkg_path}" ]; then
    package="/* unable to determine package from $TM_NEW_FILE_DIRECTORY and $TM_PROJECT_DIRECTORY */"
fi

## build @author
author=$(defaults read AddressBookME | awk -f addrbook.awk)

sed -e "s#@@CLASSNAME@@#${classname}#g" \
    -e "s#@@PROJECT@@#${package}#g" \
    -e "s#@@AUTHOR@@#${author}#g" \
    < java-insert.java > ${TM_NEW_FILE}

## env >> ${TM_NEW_FILE}