//
//  ViewController2ViewController.m
//  文客云屏
//
//  Created by 张文轩 on 2017/4/29.
//  Copyright © 2017年 张文轩. All rights reserved.
//

#import "CollegeView.h"
#import "ViewController.h"
#import "MainCollege1.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface CollegeView ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIView *navView;
    UILabel *sliderLabel;
    UIButton *firstBtn;
    UIButton *secondBtn;
    UIButton *thirdBtn;
    UIButton *forthBtn;
    UIButton *fifthBtn;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) UITableView *tableview1;
@property (nonatomic,strong) UITableView *tableview2;
@property (nonatomic,strong) UITableView *tableview3;
@property (nonatomic,strong) UITableView *tableview4;
@property (nonatomic,strong) UITableView *tableview5;
@property (nonatomic,strong) UIView *view1;
@property (nonatomic,strong) UIView *view2;
@property (nonatomic,strong) UIView *view3;
@property (nonatomic,strong) UIView *view4;
@property (nonatomic,strong) UIView *view5;
@property UITextView *textView;

//滑动导航栏
@property (strong,nonatomic)UIScrollView *mainScrollView;


@end

@implementation CollegeView

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
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onNotifiction1:) name:@"pushToC" object:nil];
}

- (void)onNotifiction1:(NSNotification*)item{
    [self sliderAction:firstBtn];
}

