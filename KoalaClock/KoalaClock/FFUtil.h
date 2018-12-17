//
//  FFUtil.h
//  KoalaClock
//
//  Created by ff'Mac on 2018/11/27.
//  Copyright © 2018 ff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FFUtil : NSObject

+ (UILabel *)ff_labWithText:(NSString *)text textColor:(UIColor *)color ali:(NSTextAlignment)ali font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
