//
//  ViewController.m
//  TotalKit
//
//  Created by kinjin on 16/3/18.
//  Copyright © 2016年 kinjin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
- (IBAction)threadCreateAction:(id)sender {
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(repeatAction:) userInfo:@{@"key":@"hello wolld"} repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
}
- (void)repeatAction:(NSTimer*)timer{
    NSLog(@"%@",timer.userInfo[@"key"]);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
