//
//  SuggestionBar.h
//  SuggestionBar
//
//  Created by Aaron Signorelli on 11/05/2012.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@protocol SuggestionBarDelegate <NSObject>

@optional
- (void) suggestionBar:(id)suggestionBar didSelectSuggestion:(NSString*) suggestion;

@end

@interface SuggestionBar : UIView {
    
    NSArray *_suggestions;
    NSMutableArray *_suggestionLabels;
    
}

@property (nonatomic, weak) id <SuggestionBarDelegate> delegate;

- (void) setSuggestions:(NSArray *) suggestions;

@end