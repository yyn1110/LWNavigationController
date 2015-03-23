//
//  THTinderNavigationBar.m
//  THTinderNavigationControllerExample
//
//  Created by Tanguy Hélesbeux on 11/10/2014.
//  Copyright (c) 2014 Tanguy Hélesbeux. All rights reserved.
//

#import "THTinderNavigationBar.h"

#define kXHiPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

#define kXHLabelBaseTag 1000


#define WIDTH           self.bounds.size.width
#define WIDTH_MID       WIDTH/2.0
#define IMAGESIZE       40
#define MARGIN_LEFT     (WIDTH-IMAGESIZE)/2.0 //145
#define Y_POSITION      23
#define X_PADDING       10
#define STEP            (MARGIN_LEFT-X_PADDING) //130
#define SPEED           (WIDTH/(float)STEP)

#define C_MARGIN_LEFT   (WIDTH/2.0)
#define C_POSITION      (Y_POSITION+IMAGESIZE/2.0)

@interface THTinderNavigationBar ()

@end

@implementation THTinderNavigationBar

#pragma mark - DataSource

- (void)reloadData
{
    if (!self.itemViews.count)
    {
        return;
    }
    
    [self.itemViews enumerateObjectsUsingBlock:^(UIView<THTinderNavigationBarItem> *itemView, NSUInteger idx, BOOL *stop) {
        CGRect itemViewFrame = CGRectMake(MARGIN_LEFT + (idx * (kXHiPad ? 240 : STEP)), Y_POSITION, IMAGESIZE, IMAGESIZE);
        itemView.hidden = NO;
        itemView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        itemView.frame = itemViewFrame;
        
        itemView.center = CGPointMake(C_MARGIN_LEFT + (idx * (kXHiPad ? 240 : STEP)), C_POSITION);
        
        if (self.currentPage == idx)
        {
            itemView.center = CGPointMake(C_MARGIN_LEFT + (idx * (kXHiPad ? 240 : STEP))-itemView.titleOffset, C_POSITION);
            [itemView updateViewWithRatio:1.0];
        } else
        {
            [itemView updateViewWithRatio:0.0];
        }
        
    }];
}

- (void)tapGestureHandle:(UITapGestureRecognizer *)tapGesture
{
    NSInteger pageIndex = [self.itemViews indexOfObject:tapGesture.view];
    [self.navigationController setCurrentPage:pageIndex animated:YES];
}

#pragma mark - Propertys

- (void)setContentOffset:(CGPoint)contentOffset
{
    _contentOffset = contentOffset;
    
    CGFloat xOffset = contentOffset.x;
    
    CGFloat normalWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    
    NSInteger currentIndex = xOffset/normalWidth;
    
    [self.itemViews enumerateObjectsUsingBlock:^(UIView<THTinderNavigationBarItem> *itemView, NSUInteger idx, BOOL *stop) {

        
        CGFloat ratio;
        
        if(xOffset < normalWidth * idx)
        {
            ratio = (xOffset - normalWidth * (idx - 1)) / normalWidth;
            
        }else
        {
            ratio = 1 - ((xOffset - normalWidth * idx) / normalWidth);
        }
        
        if (idx == currentIndex || idx == currentIndex+1)
        {
            itemView.center = CGPointMake(C_MARGIN_LEFT + idx * (kXHiPad ? 240 : STEP) - xOffset / SPEED - itemView.titleOffset/2.0 * ratio, C_POSITION);
        } else
        {
            itemView.center = CGPointMake(C_MARGIN_LEFT + idx * (kXHiPad ? 240 : STEP) - xOffset / SPEED, C_POSITION);
        }
        
        [itemView updateViewWithRatio:ratio];
    }];
}

- (void)setItemViews:(NSArray *)itemViews
{
    if (itemViews) {
        
        [self.itemViews enumerateObjectsUsingBlock:^(UIView<THTinderNavigationBarItem> *itemView, NSUInteger idx, BOOL *stop) {
            [itemView removeFromSuperview];
        }];
        
        [itemViews enumerateObjectsUsingBlock:^(UIView<THTinderNavigationBarItem> *itemView, NSUInteger idx, BOOL *stop) {
            itemView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureHandle:)];
            [itemView addGestureRecognizer:tapGesture];
            [self addSubview:itemView];
            [self addSubview:itemView.exView];
        }];
    }
    
    _itemViews = itemViews;
}

#pragma mark - Life Cycle

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

- (void)dealloc {
    self.itemViews = nil;
}

@end


// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
