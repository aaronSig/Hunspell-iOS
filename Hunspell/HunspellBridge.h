//
//  HunspellBridge.h
//  Hunspell
//
//  Created by Aaron Signorelli on 11/05/2012.
//

#import <Foundation/Foundation.h>

@interface HunspellBridge : NSObject

bool loadDictionary(const char *language);
void releaseDictionary();
bool isSpeltCorrectly(const char *word);
int  getSuggestions(const char *word, char ***suggestionListPtr);
void releaseSuggestions(int count, char ***suggestionListPtr);

@end
