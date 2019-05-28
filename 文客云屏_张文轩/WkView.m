//
//  WkView.m
//  文客云屏
//
//  Created by 张文轩 on 2017/5/8.
//  Copyright © 2017年 张文轩. All rights reserved.
//

#import "WkView.h"
#import "ViewController.h"
#import "MovieDetail.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface WkView ()<UIScrollViewDelegate>
{
    UIScrollView *navView;
    UILabel *sliderLabel;
    UIButton *firstBtn;
    UIButton *secondBtn;
    UIButton *thirdBtn;
    UIButton *forthBtn;
    UIButton *fifthBtn;
    UIButton *sixthBtn;
    UIButton *seventhBtn;
    UIButton *eighthBtn;
    UIButton *ninthBtn;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic,strong) NSTimer *timer;
@property (strong,nonatomic) UIScrollView *scroll3;

//滑动导航栏
@property (strong,nonatomic)UIScrollView *mainScrollView;

@end

@implementation WkView

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *background = [[UIImageView alloc]init];
    [self.view addSubview:background];
    background.frame = CGRectMake(0, 0, 375, 667);
    background.image = [UIImage imageNamed:@"首页v2-文客_0000_图层-15"];
    /********************************顶部Banner*************************************/
    UIScrollView* scrollview = [[UIScrollView alloc]init];
    UIPageControl* pageControl = [[UIPageControl alloc]init];
    _scrollview = scrollview;
    _pageControl = pageControl;
    _scrollview.frame = CGRectMake(0, 20, 375, 166);
    _pageControl.frame = CGRectMake(168, 145, 39, 37);
    [self.view addSubview:_scrollview];
    [self.scrollview addSubview:_pageControl];
    CGFloat imageW = self.scrollview.frame.size.width;
    CGFloat imageH = self.scrollview.frame.size.height;
    CGFloat imageY = 0;
    NSInteger totalCount = 3;
    for (int i = 0; i < totalCount; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        CGFloat imageX = i * imageW;
        imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
        NSString *name = [NSString stringWithFormat:@"banner%d", i + 1];
        imageView.image = [UIImage imageNamed:name];
        self.scrollview.showsHorizontalScrollIndicator = NO;
        [self.scrollview addSubview:imageView];
    }
    //定义pagecontrol
    pageControl.numberOfPages = 3;
    //设置scrollview的滚动范围
    CGFloat contentW = totalCount *imageW;
    //不允许在垂直方向上进行滚动
    self.scrollview.contentSize = CGSizeMake(contentW, 0);
    //设置分页
    self.scrollview.pagingEnabled = YES;
    //监听scrollview的滚动
    self.scrollview.delegate = self;
    //定时器
    NSTimer *timer = [NSTimer timerWithTimeInterval:10.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    self.timer = timer;
    //消息循环
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    [runloop addTimer:timer forMode:NSRunLoopCommonModes];
    
    /********************************顶部Banner*************************************/
    /******************************************************************************/
    /********************************中部scroll*************************************/
    //设置scrollView
    [self setMainScrollView];
    [self initUI];
    
    
    
    
    /********************************中部scroll*************************************/
    /******************************************************************************/
    //右下角返回和首页
    UIButton *shouye = [[UIButton alloc]init];
    shouye.frame = CGRectMake(self.view.bounds.size.width*0.87, self.view.bounds.size.height*0.704, self.view.bounds.size.width*0.09, self.view.bounds.size.width*0.09);
    [shouye setBackgroundImage:[UIImage imageNamed:@"首页v2-文客_0002s_0001s_0001_椭圆-3"] forState:UIControlStateNormal];
    [shouye setImage:[UIImage imageNamed:@"首页v2-文客_0002s_0001s_0000_图层-39"] forState:UIControlStateNormal];
    shouye.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [self.view addSubview:shouye];
    UIButton *fanhui = [[UIButton alloc]init];
    fanhui.frame = CGRectMake(self.view.bounds.size.width*0.87, self.view.bounds.size.height*0.764, self.view.bounds.size.width*0.09, self.view.bounds.size.width*0.09);
    [fanhui setBackgroundImage:[UIImage imageNamed:@"首页v2-文客_0002s_0000s_0001_椭圆-3-副本"] forState:UIControlStateNormal];
    [fanhui setImage:[UIImage imageNamed:@"首页v2-文客_0002s_0000s_0000_图层-42"] forState:UIControlStateNormal];
    fanhui.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [self.view addSubview:fanhui];
    //按钮的实现
    [shouye addTarget:self action:@selector(backView) forControlEvents:UIControlEventTouchUpInside];
    [fanhui addTarget:self action:@selector(backView) forControlEvents:UIControlEventTouchUpInside];
    
    //底部文客
    UIImageView *dibu = [[UIImageView alloc]init];
    dibu.frame = CGRectMake(0, self.view.bounds.size.height*0.953, self.view.bounds.size.width, self.view.bounds.size.height*0.047);
    dibu.image = [UIImage imageNamed:@"首页v2-文客_0000_foot"];
    [self.view addSubview:dibu];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onNotifiction1:) name:@"pushToWk" object:nil];
}

