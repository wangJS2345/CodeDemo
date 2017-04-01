//
//  GKVLCPlayVC.m
//  GKtfp
//
//  Created by apple on 2017/3/31.
//  Copyright © 2017年 LYP. All rights reserved.
//

#import "GKVLCPlayVC.h"

@interface GKVLCPlayVC () <VLCMediaPlayerDelegate,VLCMediaThumbnailerDelegate>
{
    //正在播放：YES
    BOOL isPlaying;
    //顶部底部显示YES
    BOOL isHidden;
    
    NSTimer *timer;
}
@property (nonatomic, strong) NSURL *playURL;
@property (nonatomic ,retain)VLCMediaPlayer *mediaPlayer;
//缩略图
@property (nonatomic ,retain)VLCMediaThumbnailer *thumbnailer;

/****************************/
//加载等待播放视图
@property (weak, nonatomic) IBOutlet UIView *waitView;
@property (weak, nonatomic) IBOutlet UIButton *waitButton;
- (IBAction)waitBtnClick:(UIButton *)sender;

/****************************/
//播放视图
@property (weak, nonatomic) IBOutlet UIView *playerView;

//顶部控件
@property (weak, nonatomic) IBOutlet UIView *topView;
//视频名
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//返回按钮
- (IBAction)backAndStopClick:(UIButton *)sender;

/****************************/
//底部控件
@property (weak, nonatomic) IBOutlet UIView *bottomView;
//暂停/继续播放
@property (weak, nonatomic) IBOutlet UIButton *stopOrPlayButton;
//暂停/继续播放
- (IBAction)stopOrPlayClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;
- (IBAction)changeValue:(UISlider *)sender;
- (IBAction)startChange:(UISlider *)sender;
- (IBAction)stopChange:(UISlider *)sender;
- (IBAction)changeEnd:(UISlider *)sender;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@end

@implementation GKVLCPlayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _progressSlider.continuous = YES;
    NSString *url = Video_URL;
    _playURL = [NSURL URLWithString:url];

    VLCMediaPlayer *player = [[VLCMediaPlayer alloc] initWithOptions:nil];
    _mediaPlayer = player;

    
    VLCMedia  *media = [VLCMedia mediaWithURL:_playURL];
    _mediaPlayer.media = media;
    _mediaPlayer.drawable = _playerView;
    _mediaPlayer.delegate = self;
//    _nameLabel.text = _mediaPlayer.titles
    //获取缩略图
    //初始化并设置代理
    VLCMediaThumbnailer *thumbnailer = [VLCMediaThumbnailer thumbnailerWithMedia:media andDelegate:self];
    self.thumbnailer = thumbnailer;
    //开始获取缩略图
    [self.thumbnailer fetchThumbnail];
    
    //开始播放
    [_mediaPlayer play];

    
    
//    [_topView setHidden:YES];
//    [_bottomView setHidden:YES];
    
    // 5秒后自动隐藏顶部和底部
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [_topView setHidden:YES];
//        [_bottomView setHidden:YES];
    });
    
    // 设置视频名称
//    self.vlcPlayerView.videoName = self.playName;
//    _nameLabel.text = [NSString stringWithFormat:@"%@",_mediaPlayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
/*
#pragma mark - 屏幕方向
// 隐藏状态栏显得和谐
- (BOOL)prefersStatusBarHidden {
    return YES;
}
- (BOOL)shouldAutorotate {    // 允许进行旋转
    return YES;
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    //支持哪些转屏方向
    return UIInterfaceOrientationMaskAllButUpsideDown;
}
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    //进入界面直接旋转的方向
    return UIInterfaceOrientationLandscapeLeft;
}
*/
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //不显示导航栏
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    isPlaying = NO;
    isHidden = NO;
    [self addActionsForView];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear: animated];
    [_mediaPlayer stop];
}
// 隐藏状态栏显得和谐
- (BOOL)prefersStatusBarHidden {
    return YES;
}
#pragma mark - 视图添加点击事件
- (void)addActionsForView {
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapActionOne:)];
    [_playerView addGestureRecognizer:tapGesturRecognizer];
}
#pragma mark - 懒加载
- (NSDictionary *)dictionary {
    if (!_dictionary) {
        self.dictionary = [NSDictionary dictionary];
    }
    return _dictionary;
}

