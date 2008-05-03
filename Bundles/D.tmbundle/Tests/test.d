/**
 * @author    Rasmus Andersson
 * @copyright Copyright (c) 2008 Spotify Technology S.A.R.L. All rights reserved.
 * @version   $Rev$
 */
module untitled;
import tango.io.Stdout;
import tango.text.convert.Format;
import tango.util.log.Log, tango.util.log.Configurator;

protected static Logger log = null;
static this() {
  log = Log.getLogger(__FILE__);
  //log.setLevel(log.Level.Info);
}

private static final char[] NAME = "John Dong";

alias NAME name;

class MyClass : Log {
  protected int x = 0x3;
  this(lazy int d) {
    this.x = d;
  }
  ~this() {
    this.x = 0;
  }
  public synchronized void run() {
    Stdout("I'm running...").newline;
  }
}

void main() {
	Stdout(r"Hej på dig \n internets").newline;
	Stdout(`Hello`).newline;
	Stdout("hello " ~ "world" ~ \' ).newline;
	Stdout(name).newline;
	log.error("Hello");
	log.info(Format("Hello {}", NAME));
	debug {
    Stdout("this is from within debug { }").newline;
  }
  
  foreach_reverse(i,c; name) {
    Stdout.format("{}:{}, ", i, c);
  }
  Stdout.newline;
  
  auto mc = new MyClass(14);
  mc.run();
}
