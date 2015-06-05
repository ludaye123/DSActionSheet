//
//  DSActionSheet.h
//  DSActionSheetDemo
//
//  Created by LS on 6/5/15.
//  Copyright (c) 2015 LS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DSActionSheetDelegate;

@interface DSActionSheet : UIView

@property (assign, nonatomic) id<DSActionSheetDelegate> delegate;

- (instancetype)initWithMessage:(NSString *)message delegate:(id<DSActionSheetDelegate>)delegate cancelTitle:(NSString *)title otherTitles:(NSString *)otherTitles,... NS_REQUIRES_NIL_TERMINATION;
- (void)show;

@end

@protocol DSActionSheetDelegate <NSObject>

@optional
- (void)actionSheet:(DSActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

@end