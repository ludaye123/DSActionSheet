//
//  DSActionSheet.m
//  DSActionSheetDemo
//
//  Created by LS on 6/5/15.
//  Copyright (c) 2015 LS. All rights reserved.
//

#import "DSActionSheet.h"

#define kScreenOfWidth  CGRectGetWidth([[UIScreen mainScreen] bounds])
#define kScreenOfHeight CGRectGetHeight([[UIScreen mainScreen] bounds])
#define BUTTON_HEIGHT 44.0
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

#define NORMAL_BUTTON_BACKGOURND_IMAGE [self ds_drawImageWithColor:RGB(255.0, 255.0, 255.0)]
#define HIGH_BUTTON_BACKGOURND_IMAGE   [self ds_drawImageWithColor:RGB(242.0, 242.0, 242.0)]


@interface DSActionSheet ()
{
    NSInteger   _tag;
    NSInteger   _itemCount;
}

@property (strong, nonatomic) UIView *actionSheetView;

- (UIImage *)ds_drawImageWithColor:(UIColor *)color;

@end

@implementation DSActionSheet

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithMessage:(NSString *)message delegate:(id<DSActionSheetDelegate>)delegate cancelTitle:(NSString *)title otherTitles:(NSString *)otherTitles, ...
{
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if(self)
    {
        _tag = 1;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
        [self addGestureRecognizer:tapGestureRecognizer];
        
        self.delegate = delegate;
        NSString *titleStr;
        va_list list;
        if(otherTitles)
        {
            [self setupBtnWithTitle:otherTitles];
            va_start(list, otherTitles);
            while ((titleStr = va_arg(list, NSString*))) {
                _tag++;
                [self setupBtnWithTitle:titleStr];
            }
            va_end(list);
            
        }
        _itemCount = _tag;
        
        CGRect frame = self.actionSheetView.frame;
        frame.size.height = (_itemCount+1)*BUTTON_HEIGHT+(_itemCount-1)+8.0;
        self.actionSheetView.frame = frame;
        
        _tag = 0;
        [self setupBtnWithTitle:title];
        
    }
    
    return self;
}


- (UIView *)actionSheetView
{
    if(!_actionSheetView)
    {
        CGFloat height = (_itemCount+1)*BUTTON_HEIGHT+(_itemCount-1)+8.0;
        _actionSheetView = [[UIView alloc] initWithFrame:CGRectMake(0.0, kScreenOfHeight, CGRectGetWidth(self.bounds), height)];
        _actionSheetView.backgroundColor = [UIColor lightGrayColor];
    }
    
    return _actionSheetView;
}

- (void)setupBtnWithTitle:(NSString *)title
{
    UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat originY = _tag == 0? CGRectGetHeight(self.actionSheetView.frame)-BUTTON_HEIGHT : BUTTON_HEIGHT*(_tag-1)+(_tag-1)*1;
    tempBtn.frame = CGRectMake(0.0, originY, kScreenOfWidth, BUTTON_HEIGHT);
    [tempBtn setBackgroundImage:NORMAL_BUTTON_BACKGOURND_IMAGE forState:UIControlStateNormal];
    [tempBtn setBackgroundImage:HIGH_BUTTON_BACKGOURND_IMAGE forState:UIControlStateHighlighted];
    [tempBtn setTitle:title forState:UIControlStateNormal];
    [tempBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    tempBtn.tag = _tag;
    [tempBtn addTarget:self action:@selector(sendClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.actionSheetView addSubview:tempBtn];
}

- (void)show
{
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview:self];
    [self addSubview:self.actionSheetView];
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.actionSheetView.frame;
        frame.origin.y = kScreenOfHeight-CGRectGetHeight(frame);
        self.actionSheetView.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hide
{
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.actionSheetView.frame;
        frame.origin.y = kScreenOfHeight;
        self.actionSheetView.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - Action Event

- (void)singleTapAction:(UITapGestureRecognizer *)gestureRecognizer
{
    [self hide];
}

- (void)sendClickAction:(UIButton *)sender
{
    [self hide];
    if(self.delegate && [self.delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)])
    {
        [self.delegate actionSheet:self clickedButtonAtIndex:sender.tag];
    }
}

- (UIImage *)ds_drawImageWithColor:(UIColor *)color
{
    CGRect imageRect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(imageRect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, imageRect);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
