#import "GFEvent.h"

#import "NSDictionary+ObjectForKeyOrNil.h"

@interface GFEvent ()

// Private interface goes here.

@end


@implementation GFEvent

+ (GFEvent *)eventWithServerId:(NSInteger)serverId usingManagedObjectContext:(NSManagedObjectContext *)moc {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[GFEvent entityName]];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"serverId = %d", serverId]];
    [fetchRequest setFetchLimit:1];

    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:fetchRequest error:&error];
    if (error) {
        exit(1);
    }

    if ([results count] == 0) {
        return nil;
    }

    return [results objectAtIndex:0];
}

- (void)updateAttributes:(NSDictionary *)attributes {
    self.name = [attributes objectForKeyOrNil:@"title"];
    self.gratis = [NSNumber numberWithInt:[[attributes objectForKeyOrNil:@"gratis"] intValue]];
    self.prijs = [attributes objectForKeyOrNil:@"prijs"];
    self.prijs_vvk = [attributes objectForKeyOrNil:@"prijs_vvk"];
    self.omschrijving = [attributes objectForKeyOrNil:@"omsch"];
    self.datum = [attributes objectForKeyOrNil:@"datum"];
    self.periode = [attributes objectForKeyOrNil:@"periode"];
    self.startuur = [attributes objectForKeyOrNil:@"start"];
    self.sort = [NSNumber numberWithInt:[[attributes objectForKeyOrNil:@"sort"] intValue]];
    self.cat = [attributes objectForKeyOrNil:@"cat"];
    self.cat_id = [NSNumber numberWithInt:[[attributes objectForKeyOrNil:@"cat_id"] intValue]];
    self.url = [attributes objectForKeyOrNil:@"url"];
    self.loc = [attributes objectForKeyOrNil:@"loc"];
    self.loc_id = [NSNumber numberWithInt:[[attributes objectForKeyOrNil:@"loc_id"] intValue]];
    self.lat = [NSNumber numberWithInt:[[attributes objectForKeyOrNil:@"lat"] floatValue]];
    self.lon = [NSNumber numberWithInt:[[attributes objectForKeyOrNil:@"lon"] floatValue]];
    self.korting = [attributes objectForKeyOrNil:@"korting"];   
}


@end
