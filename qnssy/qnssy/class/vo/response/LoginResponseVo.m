//
//  ZSKSearchResponseVo.m
//  BSMobileSale
//
//  Created by jpm on 12-11-2.
//
//

#import "LoginResponseVo.h"

@implementation LoginResponseVo

- (id)initWithDic:(NSDictionary *)result{
    self = [super init];
    if (self) {
        
        int status = [[result objectForKey:@"status"] intValue];
        //网络数据获取成功
        if (status == 0) {
            NSDictionary *data = [result objectForKey:@"data"];
            int resCode = [[data objectForKey:@"ResCode"] intValue];
            //服务器返回数据正确
            if (resCode == 0) {
                self.userInfo = [[[UserInfo alloc] init] autorelease];
                NSDictionary *ResData = [data objectForKey:@"ResData"];
                self.message = [ResData objectForKey:@"Message"];
                self.userInfo.userId = [ResData objectForKey:@"userid"];
                self.userInfo.vipLevel = [ResData objectForKey:@"vipLevel"];
                self.userInfo.nickName = [ResData objectForKey:@"nickname"];
                self.userInfo.imageUrl = [ResData objectForKey:@"imageUrl"];

                self.loginStatus = [[ResData objectForKey:@"loginStatus"] intValue];
            }else{
                NSLog(@"%@",[data objectForKey:@"ResMessage"]);
            }
            
        }
        
        
    }
    return self;
}

- (void)dealloc{
    [_message release];
    [_userInfo release];
    [super dealloc];
}
@end
