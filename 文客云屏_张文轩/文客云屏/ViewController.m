//
//  ViewController.m
//  文客云屏
//
//  Created by 张文轩 on 2017/4/25.
//  Copyright © 2017年 张文轩. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "AFSecurityPolicy.h"
#import "CollegeView.h"
#import "MainCollege1.h"
#import "WkView.h"
#import "ButtonView.h"

@interface ViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic) UIScrollView *sv;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic,strong) NSTimer*timer;
@property (nonatomic,strong) NSTimer*timer2;
@property (weak, nonatomic) UIPageControl *pageControl2;
@property (nonatomic,weak) UITableView *tableview;
@property (nonatomic,strong) NSDictionary *dic;
@property (nonatomic,strong) NSString *str;
@property (nonatomic,strong) NSNumber *num;
@property (strong, nonatomic) NSArray *dataList;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
/********************************顶部Banner*************************************/
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
    _pageControl.numberOfPages = 3;
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
    
    
/*******************************中部按钮*****************************************/
    [_signIn addTarget:self action:@selector(signin) forControlEvents:UIControlEventTouchUpInside];
    [_welFare addTarget:self action:@selector(welfare) forControlEvents:UIControlEventTouchUpInside];
    [_wkAction addTarget:self action:@selector(wkaction) forControlEvents:UIControlEventTouchUpInside];
    [_redPacket addTarget:self action:@selector(redpacket) forControlEvents:UIControlEventTouchUpInside];
    
    
/*******************************中部按钮*****************************************/
    
    
/*******************************底部scrollview**********************************/
    
    UIScrollView* sv = [[UIScrollView alloc] init];
    sv.frame = CGRectMake(7, 336, 362, 289);
    _sv = sv;
    [self.view addSubview:sv];
    
    sv.contentSize = CGSizeMake(724, 289);
    sv.alwaysBounceHorizontal = NO;
    sv.scrollEnabled = YES;
    sv.bounces = NO;
    sv.showsHorizontalScrollIndicator = NO;
    sv.pagingEnabled = YES;
    //pageControl定义
    UIPageControl *pageControl2 = [[UIPageControl alloc]init];
    _pageControl2 = pageControl2;
    pageControl2.frame = CGRectMake(161.5, 265, 39, 37);
    pageControl2.numberOfPages = 2;
    [sv addSubview:pageControl2];
    //文客和院校
    UILabel *label1 = [[UILabel alloc] init];
    label1.frame = CGRectMake(0, 0, 42, 40);
    label1.text = @"文客";
    label1.textColor = [UIColor whiteColor];
    [sv addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.frame = CGRectMake(362, 0, 60, 40);
    label2.text = @"院校";
    label2.textColor = [UIColor whiteColor];
    [sv addSubview:label2];
    
//    UILabel *zwx = [[UILabel alloc]init];
//    zwx.frame = CGRectMake(180, 0, 80, 40);
//    zwx.text = @"张文轩";
//    zwx.textColor = [UIColor whiteColor];
//    [sv addSubview:zwx];
    
    //查看更多
    UIButton *button1 = [[UIButton alloc]init];
    button1.frame = CGRectMake(302, 0, 60, 40);
    [button1 setTitle:@"查看更多" forState:UIControlStateNormal];
    button1.titleLabel.font = [UIFont systemFontOfSize:14];
    [sv addSubview:button1];
    [button1 addTarget:self action:@selector(pushView1) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button2 = [[UIButton alloc]init];
    button2.frame = CGRectMake(664, 0, 60, 40);
    [button2 setTitle:@"查看更多" forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont systemFontOfSize:14];
    [sv addSubview:button2];
    [button2 addTarget:self action:@selector(pushView2) forControlEvents:UIControlEventTouchUpInside];
    
    //左边图片

    UIButton *btn1 = [[UIButton alloc]init];
    btn1.frame = CGRectMake(2, 38, 178, 249);
    [btn1 setBackgroundImage:[UIImage imageNamed:@"首页文客1"] forState:UIControlStateNormal];
    [sv addSubview:btn1];
    [btn1 addTarget:self action:@selector(pushView1) forControlEvents:UIControlEventTouchUpInside];

    UIButton *btn2 = [[UIButton alloc]init];
    btn2.frame = CGRectMake(181, 38, 178, 127);
    [btn2 setBackgroundImage:[UIImage imageNamed:@"首页文客2"] forState:UIControlStateNormal];
    [sv addSubview:btn2];
    [btn2 addTarget:self action:@selector(pushView1) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn3 = [[UIButton alloc]init];
    btn3.frame = CGRectMake(181, 166, 178, 121);
    [btn3 setBackgroundImage:[UIImage imageNamed:@"首页文客3"] forState:UIControlStateNormal];
    [sv addSubview:btn3];
    [btn3 addTarget:self action:@selector(pushView1) forControlEvents:UIControlEventTouchUpInside];
    
    
    //tableview设置
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(356, 40, self.view.bounds.size.width, 249) style:UITableViewStylePlain];
    _tableview = tableview;
    [sv addSubview:_tableview];
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    _tableview.backgroundColor=[UIColor clearColor];
    _tableview.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"院校背景"]];
    [tableview setRowHeight:249/3];
    

    
    //监听scrollview的滚动
    self.sv.delegate = self;
    //定时器
    NSTimer *timer2 = [NSTimer timerWithTimeInterval:30.0 target:self selector:@selector(nextImage2) userInfo:nil repeats:YES];
    self.timer2 = timer2;
    //消息循环
    NSRunLoop *runloop2 = [NSRunLoop currentRunLoop];
    [runloop2 addTimer:timer2 forMode:NSRunLoopCommonModes];


