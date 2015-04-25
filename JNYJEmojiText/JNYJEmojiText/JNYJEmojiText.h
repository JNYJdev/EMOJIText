//
//  JNYJEmojiText.h
//  JNYJEmojiText
//
//  Created by William on 10/4/15.
//  Copyright (c) 2015 JNYJ. All rights reserved.
//
/*
 need <QuartzCore/QuartzCore.h>
 */
#import <UIKit/UIKit.h>

@interface JNYJEmojiText : UIView

+(void)showEmojiText:(NSString *)text font:(UIFont*)aFont superView:(UIView *)superView;
+(UIView *)getEmojiTextView:(NSString *)text font:(UIFont*)aFont width:(CGFloat)width;
+(NSArray *)getEmojiTextViews:(NSArray *)texts font:(UIFont*)aFont width:(CGFloat)width;
@end
