BEGIN {
    FS = "=";
}

{
    gsub(/[ \t]*/,"", $1);
    gsub(/[ ";\t]*/,"", $2);
    
    values[$1] = $2;
}

END {
    printf("%s %s \\&lt;%s\\&gt;\n",
           values["FirstName"], values["LastName"], values["Email"]);
}