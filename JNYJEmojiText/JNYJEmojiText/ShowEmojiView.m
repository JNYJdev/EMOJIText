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
    if (text && [text isKindOfClass:[NSString class]] && ![text isEqualToString:@""]) {
        //
        UIView *view_ = [JNYJEmojiText assembleMessageAtIndex:text from:YES];
        
        CGRect rect_ = view_.frame;
        rect_.origin.x = 0;
        rect_.origin.y = 0;
        [view_ setFrame:rect_];
        [view_ setBackgroundColor:[UIColor clearColor]];
        //
        [superView addSubview:view_];
    }
}

@end
