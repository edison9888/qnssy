//
//  MyTableViewCell.h
//  ContactDocFilesManage
//
//  Created by Sophie Sun on 12-4-26.
//  Copyright (c) 2012年 baosight. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseInfoTableViewCell_iPhone : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *leftLabel;
@property (retain, nonatomic) IBOutlet UILabel *rightLabel;
@property (retain, nonatomic) NSString *key;
@property (retain, nonatomic) NSString *commitValue;
@property (retain, nonatomic) IBOutlet UITextField *username;

@end
