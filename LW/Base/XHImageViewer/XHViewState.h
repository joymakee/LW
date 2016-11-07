

#import <UIKit/UIKit.h>

@interface XHViewState : UIView

@property (nonatomic, strong) UIView *superview;
@property (nonatomic, assign) CGRect frame;
@property (nonatomic, assign) BOOL userInteratctionEnabled;

+ (XHViewState *)viewStateForView:(UIView *)view;
- (void)setStateWithView:(UIView *)view;

@end
