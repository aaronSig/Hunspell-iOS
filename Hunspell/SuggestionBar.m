//
//  SuggestionBar.m
//  SuggestionBar
//
//  Created by Aaron Signorelli on 11/05/2012.
//

#import "SuggestionBar.h"

@implementation SuggestionBar

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    frame.size.height = 40;
    frame.size.width = screenRect.size.width + 2;
    frame.origin.x = -1;
    frame.origin.y = screenRect.size.height;
    
    self = [super initWithFrame:frame];
    if (self) {
        _suggestionLabels = [[NSMutableArray alloc] init];        
        
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = self.bounds;
        
        UIColor *gradColour1 = [UIColor colorWithRed:241.0/255.0 green:241.0/255.0 blue:243.0/255 alpha:1];
        UIColor *gradColour2 = [UIColor colorWithRed:223.0/255.0 green:223.0/255.0 blue:231.0/255 alpha:1];
        gradient.colors = [NSArray arrayWithObjects:(id)[gradColour1 CGColor], (id)[gradColour2 CGColor], nil];

        UIColor *borderColour = [UIColor colorWithRed:173.0/255.0 green:173./255.0 blue:171.0/255 alpha:0.8];
        self.layer.borderColor = borderColour.CGColor;
        self.layer.borderWidth = 1.0f;
        
        [self.layer insertSublayer:gradient atIndex:0];
    }
    
    return self;
}

-(void) dealloc {
    _suggestionLabels = nil;
    _suggestions = nil;
    delegate = nil;
}

- (void) setSuggestions:(NSArray *) suggestions {
    _suggestions = suggestions;
    
    int i =0;
    for(i = 0; i < [_suggestions count] ; i++){
        NSString *suggestion = [_suggestions objectAtIndex:i];
        UILabel *label = (_suggestionLabels.count > i ? [_suggestionLabels objectAtIndex:i] : nil);
        UILabel *previousLabel = (_suggestionLabels.count > i - 1 ? [_suggestionLabels objectAtIndex:i - 1] : nil);
        
        if(label == nil){
            label = [[UILabel alloc] init];
            label.backgroundColor = [UIColor clearColor];
            [label setFont:[UIFont systemFontOfSize:20]];
            label.layer.borderColor = [UIColor colorWithRed:173.0/255.0 green:173./255.0 blue:171.0/255 alpha:0.9].CGColor;
            label.layer.borderWidth = 1.0f;
            label.textAlignment = UITextAlignmentCenter;
            label.userInteractionEnabled = YES;
            UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
            [label addGestureRecognizer:tapGesture];            
            [_suggestionLabels addObject:label]; 
        }

        [self addSubview:label];
        label.text = suggestion;
        [label sizeToFit];

        CGRect frame = label.frame;
        if(previousLabel){
            CGRect previousFrame = previousLabel.frame;            
            frame.origin.x = previousFrame.origin.x + previousFrame.size.width;
            
            if(frame.origin.x + frame.size.width > self.frame.size.width){
                //don't draw suggestions off the screen
                [label removeFromSuperview];
            }
        }else {
            frame.origin.x = 0;
        }
        
        frame.size.height = 40;
        frame.size.width += 20;
        frame.origin.x -= 1;
        label.frame = frame;
    }
    
    if (i < [_suggestionLabels count]) {
        int count = [_suggestionLabels count];
        for(int j = i; j < count; j++){
            UILabel *label = [_suggestionLabels objectAtIndex:i];
            [label removeFromSuperview];
            [_suggestionLabels removeObject:label];
            label = nil;
        }
    }

}

- (void)handleTap:(UITapGestureRecognizer *)sender {     
    if (sender.state == UIGestureRecognizerStateEnded) {        
        CGPoint loc = [sender locationInView:self];
        UILabel* label = (UILabel *)[self hitTest:loc withEvent:nil];
        NSLog(@"Suggestion tapped: %@", label.text);
        
        [self setSuggestions:[NSArray array]];
        
        if([delegate respondsToSelector:@selector(suggestionBar:didSelectSuggestion:)]){
            [delegate suggestionBar:self didSelectSuggestion:label.text];
        }
    } 
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
