//
//  SpellingViewController.m
//  Hunspell for iOS
//
//  Created by Aaron Signorelli on 18/04/2012.
//  Copyright (c) 2012 Aaron Signorelli. All rights reserved.
//

#import "SpellingViewController.h"

@interface SpellingViewController ()

@end

@implementation SpellingViewController
@synthesize _textView, _spellCheck;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        spellChecker = [[SpellChecker alloc] init];
        textFieldDelegate = [[SpellCheckTextFieldDelegate alloc] init];
        textFieldDelegate.delegate = self;
        textFieldDelegate.spellChecker = spellChecker;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _inputBox.delegate = textFieldDelegate;
}

- (void)viewDidUnload
{
    [self set_textView:nil];
    [self set_spellCheck:nil];
    _wordField = nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark buttons

-(IBAction)switchToEnglish:(id)sender {
    [spellChecker updateLanguage:@"en_GB"];
}

-(IBAction)switchToIrish:(id)sender {
    [spellChecker updateLanguage:@"ga_IE"];
}

#pragma mark text field delegate

- (void)word:(NSString *)word isSpeltCorrectly:(BOOL)isCorrect{
    if(isCorrect){
        _spellCheck.text = @"Correct";
    }else {
        _spellCheck.text = @"incorrect";
    }
}

- (void)spellingSuggestions:(NSArray *)suggestions forWord:(NSString *) word{
    NSString *stringSugggestions = [suggestions componentsJoinedByString:@"\n"];
    _textView.text = stringSugggestions;
}


@end