- (void)onNotifiction1:(NSNotification*)item{
    [self sliderAction:firstBtn];
}

- (void)initUI{
    navView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 186, kScreenWidth, 40)];
    navView.contentSize = CGSizeMake(2*kScreenWidth, 0);
    navView.showsHorizontalScrollIndicator = NO;
    UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    img1.image = [UIImage imageNamed:@"首页v2-文客_0001s_0012_图层-13"];
    [navView addSubview:img1];
    [self.view addSubview:navView];
    firstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    firstBtn.frame = CGRectMake(30, 0, (kScreenWidth-60)/5, navView.frame.size.height);
    firstBtn.titleLabel.font = [UIFont boldSystemFontOfSize:11];
    [firstBtn addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
    [firstBtn setTitle:@"电影" forState:UIControlStateNormal];
    [firstBtn setBackgroundImage:[UIImage imageNamed:@"首页v2-文客_0001s_0008_图层-15-副本-22"] forState:UIControlStateNormal];
    [firstBtn setTitleColor:[UIColor colorWithRed:100/255.0 green:149/255.0 blue:237/255.0 alpha:1.0] forState:UIControlStateNormal];
    firstBtn.tag = 1;
    [navView addSubview:firstBtn];
    
    
    secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    secondBtn.frame = CGRectMake(firstBtn.frame.origin.x+firstBtn.frame.size.width, firstBtn.frame.origin.y, (kScreenWidth-60)/5, navView.frame.size.height);
    secondBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [secondBtn addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
    [secondBtn setTitle:@"音乐" forState:UIControlStateNormal];
    [secondBtn setBackgroundImage:[UIImage imageNamed:@"首页v2-文客_0001s_0008_图层-15-副本-22"] forState:UIControlStateNormal];
    [secondBtn setTitleColor:[UIColor colorWithRed:100/255.0 green:149/255.0 blue:237/255.0 alpha:1.0] forState:UIControlStateNormal];
    secondBtn.tag = 2;
    [navView addSubview:secondBtn];
    
    
    thirdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    thirdBtn.frame = CGRectMake(secondBtn.frame.origin.x+secondBtn.frame.size.width, secondBtn.frame.origin.y, (kScreenWidth-60)/5, navView.frame.size.height);
    thirdBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [thirdBtn addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
    [thirdBtn setTitle:@"戏剧" forState:UIControlStateNormal];
    [thirdBtn setBackgroundImage:[UIImage imageNamed:@"首页v2-文客_0001s_0008_图层-15-副本-22"] forState:UIControlStateNormal];
    [thirdBtn setTitleColor:[UIColor colorWithRed:100/255.0 green:149/255.0 blue:237/255.0 alpha:1.0] forState:UIControlStateNormal];
    thirdBtn.tag = 3;
    [navView addSubview:thirdBtn];
    
    
    forthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forthBtn.frame = CGRectMake(thirdBtn.frame.origin.x+thirdBtn.frame.size.width, thirdBtn.frame.origin.y, (kScreenWidth-60)/5, navView.frame.size.height);
    forthBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [forthBtn addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
    [forthBtn setTitle:@"曲艺" forState:UIControlStateNormal];
    [forthBtn setBackgroundImage:[UIImage imageNamed:@"首页v2-文客_0001s_0008_图层-15-副本-22"] forState:UIControlStateNormal];
    [forthBtn setTitleColor:[UIColor colorWithRed:100/255.0 green:149/255.0 blue:237/255.0 alpha:1.0] forState:UIControlStateNormal];
    forthBtn.tag = 4;
    [navView addSubview:forthBtn];
    
    
    fifthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    fifthBtn.frame = CGRectMake(forthBtn.frame.origin.x+forthBtn.frame.size.width, forthBtn.frame.origin.y, (kScreenWidth-60)/5, navView.frame.size.height);
    fifthBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [fifthBtn addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
    [fifthBtn setTitle:@"戏曲" forState:UIControlStateNormal];
    [fifthBtn setBackgroundImage:[UIImage imageNamed:@"首页v2-文客_0001s_0008_图层-15-副本-22"] forState:UIControlStateNormal];
    [fifthBtn setTitleColor:[UIColor colorWithRed:100/255.0 green:149/255.0 blue:237/255.0 alpha:1.0] forState:UIControlStateNormal];
    fifthBtn.tag = 5;
    [navView addSubview:fifthBtn];
    
    sixthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sixthBtn.frame = CGRectMake(fifthBtn.frame.origin.x+fifthBtn.frame.size.width, fifthBtn.frame.origin.y, (kScreenWidth-60)/5, navView.frame.size.height);
    sixthBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [sixthBtn addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
    [sixthBtn setTitle:@"展览" forState:UIControlStateNormal];
    [sixthBtn setBackgroundImage:[UIImage imageNamed:@"首页v2-文客_0001s_0008_图层-15-副本-22"] forState:UIControlStateNormal];
    [sixthBtn setTitleColor:[UIColor colorWithRed:100/255.0 green:149/255.0 blue:237/255.0 alpha:1.0] forState:UIControlStateNormal];
    sixthBtn.tag = 6;
    [navView addSubview:sixthBtn];
    
    seventhBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    seventhBtn.frame = CGRectMake(sixthBtn.frame.origin.x+sixthBtn.frame.size.width, sixthBtn.frame.origin.y, (kScreenWidth-60)/5, navView.frame.size.height);
    seventhBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [seventhBtn addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
    [seventhBtn setTitle:@"活动" forState:UIControlStateNormal];
    [seventhBtn setBackgroundImage:[UIImage imageNamed:@"首页v2-文客_0001s_0008_图层-15-副本-22"] forState:UIControlStateNormal];
    [seventhBtn setTitleColor:[UIColor colorWithRed:100/255.0 green:149/255.0 blue:237/255.0 alpha:1.0] forState:UIControlStateNormal];
    seventhBtn.tag = 7;
    [navView addSubview:seventhBtn];
    
    eighthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    eighthBtn.frame = CGRectMake(seventhBtn.frame.origin.x+seventhBtn.frame.size.width, seventhBtn.frame.origin.y, (kScreenWidth-60)/5, navView.frame.size.height);
    eighthBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [eighthBtn addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
    [eighthBtn setTitle:@"文博" forState:UIControlStateNormal];
    [eighthBtn setBackgroundImage:[UIImage imageNamed:@"首页v2-文客_0001s_0008_图层-15-副本-22"] forState:UIControlStateNormal];
    [eighthBtn setTitleColor:[UIColor colorWithRed:100/255.0 green:149/255.0 blue:237/255.0 alpha:1.0] forState:UIControlStateNormal];
    eighthBtn.tag = 8;
    [navView addSubview:eighthBtn];
    
    ninthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ninthBtn.frame = CGRectMake(eighthBtn.frame.origin.x+eighthBtn.frame.size.width, eighthBtn.frame.origin.y, (kScreenWidth-60)/5, navView.frame.size.height);
    ninthBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [ninthBtn addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
    [ninthBtn setTitle:@"文客" forState:UIControlStateNormal];
    [ninthBtn setBackgroundImage:[UIImage imageNamed:@"首页v2-文客_0001s_0008_图层-15-副本-22"] forState:UIControlStateNormal];
    [ninthBtn setTitleColor:[UIColor colorWithRed:100/255.0 green:149/255.0 blue:237/255.0 alpha:1.0] forState:UIControlStateNormal];
    ninthBtn.tag = 9;
    [navView addSubview:ninthBtn];
    
    
    sliderLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 40-5, (kScreenWidth-60)/5, 5)];
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (kScreenWidth-60)/5, 5)];
    imageview.image = [UIImage imageNamed:@"首页v2-文客_0001s_0007_图层-15-副本-5"];
    [sliderLabel addSubview:imageview];
    [navView addSubview:sliderLabel];
    self.navigationItem.titleView = navView;

}
-(UIButton *)theSeletedBtn{
    if (firstBtn.selected) {
        return firstBtn;
    }else if (secondBtn.selected){
        return secondBtn;
    }else if (thirdBtn.selected){
        return thirdBtn;
    }else if (forthBtn.selected){
        return forthBtn;
    }else if (fifthBtn.selected){
        return fifthBtn;
    }else if (sixthBtn.selected){
        return sixthBtn;
    }else if (seventhBtn.selected){
        return seventhBtn;
    }else if (eighthBtn.selected){
        return eighthBtn;
    }else if (ninthBtn.selected){
        return ninthBtn;
    }else{
        return  nil;
    }
}

- (void) setMainScrollView{
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 186, kScreenWidth, 667-(186+self.view.bounds.size.height*0.047))];
    _mainScrollView.delegate = self;
    _mainScrollView.pagingEnabled = YES;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    _mainScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_mainScrollView];
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.bounds.size.height - 226 -self.view.bounds.size.height*0.047)];
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.bounds.size.height - 226 -self.view.bounds.size.height*0.047)];
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.bounds.size.height - 226 -self.view.bounds.size.height*0.047)];
    UIView *view4 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.bounds.size.height - 226 -self.view.bounds.size.height*0.047)];
    UIView *view5 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.bounds.size.height - 226 -self.view.bounds.size.height*0.047)];
    UIView *view6 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.bounds.size.height - 226 -self.view.bounds.size.height*0.047)];
    UIView *view7 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.bounds.size.height - 226 -self.view.bounds.size.height*0.047)];
    UIView *view8 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.bounds.size.height - 226 -self.view.bounds.size.height*0.047)];
    UIView *view9 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.bounds.size.height - 226 -self.view.bounds.size.height*0.047)];
    NSArray *views = @[view1,view2,view3,view4,view5,view6,view7,view8,view9];
    //电影滑动
    NSInteger totalCount = 8;
    UIScrollView *scroll3 = [[UIScrollView alloc]initWithFrame:CGRectMake(30, -110, 315, 400)];
    _scroll3 = scroll3;
    scroll3.contentSize = CGSizeMake(255*totalCount, 0);
    scroll3.pagingEnabled = YES;
    scroll3.showsHorizontalScrollIndicator = NO;
    scroll3.userInteractionEnabled = YES;
    scroll3.delaysContentTouches = NO;
    scroll3.canCancelContentTouches=YES;
    [view3 addSubview:scroll3];
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 140)];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"首页v2-文客_0002s_0000s_0006_图层-25-副本"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(M1) forControlEvents:UIControlEventTouchUpInside];
    btn1.layer.cornerRadius = 5;
    btn1.clipsToBounds = YES;
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(107.5, 0, 100, 140)];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"首页v2-文客_0002s_0000s_0003_图层-29-副本"] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(M2) forControlEvents:UIControlEventTouchUpInside];
    btn2.layer.cornerRadius = 5;
    btn2.clipsToBounds = YES;
    UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(215, 0, 100, 140)];
    [btn3 setBackgroundImage:[UIImage imageNamed:@"首页v2-文客_0002s_0000s_0000_图层-28-副本"] forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(M3) forControlEvents:UIControlEventTouchUpInside];
    btn3.layer.cornerRadius = 5;
    btn3.clipsToBounds = YES;
    UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 150, 80, 18)];
    img1.image = [UIImage imageNamed:@"首页v2-文客_0002s_0001s_0008_刘健大咖说"];
    UIImageView *img2 = [[UIImageView alloc]initWithFrame:CGRectMake(137.5, 150, 40, 18)];
    img2.image = [UIImage imageNamed:@"首页v2-文客_0002s_0001s_0005_Q大道"];
    UIImageView *img3 = [[UIImageView alloc]initWithFrame:CGRectMake(220, 150, 90, 18)];
    img3.image = [UIImage imageNamed:@"首页v2-文客_0002s_0001s_0002_好妹妹乐队..."];
    UIImageView *labelBackground = [[UIImageView alloc]initWithFrame:CGRectMake(-10, 150, 335, 27)];
    labelBackground.image = [UIImage imageNamed:@"文字阴影"];
    UIImageView *picBackground = [[UIImageView alloc]initWithFrame:CGRectMake(0, 140, 315, 10)];
    picBackground.image = [UIImage imageNamed:@"图片倒影"];
    NSArray *btn = @[btn1,btn2,btn3,img1,img2,img3,labelBackground,picBackground];
    for (int i = 0; i <totalCount; i++) {
        [scroll3 addSubview:btn[i]];
    }
    UIButton *left = [[UIButton alloc]initWithFrame:CGRectMake(5, 50, 16, 22)];
    [left setImage:[UIImage imageNamed:@"首页v2-文客_0002s_0001_左翻箭头"] forState:UIControlStateNormal];
    [view3 addSubview:left];
    UIButton *right = [[UIButton alloc]initWithFrame:CGRectMake(352, 50, 16, 22)];
    [right setImage:[UIImage imageNamed:@"首页v2-文客_0002s_0000_右翻箭头"] forState:UIControlStateNormal];
    [view3 addSubview:right];
    [left addTarget:self action:@selector(left:) forControlEvents:UIControlEventTouchUpInside];
    [right addTarget:self action:@selector(right:) forControlEvents:UIControlEventTouchUpInside];

    for (int i = 0; i < views.count; i++){
        //添加背景，把五个VC的view贴到mainScrollView上面
        UIView *pageView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth * i, 186, _mainScrollView.frame.size.width, 667-(186+self.view.bounds.size.height*0.047))];
        [pageView addSubview:views[i]];
        [_mainScrollView addSubview:pageView];
    }
    _mainScrollView.contentSize = CGSizeMake(kScreenWidth * (views.count), 0);
    
}
- (void) M1
{
    MovieDetail *M1 = [[MovieDetail alloc]init];
    [self presentViewController:M1 animated:YES completion:^{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"pushToM1" object:nil];
    }];
}
- (void) M2
{
    MovieDetail *M1 = [[MovieDetail alloc]init];
    [self presentViewController:M1 animated:YES completion:^{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"pushToM2" object:nil];
    }];
}
- (void) M3
{
    MovieDetail *M1 = [[MovieDetail alloc]init];
    [self presentViewController:M1 animated:YES completion:^{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"pushToM3" object:nil];
    }];
}
-(UIButton *)buttonWithTag:(NSInteger)tag{
    if (tag==1) {
        return firstBtn;
    }else if (tag==2){
        return secondBtn;
    }else if (tag==3){
        return thirdBtn;
    }else if (tag==4){
        return forthBtn;
    }else if (tag==5){
        return fifthBtn;
    }else if (tag==6){
        return sixthBtn;
    }else if (tag==7){
        return seventhBtn;
    }else if (tag==8){
        return eighthBtn;
    }else if (tag==9){
        return ninthBtn;
    }else{
        return nil;
    }
}

