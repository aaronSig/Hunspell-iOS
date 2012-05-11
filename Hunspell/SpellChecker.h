//
//  SpellChecker.h
//  Hunspell
//
//  Created by Aaron Signorelli on 11/05/2012.
//

#import <Foundation/Foundation.h>

@interface SpellChecker : NSObject
{
	NSMutableString *currentLanguage;
}

- (id)init;
- (void) dealloc;
- (void)updateLanguage:(NSString *)language;
- (NSArray *) getSuggestionsForWord:(NSString *) word;
- (BOOL)isSpeltCorrectly:(NSString *) word;

@end

