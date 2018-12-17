//
//  FFMacros.h
//  KoalaClock
//
//  Created by ff'Mac on 2018/11/27.
//  Copyright © 2018 ff. All rights reserved.
//

#ifndef FFMacros_h
#define FFMacros_h

#define FFColorWithHEX(v,a)         [UIColor colorWithRed:(((v) >> 16) & 0xff)/255.0f green:(((v) >> 8) & 0xff)/255.0f blue:((v) & 0xff)/255.0f alpha:a]
#define FFColorWithRGBA(r,g,b,a)    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define FFFontSize(v)               [UIFont systemFontOfSize:v]
#define FFBoldFontSize(v)           [UIFont fontWithName:@"CourierNewPS-BoldMT" size:v]//[UIFont boldSystemFontOfSize:v]//Courier-Bold
#define FFWeakSelf __weak typeof(self) weakSelf = self;


#endif /* FFMacros_h */
