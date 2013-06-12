//
//  BSAboutViewController_iphone.m
//  qnssy
//
//  Created by jpm on 13-4-21.
//  Copyright (c) 2013年 jpm. All rights reserved.
//

#import "BSPasswordViewController_iPhone.h"

#import "AmendPasswordRequestVo.h"
#import "AmendPasswordResponseVo.h"

#import "AboutTableCell_iPhone.h"

@interface BSPasswordViewController_iPhone (){
    MBProgressHUD *progressHUD;
}

@end

@implementation BSPasswordViewController_iPhone

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"修改密码";
    
    //初始化加载框
    [self initHUDView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_oldPasswordText release];
    [_passwordTextNew release];
    [_changePasswordButton release];
    [_passwordTextNew1 release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setOldPasswordText:nil];
    [self setPasswordTextNew:nil];
    [self setChangePasswordButton:nil];
    [self setPasswordTextNew1:nil];
    [super viewDidUnload];
}

- (void)initHUDView{
    //-------加载框
    progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    
    [self.view addSubview:progressHUD];
    
    progressHUD.labelText = @"数据加载中...";
    
}
- (void)loadServiceData{
    [progressHUD show:YES];
    AmendPasswordRequestVo *vo = [[AmendPasswordRequestVo alloc] initWithNewPassord:self.passwordTextNew.text oldPassword:self.oldPasswordText.text];
    [[BSContainer instance].serviceAgent callServletWithObject:self
                                                   requestDict:vo.mReqDic
                                                        target:self
                                               successCallBack:@selector(requestSucceess:data:)
                                                  failCallBack:@selector(requestFailed:data:)];
    
    [vo release];
}
#pragma mark - 回调方法

- (void)requestSucceess:(id)sender data:(NSDictionary *)dic {
    
    AmendPasswordResponseVo *vo = [[AmendPasswordResponseVo alloc] initWithDic:dic];
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:vo.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    
    [progressHUD hide:YES];
    
    [vo release];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    [app.loginNav popToRootViewControllerAnimated:NO];
    app.window.rootViewController = app.loginNav;
    [BSContainer instance].userInfo = nil;

    
}


- (void)requestFailed:(id)sender data:(NSDictionary *)dic {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"网络异常，请检查网络连接后重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    [progressHUD hide:YES];
}



- (IBAction)clickChangeButton:(id)sender {
    NSString *message = @"";
    if ([self.oldPasswordText.text isEqualToString: @""]) {
        message = @"请输入旧密码";
        [self.oldPasswordText becomeFirstResponder];

    }else if([self.passwordTextNew.text isEqualToString:@""]){
        message = @"请输入新密码";
        [self.passwordTextNew becomeFirstResponder];

    }else if(![self.passwordTextNew.text isEqualToString:self.passwordTextNew1.text]){
        message = @"两次输入密码不一致，请重新输入";
        [self.passwordTextNew becomeFirstResponder];

        
    }else{
        [self loadServiceData];
        return;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:message message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    
    
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField == self.oldPasswordText) {
        [self.passwordTextNew becomeFirstResponder];
    }else if(textField == self.passwordTextNew){
        [self clickChangeButton:nil];
    }
    
    
    return YES;
}
@end
