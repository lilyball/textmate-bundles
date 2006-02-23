#!/usr/bin/env python
# encoding: utf-8

import sys
import os
import getopt
import re

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
# TODO:  How to replace the original table list with a new one....

class Usage(Exception):
    def __init__(self, msg):
        self.msg = msg


def main(argv=None):
    if argv is None:
        argv = sys.argv
    # set up default values... This only matters for the table listing as 
    # everything we need to know is fully specified on the command line
    # for the column list.
    serverType = os.getenv('TM_DB_SERVER','postgresql')    
    dbHost = None
    dbPort = None
    dbName = None
    tblName = None
    dbUser = None
    passwd = None        
    try:
        try:
            opts, args = getopt.getopt(argv[1:], "hodtpsnu:v", ["host=", "output=", "database=", "table=", "server=", "passwd=", "user=", "port="])
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
            if option in ("-u", "--user"):  
                dbUser = value
            if option in ("-n", "--port"):  
                dbPort = value
    except Usage, err:
        print >> sys.stderr, sys.argv[0].split("/")[-1] + ": " + str(err.msg)
        print >> sys.stderr, "\t for help use --help"
        return 2

    # option parsing done, now handle any fallback values for parameters.
    osuser = os.getenv('USER')
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
    # listDatabases()
    
    if tblName == None:
        printScriptTag()
        listDatabases(dbHost,dbPort,serverType,passwd,dbUser)
        print '<div id="main">'
        print '<div id="tablist">'
        listTables(dbName,dbHost,dbPort,serverType,passwd,dbUser)
        print '</div>'
        print """<div id="debug"></div>"""
        print """<div id="result"></div>"""
        print """<div id="tablist"></div>"""
        print '</div>'
    elif tblName == '__none__':
        listTables(dbName,dbHost,dbPort,serverType,passwd,dbUser)
    else:
        listColumns(dbName,dbHost,dbPort,tblName,serverType,passwd,dbUser)


def listTables(dbName,dbHost,dbPort,serverType,passwd,dbUser):
    if serverType == 'postgresql':
        mycon = pgdb.connect(database=dbName,host=dbHost+':'+dbPort,user=dbUser)
        qstr = "select table_name from information_schema.tables where table_schema = 'public'"        
    else:
        mycon = MySQLdb.connect(db=dbName,host=dbHost,port=int(dbPort),user=dbUser,passwd=passwd)
        qstr = "show tables"
    curs = mycon.cursor()
    curs.execute(qstr)
    tList = curs.fetchall()
    formatTableList(dbName,dbHost,tList,serverType,passwd,dbUser,dbPort)

# TODO rewrite formatTableLilst to remove all the divs...    
def formatTableList(dbName,dbHost,tList,serverType,passwd,dbUser,dbPort):
    print "<h2>Tables in database: "+dbName+"</h2>"
    print "<ul class='tableList'>"
    for t in tList:
        tblLink = "<li><a href='javascript:tb(" +"%22" + dbName +"%22,%22" + t[0] + "%22,%22" + dbHost + "%22,%22" + serverType + "%22,%22" + passwd + "%22,%22" + dbUser + "%22,%22" + str(dbPort) + "%22)'>" + t[0] + "</a></li>"        
        print tblLink
    print "</ul><hr>"


def listColumns(dbName,dbHost,dbPort,tbl,serverType,passwd,dbUser):
    if tbl.find(".") >= 0:
        schema,tname = tbl.split('.')
    else:
        tname = tbl
    print "<h2>Columns in table: " + tbl + "</h2>"
    print "<table width='75%' class='graybox' cellspacing='0' cellpadding='5'>"
    print "<tr><th align='left'>Name</th><th align='left'>Type</th><th align='left'>Nullable</th><th align='left'>Default</th></tr>"
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
        curs = mycon.cursor()
        curs.execute(qstr)
        resList = curs.fetchall()    
        for row in resList:
            print "<tr><td>%s</td><td>%s</td><td>%s</td><td>%s</td></tr>"%(row[1],row[2],row[3],row[4])
    else:
        mycon = MySQLdb.connect(db=dbName,host=dbHost,port=int(dbPort),user=dbUser,passwd=passwd)
        qstr = "show columns in " + tname
        curs = mycon.cursor()
        curs.execute(qstr)
        resList = curs.fetchall()  
        for row in resList:
            print "<tr><td>%s</td><td>%s</td><td>%s</td><td>%s</td></tr>"%(row[0],row[1],row[2],row[4])
    print "</table>"  


def printScriptTag():
    path = os.getenv("TM_BUNDLE_SUPPORT")
    path = path + '/bin/tableBrowser.py'
    print """<script>
       function tb(db,tbl,hname,stype,pw,dbuser,dbport) {
          var cmd = "%s --database=" + db + " --table=" + tbl + " --host=" + hname + " --server=" + stype + " --passwd=" + pw + " --user=" + dbuser + " --port=" + dbport;
          cmd = cmd.replace(" ","\\\\ ")
          var res = TextMate.system(cmd, null).outputString;
          if(tbl == '__none__') {
             document.getElementById("tablist").innerHTML = res;
          } else {
             document.getElementById("result").innerHTML = res;
             }
          window.location.hash = "result";
       }
    </script>"""%(path)

def listDatabases(dbHost,dbPort,serverType,passwd,dbUser):
    print '<div id="dbbar">'
    if serverType == 'postgresql':
        dbList = os.popen('psql8 -l --host=' + dbHost + ' --port=' + dbPort + ' --user=' + dbUser + ' --html')
        i = dbList.readline()
        while i:
            if re.match('<table',i):
                print """<table class="graybox" cellspacing='0' cellpadding='5'> """
            elif re.search('rows\)',i):
                pass
            elif re.search('<tr valign',i):  # start of a row
                print i
                i = dbList.readline()
                x = re.match('\s+(<td align=.*?>)(.*?)(</td>)',i)
                dbLink = "<a href='javascript:tb(" +"%22" + x.group(2) +"%22,%22" + '__none__' + "%22,%22" + dbHost + "%22,%22" + serverType + "%22,%22" + passwd + "%22,%22" + dbUser + "%22,%22" + str(dbPort) + "%22)'>"
                print x.group(1) + dbLink + x.group(2) + "</a>" + x.group(3)
            else:
                print i
            i = dbList.readline()
    else:
        dbList = os.popen("mysql  -e 'show databases' --host=" + dbHost + " --port=" + str(dbPort) + " --user=" + dbUser + " --password="+passwd+" --xml")
        print """<table class="graybox" cellspacing='0' cellpadding='5'>"""
        for i in dbList:
            if re.search('<row>',i):
                print """<tr><td>"""
            elif re.search('</row>',i):
                print """</td></tr>"""
            elif re.search('<Database>',i):
                x = re.match('\s+(<Database>)(.*?)(</Database>)',i)
                dbLink = "<a href='javascript:tb(" +"%22" + x.group(2) +"%22,%22" + '__none__' + "%22,%22" + dbHost + "%22,%22" + serverType + "%22,%22" + passwd + "%22,%22" + dbUser + "%22,%22" + str(dbPort) + "%22)'>"
                print dbLink + x.group(2) + "</a>"
            else:
                pass
        print """</table>"""
    print '</div>'

#           <div id="debug"></div>
#          document.getElementById("debug").innerText = cmd;                    
#
if __name__ == "__main__":
    sys.exit(main())