-(void)sliderAction:(UIButton *)sender{
    [self sliderAnimationWithTag:sender.tag];
    [UIView animateWithDuration:0.3 animations:^{
        _mainScrollView.contentOffset = CGPointMake(kScreenWidth * (sender.tag - 1), 0);
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void) left:(id)sender
{
    if (_scroll3.contentOffset.x == 0){
        
    }
//    if (_scroll3.contentOffset.x == 255) {
//        [_scroll3 setContentOffset:CGPointMake(0, 0) animated:YES];
//    }
//    if (_scroll3.contentOffset.x == 510) {
//        [_scroll3 setContentOffset:CGPointMake(255, 0) animated:YES];
//    }
}

- (void) right:(id)sender
{
    if (_scroll3.contentOffset.x == 510) {
        
    }
//    if (_scroll3.contentOffset.x == 255) {
//        [_scroll3 setContentOffset:CGPointMake(510, 0) animated:YES];
//    }
//    if (_scroll3.contentOffset.x == 0) {
//        [_scroll3 setContentOffset:CGPointMake(255, 0) animated:YES];
//    }
}


#pragma mark - sliderLabel滑动动画
- (void)sliderAnimationWithTag:(NSInteger)tag{
    firstBtn.selected = NO;
    secondBtn.selected = NO;
    thirdBtn.selected = NO;
    forthBtn.selected = NO;
    fifthBtn.selected = NO;
    sixthBtn.selected = NO;
    seventhBtn.selected = NO;
    eighthBtn.selected = NO;
    ninthBtn.selected = NO;
    UIButton *sender = [self buttonWithTag:tag];
    sender.selected = YES;
    //动画
    [UIView animateWithDuration:0.3 animations:^{
        sliderLabel.frame = CGRectMake(sender.frame.origin.x, sliderLabel.frame.origin.y, sliderLabel.frame.size.width, sliderLabel.frame.size.height);
        
    } completion:^(BOOL finished) {
        firstBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        secondBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        thirdBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        forthBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        fifthBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        sixthBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        seventhBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        eighthBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        ninthBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        
        sender.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        [sender setBackgroundImage:[UIImage imageNamed:@"首页v2-文客_0001s_0007_图层-15-副本-2"] forState:UIControlStateSelected];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    }];
    
}

- (void) nextImage
{
    NSInteger page = self.pageControl.currentPage;
    if (page == 2) {
        page = 0;
    }else
    {
        page++;
    }
    CGFloat x = page *self.scrollview.frame.size.width;
    [UIView animateWithDuration:1.0 animations:^{
        self.scrollview.contentOffset = CGPointMake(x, 0);}];
}


//返回首页
- (void) backView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - scrollview的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _scrollview){
        int page = (_scrollview.contentOffset.x + _scrollview.frame.size.width / 2)/_scrollview.frame.size.width;
        self.pageControl.currentPage = page;
    }
    
    if (scrollView == _mainScrollView) {
        double index_ = scrollView.contentOffset.x / kScreenWidth;
        [self sliderAnimationWithTag:(int)(index_+0.5)+1];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView == _scrollview){
        //停止定时器
        [self.timer invalidate];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
}

@end
