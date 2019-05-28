//
//  MovieDetail.m
//  文客云屏
//
//  Created by 张文轩 on 2017/5/15.
//  Copyright © 2017年 张文轩. All rights reserved.
//

#import "MovieDetail.h"
#import "WkView.h"
#import "ButtonView.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface MovieDetail ()<UIScrollViewDelegate>
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

@property UITextView *textView;
@property UITextView *textView1;
@property UITextView *textView2;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic,strong) NSTimer *timer;

//滑动导航栏
@property (strong,nonatomic)UIScrollView *mainScrollView;
@end

@implementation MovieDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *background = [[UIImageView alloc]init];
    [self.view addSubview:background];
    background.frame = CGRectMake(0, 0, 375, 667);
    background.image = [UIImage imageNamed:@"首页v2-文客_0000_图层-15"];
    //顶部banner
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

    
    //设置scrollView
    [self setMainScrollView];
    [self initUI];
    
    
    
    //右下角返回
    UIButton *fanhui = [[UIButton alloc]init];
    fanhui.frame = CGRectMake(self.view.bounds.size.width*0.87, self.view.bounds.size.height*0.764, self.view.bounds.size.width*0.09, self.view.bounds.size.width*0.09);
    [fanhui setBackgroundImage:[UIImage imageNamed:@"首页v2-文客_0002s_0000s_0001_椭圆-3-副本"] forState:UIControlStateNormal];
    [fanhui setImage:[UIImage imageNamed:@"首页v2-文客_0002s_0000s_0000_图层-42"] forState:UIControlStateNormal];
    fanhui.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [self.view addSubview:fanhui];
    //按钮的实现
    [fanhui addTarget:self action:@selector(backView) forControlEvents:UIControlEventTouchUpInside];

    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onNotifiction1:) name:@"pushToM1" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onNotifiction2:) name:@"pushToM2" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onNotifiction3:) name:@"pushToM3" object:nil];
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

- (void)onNotifiction1:(NSNotification*)item{
    [self sliderAction:firstBtn];
}
- (void)onNotifiction2:(NSNotification*)item{
    [self sliderAction:secondBtn];
}
- (void)onNotifiction3:(NSNotification*)item{
    [self sliderAction:thirdBtn];
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
    
    //第一部电影
    UIImageView *img11 = [[UIImageView alloc]initWithFrame:CGRectMake(30, -100, 80, 100)];
    img11.image = [UIImage imageNamed:@"首页v2-文客_0002s_0000s_0006_图层-25-副本"];
    [view1 addSubview:img11];
    UIImageView *img12 = [[UIImageView alloc]initWithFrame:CGRectMake(32, 20, 76, 76)];
    img12.image = [UIImage imageNamed:@"Q大道"];
    [view1 addSubview:img12];
    UIImageView *img13 = [[UIImageView alloc]initWithFrame:CGRectMake(32, 100, 76, 30)];
    img13.image = [UIImage imageNamed:@"首页v2-文客_0002s_0003s_0001_文客&文客app-扫码购买"];
    [view1 addSubview:img13];

    //第二部电影
    UIImageView *img21 = [[UIImageView alloc]initWithFrame:CGRectMake(30, -100, 80, 100)];
    img21.image = [UIImage imageNamed:@"首页v2-文客_0002s_0000s_0003_图层-29-副本"];
    [view2 addSubview:img21];
    UIImageView *img22 = [[UIImageView alloc]initWithFrame:CGRectMake(32, 20, 76, 76)];
    img22.image = [UIImage imageNamed:@"Q大道"];
    [view2 addSubview:img22];
    UIImageView *img23 = [[UIImageView alloc]initWithFrame:CGRectMake(32, 100, 76, 30)];
    img23.image = [UIImage imageNamed:@"首页v2-文客_0002s_0003s_0001_文客&文客app-扫码购买"];
    [view2 addSubview:img23];
    
    //第三部电影
    UIImageView *img31 = [[UIImageView alloc]initWithFrame:CGRectMake(30, -100, 80, 100)];
    img31.image = [UIImage imageNamed:@"首页v2-文客_0002s_0000s_0003_图层-29-副本"];
    [view3 addSubview:img31];
    UIImageView *img32 = [[UIImageView alloc]initWithFrame:CGRectMake(32, 20, 76, 76)];
    img32.image = [UIImage imageNamed:@"Q大道"];
    [view3 addSubview:img32];
    UIImageView *img33 = [[UIImageView alloc]initWithFrame:CGRectMake(32, 100, 76, 30)];
    img33.image = [UIImage imageNamed:@"首页v2-文客_0002s_0003s_0001_文客&文客app-扫码购买"];
    [view3 addSubview:img33];
    
    NSArray *views = @[view1,view2,view3,view4,view5,view6,view7,view8,view9];
    for (int i = 0; i < views.count; i++){
        //添加背景，把五个VC的view贴到mainScrollView上面
        UIView *pageView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth * i, 186, _mainScrollView.frame.size.width, 667-(186+self.view.bounds.size.height*0.047))];
        [pageView addSubview:views[i]];
        [_mainScrollView addSubview:pageView];
    }
    _mainScrollView.contentSize = CGSizeMake(kScreenWidth * (views.count), 0);
    
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

#pragma mark - scrollview的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _scrollview){
        int page = (_scrollview.contentOffset.x + _scrollview.frame.size.width / 2)/_scrollview.frame.size.width;
        self.pageControl.currentPage = page;
    }
    if (scrollView == _mainScrollView)
    {
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
