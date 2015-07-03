//
//  PlayViewController.h
//  ICViewPager
//
//  Created by lanou3g on 14-7-22.
//  Copyright (c) 2014年 Ilter Cengiz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "PlayerView.h"
@interface PlayViewController : UIViewController
@property (nonatomic, copy) NSString *str;
@property (nonatomic, retain) PlayerView *playView;
@end
