//
//  CDVLCPlayVC.m
//  GKtfp
//
//  Created by apple on 2017/3/31.
//  Copyright © 2017年 LYP. All rights reserved.
//

#import "CDVLCPlayVC.h"
#import <AVFoundation/AVFoundation.h>

@interface CDVLCPlayVC () <VLCMediaPlayerDelegate,VLCMediaThumbnailerDelegate,VLCMediaDelegate>
{
    //正在播放：YES
    BOOL isPlaying;
    //播放进度显示
    BOOL isShowing;
    
    NSTimer *timer;
}
@property (nonatomic, strong) NSURL *playURL;
@property (nonatomic ,retain)VLCMediaPlayer *mediaPlayer;
//缩略图
@property (nonatomic ,retain)VLCMediaThumbnailer *thumbnailer;


@property (strong, nonatomic) MPVolumeView *volumeView;//控制音量的view
@property (weak, nonatomic) IBOutlet UIButton *volumeBtn;
- (IBAction)volumeClick:(UIButton *)sender;
//音量
@property (weak, nonatomic) IBOutlet UISlider *volumeSlider;
- (IBAction)volumeValueChange:(UISlider *)sender;

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
@property (weak, nonatomic) IBOutlet UIProgressView *playProgress;

//暂停/继续播放
- (IBAction)stopOrPlayClick:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;



/*****************/
//屏幕操作手势
@property (nonatomic, strong, nullable) UISwipeGestureRecognizer *upGestureRecognizer;
@property (nonatomic, strong, nullable) UISwipeGestureRecognizer *downGestureRecognizer;
@property (nonatomic, strong, nullable) UISwipeGestureRecognizer *leftGestureRecognizer;
@property (nonatomic, strong, nullable) UISwipeGestureRecognizer *rightGestureRecognizer;
@property (nonatomic, assign) CGFloat coordinateX;
/*****************/
//约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeight;

@end

@implementation CDVLCPlayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _volumeSlider.continuous = YES;
    NSString *url = Video_URL;
    _playURL = [NSURL URLWithString:url];

    [self.volumeView setHidden:YES];
    
    VLCMediaPlayer *player = [[VLCMediaPlayer alloc] initWithOptions:nil];
    _mediaPlayer = player;
    

    /*
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:self.mp3FileUrl error:nil];
    
    NSLog(@"%lu",self.player.data.length/1024);
    [self.session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [self.player play];
    */
    
    VLCMedia  *media = [VLCMedia mediaWithURL:_playURL];
    _mediaPlayer.media = media;
    _mediaPlayer.drawable = _playerView;
    _mediaPlayer.delegate = self;
    [_nameLabel setHidden:YES];
    /*
    //获取缩略图
    //初始化并设置代理
    VLCMediaThumbnailer *thumbnailer = [VLCMediaThumbnailer thumbnailerWithMedia:media andDelegate:self];
    self.thumbnailer = thumbnailer;
    //开始获取缩略图
    [self.thumbnailer fetchThumbnail];
    */
    //开始播放
    [_mediaPlayer play];
    [self addGestureRecognizers];

    //音量
    int volume = _mediaPlayer.audio.volume;
