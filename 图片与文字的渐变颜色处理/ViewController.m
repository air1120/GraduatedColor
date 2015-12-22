//
//  ViewController.m
//  图片与文字的渐变处理
//
//  Created by rason on 15/12/22.
//  Copyright © 2015年 rason. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat width = 200;
    CGFloat startY = 64;
    UIColor *beforeColor = [UIColor blueColor];
    UIColor *afterColor = [UIColor redColor];
    
    UILabel *label4 = ({
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(64, startY, 200, 15)];
        startY +=20;
        label.text = @"你好啊";
        [self.view addSubview:label];
        //设置渐变层，实际上有这个渐变层就可以显示了。
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = label.frame;
        // 设置渐变层的颜色
        gradientLayer.colors = @[(id)beforeColor.CGColor,(id)afterColor.CGColor];
        //水平渐变添加下面两行即可
        //    gradientLayer.startPoint = CGPointMake(0, .5);
        //    gradientLayer.endPoint = CGPointMake(1, .5);
        // 疑问:渐变层能不能加在label上
        // 不能，如果添加渐变层到label图层上,则会遮盖label的文字图层；如果作为label图层的mask，由于mask是完全不透明渐变层，所以是正常显示，这种情况如果消失了，说明mask的frame.origin没有设置正确。
        // 添加渐变层到控制器的view图层上
        [self.view.layer addSublayer:gradientLayer];
        gradientLayer.mask = label.layer;
        //由于label.layer从self.view.layer中移动到渐变层gradientLayer中作为蒙版，所以坐标改变了需要重新调整。
        label.layer.frame = gradientLayer.bounds;
        label;
    });
    
    //原图
    UIImageView *imageView1 = ({
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((screenWidth-width)/2, startY, width, 30)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = [UIImage imageNamed:@"abc.png"];
        startY +=35;
        [self.view addSubview:imageView];
        imageView;
    });
    //设置渐变图片
    UIImageView *imageView2 = ({
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((screenWidth-width)/2, startY, width, 30)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = [UIImage imageNamed:@"abc.png"];
        startY +=35;
        [self.view addSubview:imageView];
        [self addLayerForView:imageView beforeColor:beforeColor afterColor:afterColor isAsMask:YES];
        imageView;
    });
    
    UIImageView *imageView5 = ({
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((screenWidth-width)/2, startY, 200, 30)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = [UIImage imageNamed:@"abc.png"];
        startY +=35;
        [self.view addSubview:imageView];
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = imageView.frame;
        gradientLayer.colors = @[(id)beforeColor.CGColor,(id)afterColor.CGColor];
        //添加渐变层到view图层上
        [self.view.layer addSublayer:gradientLayer];
        //将原来的图标图层或者文字图层添加到渐变层上
        [gradientLayer addSublayer:imageView.layer];
        
        //由于imageView.layer从self.view.layer中移动到渐变层gradientLayer中，所以坐标改变了需要重新调整。
        imageView.layer.frame = imageView.layer.bounds;
        imageView;
    });
    
    UIImageView *imageView6 = ({
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((screenWidth-30)/2, startY, 30, 30)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = [UIImage imageNamed:@"abc2.png"];
        startY +=35;
        [self.view addSubview:imageView];
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = imageView.frame;
        gradientLayer.colors = @[(id)beforeColor.CGColor,(id)afterColor.CGColor];
        //添加渐变层到view图层上
        [self.view.layer addSublayer:gradientLayer];
        //将原来的图标图层或者文字图层添加到渐变层上
        [gradientLayer addSublayer:imageView.layer];
        
        //        CAGradientLayer *roundLayer = [CAGradientLayer layer];
        //        roundLayer.colors = @[(id)beforeColor.CGColor,(id)afterColor.CGColor];
        //        roundLayer.frame = imageView.bounds;
        //        roundLayer.cornerRadius = imageView.frame.size.width/2;
        //        roundLayer.masksToBounds = YES;
        //        gradientLayer.mask = roundLayer;
        
        gradientLayer.cornerRadius = imageView.frame.size.width/2;
        gradientLayer.masksToBounds = YES;
        
        //由于imageView.layer从self.view.layer中移动到渐变层gradientLayer中，所以坐标改变了需要重新调整。
        imageView.layer.frame = imageView.layer.bounds;
        imageView;
    });
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addLayerForView:(UIView *)label beforeColor:(UIColor *)beforeColor afterColor:(UIColor*)afterColor isAsMask:(BOOL)isAsMask{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = label.frame;
    gradientLayer.colors = @[(id)beforeColor.CGColor,(id)afterColor.CGColor];
    [self.view.layer addSublayer:gradientLayer];
    if (isAsMask) {
        gradientLayer.mask = label.layer;
    }
    else{
        [gradientLayer addSublayer:label.layer];
    }
    label.layer.frame = gradientLayer.bounds;
}


@end
