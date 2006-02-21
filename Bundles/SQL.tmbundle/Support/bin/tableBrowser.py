#!/usr/bin/env python
# encoding: utf-8

import sys
import os
import getopt

# import the right driver based on the command line args. (default to postgres)
if '--server=postgresql' in sys.argv:
    try:
        import pgdb
    except:
        print "pgdb module is not installed"

if '--server=mysql' in sys.argv:
    try:    
        import MySQLdb
    except:
        print "MySQLdb module is not installed"

# TODO:  Add option to view (partial) table contents


class Usage(Exception):
    def __init__(self, msg):
        self.msg = msg


def main(argv=None):
    if argv is None:
        argv = sys.argv
    # set up default values... This only matters for the table listing as 
    # everything we need to know is fully specified on the command line
    # for the column list.
    serverType = None
    dbHost = None
    dbPort = None
    dbName = None
    tblName = None
    dbUser = None
    passwd = None        
    try:
        try:
            opts, args = getopt.getopt(argv[1:], "hodtps:v", ["host=", "output=", "database=", "table=", "server=", "passwd="])
        except getopt.error, msg:
            raise Usage(msg)
    
        # option processing
        for option, value in opts:
            if option == "-v":
                verbose = True
            if option in ("-h", "--host"):
                dbHost = value
            if option in ("-d", "--database"):
                dbName = value
            if option in ("-t", "--table"):
                tblName = value
            if option in ("-s", "--server"):
                serverType = value
            if option in ("-p", "--passwd"):  # useful only for mysql
                passwd = value
    except Usage, err:
        print >> sys.stderr, sys.argv[0].split("/")[-1] + ": " + str(err.msg)
        print >> sys.stderr, "\t for help use --help"
        return 2

    # option parsing done, now handle any fallback values for parameters.
    osuser = os.getenv('USER')
    serverType = os.getenv('TM_DB_SERVER','postgresql')
    if serverType == 'postgresql':
        if dbName == None:
            dbName = os.getenv('PGDATABASE',osuser)
        if dbHost == None:
            dbHost = os.getenv('PGHOST','localhost')
        if dbPort == None:
            dbPort = os.getenv('PGPORT','5432')
        if dbUser == None:
            dbUser = os.getenv('PGUSER',osuser)
        if passwd == None:
            passwd = ""  # postgres password must come from ~/.pgpass file
    elif serverType == 'mysql':
        if dbName == None:
            dbName = os.getenv('MYSQL_DB',osuser)
        if dbHost == None:
            dbHost = os.getenv('MYSQL_HOST','localhost')
        if dbPort == None:
            dbPort = int(os.getenv('MYSQL_PORT','3306'))
        if dbUser == None:
            dbUser = os.getenv('MYSQL_USER',osuser)
        if passwd == None:
            passwd = os.getenv('MYSQL_PWD',"")
    else:
        print "Error: Unsupport server type: ", serverType

    # option parsing done, now start browsing the database.
    if tblName == None:
        printScriptTag()
        listTables(dbName,dbHost,dbPort,serverType,passwd,dbUser)
    else:
        listColumns(dbName,dbHost,dbPort,tblName,serverType,passwd,dbUser)


def listTables(dbName,dbHost,dbPort,serverType,passwd,dbUser):
    if serverType == 'postgresql':
        mycon = pgdb.connect(database=dbName,host=dbHost+':'+dbPort,user=dbUser)
        qstr = "select table_name from information_schema.tables where table_schema = 'public'"        
    else:
        mycon = MySQLdb.connect(db=dbName,host=dbHost,port=dbPort,user=dbUser,passwd=passwd)
        qstr = "show tables"
    curs = mycon.cursor()
    curs.execute(qstr)
    tList = curs.fetchall()
    formatTableList(dbName,dbHost,tList,serverType,passwd)
    
def formatTableList(dbName,dbHost,tList,serverType,passwd):
    print "<h2>Tables in database: "+dbName+"</h2>"
    print "<ul class='tableList'>"
    for t in tList:
        tblLink = "<li><a href='javascript:tb(" +"%22" + dbName +"%22,%22" + t[0] + "%22,%22" + dbHost + "%22,%22" + serverType + "%22,%22" + passwd + "%22)'>" + t[0] + "</a></li>"        
        print tblLink
    print "</ul><hr>"
    print """<div id="debug"></div>"""
    print """<div id="result"></div>"""


def listColumns(dbName,dbHost,dbPort,tbl,serverType,passwd,dbUser):
    if tbl.find(".") >= 0:
        schema,tname = tbl.split('.')
    else:
        tname = tbl
    qstr = """select ordinal_position, column_name, data_type, is_nullable, column_default 
    from information_schema.columns 
    where table_name='%s'
    order by ordinal_position"""%(tname)
    #for mysql qstr = show columns in <<table>>
    if serverType == 'postgresql':
        mycon = pgdb.connect(database=dbName,host=dbHost+':'+dbPort,user=dbUser)
        qstr = """select ordinal_position, column_name, data_type, is_nullable, column_default 
    from information_schema.columns 
    where table_name='%s'
    order by ordinal_position"""%(tname)        
    else:
        mycon = MySQLdb.connect(db=dbName,host=dbHost,port=dbPort,user=dbUser,passwd=passwd)
        qstr = "show columns in " + tname
    curs = mycon.cursor()
    curs.execute(qstr)
    resList = curs.fetchall()    
    print "<h2>Columns in table: " + tbl + "</h2>"
    print "<table width='75%'>"
    print "<tr><th align='left'>Name</th><th align='left'>Type</th><th align='left'>Nullable</th><th align='left'>Default</th></tr>"
    for row in resList:
        print "<tr><td>%s</td><td>%s</td><td>%s</td><td>%s</td></tr>"%(row[1],row[2],row[3],row[4])
    print "</table>"  


def printScriptTag():
    path = os.getenv("TM_BUNDLE_SUPPORT")
    path = path + '/bin/tableBrowser.py'
    print """<script>
       function tb(db,tbl,hname,stype,pw) {
          var cmd = "%s --database=" + db + " --table=" + tbl + " --host=" + hname + " --server=" + stype + " --passwd=" + pw;
          cmd = cmd.replace(" ","\\\\ ")
          var res = TextMate.system(cmd, null).outputString;
          document.getElementById("result").innerHTML = res;
          window.location.hash = "result";
       }
    </script>"""%(path)

#           <div id="debug"></div>
#          document.getElementById("debug").innerText = cmd;                    
#
if __name__ == "__main__":
    sys.exit(main())

