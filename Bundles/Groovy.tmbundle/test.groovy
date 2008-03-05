println "Read Test"
print "Please enter something: "

System.in.withReader {
    println  it.readLine()
}
