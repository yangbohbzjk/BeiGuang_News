//
//  ListCell.h
//  HanKouBank
//
//  Created by David on 13-4-25.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *ListCell_title;

@property (weak, nonatomic) IBOutlet UILabel *ListCell_date;

@property (weak, nonatomic) IBOutlet UILabel *ListCell_titleless;
@property (weak, nonatomic) IBOutlet UIView *ListCell_icon;

@end
