//
//  ViewController.m
//  PinchZoomView
//
//  Created by Michael Katkov on 2/4/20.
//  Copyright © 2020 Michael Katkov. All rights reserved.
//

#import "ViewController.h"
#import "MKPinchZoomView.h"

@interface ViewController ()

@end

@implementation ViewController {
    MKPinchZoomView *pinchZoomView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    pinchZoomView = [[MKPinchZoomView alloc] init];
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
    {
        [pinchZoomView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width)];
    } else {
        [pinchZoomView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    }
    pinchZoomView.maximumZoomScale = 3.0f;
    pinchZoomView.minimumZoomScale = 1.0f;
    UIImage *img = [UIImage imageNamed:@"example"];
    [pinchZoomView setImage:img];
    [self.view addSubview:pinchZoomView];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [pinchZoomView setFrame:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage *img = [UIImage imageNamed:@"example"];
    [pinchZoomView setImage:img];
}


@end
