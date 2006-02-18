#!/usr/bin/python
# encoding: utf-8

import sys
import os
import getopt
from pg import DB

help_message = '''
The help message goes here.
'''


class Usage(Exception):
    def __init__(self, msg):
        self.msg = msg


def main(argv=None):
    if argv is None:
        argv = sys.argv
    user = os.getenv('USER')
    dbName = os.getenv('PGDATABASE',user)
    tblName = None
    dbHost = os.getenv('PGHOST','localhost')
    try:
        try:
            opts, args = getopt.getopt(argv[1:], "hodt:v", ["help", "output=", "database=", "table="])
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
    except Usage, err:
        print >> sys.stderr, sys.argv[0].split("/")[-1] + ": " + str(err.msg)
        print >> sys.stderr, "\t for help use --help"
        return 2
    

    # option parsing done, now start browsing the database.
    if tblName == None:
        printScriptTag()
        listTables(dbName,dbHost)
    else:
        return listColumns(dbName,dbHost,tblName)


def listTables(dbName,dbHost):
    cnx = DB(dbName,host=dbHost)
    tList = cnx.get_tables()    # use the built in functionto get all tables.
    formatTableList(dbName,dbHost,tList)
    
def formatTableList(dbName,dbHost,tList,includeSys=False):
    print "<h2>Tables in database: "+dbName+"</h2>"
    print "<ul class='tableList'>"
    for t in tList:
        tblLink = "<li><a href='javascript:tb(" +"%22" + dbName +"%22,%22" + t + "%22,%22" + dbHost + "%22)'>" + t + "</a></li>"        
        if t.find("information_schema") == 0:
            if includeSys:
                print tblLink
        else:
            print tblLink
    print "</ul><hr>"
    print """<div id="result"></div>"""


def listColumns(db,dbhost,tbl):
    schema,tname = tbl.split('.')
    qstr = """select ordinal_position, column_name, data_type, is_nullable, column_default 
    from information_schema.columns 
    where table_name='%s'
    order by ordinal_position"""%(tname)
    cnx = DB(db,host=dbhost)
    cList = cnx.query(qstr)
    resList = cList.dictresult()
    print "<h2>Columns in table: " + tbl + "</h2>"
    print "<table width='75%'>"
    print "<tr><th align='left'>Name</th><th align='left'>Type</th><th align='left'>Nullable</th><th align='left'>Default</th></tr>"
    for row in resList:
        print "<tr><td>%s</td><td>%s</td><td>%s</td><td>%s</td></tr>"%(row['column_name'],row['data_type'],row['is_nullable'],row['column_default'])
    print "</table>"  

      
def printScriptTag():
    path = os.getenv("TM_BUNDLE_SUPPORT")
    path = path + '/bin/tableBrowser.py'
    print """<script>
       function tb(db,tbl,host) {
          var cmd = "%s --database=" + db + " --table=" + tbl;
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
