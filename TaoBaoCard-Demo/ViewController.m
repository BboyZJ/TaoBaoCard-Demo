//
//  ViewController.m
//  TaoBaoCard-Demo
//
//  Created by 张建 on 2017/4/20.
//  Copyright © 2017年 JuZiShu. All rights reserved.
//

#import "ViewController.h"

#define kScreenH [UIScreen mainScreen].bounds.size.height
#define kScreenW [UIScreen mainScreen].bounds.size.width

@interface ViewController ()
////back
//@property (nonatomic,strong)UIView * backView;
//card
@property (nonatomic,strong)UIView * cartView;
//mask
@property (nonatomic,strong)UIView * maskView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //back
//    _backView = [[UIView alloc] initWithFrame:self.view.bounds];
//    _backView.backgroundColor = [UIColor orangeColor];
//    [self.view addSubview:_backView];
    
    //btn
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 30);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"pre" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    //initUI
    [self initUI];
    
}
//点击了pre
- (void)btnClick{
    
    CGRect rect = _cartView.frame;
    rect.origin.y = kScreenH / 2.0;
   
    [UIView animateWithDuration:0.3 animations:^{
        
        //mask
        [self.view addSubview:_maskView];
        _maskView.alpha = 0.5;
        
        //view
        self.view.layer.transform = [self firstTran];
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            //view
            self.view.layer.transform = [self secondTran];
            
            //card
            _cartView.frame = rect;
            [[UIApplication sharedApplication].keyWindow addSubview:_cartView];
            
        } completion:^(BOOL finished) {
            
            
        }];
        
    }];
    
}
- (CATransform3D)firstTran{
    
    CATransform3D transform = CATransform3DIdentity;
    //.m一定要写在CATransform3DRotate前面(.m42是平移效果)
    transform.m34 = 1.0/-400;//透视效果
    transform = CATransform3DRotate(transform,(M_PI/360 * 10), 1, 0,0 );//旋转角度等;
    transform = CATransform3DScale(transform, 0.9, 0.9, 1);
    return transform;
}
- (CATransform3D)secondTran{
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform, -(M_PI/360 * 10), 1, 0, 0);
    transform = CATransform3DScale(transform, 0.9, 0.9, 1);
    return transform;

}
//initUI
- (void)initUI{
    
    
    //card
    _cartView = [[UIView alloc] initWithFrame:CGRectMake(0,kScreenH,kScreenW, kScreenH / 2.0)];
    _cartView.backgroundColor = [UIColor greenColor];
    
    //mask
    _maskView = [[UIView alloc] initWithFrame:self.view.bounds];
    _maskView.backgroundColor = [UIColor blackColor];
    _maskView.alpha = 0.0;
    
    UITapGestureRecognizer * maskTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskTap)];
    maskTap.numberOfTapsRequired = 1;
    maskTap.numberOfTouchesRequired = 1;
    [_maskView addGestureRecognizer:maskTap];
}

//点击mask蒙层的事件
- (void)maskTap{
    
    //card
    CGRect rect = _cartView.frame;
    rect.origin.y = kScreenH;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _cartView.frame = rect;
        _maskView.alpha = 0.0f;
        
        //view
        self.view.layer.transform = CATransform3DIdentity;

        
    } completion:^(BOOL finished) {
        
        //移除
        [_cartView removeFromSuperview];
        [_maskView removeFromSuperview];
        
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
