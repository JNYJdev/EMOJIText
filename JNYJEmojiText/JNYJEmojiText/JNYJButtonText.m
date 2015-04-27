//
//  JNYJButtonText.m
//  JNYJEmojiText
//
//  Created by William on 23/4/15.
//  Copyright (c) 2015 JNYJ. All rights reserved.
//

#import "JNYJButtonText.h"

#define KFacialSizeWidth  18
#define KFacialSizeHeight 18

#define StringFormat_label_indexPath @"%ld_indexPath_%ld"
#define Comp_label_IndexPath @"_indexPath_"

#define Tag_label_indexPath 150427

@implementation JNYJButtonText


#pragma mark APIClient
+ (instancetype)sharedInstance{
    static JNYJButtonText *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[JNYJButtonText alloc] init];
        _sharedClient.float_text_height = 18.0f;
        _sharedClient.float_text_width = 320-20;
        
        [_sharedClient setFont:[UIFont fontWithName:@"Helvetica" size:11]];
        [_sharedClient setFontButton:[UIFont fontWithName:@"Helvetica" size:11]];
        
        [_sharedClient setColorText:[UIColor blackColor]];
        [_sharedClient setColorTextButton:[UIColor blackColor]];
    });
    
    return _sharedClient;
}
//

-(void)initText:(NSString *)text to:(NSMutableArray *)formatMessage{
    
    NSMutableDictionary *dic_ = [NSMutableDictionary dictionary];
    [formatMessage addObject:dic_];
    
    [dic_ setValue:EnumButtonTextType_label forKey:KEY_text_type];
    text = (text)?text:Value_text_default;
    [dic_ setValue:text forKey:KEY_text_title];
}
-(void)initHrefLink:(NSString *)message to:(NSMutableArray *)formatMessage{
    //
    NSString *string_message = [message lowercaseString];
    NSRange range=[string_message rangeOfString: @"href='"];//6
    NSUInteger int_start_count = 6;
    NSRange range1=[string_message rangeOfString: @"' target"];//8
    NSUInteger int_end_count = 8;
    //
    NSMutableDictionary *dic_ = [NSMutableDictionary dictionary];
    [formatMessage addObject:dic_];
    
    [dic_ setValue:EnumButtonTextType_button forKey:KEY_text_type];
    //
    NSString *string_contents = @"None";
    if (range.length>0 && range1.length>0) {
        if (range.location > 0) {
            NSString *string_ =[NSString stringWithFormat:@"%@",[message substringWithRange:
                                                                 NSMakeRange(range.location+int_start_count,
                                                                             range1.location-range.location-range.length)]];
            
            NSArray *array_ = [string_ componentsSeparatedByString:@"/"];
            if (array_ && [array_ count]>=2) {
                string_  = [array_ objectAtIndex:0];
                string_ = (string_)?string_:Value_text_default;
                [dic_ setValue:string_ forKey:KEY_text_type_lessionType];
                
                string_  = [array_ objectAtIndex:1];
                string_ = (string_)?string_:Value_text_default;
                [dic_ setValue:string_ forKey:KEY_text_type_ID];
            }
            string_contents=[message substringFromIndex:range1.location+int_end_count];
        }
    }
    
    range=[string_contents rangeOfString: @">"];//1
    int_start_count = 1;
    range1=[string_contents rangeOfString: @"<"];//1
    int_end_count = 1;
    //
    if (range.length>0 && range1.length>0) {
        if (range.location > 0) {
            NSString *string_ =[NSString stringWithFormat:@"%@",[string_contents substringWithRange:
                                                                 NSMakeRange(range.location+int_start_count,
                                                                             range1.location-range.location-range.length)]];
            
            string_ = (string_)?string_:Value_text_default;
            [dic_ setValue:string_ forKey:KEY_text_title];
        }
    }
    
    
}
-(void)detectMessage:(NSString *)message to:(NSMutableArray *)formatMessage{
    //
    NSRange range=[message rangeOfString: @"<a"];//2
    //    NSUInteger int_start_count = 2;
    NSRange range1=[message rangeOfString: @"</a>"];//4
    NSUInteger int_end_count = 4;
    //判断当前字符串是否还有表情的标志。
    if (range.length>0 && range1.length>0) {
        if (range.location > 0) {
            
            
            NSString *string_ =[NSString stringWithFormat:@"%@",[message substringToIndex:range.location]];
            
            [self initText:string_ to:formatMessage];
            
            //
            string_ =[NSString stringWithFormat:@"%@",[message substringWithRange:
                                                       NSMakeRange(range.location,
                                                                   range1.location+int_end_count-range.location)]];
            
            [self initHrefLink:string_ to:formatMessage];
            
            NSString *str=[message substringFromIndex:range1.location+int_end_count];
            [self detectMessage:str to:formatMessage];
        }else {
            NSString *string_ =[NSString stringWithFormat:@"%@",[message substringWithRange:
                                                                 NSMakeRange(range.location,
                                                                             range1.location+int_end_count-range.location)]];
            //排除文字是“”的
            if (![string_ isEqualToString:@""]) {
                [self initHrefLink:string_ to:formatMessage];
                NSString *str=[message substringFromIndex:range1.location+int_end_count];
                [self detectMessage:str to:formatMessage];
            }else {
                return;
            }
        }
        
    } else if (message != nil) {
        [self initText:message to:formatMessage];
    }
}
-(NSArray *)convertMessages:(NSString *)text{
    NSMutableArray *array_ = [NSMutableArray array];
    [self detectMessage:text to:array_];
    return array_;
}
//
-(UIView *)getButtonTextView:(NSString *)text indexPath:(NSIndexPath *)indexPath{
    NSArray *array_ = [self convertMessages:text];
    self.arrayTexts = array_;
    if (array_ && [array_ isKindOfClass:[NSArray class]]){
        //
        UIView *view_ = [self assembleMessages];
        //
        UILabel *label_ = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        NSString *string_ = [NSString stringWithFormat:
                             StringFormat_label_indexPath,
                             (long)indexPath.row,
                             (long)indexPath.section];
        [label_ setText:string_];
        [label_ setHidden:YES];
        [label_ setTag:Tag_label_indexPath];
        [view_ addSubview:label_];
        //
        CGRect rect_ = view_.frame;
        rect_.origin.x = 0;
        rect_.origin.y = 0;
        [view_ setFrame:rect_];
        [view_ setBackgroundColor:[UIColor purpleColor]];
        return view_;
    }
    return [[UIView alloc] initWithFrame:CGRectMake(0,0,0,0)];
}
//
-(UIView *)assembleMessages
{
    if (self.arrayTexts && [self.arrayTexts count]>0) {
    }else{
        return [[UIView alloc] initWithFrame:CGRectMake(0,0,0,0)];
    }
    CGFloat width = (self.float_text_width-6);
    //
    UIView *returnView = [[UIView alloc] initWithFrame:CGRectZero];
    [returnView setBackgroundColor:[UIColor clearColor]];
    NSArray *data = self.arrayTexts;
    CGFloat upX = 0;
    CGFloat upY = 0;
    CGFloat X = 0;
    CGFloat Y = 0;
    
    //
    NSInteger int_index_button = (-9527);
    //
    if (data) {
        for (int i=0;i < [data count];i++) {
            //
            NSDictionary *dic_ = [data objectAtIndex:i];
            if (dic_ && [dic_ isKindOfClass:[NSDictionary class]])
            {
                if (upX >= (width))
                {
                    upY = upY + self.float_text_height;
                    upX = 0;
                    X = width;
                    Y = upY;
                }
                
                NSString *string_ = [dic_ valueForKey:KEY_text_title];
                //
                NSString *string_title = string_;
                NSString *string_text = @"";
                CGFloat float_text = 0.0f;
                
                string_ = [NSString stringWithFormat:@"%@",[dic_ valueForKey:KEY_text_type]];
                BOOL isButton = NO;
                if (string_ && [string_ isEqualToString:EnumButtonTextType_button]) {
                    isButton = YES;
                    if (int_index_button >=0) {
                        int_index_button++;
                    }else{
                        int_index_button = 0;
                    }
                }
                //
                UIFont *font_ = self.font;
                if (isButton) {
                    font_ = self.fontButton;
                }
                
                for (int j = 0; j < [string_title length]; j++) {
                    NSString *string_temp = [string_title substringWithRange:NSMakeRange(j, 1)];
                    string_text = [NSString stringWithFormat:@"%@%@",string_text,string_temp];
                    
                    //                    CGSize size=[temp sizeWithFont:fon constrainedToSize:CGSizeMake(width, 40)];
                    
                    NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:font_,NSFontAttributeName, nil];
                    CGRect rect_ = [string_text boundingRectWithSize:CGSizeMake(width, 40)
                                                             options:NSStringDrawingTruncatesLastVisibleLine
                                                          attributes:attribute context:nil];
                    CGSize size = rect_.size;
                    //
                    float_text=upX+size.width;
                    //                    NSLog(@"(String)--->%@(%f:%f)",string_text,width,float_text);
                    
                    
                    if (float_text >= (width-8))
                    {
                        CGRect rect_ = CGRectMake(upX,upY,size.width,size.height);
                        if (string_ && [string_ isEqualToString:EnumButtonTextType_button]) {
                            //
                            UIButton *button_ = [[UIButton alloc] initWithFrame:rect_];
                            button_.backgroundColor = [UIColor whiteColor];
                            [button_ setTitle:string_text forState:UIControlStateNormal];
                            [button_.titleLabel setFont:font_];
                            [button_ setTitleColor:self.colorTextButton forState:UIControlStateNormal];
                            [returnView addSubview:button_];
                            [button_ setShowsTouchWhenHighlighted:YES];
                            [button_ setTag:int_index_button];
                            [button_ addTarget:self action:@selector(event_click:)
                              forControlEvents:UIControlEventTouchUpInside];                            //
                        }else if (string_ && [string_ isEqualToString:EnumButtonTextType_label]) {
                            //
                            UILabel *la = [[UILabel alloc] initWithFrame:rect_];
                            la.font = font_;
                            la.text = string_text;
                            [la setTextColor:self.colorText];
                            la.backgroundColor = [UIColor clearColor];
                            [returnView addSubview:la];
                            //
                        }else{
                            
                        }
                        //
                        upY = upY + self.float_text_height;
                        upX = 0;
                        X = width;
                        Y =upY;
                        //
                        float_text = upX;
                        string_text = @"";
                        
                    }else if ((j+1) == string_title.length) {
                        //
                        
                        CGRect rect_ = CGRectMake(upX,upY,size.width,size.height);
                        if (string_ && [string_ isEqualToString:EnumButtonTextType_button]) {
                            //
                            UIButton *button_ = [[UIButton alloc] initWithFrame:rect_];
                            button_.backgroundColor = [UIColor whiteColor];
                            [button_ setTitle:string_text forState:UIControlStateNormal];
                            [button_.titleLabel setFont:font_];
                            [button_ setTitleColor:self.colorTextButton forState:UIControlStateNormal];
                            [returnView addSubview:button_];
                            [button_ setShowsTouchWhenHighlighted:YES];
                            [button_ setTag:int_index_button];
                            [button_ addTarget:self action:@selector(event_click:)
                              forControlEvents:UIControlEventTouchUpInside];
                            //
                        }else if (string_ && [string_ isEqualToString:EnumButtonTextType_label]) {
                            //
                            UILabel *la = [[UILabel alloc] initWithFrame:rect_];
                            la.font = font_;
                            la.text = string_text;
                            [la setTextColor:self.colorText];
                            la.backgroundColor = [UIColor clearColor];
                            [returnView addSubview:la];
                            //
                        }else{
                            
                        }
                        //
                        upX=float_text;
                        //
                        float_text = upX;
                        string_text = @"";
                    }
                    
                    
                    if (X<width) {
                        X = upX;
                    }
                }
                //                NSString *imageName=[NSString stringWithFormat:@"%@",str];
                //                UIImageView *img=[[UIImageView alloc] initWithImage:[self getEmoji_7QImage:imageName]];
                //                [img setBackgroundColor:[UIColor clearColor]];
                //                img.frame = CGRectMake(upX, upY, KFacialSizeWidth, KFacialSizeHeight);
                //                [returnView addSubview:img];
                //                upX=KFacialSizeWidth+upX;
                //                if (X<width){
                //                    X = upX;
                //                }
                //                //                NSLog(@"(image)---->%@(%f:%f)",str,width,upX);
                //
            } else {
                //
            }
        }
    }
    returnView.frame = CGRectMake(0.0f,0.0f, X, (Y+self.float_text_height)); //@ 需要将该view的尺寸记下，方便以后使用
    //    NSLog(@"%f %f", X, Y);
    return returnView;
}

