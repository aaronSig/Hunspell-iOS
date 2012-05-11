//
//  SpellCheckTextFieldDelegate.h
//  Hunspell
//
//  Created by Aaron Signorelli on 11/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SpellChecker.h"

@protocol SpellCheckTextFieldDelegateDelegate <NSObject>

@optional
- (void)word:(NSString *)word isSpeltCorrectly:(BOOL)isCorrect; 
- (void)spellingSuggestions:(NSArray *)suggestions forWord:(NSString *) word;
@end

// --------------------------------------------------------------------

@interface SpellCheckTextFieldDelegate : NSObject<UITextFieldDelegate> {
    SpellChecker *spellChecker;
    id<SpellCheckTextFieldDelegateDelegate> delegate;
}

@property(nonatomic, retain) SpellChecker *spellChecker;
@property(nonatomic, retain) id<SpellCheckTextFieldDelegateDelegate> delegate;

@end




