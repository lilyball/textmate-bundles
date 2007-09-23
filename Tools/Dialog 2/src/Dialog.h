#ifndef _DIALOG_H_
#define _DIALOG_H_

#ifndef enumerate
#define enumerate(container,var) for(NSEnumerator* _enumerator = [container objectEnumerator]; var = [_enumerator nextObject]; )
#endif

#ifndef iterate
#define iterate(v,c) for(typeof(c.begin()) v = (c.begin()), _end = (c.end()); v != _end; ++v)
#endif

#ifndef sizeofA
#define sizeofA(a) (sizeof(a)/sizeof(a[0]))
#endif

@protocol DialogServerProtocol
- (void)hello:(id)anArgument;
@end

#endif /* _DIALOG_H_ */
