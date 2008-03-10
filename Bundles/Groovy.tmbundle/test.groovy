println "Read Test"
print "Please enter something: "


System.out.flush()

System.in.withReader {
    println  it.readLine()
}
