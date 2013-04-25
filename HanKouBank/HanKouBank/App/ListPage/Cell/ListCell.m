//
//  ListCell.m
//  HanKouBank
//
//  Created by David on 13-4-25.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import "ListCell.h"

@implementation ListCell
@synthesize ListCell_date = _ListCell_date;
@synthesize ListCell_title = _ListCell_title;
@synthesize ListCell_titleless = _ListCell_titleless;
@synthesize ListCell_icon = _ListCell_icon;

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
