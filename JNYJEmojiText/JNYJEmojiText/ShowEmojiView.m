//
//  ShowEmojiView.m
//  JNYJEmojiText
//
//  Created by William on 10/4/15.
//  Copyright (c) 2015 JNYJ. All rights reserved.
//

#import "ShowEmojiView.h"
#import "JNYJEmojiText.h"
#import "JNYJButtonText.h"
@implementation ShowEmojiView

+(void)showEmojiText:(NSString *)text font:(UIFont *)aFont superView:(UIView *)superView{
    [JNYJEmojiText showEmojiText:text font:aFont superView:superView];
    //One view
    NSString *string_ = @"f01 0020202020 20202020202f02dkdkkssdkldklf3kdkdf05dddldlkfkf06fkkdl";
    UIView *view_ = [JNYJEmojiText getEmojiTextView:string_ font:aFont width:superView.frame.size.width];
    CGRect rect_ = superView.frame;
    CGRect rect_s = view_.frame;
    rect_s.origin.y = rect_.size.height;
    [view_ setFrame:rect_s];
    [superView addSubview:view_];
    //
    rect_ = superView.frame;
    rect_.size.height += view_.frame.size.height+10.0f;
    [superView setFrame:rect_];
    //More then one view
    NSArray *text_ = [NSArray arrayWithObjects:
                      
                      @"f01 0020202020 20202020202f02dkdkkssdkldklf3kdkdf05dddldlkfkf06fkkdl",
                      @"f01 0020202020 20202020202f02dkdkkssdkldklf3kdkdf05dddldlkfkf06fkkdl",
                      @"f01 0020202020 20202020202f02dkdkkssdkldklf3kdkdf05dddldlkfkf06fkkdl",nil];
    NSArray *array_ = [JNYJEmojiText getEmojiTextViews:text_ font:aFont width:superView.frame.size.width];
    for (NSInteger i=0; i<[array_ count]; i++) {
        view_ = [array_ objectAtIndex:i];
        rect_ = superView.frame;
        rect_s = view_.frame;
        rect_s.origin.y = rect_.size.height;
        [view_ setFrame:rect_s];
        [superView addSubview:view_];
        //
        rect_ = superView.frame;
        rect_.size.height += view_.frame.size.height+10.0f;
        [superView setFrame:rect_];
    }
    //
    [superView setBackgroundColor:[UIColor redColor]];
    
    //
    [[JNYJButtonText sharedInstance] setCallback_delegate:[JNYJButtonText sharedInstance]];
    [[JNYJButtonText sharedInstance] setFloat_text_height:24.0f];
    [[JNYJButtonText sharedInstance] setFloat_text_width:superView.frame.size.width-20];
    [[JNYJButtonText sharedInstance] setFont:aFont];
    [[JNYJButtonText sharedInstance] setFontButton:[UIFont fontWithName:@"Helvetica" size:18]];
    
    [[JNYJButtonText sharedInstance] setColorText:[UIColor redColor]];
    [[JNYJButtonText sharedInstance] setColorTextButton:[UIColor blueColor]];
    
    view_ = [[JNYJButtonText sharedInstance] getButtonTextView:@"dfsgsdfgsdfg<a href='u/1090538' target='_blank'>穿越到未来的时间旅行时刻都在发生穿越到未来的时间旅行时刻都在发生穿越到未来的时间旅行时刻都在发生穿越到未来的时间旅行时刻都在发生</a>穿越<a href='v/2002030' target='_blank'>fghdghdfgfghdghdfgfghdghdfgfghdghdfgfghdghdfgfghdghdfgfghdghdfgfghdghdfgfghdghdfgfghdghdfg</a>gfhdsthrtyr"
             indexPath:[NSIndexPath indexPathForRow:2 inSection:2]];
    [superView addSubview:view_];
    
    
    
    rect_ = superView.frame;
    rect_s = view_.frame;
    rect_s.origin.x = 5;
    rect_s.origin.y = rect_.size.height;
    [view_ setFrame:rect_s];
    [superView addSubview:view_];
    //
    rect_ = superView.frame;
    rect_.size.height += view_.frame.size.height+10.0f;
    [superView setFrame:rect_];
    //
}

@end
