//
//  JNYJButtonText.h
//  JNYJEmojiText
//
//  Created by William on 23/4/15.
//  Copyright (c) 2015 JNYJ. All rights reserved.
//

/*
 need <QuartzCore/QuartzCore.h>
 */
#import <UIKit/UIKit.h>

/*
 Messages: DIC
 key:value
 EnumButtonTextType --
 Title --
 KEY_text_type_ID --
 KEY_text_type_lessionType --
 */

#define EnumButtonTextType_button   @"EnumButtonTextType_button"
#define EnumButtonTextType_label    @"EnumButtonTextType_label"
#define EnumButtonTextType_image    @"EnumButtonTextType_image"

#define KEY_text_title @"KEY_text_title"
#define KEY_text_type @"KEY_text_type"
#define KEY_text_type_ID @"KEY_text_type_ID"
#define KEY_text_type_lessionType @"KEY_text_type_lessionType"

#define Value_text_default @"Value_text_default"

@protocol JNYJButtonTextDelegate <NSObject>

-(void)callback_JNYJButtonText_buttonClick:(id)sender;

@end


@interface JNYJButtonText : NSObject

@property(nonatomic,assign)CGFloat  float_text_height;
@property(nonatomic,assign)CGFloat  float_text_width;
@property(nonatomic,strong)UIFont   *font;
@property(nonatomic,strong)UIFont   *fontButton;
@property(nonatomic,strong)UIColor  *colorText;
@property(nonatomic,strong)UIColor  *colorTextButton;

@property(nonatomic,strong)NSArray  *arrayTexts;

@property(nonatomic,weak)id<JNYJButtonTextDelegate> callback_delegate;

+ (instancetype)sharedInstance;

-(NSArray *)convertMessages:(NSString *)text;

-(UIView *)getButtonTextView:(NSString *)text;

-(UIView *)assembleMessages;
@end
