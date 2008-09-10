import com.foo.*;
import com.bar.*;  // comment
import com.baz.*;

  /** class foo */

public class Foo
{
	void bar(Object baz)
	{
		throw new RuntimeException(baz.toString() + "; void");
	}
}

public class Hello
{
	void method(Integer integer) {}
	void method(INTEGER integer) {}
	
	private static final int ID = 0;
    ID id = new ID();
    Id id = new Id();
    
}

class Foo // bar
{
}

class Foo /* bar */
{
}

interface Foo // bar
{
}

interface Foo /* bar */
{
}

class Foo
{
}

class Assertion 
{
    assert 1 = 1 : "Failure message";
    assert 1 = 1;
}