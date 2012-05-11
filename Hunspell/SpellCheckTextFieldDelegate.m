//
//  SpellCheckTextFieldDelegate.m
//  Hunspell
//
//  Created by Aaron Signorelli on 11/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SpellCheckTextFieldDelegate.h"

@implementation SpellCheckTextFieldDelegate

@synthesize spellChecker, delegate;

dispatch_queue_t suggestionsQueue;

-(id) init{
    self = [super init];
    if(self){
        suggestionsQueue = dispatch_queue_create("spelling suggestions queue", NULL);
    }
    return self;
}

-(void) dealloc {
    self.spellChecker = nil;
    self.delegate = nil;
    dispatch_release(suggestionsQueue);
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(!spellChecker){
        NSLog(@"Please supply the SpellCheckTextFieldDelegate with an instance of a SpellChecker.");
    }
    
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSString *word = newString; //TODO isolate the word being edited here
    
    if([delegate respondsToSelector:@selector(word:isSpeltCorrectly:)]){
        [delegate word: word isSpeltCorrectly: [spellChecker isSpeltCorrectly:word]];
    }
    
    if(newString.length < textField.text.length){
        return YES;
    }
    
    dispatch_async(suggestionsQueue, ^{
        if(newString.length > 0){
            NSArray *suggestions = [spellChecker getSuggestionsForWord:newString];            
            dispatch_async(dispatch_get_main_queue(), ^{
                if([delegate respondsToSelector:@selector(spellingSuggestions:forWord:)]){
                    [delegate spellingSuggestions:suggestions forWord:word];
                }
            });
        }
    });
    
    return YES;
}

@end
