//
//  MainCell.m
//  HanKouBank
//
//  Created by David on 13-4-24.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import "MainCell.h"

@implementation MainCell
@synthesize MainCell_ImageView = _MainCell_ImageView;
@synthesize MainCell_Title = _MainCell_Title;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
