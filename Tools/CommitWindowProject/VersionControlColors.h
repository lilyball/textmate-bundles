
#define RGB8ComponentTransform(component) ((component) == 0 ? 0.0 : 1.0/(255.0/(component)))

#define OneShotNSColorFromTriplet(accessorName,r,g,b) \
static inline NSColor * accessorName(void)\
{\
	static NSColor *	color = nil;\
	\
	if(color == nil)\
	{\
		color = [[NSColor colorWithDeviceRed:RGB8ComponentTransform(r)\
									green:RGB8ComponentTransform(g)\
									blue:RGB8ComponentTransform(b)\
									alpha:1.0] retain];\
	}\
\
	return color;\
}

OneShotNSColorFromTriplet(ForeColorForFileAdded,		0x00, 0xAA, 0x00)
OneShotNSColorFromTriplet(BackColorForFileAdded,		0xBB, 0xFF, 0xB3)

OneShotNSColorFromTriplet(ForeColorForFileModified,		0xEB, 0x64, 0x00)
OneShotNSColorFromTriplet(BackColorForFileModified,		0xF7, 0xE1, 0xAD)

OneShotNSColorFromTriplet(ForeColorForFileDeleted,		0xFF, 0x00, 0x00)
OneShotNSColorFromTriplet(BackColorForFileDeleted,		0xF5, 0xBD, 0xBD)

OneShotNSColorFromTriplet(ForeColorForFileConflict,		0x00, 0x80, 0x80)
OneShotNSColorFromTriplet(BackColorForFileConflict,		0xA3, 0xCE, 0xD0)

OneShotNSColorFromTriplet(ForeColorForFileIgnore,		0x80, 0x00, 0x80)
OneShotNSColorFromTriplet(BackColorForFileIgnore,		0xED, 0xAE, 0xF5)

OneShotNSColorFromTriplet(ForeColorForExternal,			0xFF, 0xFF, 0xFF)
OneShotNSColorFromTriplet(BackColorForExternal,			0x00, 0x00, 0x00)


static inline void ColorsFromStatus( NSString * status, NSColor ** foreColor, NSColor ** backColor )
{
	if([status isEqualToString:@"M"])
	{
		*foreColor = ForeColorForFileModified();
		*backColor = BackColorForFileModified();
	}
	else if([status isEqualToString:@"X"])
	{
		*foreColor = ForeColorForExternal();
		*backColor = BackColorForExternal();
	}
	else if([status isEqualToString:@"A"])
	{
		*foreColor = ForeColorForFileAdded();
		*backColor = BackColorForFileAdded();
	}
	else if([status isEqualToString:@"D"]
		|| [status isEqualToString:@"R"])
	{
		*foreColor = ForeColorForFileDeleted();
		*backColor = BackColorForFileDeleted();
	}
	else
	{
		*foreColor = [NSColor controlTextColor];
		*backColor = [NSColor controlBackgroundColor];
	}
}
