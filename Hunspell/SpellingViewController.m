//
//  SpellingViewController.m
//  Hunspell for iOS
//
//  Created by Aaron Signorelli on 18/04/2012.
//  Copyright (c) 2012 Aaron Signorelli. All rights reserved.
//

#import "SpellingViewController.h"
#import "SpellingSuggestionDelegate.h"

@interface SpellingViewController ()

@end

@implementation SpellingViewController
@synthesize _textView, _spellCheck;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    _spellingDelegate = [[SpellingSuggestionDelegate alloc] init];
    _inputBox.delegate = _spellingDelegate;

    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [self set_textView:nil];
    [self set_spellCheck:nil];
    _wordField = nil;
    _spellingDelegate = nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark buttons

// note that dictionaries are loaded on top of each other. Loading en_GB and ga_IE will load both into memory

-(IBAction)switchToEnglish:(id)sender {
    [_spellingDelegate.spellChecker updateLanguage:@"en_GB"];
    _inputBox.enabled = YES;
}

-(IBAction)switchToIrish:(id)sender {
    [_spellingDelegate.spellChecker updateLanguage:@"ga_IE"];
    _inputBox.enabled = YES;
}

-(IBAction)dropKeyboard:(id)sender {
    [_inputBox resignFirstResponder]; 
}

@end