- (IBAction)stopOrPlayClick:(UIButton *)sender {
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 20:
        {
            //播放模式，改为暂停
            btn.tag = 21;
            [btn setImage:[UIImage imageNamed:@"play_stop.png"] forState:UIControlStateNormal];
            [_mediaPlayer pause];
//            [_topView setHidden:NO];
//            [_bottomView setHidden:NO];
        }
            break;
        case 21:
        {
            //暂停模式，继续播放
            btn.tag = 20;
            [btn setImage:[UIImage imageNamed:@"play_start.png"] forState:UIControlStateNormal];
            [_mediaPlayer play];
//            [_topView setHidden:YES];
//            [_bottomView setHidden:YES];
        }
            break;
            
        default:
            break;
    }
}
- (IBAction)changeValue:(UISlider *)sender {
//    [_mediaPlayer currentTitleIndex]
    //设置播放进度, 0.0~1.0
//    float sliderValue = sender.value;
//    [_mediaPlayer setPosition:sliderValue];
}

- (IBAction)startChange:(UISlider *)sender {
}

- (IBAction)stopChange:(UISlider *)sender {
}

- (IBAction)changeEnd:(UISlider *)sender {
}
#pragma mark - VLCMediaPlayerDelegate
- (void)mediaPlayerStateChanged:(NSNotification *)aNotification {
    
}
- (void)mediaPlayerTimeChanged:(NSNotification *)aNotification {
    //获取当前的播放进度条
    NSString *currentString = [NSString stringWithFormat:@"%@",_mediaPlayer.time];
    NSString *remainingString = [NSString stringWithFormat:@"%@",_mediaPlayer.remainingTime];
    NSString *allTimeString = [NSString stringWithFormat:@"%@",_mediaPlayer.media.length];
    NSInteger value1 = [currentString integerValue];
    NSInteger value2 = [remainingString integerValue];
    NSInteger allTime = [allTimeString integerValue];

    NSLog(@"进度条的值----%ld，%ld，%ld",(long)value1,(long)value2,(long)allTime);
    //播放进度 剩余时间
    [_progressSlider setValue:[currentString floatValue]/[allTimeString floatValue]];
    _timeLabel.text = remainingString;
}
- (IBAction)waitBtnClick:(UIButton *)sender {
}
#pragma mark - 获取缩略图
//获取缩略图超时
- (void)mediaThumbnailerDidTimeOut:(VLCMediaThumbnailer *)mediaThumbnailer{
    NSLog(@"获取缩略图失败 getThumbnailer time out.");
}
//获取缩略图成功
- (void)mediaThumbnailer:(VLCMediaThumbnailer *)mediaThumbnailer didFinishThumbnail:(CGImageRef)thumbnail{
    //获取缩略图
    UIImage *image = [UIImage imageWithCGImage:thumbnail];
    [_waitButton setImage:image forState:UIControlStateNormal];
    // 5秒后自动隐藏顶部和底部
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [_waitView setHidden:YES];
        isPlaying = NO;
        isHidden = YES;
    });
}
#pragma mark - 手势操作
- (void)tapActionOne:(UITapGestureRecognizer *)tapGesturRecognizer {
    //点击播放视图
    //暂停或继续播放
    //显示或隐藏顶部底部
    if (isPlaying) {
        [_mediaPlayer pause];
//        [timer];
    }else {
        [_mediaPlayer play];
    }
    
    if (isHidden) {
//        [_topView setHidden:NO];
//        [_bottomView setHidden:NO];
    }else {
//        [_topView setHidden:YES];
//        [_bottomView setHidden:YES];
    }
    
    isPlaying = !isPlaying;
    isHidden = !isHidden;
}

@end
