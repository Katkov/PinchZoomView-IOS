//
//  PinchZoomView.m
//  PinchZoomView
//
//  Created by Michael Katkov on 2/4/20.
//  Copyright © 2020 Michael Katkov. All rights reserved.
//

#import "MKPinchZoomView.h"

@implementation MKPinchZoomView

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.contentInset = UIEdgeInsetsZero;
    self.contentSize = CGSizeMake(frame.size.width, frame.size.height);
    self.contentOffset = CGPointMake(0, 0);
}

-(void)setImage:(UIImage *)image
{
    //remove all subviews
    for (UIView* v in self.subviews) [v removeFromSuperview];
    //add image
    self.imageView = [[UIImageView alloc] initWithImage:image];
    self.imageView.frame = self.frame;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.imageView];
    //set delegate
    self.delegate = self;
    //set double tap gesture recognizer
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapDetected:)];
    tap.numberOfTapsRequired = 2;
    [self setUserInteractionEnabled:YES];
    [self addGestureRecognizer: tap];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    if (self.zoomScale > 1) {

        CGFloat ratioW = self.imageView.frame.size.width / self.imageView.image.size.width;
        CGFloat ratioH = self.imageView.frame.size.height / self.imageView.image.size.height;

        CGFloat ratio = ratioW < ratioH ? ratioW:ratioH;

        CGFloat newWidth = self.imageView.image.size.width*ratio;
        CGFloat newHeight = self.imageView.image.size.height*ratio;

        CGFloat left = 0.5 * (newWidth * self.zoomScale > self.imageView.frame.size.width ? (newWidth - self.imageView.frame.size.width) : (self.frame.size.width - self.contentSize.width));
        CGFloat top = 0.5 * (newHeight * self.zoomScale > self.imageView.frame.size.height ? (newHeight - self.imageView.frame.size.height) : (self.frame.size.height - self.contentSize.height));

        self.contentInset = UIEdgeInsetsMake(top, left, top, left);
        
    } else {
        self.contentInset = UIEdgeInsetsZero;
    }
}

-(void) doubleTapDetected:(UITapGestureRecognizer*)sender
{
    if (self.zoomScale < self.maximumZoomScale) {
        CGPoint center = [sender locationInView:[sender.view self]];
        CGSize scrollSize = self.frame.size;
        CGSize size = CGSizeMake(scrollSize.width / self.maximumZoomScale, scrollSize.height / self.maximumZoomScale);
        CGPoint origin = CGPointMake(center.x - size.width / 2, center.y - size.height / 2);
        CGRect rect = CGRectMake(origin.x, origin.y, size.width, size.height);
        [self zoomToRect:rect animated:true];
    } else {
        [self setZoomScale:1 animated:true];
    }
}

@end
