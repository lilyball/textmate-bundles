database_choice () {

	export TM_PSQL=${TM_PSQL:-psql8}

	if [[ -n "$TM_DB_SERVER" ]]; then
		echo -n "$TM_DB_SERVER"
	elif ! type -p mysql >/dev/null && type -p "${TM_PSQL}" >/dev/null; then
		echo -n "postgresql"
	elif type -p mysql >/dev/null && ! type -p "${TM_PSQL}" >/dev/null; then
		echo -n "mysql"
	else
		res=$(CocoaDialog dropdown --title "Select Database" \
		 	--text "Which database should be used?" \
			--button1 Okay \
			--button2 Cancel \
			--string-output \
			--no-newline \
			--items mysql postgresql sqlite3)

		if [[ "${res:0:4}" == "Okay" ]]; then
			echo -n "${res:5}"
		fi
	fi

}