-(void)event_click:(id)sender{
    if (self.callback_delegate && [self.callback_delegate respondsToSelector:@selector(callback_JNYJButtonText_buttonClick:)]) {
        UIButton *button_ = (UIButton *)sender;
        if (button_ &&[button_ isKindOfClass:[UIButton class]]) {
            NSMutableDictionary *dic_ = [NSMutableDictionary dictionary];
            [dic_ setValue:[NSNumber numberWithInteger:button_.tag] forKey:@"ClickIndex"];
            UIView *view_ = [button_ superview];
            UILabel *label_ = (UILabel *)[view_ viewWithTag:Tag_label_indexPath];
            if (label_ && [label_ isKindOfClass:[UILabel class]]) {
                NSString *string_ = label_.text;
                if (string_) {
                    NSArray *array_ = [string_ componentsSeparatedByString:Comp_label_IndexPath];
                    if (array_ && [array_ count]>=2) {
                        NSIndexPath *indexPath_ = [NSIndexPath indexPathForRow:[([array_ objectAtIndex:0]) integerValue]
                                                                     inSection:[([array_ objectAtIndex:1]) integerValue]];
                        [dic_ setValue:indexPath_ forKey:@"IndexPath"];
                        [self.callback_delegate callback_JNYJButtonText_buttonClick:dic_];
                    }
                }
            }
        }
    }
}
-(void)callback_JNYJButtonText_buttonClick:(id)sender{
    NSLog(@"buttonClick:--\n\n%@\n\n",sender);
}
@end