//    NSLog(@"volume----%d",volume);
    [_volumeSlider setValue:volume];

    // 8秒后自动隐藏顶部和底部
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        isShowing = NO;
//        [_bottomView setHidden:YES];
        [_waitView setHidden:YES];
    });
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



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //不显示导航栏
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    isPlaying = NO;
    isShowing = YES;
    [self addActionsForView];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear: animated];
    [_mediaPlayer stop];
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
        }
            break;
        case 21:
        {
            //暂停模式，继续播放
            btn.tag = 20;
            [btn setImage:[UIImage imageNamed:@"play_start.png"] forState:UIControlStateNormal];
            [_mediaPlayer play];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - VLCMediaPlayerDelegate
- (void)mediaPlayerStateChanged:(NSNotification *)aNotification {
    /*
     VLCMediaPlayerStateStopped,        //< Player has stopped
     VLCMediaPlayerStateOpening,        //< Stream is opening
     VLCMediaPlayerStateBuffering,      //< Stream is buffering
     VLCMediaPlayerStateEnded,          //< Stream has ended
     VLCMediaPlayerStateError,          //< Player has generated an error
     VLCMediaPlayerStatePlaying,        //< Stream is playing
     VLCMediaPlayerStatePaused          //< Stream is paused
     */
    switch (_mediaPlayer.state) {
        case VLCMediaPlayerStateStopped:
        {
            NSLog(@"停止播放 VLCMediaPlayerStateStopped");
        }
            break;
        case VLCMediaPlayerStateOpening:
        {
            NSLog(@"正在打开视频 VLCMediaPlayerStateOpening");
        }
            break;
        case VLCMediaPlayerStateBuffering:
        {
            NSLog(@"正在缓冲 VLCMediaPlayerStateBuffering");
        }
            break;
        case VLCMediaPlayerStateEnded:
        {
            NSLog(@"播放结束 VLCMediaPlayerStateEnded");
        }
            break;
        case VLCMediaPlayerStateError:
        {
            NSLog(@"视频出错 VLCMediaPlayerStateError");
        }
            break;
        case VLCMediaPlayerStatePlaying:
        {
            NSLog(@"视频正在播放 VLCMediaPlayerStatePlaying");
        }
            break;
        case VLCMediaPlayerStatePaused:
        {
            NSLog(@"暂停播放 VLCMediaPlayerStatePaused");
        }
            break;
            
        default:
            break;
    }
}
- (void)mediaPlayerTimeChanged:(NSNotification *)aNotification {
    //获取当前的播放进度条
    NSString *currentString = [NSString stringWithFormat:@"%@",_mediaPlayer.time];
    NSString *remainingString = [NSString stringWithFormat:@"%@",_mediaPlayer.remainingTime];
    NSString *allTimeString = [NSString stringWithFormat:@"%@",_mediaPlayer.media.length];

    //播放进度 剩余时间
    [_playProgress setProgress:[currentString floatValue]/[allTimeString floatValue]];
    _timeLabel.text = remainingString;
    
    //音量
//    int volume = _mediaPlayer.audio.volume;
//    NSLog(@"volume-----%d",volume);
//    NSString *volumeString = [NSString stringWithFormat:@"%d",volume];
//    [_volumeSlider setValue:[volumeString floatValue]];
    float volume = _volumeSlider.value;
    NSLog(@"volume-----%f",volume);
    NSString *volumeString = [NSString stringWithFormat:@"%f",volume];
    [_mediaPlayer.audio setVolume:[volumeString intValue]];
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
        isPlaying = NO;
    });
}
#pragma mark - 手势操作
- (void)tapActionOne:(UITapGestureRecognizer *)tapGesturRecognizer {
    //点击播放视图
    //暂停或继续播放
    //显示或隐藏顶部底部
    if (isPlaying) {
//        [_mediaPlayer pause];
////        [timer];
//        //播放模式，改为暂停
        _stopOrPlayButton.tag = 21;
        [_stopOrPlayButton setImage:[UIImage imageNamed:@"play_stop.png"] forState:UIControlStateNormal];
    }else {
//        [_mediaPlayer play];
//        //暂停模式，继续播放
        _stopOrPlayButton.tag = 20;
        [_stopOrPlayButton setImage:[UIImage imageNamed:@"play_start.png"] forState:UIControlStateNormal];
    }

    //显示或隐藏顶部底部
    if (isShowing) {
        [UIView animateWithDuration:1 animations:^{
            [_bottomView setAlpha:1];
        } completion:^(BOOL finished) {
            [_bottomView setHidden:YES];
            
            // 8秒后自动隐藏顶部和底部
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                isShowing = NO;
                [self hiddenBottomView];
            });
            
        }];
    }else {
        [_bottomView setHidden:NO];
        [UIView animateWithDuration:1 animations:^{
            [_bottomView setAlpha:1];
        }];
    }
    
    isPlaying = !isPlaying;
    isShowing = !isShowing;
}
- (void)hiddenBottomView {
    [UIView animateWithDuration:1 animations:^{
        [_bottomView setAlpha:1];
    } completion:^(BOOL finished) {
        [_bottomView setHidden:YES];
    }];
}
#pragma mark - 添加手势
- (void)addGestureRecognizers {
    self.upGestureRecognizer = [[UISwipeGestureRecognizer alloc] init];
    [self.upGestureRecognizer addTarget:self action:@selector(upGestureRecognizer:)];
    self.upGestureRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
    [_playerView addGestureRecognizer:self.upGestureRecognizer];
    
    self.downGestureRecognizer = [[UISwipeGestureRecognizer alloc] init];
    [self.downGestureRecognizer addTarget:self action:@selector(downGestureRecognizer:)];
    self.downGestureRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
    [_playerView addGestureRecognizer:self.downGestureRecognizer];
    
    self.leftGestureRecognizer = [[UISwipeGestureRecognizer alloc] init];
    [self.leftGestureRecognizer addTarget:self action:@selector(leftGestureRecognizer:)];
    self.leftGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [_playerView addGestureRecognizer:self.leftGestureRecognizer];
    
    self.rightGestureRecognizer = [[UISwipeGestureRecognizer alloc] init];
    [self.rightGestureRecognizer addTarget:self action:@selector(rightGestureRecognizer:)];
    self.rightGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [_playerView addGestureRecognizer:self.rightGestureRecognizer];
}