- (void)initUI{
    navView = [[UIView alloc]initWithFrame:CGRectMake(0, 186, kScreenWidth, 40)];
    UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    img1.image = [UIImage imageNamed:@"首页v2-文客_0001s_0012_图层-13"];
    [navView addSubview:img1];
    [self.view addSubview:navView];
    firstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    firstBtn.frame = CGRectMake(30, 0, (kScreenWidth-60)/5, navView.frame.size.height);
    firstBtn.titleLabel.font = [UIFont boldSystemFontOfSize:11];
    [firstBtn addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
    [firstBtn setTitle:@"校方通知" forState:UIControlStateNormal];
    [firstBtn setBackgroundImage:[UIImage imageNamed:@"首页v2-文客_0001s_0008_图层-15-副本-22"] forState:UIControlStateNormal];
    [firstBtn setTitleColor:[UIColor colorWithRed:100/255.0 green:149/255.0 blue:237/255.0 alpha:1.0] forState:UIControlStateNormal];
    firstBtn.tag = 1;
    [navView addSubview:firstBtn];
    
    
    secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    secondBtn.frame = CGRectMake(firstBtn.frame.origin.x+firstBtn.frame.size.width, firstBtn.frame.origin.y, (kScreenWidth-60)/5, navView.frame.size.height);
    secondBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [secondBtn addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
    [secondBtn setTitle:@"最新资讯" forState:UIControlStateNormal];
    [secondBtn setBackgroundImage:[UIImage imageNamed:@"首页v2-文客_0001s_0008_图层-15-副本-22"] forState:UIControlStateNormal];
    [secondBtn setTitleColor:[UIColor colorWithRed:100/255.0 green:149/255.0 blue:237/255.0 alpha:1.0] forState:UIControlStateNormal];
    secondBtn.tag = 2;
    [navView addSubview:secondBtn];
    
    
    thirdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    thirdBtn.frame = CGRectMake(secondBtn.frame.origin.x+secondBtn.frame.size.width, secondBtn.frame.origin.y, (kScreenWidth-60)/5, navView.frame.size.height);
    thirdBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [thirdBtn addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
    [thirdBtn setTitle:@"热门活动" forState:UIControlStateNormal];
    [thirdBtn setBackgroundImage:[UIImage imageNamed:@"首页v2-文客_0001s_0008_图层-15-副本-22"] forState:UIControlStateNormal];
    [thirdBtn setTitleColor:[UIColor colorWithRed:100/255.0 green:149/255.0 blue:237/255.0 alpha:1.0] forState:UIControlStateNormal];
    thirdBtn.tag = 3;
    [navView addSubview:thirdBtn];
    
    
    forthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forthBtn.frame = CGRectMake(thirdBtn.frame.origin.x+thirdBtn.frame.size.width, thirdBtn.frame.origin.y, (kScreenWidth-60)/5, navView.frame.size.height);
    forthBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [forthBtn addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
    [forthBtn setTitle:@"校团委" forState:UIControlStateNormal];
    [forthBtn setBackgroundImage:[UIImage imageNamed:@"首页v2-文客_0001s_0008_图层-15-副本-22"] forState:UIControlStateNormal];
    [forthBtn setTitleColor:[UIColor colorWithRed:100/255.0 green:149/255.0 blue:237/255.0 alpha:1.0] forState:UIControlStateNormal];
    forthBtn.tag = 4;
    [navView addSubview:forthBtn];
    
    
    fifthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    fifthBtn.frame = CGRectMake(forthBtn.frame.origin.x+forthBtn.frame.size.width, forthBtn.frame.origin.y, (kScreenWidth-60)/5, navView.frame.size.height);
    fifthBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [fifthBtn addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
    [fifthBtn setTitle:@"学生会" forState:UIControlStateNormal];
    [fifthBtn setBackgroundImage:[UIImage imageNamed:@"首页v2-文客_0001s_0008_图层-15-副本-22"] forState:UIControlStateNormal];
    [fifthBtn setTitleColor:[UIColor colorWithRed:100/255.0 green:149/255.0 blue:237/255.0 alpha:1.0] forState:UIControlStateNormal];
    fifthBtn.tag = 5;
    [navView addSubview:fifthBtn];
    
    
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
    _view1 = view1;
    _view2 = view2;
    _view3 = view3;
    _view4 = view4;
    _view5 = view5;
    NSArray *views = @[view1,view2,view3,view4,view5];
    UITableView *tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(30, -130, 315, 400)];
    UITableView *tableview2 = [[UITableView alloc]initWithFrame:CGRectMake(30, -130, 315, 400)];
    UITableView *tableview3 = [[UITableView alloc]initWithFrame:CGRectMake(30, -130, 315, 400)];
    UITableView *tableview4 = [[UITableView alloc]initWithFrame:CGRectMake(30, -130, 315, 400)];
    UITableView *tableview5 = [[UITableView alloc]initWithFrame:CGRectMake(30, -130, 315, 400)];
    _tableview1 = tableview1;
    _tableview2 = tableview2;
    _tableview3 = tableview3;
    _tableview4 = tableview4;
    _tableview5 = tableview5;
    [view1 addSubview:tableview1];
    [view2 addSubview:tableview2];
    [view3 addSubview:tableview3];
    [view4 addSubview:tableview4];
    [view5 addSubview:tableview5];
    tableview1.backgroundColor = [UIColor clearColor];
    tableview2.backgroundColor = [UIColor clearColor];
    tableview3.backgroundColor = [UIColor clearColor];
    tableview4.backgroundColor = [UIColor clearColor];
    tableview5.backgroundColor = [UIColor clearColor];
    [tableview1 setRowHeight:100];
    [tableview2 setRowHeight:100];
    [tableview3 setRowHeight:100];
    [tableview4 setRowHeight:100];
    [tableview5 setRowHeight:100];
    self.tableview1.delegate = self;
    self.tableview2.delegate = self;
    self.tableview3.delegate = self;
    self.tableview4.delegate = self;
    self.tableview5.delegate = self;
    self.tableview1.dataSource = self;
    self.tableview2.dataSource = self;
    self.tableview3.dataSource = self;
    self.tableview4.dataSource = self;
    self.tableview5.dataSource = self;
    for (int i = 0; i < views.count; i++){
        //添加背景，把五个view贴到mainScrollView上面
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

#pragma mark - 数据源方法
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arry1 = [NSArray arrayWithObjects:@"我校举办纪念“一二·九”运动系列主题教育活动",@"学工处举办第36期德风议事厅活动",@"我校开展“践行核心价值，守护诚信校园”主题系列活动", nil];
    NSArray *arry2 = [NSArray arrayWithObjects:@"铭记一二·九运动，勿忘国耻，为中华崛起而读书；八十一载峥嵘岁月，回眸历史，谱写中国未来华章。在一二·九运动纪念日临近之际，为增进大学生对中国历史的了解，激发同学们的爱国热情，鼓励同学们为民族复兴而奋斗，校学生工作处组织了一系列主题教育活动，把培育和践行社会主义核心价值观教育贯穿主题教育全过程，号召广大南师学子铭记历史、勿忘国耻，勇挑时代重任，践行青春梦想。",@"在电子信息技术飞速发展的今天，纸质书籍是否会被取而代之？为提倡纸本阅读，国内大城市地铁中掀起了一场“丢书大作战”，即由娱乐界明星发起的，把自己阅读过的书籍分享给陌生人的公益活动。对于这场活动究竟该如何评判？12月1日下午，由学工处主办，学工处学生助理团与强化院、教师院学生会联合承办的第36期德风议事厅，在学明楼207教室成功举办。教师院殷志伟老师、强化院学生会主席邱亦涵受邀作为指导参加了此次活动，活动由马祥然和杨顺媛主持。",@"为积极响应团中央号召，引导广大青年学生深入践行社会主义核心价值观，积极参与社会主义诚信建设，营造校园诚实守信的文化氛围，11月至12月，校团委组织校志协、各学院青协开展了以“践行核心价值，守护诚信校园”为主题的丰富多彩的活动。", nil];
    //创建cell
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    //给cell的子控件赋值
    cell.backgroundColor = [UIColor clearColor];
    if ( tableView == _tableview1) {
        if ( indexPath.row == 1) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@",arry1[0]];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",arry2[0]];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.detailTextLabel.textColor = [UIColor whiteColor];
        }
    }
    if ( tableView == _tableview2) {
        if ( indexPath.row == 1) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@",arry1[1]];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",arry2[1]];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.detailTextLabel.textColor = [UIColor whiteColor];
        }
    }
    if ( tableView == _tableview3) {
        if ( indexPath.row == 1) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@",arry1[2]];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",arry2[2]];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.detailTextLabel.textColor = [UIColor whiteColor];
        }
    }

    //返回cell
    return cell;
}

//tableview代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainCollege1 *detail1 = [[MainCollege1 alloc]init];
    if (indexPath.row == 1){
    if (tableView == _tableview1) {
        [self presentViewController:detail1 animated:YES completion:^{
            [[NSNotificationCenter defaultCenter]postNotificationName:@"pushToC1" object:nil];
        }];
            }
    if (tableView == _tableview2) {
        [self presentViewController:detail1 animated:YES completion:^{
            [[NSNotificationCenter defaultCenter]postNotificationName:@"pushToC2" object:nil];
        }];
            }
    if (tableView == _tableview3) {
        [self presentViewController:detail1 animated:YES completion:^{
            [[NSNotificationCenter defaultCenter]postNotificationName:@"pushToC3" object:nil];
        }];
            }
    }
}
@end
