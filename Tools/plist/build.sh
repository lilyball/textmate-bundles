TARGET=plist
rm -f *.bundle
for M in 32 64; do
	[ -f Makefile ] && make clean && rm Makefile
	CFLAGS="-m$M" ruby ./extconf.rb && CFLAGS="-m$M" make && mv "${TARGET}.bundle" "${TARGET}_${M}.bundle" || ( echo "Failed to build ${M}-bit bundle" && exit 1 )
done
lipo -create "${TARGET}_32.bundle" "${TARGET}_64.bundle" -output "${TARGET}.bundle" && echo Done
