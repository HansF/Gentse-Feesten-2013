#import "_GFEvent.h"

@interface GFEvent : _GFEvent {}

+ (GFEvent *)eventWithServerId:(NSInteger)serverId usingManagedObjectContext:(NSManagedObjectContext *)moc;

- (void)updateAttributes:(NSDictionary *)attributes;

@end
