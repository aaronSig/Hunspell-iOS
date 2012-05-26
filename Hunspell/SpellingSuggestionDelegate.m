//
//  SpellingSuggestionDelegate.m
//  Hunspell
//
//  Created by Aaron Signorelli on 25/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SpellingSuggestionDelegate.h"

@implementation SpellingSuggestionDelegate

@synthesize spellChecker;

dispatch_queue_t suggestionsQueue;

-(id) init{
    self = [super init];
    if(self){
        suggestionsQueue = dispatch_queue_create("spelling suggestions queue", NULL);

        _bar = [[SuggestionBar alloc] init];
        _bar.delegate = self;
        
        self.spellChecker = [[SpellChecker alloc] init]; 
    }

    return self;
}

-(void) dealloc {    
    self.spellChecker = nil;
    _bar = nil;
    dispatch_release(suggestionsQueue);
}

#pragma mark suggestion bar positioning

-(void) keyboardUp: (NSNotification *) notification {
    [[[UIApplication sharedApplication] keyWindow] addSubview:_bar];
    [self keyboardStateChange: notification];
}

-(void) keyboardDown: (NSNotification *) notification {
    [self keyboardStateChange: notification];
    [_bar removeFromSuperview];
}

-(void) keyboardStateChange: (NSNotification *) notification
{
    NSDictionary* info = [notification userInfo];
    CGRect frameStart = [[info objectForKey: UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect frameEnd = [[info objectForKey: UIKeyboardFrameEndUserInfoKey] CGRectValue];
 
    [UIView beginAnimations:@"slide in suggestion bar" context:nil];

    CGRect barFrame = _bar.frame;
    barFrame.origin.y = frameEnd.origin.y - (frameStart.origin.y < frameEnd.origin.y ? 0 : _bar.frame.size.height);
    _bar.frame = barFrame;    
    [UIView commitAnimations];
}

#pragma mark text field delegate

-(BOOL) textFieldShouldBeginEditing:(UITextField *)textField {
    _textField = textField;
    _textField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDown:)
                                                 name: UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(keyboardUp:)
                                                 name: UIKeyboardWillShowNotification object:nil];
    return YES;
}

-(void) textFieldDidEndEditing:(UITextField *)textField {
    _textField = nil;
    [_bar setSuggestions:[NSArray array]];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(!spellChecker){
        [NSException raise:@"No SpellChecker present" format:@"Please supply the SpellingSuggestionDelegate with an instance of a SpellChecker."];
    }
    
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
    if(newString.length < 1){
        [self spellingSuggestions:[NSArray array] forWord:@""];
        return YES;    
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *word = [self findWordBeingTyped];
        [self word: word isSpeltCorrectly: [spellChecker isSpeltCorrectly:word]];
        dispatch_async(suggestionsQueue, ^{
            NSArray *suggestions = [spellChecker getSuggestionsForWord:word];            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self spellingSuggestions:suggestions forWord:word];
            });
        });
    });
    
    return YES;
}

- (void)word:(NSString *)word isSpeltCorrectly:(BOOL)isCorrect{
    UITextRange *wordRange = [self findRangeOfWordBeingTyped];
    CGRect frame = [_textField firstRectForRange: wordRange];
    
    if(!_correctionView){
        _correctionView = [[UIView alloc] initWithFrame:frame];
    }
    
    _correctionView.frame = frame;
    
    _correctionView.alpha = 0.2;
    
    if(isCorrect){
        _correctionView.backgroundColor = [UIColor greenColor];
    }else {
        _correctionView.backgroundColor = [UIColor redColor];
    }
    
    [_textField.textInputView addSubview:_correctionView];
}

- (void)spellingSuggestions:(NSArray *)suggestions forWord:(NSString *) word{
    [_bar setSuggestions: suggestions];
}

#pragma mark SuggestionBarDelegate methods

-(void) suggestionBar:(id)suggestionBar didSelectSuggestion:(NSString *)suggestion {
    NSString *existingText = _textField.text;
    if(existingText.length == 0){
        return;
    }
    
    UITextRange *wordRange = [self findRangeOfWordBeingTyped];
    if(!wordRange){
        return;
    }

    int end = [_textField offsetFromPosition:_textField.beginningOfDocument 
                                    toPosition:wordRange.end];
    
    //Add a space if there isn't one already
    if(existingText.length == end || existingText.length < end ){
        suggestion = [suggestion stringByAppendingString:@" "];
    }else if(existingText.length > end &&  ![[_textField.text substringWithRange:NSMakeRange(end, 1)] isEqualToString:@" "]){
        suggestion = [suggestion stringByAppendingString:@" "];
    }
    
    
    [_textField replaceRange:wordRange withText:suggestion];
    [self word:suggestion isSpeltCorrectly:YES];
}

- (NSString *)findWordBeingTyped {
    UITextRange *wordRange = [self findRangeOfWordBeingTyped];
    NSString *word = [_textField textInRange:wordRange];
    return (word == nil ? @"" : word);
}

- (UITextRange *)findRangeOfWordBeingTyped {
    
    UITextRange *selectedRange = [_textField selectedTextRange];
    
    id<UITextInputTokenizer> tokenizer = _textField.tokenizer;
    
    UITextRange *wordRange;
    if([tokenizer isPosition:selectedRange.start withinTextUnit:UITextGranularityWord inDirection:UITextWritingDirectionNatural]){
        wordRange = [tokenizer rangeEnclosingPosition:selectedRange.start 
                                      withGranularity:UITextGranularityWord 
                                          inDirection:UITextWritingDirectionNatural];
    }else{
        wordRange = [tokenizer rangeEnclosingPosition:selectedRange.start 
                                      withGranularity:UITextGranularityWord 
                                          inDirection:UITextWritingDirectionLeftToRight];  
    }

    return wordRange;
}



@end
