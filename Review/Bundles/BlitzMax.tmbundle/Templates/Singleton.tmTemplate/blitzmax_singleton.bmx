Strict

Private

Global singleton_instance:Singleton

Public

Type Singleton
	
	Function Instance:Singleton()
		If singleton_instance = Null Then
			Return New Singleton
		EndIf
		Return singleton_instance
	End Function
	
	Method New()
		If singleton_instance Then Throw "Unable to create instance of singleton class"
		singleton_instance = Self
	End Method
	
	Method Delete()
	End Method
	
	Method Destroy()
		singleton_instance = Null
	End Method

End Type
