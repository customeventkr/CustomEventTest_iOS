//
//  ViewController.m
//  CustomEvent

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 테스트를 위해 각 Mediation 별 버튼을 화면에 추가
    CGFloat width = 320.0, height = 32.0;
    UIButton *buttonCauly, *buttonAdam, *buttonCaulyInt, *buttonAdamInt;
    UIColor *bgColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:0.9];
    UIColor *bgIntColor = [UIColor colorWithRed:255.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:0.9];
    
    // Cauly Banner 광고 호출을 위한 버튼 생성
    buttonCauly = [UIButton buttonWithType:UIButtonTypeSystem];
    [buttonCauly setTitle:@"Cauly" forState:UIControlStateNormal];
    buttonCauly.frame = CGRectMake(0,30,width,height);
    buttonCauly.backgroundColor = bgColor;
    buttonCauly.tag = 1;
    [buttonCauly addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
    
    // Adam Banner 광고 호출을 위한 버튼 생성
    buttonAdam = [UIButton buttonWithType:UIButtonTypeSystem];
    [buttonAdam setTitle:@"Adam" forState:UIControlStateNormal];
    buttonAdam.frame = CGRectMake(0,70,width,height);
    buttonAdam.backgroundColor = bgColor;
    buttonAdam.tag = 2;
    [buttonAdam addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];

    // Cauly Interstitial 광고 호출을 위한 버튼 생성
    buttonCaulyInt = [UIButton buttonWithType:UIButtonTypeSystem];
    [buttonCaulyInt setTitle:@"Cauly Interstitial" forState:UIControlStateNormal];
    buttonCaulyInt.frame = CGRectMake(0,130,width,height);
    buttonCaulyInt.backgroundColor = bgIntColor;
    buttonCaulyInt.tag = 11;
    [buttonCaulyInt addTarget:self action:@selector(touchButtonInterstitial:) forControlEvents:UIControlEventTouchUpInside];
    
    // Adam Interstitial 광고 호출을 위한 버튼 생성
    buttonAdamInt = [UIButton buttonWithType:UIButtonTypeSystem];
    [buttonAdamInt setTitle:@"Adam Interstitial" forState:UIControlStateNormal];
    buttonAdamInt.frame = CGRectMake(0,170,width,height);
    buttonAdamInt.backgroundColor = bgIntColor;
    buttonAdamInt.tag = 12;
    [buttonAdamInt addTarget:self action:@selector(touchButtonInterstitial:) forControlEvents:UIControlEventTouchUpInside];
    
    // view에 추가
    [self.view addSubview:buttonCauly];
    [self.view addSubview:buttonAdam];
    [self.view addSubview:buttonCaulyInt];
    [self.view addSubview:buttonAdamInt];
    
}

// Interstitial 광고 호출 버튼을 누른 경우 호출
- (void)touchButtonInterstitial:(id)sender
{
    UIButton *touchedButton = (UIButton *)sender;
    NSString *mediationID;
    
    // 테스트용 mediation ID : iOS Adam > AdMob - b6db6dc2b7534e27
    // 테스트용 mediation ID : iOS Cauly > AdMob - d84636499f894cb9
    
    switch (touchedButton.tag)
    {
        case 11:
            //mediationID = @"b6db6dc2b7534e27";
            mediationID = @"ca-app-pub-7314735943412778/5433916445";
            break;
        case 12:
            //mediationID = @"d84636499f894cb9";
            mediationID = @"ca-app-pub-7314735943412778/3957183245";
            break;
    }
    
    // 전면 광고 생성
    interstitial_ = [[GADInterstitial alloc] init];
    interstitial_.adUnitID = mediationID;
    interstitial_.delegate = self;
    
    // 전면 광고 불러오기
    [interstitial_ loadRequest:[GADRequest request]];
}

// Banner 광고 호출 버튼을 누른 경우 호출
- (void)touchButton:(id)sender
{
    UIButton *touchedButton = (UIButton *)sender;
    NSString *mediationID;
    
    // 테스트용 mediation ID : iOS Adam > AdMob - c805e0e9ccbc4df5
    // 테스트용 mediation ID : iOS Cauly > AdMob - 7f1f21a1dd7c489e

    switch (touchedButton.tag)
    {
        case 1:
            //mediationID = @"7f1f21a1dd7c489e";    // legacy admob
            mediationID = @"ca-app-pub-7314735943412778/4016058841";    // new admob
            break;
        case 2:
            //mediationID = @"c805e0e9ccbc4df5";  // legacy admob
            mediationID = @"ca-app-pub-7314735943412778/1062592448"; // new admob
            break;
    }
    
    if ([bannerView_ superview])
    {
        [bannerView_ removeFromSuperview];
    }
    
    // 320x50 배너 사이즈 View 생성
    bannerView_ = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    
    // mediation ID 할당
    bannerView_.adUnitID = mediationID;
    bannerView_.rootViewController = self;
    
    // 화면 하단에 위치하도록 frame 고정
    CGRect frame;
    frame.origin.x = 0;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height-50.0;
    frame.size.width = 320.0;
    frame.size.height = 50.0;
    
    bannerView_.frame = frame;
    [self.view addSubview:bannerView_];
    
    // 배너 광고 요청
    [bannerView_ loadRequest:[GADRequest request]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark GADInterstitialDelegate

// 전면 광고 로딩이 완료된 경우 호출
- (void)interstitialDidReceiveAd:(GADInterstitial *)interstitial
{
    NSLog(@"AdMob : GADInterstitialDelegate interstitialDidReceiveAd");
    [interstitial presentFromRootViewController:self];
    
}

- (void)interstitial:(GADInterstitial *)interstitial didFailToReceiveAdWithError:(GADRequestError *)error
{
    NSLog(@"AdMob : GADInterstitialDelegate didFailToReceiveAdWithError : %@",[error localizedDescription]);
}
@end
