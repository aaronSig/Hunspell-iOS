//
//  SpellingSuggestionDelegate.h
//  Hunspell
//
//  Created by Aaron Signorelli on 25/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SuggestionBar.h"
#import "SpellChecker.h"

@interface SpellingSuggestionDelegate : NSObject <SuggestionBarDelegate, UITextFieldDelegate> {
    
    SpellChecker *spellChecker;
    SuggestionBar *_bar;
    
    UIView *_correctionView;
    
    UITextField *_textField;
}

@property(nonatomic, retain) SpellChecker *spellChecker;

- (void)word:(NSString *)word isSpeltCorrectly:(BOOL)isCorrect;
- (void)spellingSuggestions:(NSArray *)suggestions forWord:(NSString *) word;
- (UITextRange *)findRangeOfWordBeingTyped;
- (NSString *)findWordBeingTyped;

@end
