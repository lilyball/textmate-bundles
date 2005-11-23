// Code from CocoaDev.

@implementation NSBezierPath (CXRoundRects)

+ (NSBezierPath*)bezierPathWithRoundRectInRect:(NSRect)aRect radius:(float)radius
{
   NSBezierPath* path = [self bezierPath];
   radius = MIN(radius, 0.5f * MIN(NSWidth(aRect), NSHeight(aRect)));
   NSRect rect = NSInsetRect(aRect, radius, radius);
   [path appendBezierPathWithArcWithCenter:NSMakePoint(NSMinX(rect), NSMinY(rect)) radius:radius startAngle:180.0 endAngle:270.0];
   [path appendBezierPathWithArcWithCenter:NSMakePoint(NSMaxX(rect), NSMinY(rect)) radius:radius startAngle:270.0 endAngle:360.0];
   [path appendBezierPathWithArcWithCenter:NSMakePoint(NSMaxX(rect), NSMaxY(rect)) radius:radius startAngle:  0.0 endAngle: 90.0];
   [path appendBezierPathWithArcWithCenter:NSMakePoint(NSMinX(rect), NSMaxY(rect)) radius:radius startAngle: 90.0 endAngle:180.0];
   [path closePath];
   return path;
}

+(void)		fillRoundRectInRect:(NSRect)rect radius:(float) radius
{
	NSBezierPath *   p = [self bezierPathWithRoundRectInRect: rect radius: radius];
	[p fill];
}

+(void)		strokeRoundRectInRect:(NSRect)rect radius:(float) radius
{
	NSBezierPath *   p = [self bezierPathWithRoundRectInRect: rect radius: radius];
	[p stroke];
}

@end
