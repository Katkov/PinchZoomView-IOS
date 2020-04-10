//
//  PinchZoomView.h
//  PinchZoomView
//
//  Created by Michael Katkov on 2/4/20.
//  Copyright © 2020 Michael Katkov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKPinchZoomView : UIScrollView <UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *imageView;

-(void)setImage:(UIImage*) image;

@end

NS_ASSUME_NONNULL_END
