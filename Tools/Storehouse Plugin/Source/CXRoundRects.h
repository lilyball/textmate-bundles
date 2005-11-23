

@interface NSBezierPath (CXRoundRects)

+ (void) fillRoundRectInRect:(NSRect)rect radius:(float) radius;
+ (void) strokeRoundRectInRect:(NSRect)rect radius:(float) radius;
+ (NSBezierPath*)bezierPathWithRoundRectInRect:(NSRect)aRect radius:(float)radius;

@end
