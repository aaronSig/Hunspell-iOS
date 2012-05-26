//
//  SpellingViewController.h
//  Hunspell
//
//  Created by Aaron Signorelli on 18/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpellingSuggestionDelegate.h"

@interface SpellingViewController : UIViewController {
    SpellingSuggestionDelegate *_spellingDelegate;
    
    IBOutlet UILabel *_wordField;
    IBOutlet UITextField *_inputBox;    
}

@property (weak, nonatomic) IBOutlet UILabel *_textView;
@property (weak, nonatomic) IBOutlet UILabel *_spellCheck;

-(IBAction)switchToEnglish:(id)sender;
-(IBAction)switchToIrish:(id)sender;
-(IBAction)dropKeyboard:(id)sender;

@end
