//
//  SpellingViewController.h
//  Hunspell
//
//  Created by Aaron Signorelli on 18/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpellChecker.h"
#import "SpellCheckTextFieldDelegate.h"

@interface SpellingViewController : UIViewController <SpellCheckTextFieldDelegateDelegate> {
    SpellChecker *spellChecker;
    SpellCheckTextFieldDelegate *textFieldDelegate;

    IBOutlet UILabel *_wordField;
    IBOutlet UITextField *_inputBox;    
}

@property (weak, nonatomic) IBOutlet UILabel *_textView;
@property (weak, nonatomic) IBOutlet UILabel *_spellCheck;

-(IBAction)switchToEnglish:(id)sender;
-(IBAction)switchToIrish:(id)sender;

@end
