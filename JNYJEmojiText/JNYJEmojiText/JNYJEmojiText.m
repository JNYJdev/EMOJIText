//
//  JNYJEmojiText.m
//  JNYJEmojiText
//
//  Created by William on 10/4/15.
//  Copyright (c) 2015 JNYJ. All rights reserved.
//

#import "JNYJEmojiText.h"

#import <QuartzCore/QuartzCore.h>
#import "JNYJEmojiRegexKitLite.h"

//#define TOOLBARTAG		200
//#define TABLEVIEWTAG	300


//#define BEGIN_FLAG @"[/"
//#define END_FLAG @"]"

#define KFacialSizeWidth  18
#define KFacialSizeHeight 18
/*
 @"^f[0-9]{2}$" 不区分大小写
 @"^[Ff][0-9]{2}$"  区分大小写
 */
#define RegexString_emoji @"f[0-9]{2}"

@implementation JNYJEmojiText


+(void)showEmojiText:(NSString *)text superView:(UIView *)superView{
    if (text && [text isKindOfClass:[NSString class]] && ![text isEqualToString:@""]) {
        //
        CGFloat width_MAX = superView.frame.size.width;
        UIView *view_ = [JNYJEmojiText assembleMessageAtIndex:text width:(width_MAX)];
        CGRect rect_ = view_.frame;
        rect_.origin.x = 0;
        rect_.origin.y = 0;
        [view_ setFrame:rect_];
        [view_ setBackgroundColor:[UIColor whiteColor]];
        [superView addSubview:view_];
        //
        rect_ = superView.frame;
        rect_.size.height = view_.frame.size.height;
        [superView setFrame:rect_];
        //        [superView setBackgroundColor:[UIColor redColor]];
        
        
    }
}
//图文混排

+(UIImage *)getEmoji_7QImage:(NSString *)fileName{
    NSString *string_fullFilePath = [[[NSBundle mainBundle] resourcePath]
                                     stringByAppendingPathComponent:
                                     [NSString stringWithFormat:@"Emoji.bundle/Emoji_7Q/%@.png",fileName]];
    UIImage *image_ = [UIImage imageWithContentsOfFile:string_fullFilePath];
    return image_;
}
//+(void)getImageRange:(NSString*)message to:(NSMutableArray*)array {
//    NSRange range=[message rangeOfString: BEGIN_FLAG];
//    NSRange range1=[message rangeOfString: END_FLAG];
//    //判断当前字符串是否还有表情的标志。
//    if (range.length>0 && range1.length>0) {
//        if (range.location > 0) {
//            [array addObject:[message substringToIndex:range.location]];
//            [array addObject:[message substringWithRange:NSMakeRange(range.location, range1.location+1-range.location)]];
//            NSString *str=[message substringFromIndex:range1.location+1];
//            [self getImageRange:str to:array];
//        }else {
//            NSString *nextstr=[message substringWithRange:NSMakeRange(range.location, range1.location+1-range.location)];
//            //排除文字是“”的
//            if (![nextstr isEqualToString:@""]) {
//                [array addObject:nextstr];
//                NSString *str=[message substringFromIndex:range1.location+1];
//                [self getImageRange:str to:array];
//            }else {
//                return;
//            }
//        }
//        
//    } else if (message != nil) {
//        [array addObject:message];
//    }
//}

+(void)getImageRange_RegexString:(NSString*)message to:(NSMutableArray*)array {
    
    NSRange range_ = [message rangeOfRegex:RegexString_emoji];
    
    //判断当前字符串是否还有表情的标志。
    if ([message isEqualToString:@""]) {
        return;
    }
    if (range_.location > 0 && range_.length == 3) {
        [array addObject:[message substringToIndex:range_.location]];
        [array addObject:[message substringWithRange:NSMakeRange(range_.location, range_.length)]];
        NSString *str=[message substringFromIndex:range_.location+range_.length];
        [self getImageRange_RegexString:str to:array];
    }else if (range_.location == 0 && range_.length == 3) {
        NSString *nextstr=[message substringWithRange:NSMakeRange(range_.location, range_.length)];
        //排除文字是“”的
        if (![nextstr isEqualToString:@""]) {
            [array addObject:nextstr];
            NSString *str=[message substringFromIndex:range_.location+range_.length];
            [self getImageRange_RegexString:str to:array];
        }else {
            return;
        }
    }else{
        [array addObject:message];
    }
}

//+(NSMutableArray *)getImageRange:(NSString*)message{
//    NSRange range_ = [message rangeOfRegex:RegexString_emoji];
//    NSArray *array_0 = [message componentsMatchedByRegex:RegexString_emoji];
//    NSArray *array_ = [message componentsSeparatedByRegex:RegexString_emoji];
//    NSArray *array_2 = [message captureComponentsMatchedByRegex:RegexString_emoji];
//    NSArray *array_3 = [message arrayOfCaptureComponentsMatchedByRegex:RegexString_emoji];
//    return [NSMutableArray arrayWithArray:array_];
//}


