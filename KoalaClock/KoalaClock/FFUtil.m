//
//  FFUtil.m
//  KoalaClock
//
//  Created by ff'Mac on 2018/11/27.
//  Copyright © 2018 ff. All rights reserved.
//

#import "FFUtil.h"

@implementation FFUtil

+ (UILabel *)ff_labWithText:(NSString *)text textColor:(UIColor *)color ali:(NSTextAlignment)ali font:(UIFont *)font
{
    UILabel *lab = [[UILabel alloc] init];
    lab.frame = CGRectZero;
    lab.text = text;
    lab.textColor = color;
    lab.textAlignment = ali;
    lab.font = font;
    [lab sizeToFit];
    lab.numberOfLines = 0;
    return lab;
}

@end
