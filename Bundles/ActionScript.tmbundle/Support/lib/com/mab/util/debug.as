/*
 Class: com.mab.util.debug

 Description:
 Debug without the Flash IDE.

 Usage:
 >import com.mab.util.debug;
 >debug.setColor(0x0000FF);
 >debug.trace("Hello World!");
 >debug.clear();

 Version:
 2.0

 Author:
 Michael Bianco, http://developer.mabwebdesign.com/
 
 Date:
 06/01/05
*/
class com.mab.util.debug {
	/** Properties
	 Property: txtRef
	 Reference to the text field used for displaying trace()'s
	 
	 Property: count
	 How many trace() calls have been made, used for determining when to call clear()
	 
 	 Property: maxResults
	 The max amount of lines that will fit on the screen
	  
	 Variable: socket
	 If initSocket() was called, socket represents the XMLSocket connection to a 'trace server'
	 
	 Variable: connected
	 Bool representing if the socket is currently connected to a 'trace server'
	 
	 Variable: useMtascMethodTrace
	 Bool. If it is true the MTASC method trace string is prepended to str
	 
	 Variable: useMtascFileTrace
	 Bool. When true prepends MTASC's file data (file name and line #) to the trace str
	 
	 Variable: waitForSocketConnection
	 Bool. When true and you are trying to connect to a scoket
	 
	 Variable: disableTracing
	 Bool. When true the debug.trace() funtion will not trace any data
	**/
	static private var txtRef:TextField;
	static private var count:Number = 0;
	static private var maxResults:Number;
	static private var socket:XMLSocket;
	static private var msgStack:Array;
	
	static public var connected:Boolean = false;
	static public var useMtascMethodTrace:Boolean = true;
	static public var useMtascFileTrace:Boolean = true;
	static public var waitForSocketConnection:Boolean = true;
	static public var disableTracing:Boolean = false;
	static public var self:debug;
	
	/** function: trace
	Send output to the debug text field

	Parameters:
		str - a string to send to the debugger text field
	**/
	static function trace(str):Void {
		if(!self){
			self = new debug();
		}

		if(disableTracing) return;
		
		initDebugField();
		
		if(arguments.length > 1 && (useMtascMethodTrace || useMtascFileTrace)) {
			if(useMtascMethodTrace && useMtascFileTrace) {
				str = "[" + arguments[2] + ":" + arguments[3] + " - " + arguments[1] + "()] " + str;
			} else if(useMtascMethodTrace) {
				str = "[" + arguments[1] + "] " + str;
			} else if(useMtascFileTrace) {
				str = "[" + arguments[2] + ":" + arguments[3] + "] " + str;
			}
		}
		
		str += "\n"; //add the newline to end of the str
		
		if(socket && connected) {//we have a socket server connection!
			socket.send(str);
			return;
		} else if(socket && waitForSocketConnection) {
			if(!msgStack) {
				msgStack = new Array();
			}
			msgStack.push(str);
			return; //make sure this message doesn't do anywhere but the msg stack
		}
		
		if(count >= maxResults) {
			debug.clear();
			count = 0;
		}
		
		txtRef.text += str;
		//count += str.toString().countOf("\n") + 1;
		count++; //comment the above line and uncomment this line if you dont want to have to use the string additions
	}

	function debug() {
		waitForSocketConnection = true;
		initSocket("127.0.0.1");
	}

	public static function dumpObject(ob:Object) {
		var str = "{\n";
		
		for(var i in ob) {
			str += i+":"+ob[i]+"\n";
		}
		
		debug.trace(str+="}");
	}

	/** function: initDebugField
	creates & inializes the debug text field 
	**/
	static function initDebugField(Void):Void {
		if(txtRef) return;
		
		//formatting
		var format = new TextFormat();
		format.size = 17;
		
		_root.createTextField("__traceTextField", 10000, 0, 0, Stage.width, Stage.height);
		txtRef = _root.__traceTextField;
		txtRef.setNewTextFormat(format);
		txtRef.selectable = false;
		maxResults = Math.floor(Stage.height/format.size);
	}

	/** function: setColor
	sets the color of the text in the debug field

	Parameters:

		c - The color to set the textfield to
	**/
	static function setColor(c):Void {
		debug.initDebugField();
		var format = new TextFormat();
		format.color = c;
		
		//apply the formatting
		txtRef.setTextFormat(format);
		txtRef.setNewTextFormat(format);
	}

	/** function: clear
	clears the text that is currently in the text field
	**/
	static public function clear(Void):Void {
		txtRef.text = "";
	}

	/** function: initSocket
	Initalizes a socket connection to send trace() input to.
	If the connection succeeds all output is sent to the socket server instead of the textfield

	Parameters:
		h - String specifing a specific host to connect to. If this argument is not specified "localhost" is used
		p - Number specifing the port to connect to on the host. If this argument is not specified ----

	Returns:
		Boolean;
	Return value from XMLSocket.connect, if this function returns true it actually doesn't mean you've successfully connected with the server
	**/
	static public function initSocket(h, p):Boolean {
		socket = new XMLSocket();
		
		socket.onConnect = function(success:Boolean) {
			if(success) {
				//trace("Successfull connection to socket server!");
			} else {
				//trace("Connection to server failed!");
				com.mab.util.debug.socket = null; //set the socket to null
			}
			
			com.mab.util.debug.connected = success;
			
			com.mab.util.debug._clearMsgStack(); //clear the message stack
		}
		
		socket.onClose = function() {
			trace("Connection lost");
			com.mab.util.debug.connected = false;
		}
		
		return socket.connect(h ? h : "localhost", p ? p : 9994);
	}

	/** function: _clearMsgStack
	Clears the msgStack if there is one. This is called from the sockets onConnect event, and should not be called anywhere else.
	**/
	static public function _clearMsgStack(Void):Void {
		if(socket && connected && waitForSocketConnection && msgStack) {//if we have a message stack and we have a successfull connection to the server
			while(msgStack.length) {
				socket.send(msgStack.shift());
			}
			
			msgStack = null;
		} else if(!socket && !connected && waitForSocketConnection && msgStack) {//if we have a message stack but no successful connection
			while(msgStack.length) {
				trace(msgStack.shift());
			}
			
			msgStack = null;
		}
	}
}