+(UIView *)assembleMessageAtIndex : (NSString *) message width:(CGFloat)widthMAX
{
    CGFloat width = widthMAX-4;
    //11111
    NSMutableArray *array = [[NSMutableArray alloc] init];
//    [self getImageRange:message to:array];
    //22222
    [self getImageRange_RegexString:message to:array];
    UIView *returnView = [[UIView alloc] initWithFrame:CGRectZero];
    NSArray *data = array;
    UIFont *fon = [UIFont systemFontOfSize:13.0f];
    CGFloat upX = 0;
    CGFloat upY = 0;
    CGFloat X = 0;
    CGFloat Y = 0;
    if (data) {
        for (int i=0;i < [data count];i++) {
            NSString *str=[data objectAtIndex:i];
            if ([str isMatchedByRegex:RegexString_emoji])
            {
                if (upX >= (width-KFacialSizeWidth))
                {
                    upY = upY + KFacialSizeHeight;
                    upX = 0;
                    X = width;
                    Y = upY;
                }
                
                NSString *imageName=[NSString stringWithFormat:@"%@",str];
                UIImageView *img=[[UIImageView alloc] initWithImage:[self getEmoji_7QImage:imageName]];
                img.frame = CGRectMake(upX, upY, KFacialSizeWidth, KFacialSizeHeight);
                [returnView addSubview:img];
                upX=KFacialSizeWidth+upX;
                if (X<width){
                    X = upX;
                }
//                NSLog(@"(image)---->%@(%f:%f)",str,width,upX);
                
                
            } else {
                //
                NSString *string_text = @"";
                CGFloat float_text = 0.0f;
                for (int j = 0; j < [str length]; j++) {
                    NSString *temp = [str substringWithRange:NSMakeRange(j, 1)];
                    string_text = [NSString stringWithFormat:@"%@%@",string_text,temp];
                    
                    //                    CGSize size=[temp sizeWithFont:fon constrainedToSize:CGSizeMake(width, 40)];
                    
                    NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:fon,NSFontAttributeName, nil];
                    CGRect rect_ = [string_text boundingRectWithSize:CGSizeMake(width, 40)
                                                      options:NSStringDrawingTruncatesLastVisibleLine
                                                   attributes:attribute context:nil];
                    CGSize size = rect_.size;
                    //
                    float_text=upX+size.width;
//                    NSLog(@"(String)--->%@(%f:%f)",string_text,width,float_text);
                    
                    if (float_text >= (width-2))
                    {
                        //
                        UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(upX,upY,size.width,size.height)];
                        la.font = fon;
                        la.text = string_text;
                        la.backgroundColor = [UIColor clearColor];
                        [returnView addSubview:la];
                        //
                        upY = upY + KFacialSizeHeight;
                        upX = 0;
                        X = width;
                        Y =upY;
                        //
                        float_text = upX;
                        string_text = @"";
                    }else if ((j+1) == str.length) {
                        //
                        UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(upX,upY,size.width,size.height)];
                        la.font = fon;
                        la.text = string_text;
                        la.backgroundColor = [UIColor clearColor];
                        [returnView addSubview:la];
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
            }
        }
    }
    returnView.frame = CGRectMake(0.0f,0.0f, X, (Y+KFacialSizeHeight)); //@ 需要将该view的尺寸记下，方便以后使用
//    NSLog(@"%f %f", X, Y);
    return returnView;
}

@end

/*
 +(UIView *)assembleMessageAtIndex : (NSString *) message from:(BOOL)fromself
 {
 //11111
 NSMutableArray *array = [[NSMutableArray alloc] init];
 //    [self getImageRange:message to:array];
 //22222
 [self getImageRange_RegexString:message to:array];
 UIView *returnView = [[UIView alloc] initWithFrame:CGRectZero];
 NSArray *data = array;
 UIFont *fon = [UIFont systemFontOfSize:13.0f];
 CGFloat upX = 0;
 CGFloat upY = 0;
 CGFloat X = 0;
 CGFloat Y = 0;
 if (data) {
 for (int i=0;i < [data count];i++) {
 NSString *str=[data objectAtIndex:i];
 NSLog(@"str--->%@",str);
 if ([str hasPrefix: BEGIN_FLAG] && [str hasSuffix: END_FLAG])
 {
 if (upX >= MAX_WIDTH)
 {
 upY = upY + KFacialSizeHeight;
 upX = 0;
 X = 150;
 Y = upY;
 }
 NSLog(@"str(image)---->%@",str);
 
 NSString *imageName=[str substringWithRange:NSMakeRange(2, str.length - 3)];
 UIImageView *img=[[UIImageView alloc] initWithImage:[self getEmoji_7QImage:imageName]];
 img.frame = CGRectMake(upX, upY, KFacialSizeWidth, KFacialSizeHeight);
 [returnView addSubview:img];
 //                [img release];
 upX=KFacialSizeWidth+upX;
 if (X<150) X = upX;
 
 
 } else {
 for (int j = 0; j < [str length]; j++) {
 NSString *temp = [str substringWithRange:NSMakeRange(j, 1)];
 if (upX >= MAX_WIDTH)
 {
 upY = upY + KFacialSizeHeight;
 upX = 0;
 X = 150;
 Y =upY;
 }
 //                    CGSize size=[temp sizeWithFont:fon constrainedToSize:CGSizeMake(150, 40)];
 
 NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:fon,NSFontAttributeName, nil];
 CGRect rect_ = [temp boundingRectWithSize:CGSizeMake(150, 40)
 options:NSStringDrawingTruncatesLastVisibleLine
 attributes:attribute context:nil];
 CGSize size = rect_.size;
 
 UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(upX,upY,size.width,size.height)];
 la.font = fon;
 la.text = temp;
 la.backgroundColor = [UIColor clearColor];
 [returnView addSubview:la];
 //                    [la release];
 upX=upX+size.width;
 if (X<150) {
 X = upX;
 }
 }
 }
 }
 }
 returnView.frame = CGRectMake(0.0f,0.0f, X, (Y+KFacialSizeHeight)); //@ 需要将该view的尺寸记下，方便以后使用
 NSLog(@"%f %f", X, Y);
 return returnView;
 }
 */