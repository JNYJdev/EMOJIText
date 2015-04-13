//
//  ShowEmojiView.m
//  JNYJEmojiText
//
//  Created by William on 10/4/15.
//  Copyright (c) 2015 JNYJ. All rights reserved.
//

#import "ShowEmojiView.h"
#import "JNYJEmojiText.h"
@implementation ShowEmojiView

+(void)showEmojiText:(NSString *)text superView:(UIView *)superView{
    [JNYJEmojiText showEmojiText:text superView:superView];
}

@end