- (void)upGestureRecognizer:(UISwipeGestureRecognizer *)gestureRecognizer {
    NSLog(@"上上上上上上上");
    [_mediaPlayer.audio volumeUp];
}
- (void)downGestureRecognizer:(UISwipeGestureRecognizer *)gestureRecognizer {
    NSLog(@"下下下下下下下");
    [_mediaPlayer.audio volumeDown];
}
- (void)leftGestureRecognizer:(UISwipeGestureRecognizer *)gestureRecognizer {
    NSLog(@"左左左左左左");

}
- (void)rightGestureRecognizer:(UISwipeGestureRecognizer *)gestureRecognizer {
    NSLog(@"右右右右右");

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    CGPoint touchPoint = [touch locationInView:_playerView];
    
    NSLog(@"%f==%f",touchPoint.x,touchPoint.y);
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    CGPoint touchPoint = [touch locationInView:_playerView];
    
    NSLog(@"%f==%f",touchPoint.x,touchPoint.y);
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    CGPoint touchPoint = [touch locationInView:_playerView];
    
    NSLog(@"%f==%f",touchPoint.x,touchPoint.y);
}


//返回按钮
- (IBAction)backAndStopClick:(UIButton *)sender{
    [_mediaPlayer stop];
    //[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loadVideoVC"];
    [self.navigationController popViewControllerAnimated:YES];
}
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
    return UIInterfaceOrientationMaskLandscape;
}
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    //进入界面直接旋转的方向
    return UIInterfaceOrientationLandscapeLeft;
}

#pragma mark - 懒加载
- (MPVolumeView *)volumeView {
    if (_volumeView == nil) {
        
        _volumeView = [[MPVolumeView alloc] init];
        UISlider *volumeSlider = nil;
        for (id aView in _volumeView.subviews){
            if ([[[aView class] description] isEqualToString:@"MPVolumeSlider"]){
                
                volumeSlider = (UISlider *)aView;
                break;
            }
            
        }
    }
    return _volumeView;
}

#pragma mark - 音量

- (IBAction)volumeClick:(UIButton *)sender {
    UIButton *button = (UIButton *)sender;

    switch (button.tag) {
        case 30:{
            button.tag = 31;
//            [_waitView setHidden:NO];
//            [btn setImage:[UIImage imageNamed:@"play_stop.png"] forState:UIControlStateNormal];
//            [_mediaPlayer pause];
        }
            break;
        case 31:{
            button.tag = 30;
//            [_waitView setHidden:YES];
//            [btn setImage:[UIImage imageNamed:@"play_start.png"] forState:UIControlStateNormal];
//            [_mediaPlayer play];
        }
            break;
        default:
            break;
    }
}
- (IBAction)volumeValueChange:(UISlider *)sender {
     float volume = _volumeSlider.value;
    NSLog(@"volume-----%f",volume);
    NSString *volumeString = [NSString stringWithFormat:@"%f",volume];
    [_mediaPlayer.audio setVolume:[volumeString intValue]];
}
@end
