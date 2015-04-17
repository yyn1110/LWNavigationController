//
//  THTinderScrollView.m
//  Pods
//
//  Created by kuxing on 15/4/17.
//
//

#import "THTinderScrollView.h"
@interface THTinderScrollView ()<UIGestureRecognizerDelegate>

@end
@implementation THTinderScrollView
- (instancetype)init
{
	self = [super init];
	if (self) {
		self.panGestureRecognizer.delegate = self;
	}
	return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		self.panGestureRecognizer.delegate = self;
	}
	return self;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
	if ([gestureRecognizer.view isKindOfClass:[THTinderScrollView class]] && [otherGestureRecognizer.view isKindOfClass:[UITableView class]]) {
		return NO;
	}
	
	return YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
