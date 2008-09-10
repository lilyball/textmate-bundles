#!/usr/bin/env bash

SQUEEZER="/Applications/TextMate.app/Contents/SharedSupport/Bundles/Objective-C.tmbundle/Support/list_to_regexp.rb"

cd data

ruby $SQUEEZER < objects.txt > objects_compressed.txt
ruby $SQUEEZER < methods.txt > methods_compressed.txt
ruby $SQUEEZER < properties.txt > properties_compressed.txt

