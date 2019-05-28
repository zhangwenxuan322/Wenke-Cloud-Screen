//
//  MainCollege1.m
//  文客云屏
//
//  Created by 张文轩 on 2017/5/8.
//  Copyright © 2017年 张文轩. All rights reserved.
//

#import "MainCollege1.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
@interface MainCollege1 ()<UIScrollViewDelegate>
{
    UIView *navView;
    UILabel *sliderLabel;
    UIButton *firstBtn;
    UIButton *secondBtn;
    UIButton *thirdBtn;
    UIButton *forthBtn;
    UIButton *fifthBtn;
}

@property UITextView *textView;
@property UITextView *textView1;
@property UITextView *textView2;
@property (nonatomic,strong) UILabel* label;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic,strong) NSTimer *timer;

//滑动导航栏
@property (strong,nonatomic)UIScrollView *mainScrollView;

@end

@implementation MainCollege1

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
    fanhui.frame = CGRectMake(self.view.bounds.size.width*0.90, self.view.bounds.size.height*0.764, self.view.bounds.size.width*0.09, self.view.bounds.size.width*0.09);
    [fanhui setBackgroundImage:[UIImage imageNamed:@"首页v2-文客_0002s_0000s_0001_椭圆-3-副本"] forState:UIControlStateNormal];
    [fanhui setImage:[UIImage imageNamed:@"首页v2-文客_0002s_0000s_0000_图层-42"] forState:UIControlStateNormal];
    fanhui.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [self.view addSubview:fanhui];
    //按钮的实现
    [fanhui addTarget:self action:@selector(backView) forControlEvents:UIControlEventTouchUpInside];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onNotifiction1:) name:@"pushToC1" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onNotifiction2:) name:@"pushToC2" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onNotifiction3:) name:@"pushToC3" object:nil];
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
    [secondBtn setTitle:@"热门活动" forState:UIControlStateNormal];
    [secondBtn setBackgroundImage:[UIImage imageNamed:@"首页v2-文客_0001s_0008_图层-15-副本-22"] forState:UIControlStateNormal];
    [secondBtn setTitleColor:[UIColor colorWithRed:100/255.0 green:149/255.0 blue:237/255.0 alpha:1.0] forState:UIControlStateNormal];
    secondBtn.tag = 2;
    [navView addSubview:secondBtn];
    
    
    thirdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    thirdBtn.frame = CGRectMake(secondBtn.frame.origin.x+secondBtn.frame.size.width, secondBtn.frame.origin.y, (kScreenWidth-60)/5, navView.frame.size.height);
    thirdBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [thirdBtn addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
    [thirdBtn setTitle:@"电子布告" forState:UIControlStateNormal];
    [thirdBtn setBackgroundImage:[UIImage imageNamed:@"首页v2-文客_0001s_0008_图层-15-副本-22"] forState:UIControlStateNormal];
    [thirdBtn setTitleColor:[UIColor colorWithRed:100/255.0 green:149/255.0 blue:237/255.0 alpha:1.0] forState:UIControlStateNormal];
    thirdBtn.tag = 3;
    [navView addSubview:thirdBtn];
    
    
    forthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forthBtn.frame = CGRectMake(thirdBtn.frame.origin.x+thirdBtn.frame.size.width, thirdBtn.frame.origin.y, (kScreenWidth-60)/5, navView.frame.size.height);
    forthBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [forthBtn addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
    [forthBtn setTitle:@"招募信息" forState:UIControlStateNormal];
    [forthBtn setBackgroundImage:[UIImage imageNamed:@"首页v2-文客_0001s_0008_图层-15-副本-22"] forState:UIControlStateNormal];
    [forthBtn setTitleColor:[UIColor colorWithRed:100/255.0 green:149/255.0 blue:237/255.0 alpha:1.0] forState:UIControlStateNormal];
    forthBtn.tag = 4;
    [navView addSubview:forthBtn];
    
    
    fifthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    fifthBtn.frame = CGRectMake(forthBtn.frame.origin.x+forthBtn.frame.size.width, forthBtn.frame.origin.y, (kScreenWidth-60)/5, navView.frame.size.height);
    fifthBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [fifthBtn addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
    [fifthBtn setTitle:@"讲座信息" forState:UIControlStateNormal];
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
    //text
    self.textView=[[UITextView alloc] initWithFrame:CGRectMake(30,-140, 315, 667-260)] ;
    
    self.textView.textColor= [UIColor whiteColor];
    
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.font= [UIFont fontWithName:@"Arial"size:12.0];
    self.textView.text=@"                    德风演讲　青春绽放\n      12月8日下午，由学生工作处主办，学工处本科学生助理团承办的第三届“德风杯”演讲大赛决赛暨纪念一二•九运动主题演讲比赛在图书馆西报告厅拉开帷幕。\n     “作为社会主义的接班人，作为国家未来的希望，我们应该有自己的想法，要树立远大的志向，尽自己的力量，为国家发展添砖加瓦”。“我们应向一二•九运动中的革命青年们学习，关心社会，为祖国的发展贡献力量”。围绕“青春绽放，爱我中华”这一主题，10位演讲者纷纷抒发了自己对国家的炙热情感，讲述了自己对中国梦想与个人理想的理解，分享了自己的青春故事，选手们准备充分、胸有成竹，侃侃而谈、字字珠玑，令在座观众内心激荡、受益良多。在两轮激烈的角逐之后，中北学院时闻悦同学荣获一等奖，化科院于道洋、教师院王宁、金女院刘梦洁三位同学荣获二等奖，公管院黄子萌、教师院许雅丽、社发院吴常亮三位同学荣获三等奖，另有三位同学荣获优秀奖。在场的评委为他们颁发了荣誉证书，并对获奖选手表示热烈祝贺。\n      凤凰鸣矣，于彼高冈；梧桐生矣，于彼朝阳。君子德风，见于演讲，爱我中华，青春绽放。在一二·九运动纪念日来临之际，南师学子以演讲弘爱国之情、树报国之志，他们追忆革命历史，讲述感人故事，为南师校园文化平添一份感动和暖意。\n                    特色宣传　青春激扬\n　　  12月9日，由校学工处主办，学工处助理团、校志愿者协会协办的一二·九运动宣传纪念活动于西区食堂前展开。活动通过发放宣传单的形式，向广大师生宣传一二·九运动的重要历史意义，重温一二·九爱国主义精神，的引导广大学生回顾历史，铭记革命先辈在抗击外来侵略、争取民族独立中付出的巨大牺牲与不懈努力，树立广大南师学子热爱祖国、不懈奋斗的坚定理想信念。\n　　  活动过程中，学生志愿者身着民国服装，打扮成北平街头青年学生的形象，将手中制作精美的一二·九运动历史知识宣传单递给每一位路过的同学和老师。一方面，以这种独特的装扮，提醒身边同学回顾一二·九运动的光辉历史，另一方面则通过这种独特的形式，表达对八十一年前北平进步青年、革命志士的追忆与敬仰。接过宣传单的同学们，他们中有的仔细阅读，有的拿出手机拍摄宣传单上的内容，有的则与身着民国服饰的志愿者合影留念。\n                    集体签名　铭记历史\n　　 在校学工处组织下，学工处助理团和校志愿者协会的志愿者们将两幅写有一二·九纪念口号的横幅放置于西区大学生活动中心前的小广场上，身着民国学生装的志愿者们，积极引导路过同学在纪念宣传横幅上签字，通过集体签名的方式，表达对先革命前辈的敬意、对未来振兴中华的坚定理想。一些经过此处的老师和路人，也纷纷到纪念横幅前驻足围观，并弯下腰签下自己的名字。\n　　    在集体签名的横幅旁，几位志愿者通过扩音器，向路过的同学们宣传一二·九运动史。路过的文学院播音主持专业的同学更是不禁主动上前，接过志愿者手中的扩音器，向路过的同学们大声喊出“勿忘国耻、振兴中华”的响亮口号，抒发自己胸中的爱国情怀，随之有更多的同学纷纷效仿，同学们高昂的口号喊出了南师人热爱祖国、砥砺奋进的青春理想与执着信念，让冬日的南师校园充满炙热的青春热情\n　　 回望八十一年前，一批爱国学生涌上街头，高呼抗日救国口号，为争取实现中华民族的自由解放贡献一己之力。在学校举办的纪念一二九运动系列主题教育活动中，我校学子充分展现了新时期大学生的青春与活力，用行动抒发出他们心中强烈的爱国热情。站在中华民族伟大复兴的历史新起点，我们更应传承和发扬一二·九精神，珍惜青春、努力拼搏，勇于追求自己的梦想，为实现中华民族伟大复兴贡献自己的力量！（学工处：文/党秦南　图/陈星光、谭茜、马依卉）";
    self.textView.scrollEnabled= YES;
    self.textView.editable=NO;
    self.textView.autoresizingMask= UIViewAutoresizingFlexibleHeight;
    [self.view addSubview: self.textView];
    [view1 addSubview:_textView];

    //text1
    self.textView1 = [[UITextView alloc] initWithFrame:CGRectMake(30,-140, 315, 667-260)] ;
    self.textView1.textColor = [UIColor whiteColor];
    self.textView1.backgroundColor = [UIColor clearColor];
    self.textView1.font= [UIFont fontWithName:@"Arial"size:12.0];
    self.textView1.text=@"      活动伊始，主持人向在座同学介绍了“丢书大作战”活动的来源、意义及其在中国开展的现状，并播放了相关视频。6组同学首先就“如火如荼，舶来品何得如此温度”这一议题进行了深讨。大家分别从“丢书”的形式、明星效应，以及人们的精神感受等方面分析了“丢书大作战”火爆的原因。发言者抽丝剥茧般的分析让在座的同学们对“丢书大作战”有了进一步的了解。而丢书作战是富有教育意义，还是流于形式？“丢书”究竟有没有用？在现场主持人的引导，活动进入第二个议题——“雾里看花，其意义究竟泰山鸿毛”。有同学表示，捡到书籍后，多数人只是将书作为社交手段发朋友圈作秀，并未真正阅读。他认为“丢书”行为只是模仿外来风潮，有哗众取宠之嫌。而另一名同学表示，“中国版丢书大作战”的出发点是引起大家的读书兴趣，连接陌生人之间的交流。然而，这场活动忽视了中国的文化环境从而导致了效果的不尽人意。\n　　  对于“中国版丢书大作战”的种种问题及影响，同学们进行了细致而深刻的分析和讨论。活动紧接着进入了第三个议题——“群雄逐鹿，纸质书究竟何去何从”。就这一议题，6组同学各抒己见，分析了纸质图书的发展问题。他们纷纷表示纸质书虽然有厚、重的缺点，但它的存在有其必然性。纸质书阅读包含着人类对书籍的一种传统情怀，给读者和作者一种思想和灵魂的交流，同时，电子书的便捷也伴随着种种影响人们健康问题，值得大家重视。\n                     活动临近尾声，强化院学生会主席邱亦涵也对此议题发表了自己的看法，她认为“丢书大作战”给丢书者带来的是一种忧虑——为书的命运的忧虑。在她看来，读书是一种习惯，读书的行为很大程度上关乎个人意愿，绝不单纯是一种时尚。紧接着，殷志伟老师肯定并补充了同学们的发言，他认为“丢书大作战”的目的是希望借此引起国民对读书的关注，但这项活动本身值得商榷，因为电子阅读带来的信息碎片化问题，使得深度阅读成为一件奢侈的事情。他指出，对于社会而言，应该国家和政府应该倡导公民阅读的普遍化和社会化，对于大学生而言，我们应该养成良好的阅读习惯，关注经典、反复精读、不断思考。殷老师的点评开拓了同学们的思路，发人深省。\n　　    此次德风议事厅，各个学院同学积极参与，对“中国版丢书大作战”事件进行了深度讨论。大众评审根据同学们的发言质量和积极性，评出了团体一二三等奖和一位最佳发言人，两位积极发言人，并向获奖者颁发了奖状和奖品\n      “丢书大作战”的风靡让大众再次把目光投向“读书”。当今社会，电子阅读等新事物的出现，一方面给人们的阅读提供了便利，另一方面，也让部分阅读者逐渐远离读书本质、脱离深度阅读，使阅读成为一种纯粹的娱乐。因而，重拾书本的确刻不容缓。此次德风议事厅在激烈的辩论中交流观点、碰撞思维，加深了同学们对“丢书”的了解和认识，对引导南师学子树立正确的价值观念，教育同学辩证分析时事热点问题，起到了很好的促进作用。（学工处：文/郝高蓓、唐裔惠、党秦南 图/赵伊辰";
    self.textView1.scrollEnabled= YES;
    self.textView1.editable=NO;
    self.textView1.autoresizingMask= UIViewAutoresizingFlexibleHeight;
    [view2 addSubview: self.textView1];
    
    //text2
    self.textView2=[[UITextView alloc] initWithFrame:CGRectMake(30,-140, 315, 667-260)] ;
    
    self.textView2.textColor= [UIColor whiteColor];
    self.textView2.backgroundColor = [UIColor clearColor];
    
    self.textView2.font= [UIFont fontWithName:@"Arial"size:12.0];
    self.textView2.text=@"                    开展主题班会　增强诚信意识\n      各学院开展了丰富多彩的诚信主题班会活动，从而增强同学们的诚信意识。金女院的同学为了让各位同学更加了解诚信的重要性，在班会上采用分享并讨论有趣的诚信小故事的方式，指出专业学习以及工作就业都是与诚信息息相关的；教师教育学院青年团开展了 “师说信语”主题班会设计大赛，旨在促进16级新生对教师教育学院的深入了解，增强学子们的诚信意识，同学们顺利完成了微课，并且让同学们在了解的同时树立更为长远的目标为师院学子树立模范；国教院在随园校区成功开展了以“践行核心价值，守护诚信校园”为主题的班会活动，通过PPT的形式和大家分享了与诚信有关的经典故事，对诚信问题展开了热烈地讨论，最后进行了诚信宣誓弘扬诚信之风……通过精彩纷呈的班会，同学们对于诚信的重要性有了进一步的认识，诚实做人、守信做事的观念在同学们心中树立起来。\n                     加强道德宣传　营造诚信氛围扬\n　　  举办了形式多样的宣传活动，在南师校园内外营造了人人守信、人人求信的良好氛围。“法德”志协主办的诚信小品大赛活动通过展现“诚信”这一传统美德与现代流行元素的碰撞，让同学们在笑声中感悟诚信的重要性；生科院志愿者们则怀着满满的热情，走进五福家园社区，志愿者们仔细、耐心地向居民们解释了这次活动的意义，宣传诚信生活，提醒市民提防社会上的虚假诈骗信息；环境学院“绿荫”志协联合心理健康中心举办了“诚信观影活动”，活动通过观影这种新颖模式学习和理解诚信，以独特的方式，教给同学们做人的基本准则；新闻传播学院“凡星”青协组织了以“践行核心价值观，守护诚信校园”为主题的微电影公益广告视频比赛，旨在以微电影为载体，通过最生动的形式向同学们发出倡议：养成诚信习惯，诚信做人；中北学院同心青年志愿者协会则精心组织了“守住诚信的心”主题征文、“书写诚信，诗意校园”主题三行诗以及“诚信知识进校园”微视频创作大赛三项院级活动，各系也积极地开展了“文明校园，诚信青春”主题教育并踊跃地参加了院级活动。一篇篇激情洋溢的文章、一首首优美动人的三行诗和一个个充满创意的微视频无一不体现了南师学子对“诚信”的深刻理解。\n                     参与游戏互动　体悟诚信内\n展了各种充满趣味的互动类活动，让同学们更进一步领悟诚信的内涵。公共管理学院新叶青协召集志愿青年成功举办了诚信故事交流分享会，话题涵盖了“乞讨诈骗”、“宿舍推销”、“电信诈骗”、“金融理财”等与大学生活息息相关的诚信安全问题；地科院“心韵”青协开展了“诚信知识进校园”活动，以寓教于乐的游戏形式，让广大青年学生群体在趣味活动中深刻体会诚信的价值所在，创建诚信校园，树立诚信学风；商院“牵手”青协举办了诚信知识进校园活动，为同学们开启了一场从古至今的穿越之旅，去探寻那历史背后的故事，向同学讲述了诚信廉洁的历史意蕴。\n　　    回顾我校近一个月“践行核心价值，守护诚信校园”主题系列活动，随着各项活动的圆满举办，诚信之风席卷了南师校园，诚信之潮涌动在每个人左右，诚信之花绽放在每一个南师学子的心头，整个南师弥漫着人人讲信用、人人促诚信的良好氛围。日后，我校仍将积极探索宣扬诚信的新途径，进一步推动校园的精神文化建设，为社会培养出更多诚实不欺、恪守信用的高素质人才。（校团委：刘嘉懿、章悦洋、殷皓";
    self.textView2.scrollEnabled= YES;
    self.textView2.editable=NO;
    self.textView2.autoresizingMask= UIViewAutoresizingFlexibleHeight;
    [view3 addSubview: self.textView2];

    NSArray *views = @[view1,view2,view3,view4,view5];
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
