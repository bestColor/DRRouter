//
//  TwoViewController.m
//  DRRouter_Example
//
//  Created by 李风 on 2020/3/3.
//  Copyright © 2020 3257468284@qq.com. All rights reserved.
//

#import "TwoViewController.h"

@interface TwoViewController ()
@property (nonatomic, copy)NSString *text;
@property (nonatomic, copy)NSString *textId;
@property (nonatomic, strong)UIImage *aa;
@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"text = %@, textId = %@",self.text,self.textId);
    
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 300, UIScreen.mainScreen.bounds.size.width, 300)];
    iv.image = self.aa;
    [self.view addSubview:iv];
    
    
    
}

- (void)abc:(NSString *)text {
    NSLog(@"执行了abc,带一个参数 - %@", text);
}

-  (void)abc {
    NSLog(@"执行了abc，不带参数");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
