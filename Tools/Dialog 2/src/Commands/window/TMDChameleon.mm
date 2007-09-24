//
//  TMDChameleon.mm
//  Created by Allan Odgaard on 2007-06-26.
//

#import "TMDChameleon.h"
#import <objc/objc-runtime.h>

static NSMutableDictionary* DefaultValues = [NSMutableDictionary new];

static Class find_root (Class cl)
{
	while(cl->super_class)
		cl = cl->super_class;
	return cl;
}

@implementation TMDChameleon
- (id)init
{
	id res = [DefaultValues objectForKey:NSStringFromClass([self class])];
	return [self release], [res mutableCopy];
}

+ (BOOL)createSubclassNamed:(NSString*)aName withValues:(NSDictionary*)values
{
	[DefaultValues setObject:values forKey:aName];
	if(NSClassFromString(aName))
		return YES;

	Class super_cl       = [TMDChameleon class];

	Class sub_cl         = (Class)calloc(1, sizeof(objc_class));
	Class meta_cl        = (Class)calloc(1, sizeof(objc_class));

	sub_cl->name         = strdup([aName UTF8String]);
	sub_cl->info         = CLS_CLASS;
	sub_cl->isa          = meta_cl;
	sub_cl->super_class  = super_cl;
	sub_cl->methodLists  = (objc_method_list**)calloc(1, sizeof(objc_method_list*));

	meta_cl->name        = sub_cl->name;
	meta_cl->info        = CLS_META;
	meta_cl->isa         = find_root(super_cl)->isa;
	meta_cl->super_class = super_cl->isa;
	meta_cl->methodLists = (objc_method_list**)calloc(1, sizeof(objc_method_list*));

	objc_addClass(sub_cl); 

	return YES;
}
@end
