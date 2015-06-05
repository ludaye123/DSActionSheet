//
//  ViewController.m
//  DSActionSheetDemo
//
//  Created by LS on 6/5/15.
//  Copyright (c) 2015 LS. All rights reserved.
//

#import "ViewController.h"
#import "DSActionSheet.h"

@interface ViewController () <DSActionSheetDelegate>

@property (strong, nonatomic) UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.label];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    DSActionSheet *actionSheet = [[DSActionSheet alloc] initWithMessage:nil delegate:self cancelTitle:@"取消" otherTitles:@"哈哈",@"哈哈",@"哈哈", nil];
    
    [actionSheet show];
}

- (void)actionSheet:(DSActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%ld",buttonIndex);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UILabel *)label
{
    if(!_label)
    {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), 21.0)];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.center = self.view.center;
        _label.font= [UIFont systemFontOfSize:21.0];
        _label.text = @"点击任意位置，显示DSActionSheet";
    }
    
    return _label;
}

@end
