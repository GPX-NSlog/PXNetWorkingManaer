//
//  ViewController.m
//  PXNetWorkingManagerDemo
//
//  Created by VID on 16/9/29.
//  Copyright © 2016年 VID. All rights reserved.
//

#import "ViewController.h"
#import "PXNetWorkingManager.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(1);
    
    // 发送请求
    [PXNetWorkingManager getWithUrl:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(id responseObject) {
       
        self.textView.text = [NSString stringWithFormat:@"%@",responseObject];
        NSLog(@"%@",responseObject);
    } faliure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
