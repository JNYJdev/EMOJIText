//
//  JNYJEmojiText.h
//  JNYJEmojiText
//
//  Created by William on 10/4/15.
//  Copyright (c) 2015 JNYJ. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TOOLBARTAG		200
#define TABLEVIEWTAG	300


#define BEGIN_FLAG @"[/"
#define END_FLAG @"]"


@interface JNYJEmojiText : UIView

+(UIView *)assembleMessageAtIndex : (NSString *) message
                              from:(BOOL)fromself;
@end