/*******************************底部scrollview**********************************/
   
}
//中部按钮
- (void) signin
{
    ButtonView *buttonview = [[ButtonView alloc]init];
    [self presentViewController:buttonview animated:YES completion:^{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"pushToSignin" object:nil];
    }];
}
- (void) welfare
{
    ButtonView *buttonview = [[ButtonView alloc]init];
    
    [self presentViewController:buttonview animated:YES completion:^{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"pushToWelfare" object:nil];
    }];
}
- (void) wkaction
{
    ButtonView *buttonview = [[ButtonView alloc]init];
    [self presentViewController:buttonview animated:YES completion:^{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"pushToWkaction" object:nil];
    }];
}
- (void) redpacket
{
    ButtonView *buttonview = [[ButtonView alloc]init];
    [self presentViewController:buttonview animated:YES completion:^{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"pushToRedpacket" object:nil];
    }];
}

//查看更多按钮
- (void) pushView1
{
    WkView *wkview = [[WkView alloc]init];
    [self presentViewController:wkview animated:YES completion:^{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"pushToWk" object:nil];
    }];
}
- (void) pushView2
{
    CollegeView *collegeview = [[CollegeView alloc]init];
    [self presentViewController:collegeview animated:YES completion:^{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"pushToC" object:nil];
    }];
}
//banner
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
//底部scroll
- (void) nextImage2
{
    NSInteger page = self.pageControl2.currentPage;
    if (page == 1) {
        page = 0;
    }else
    {
        page++;
    }
    CGFloat x = page *self.sv.frame.size.width;
    [UIView animateWithDuration:1.0 animations:^{
        self.sv.contentOffset = CGPointMake(x, 0);}];
}

#pragma mark - scrollview的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
        //顶部banner
        int page = (_scrollview.contentOffset.x + _scrollview.frame.size.width / 2)/_scrollview.frame.size.width;
        self.pageControl.currentPage = page;

        //底部
        int page2 = (_sv.contentOffset.x + _sv.frame.size.width / 2)/_sv.frame.size.width;
        self.pageControl2.currentPage = page2;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //停止定时器
    if (scrollView == _scrollview) {
        [self.timer invalidate];
    }
    
    if (scrollView == _sv) {
        [self.timer2 invalidate];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    self.timer2 = [NSTimer scheduledTimerWithTimeInterval:30.0 target:self selector:@selector(nextImage2) userInfo:nil repeats:YES];
}


#pragma mark - 数据源方法
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arry1 = [NSArray arrayWithObjects:@"我校举办纪念“一二·九”运动系列主题教育活动",@"学工处举办第36期德风议事厅活动",@"我校开展“践行核心价值，守护诚信校园”主题系列活动", nil];
    NSArray *arry2 = [NSArray arrayWithObjects:@"铭记一二·九运动，勿忘国耻，为中华崛起而读书；八十一载峥嵘岁月，回眸历史，谱写中国未来华章。在一二·九运动纪念日临近之际，为增进大学生对中国历史的了解，激发同学们的爱国热情，鼓励同学们为民族复兴而奋斗，校学生工作处组织了一系列主题教育活动，把培育和践行社会主义核心价值观教育贯穿主题教育全过程，号召广大南师学子铭记历史、勿忘国耻，勇挑时代重任，践行青春梦想。",@"在电子信息技术飞速发展的今天，纸质书籍是否会被取而代之？为提倡纸本阅读，国内大城市地铁中掀起了一场“丢书大作战”，即由娱乐界明星发起的，把自己阅读过的书籍分享给陌生人的公益活动。对于这场活动究竟该如何评判？12月1日下午，由学工处主办，学工处学生助理团与强化院、教师院学生会联合承办的第36期德风议事厅，在学明楼207教室成功举办。教师院殷志伟老师、强化院学生会主席邱亦涵受邀作为指导参加了此次活动，活动由马祥然和杨顺媛主持。",@"为积极响应团中央号召，引导广大青年学生深入践行社会主义核心价值观，积极参与社会主义诚信建设，营造校园诚实守信的文化氛围，11月至12月，校团委组织校志协、各学院青协开展了以“践行核心价值，守护诚信校园”为主题的丰富多彩的活动。", nil];
    //创建cell
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    //给cell的子控件赋值
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",arry1[indexPath.row]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",arry2[indexPath.row]];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    NSString *yxImage = [NSString stringWithFormat:@"yx%ld",(long)indexPath.row];
    cell.imageView.image = [UIImage imageNamed:yxImage];
    CGSize itemSize = CGSizeMake(100, 80);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //返回cell
    return cell;
}

//tableview代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainCollege1 *detail1 = [[MainCollege1 alloc]init];
    if (indexPath.row == 0) {
        [self presentViewController:detail1 animated:YES completion:^{
            [[NSNotificationCenter defaultCenter]postNotificationName:@"pushToC1" object:nil];
        }];
    }
    if (indexPath.row == 1) {
        [self presentViewController:detail1 animated:YES completion:^{
            [[NSNotificationCenter defaultCenter]postNotificationName:@"pushToC2" object:nil];
        }];
    }
    if (indexPath.row == 2) {
        [self presentViewController:detail1 animated:YES completion:^{
            [[NSNotificationCenter defaultCenter]postNotificationName:@"pushToC3" object:nil];
        }];
    }
}
@end
