#ifndef _DIALOG_H_
#define _DIALOG_H_

#define DialogServerConnectionName @"com.macromates.dialog"

@protocol DialogServerProtocol
- (void)connectFromClientWithOptions:(id)anArgument;
@end

#ifndef enumerate
#define enumerate(container,var) for(NSEnumerator* _enumerator = [container objectEnumerator]; var = [_enumerator nextObject]; )
#endif

inline char const* beginof (char const* cStr)								{ return cStr; }
inline char const* endof (char const* cStr)									{ return cStr + strlen(cStr); }
template <typename T, int N> T* beginof (T (&a)[N])						{ return a; }
template <typename T, int N> T* endof (T (&a)[N])							{ return a + N; }
template <typename T, int N, int M> T (*beginof(T (&m)[N][M]))[M]		{ return m; }
template <typename T, int N, int M> T (*endof(T (&m)[N][M]))[M]		{ return m + N; }
template <class T> typename T::const_iterator beginof (T const& c)	{ return c.begin(); }
template <class T> typename T::const_iterator endof (T const& c)		{ return c.end(); }
template <class T> typename T::iterator beginof (T& c)					{ return c.begin(); }
template <class T> typename T::iterator endof (T& c)						{ return c.end(); }

#ifndef foreach
#define foreach(v,f,l) for(typeof(f) v = (f), _end = (l); v != _end; ++v)
#endif

#ifndef iterate
#define iterate(v,c) foreach(v, beginof(c), endof(c))
#endif

#ifndef sizeofA
#define sizeofA(a) (sizeof(a)/sizeof(a[0]))
#endif


#define ErrorAndReturn(message) while(1){[proxy writeStringToError:@"Error: " message "\n"];return;};

#endif /* _DIALOG_H_ */
