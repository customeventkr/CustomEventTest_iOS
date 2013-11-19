//
//  CustomEventAdam.m
//  CustomEvent
//

#import "CustomEventAdam.h"

@implementation CustomEventAdam
@synthesize delegate;

#pragma mark GADCustomEventBanner
// AdMob custom event callback. Adam 배너광고를 요청하기 위해 AdMob이 호출해줌.
- (void)requestBannerAd:(GADAdSize)adSize
              parameter:(NSString *)serverParameter
                  label:(NSString *)serverLabel
                request:(GADCustomEventRequest *)customEventRequest
{
    UIViewController *viewController = [self.delegate viewControllerForPresentingModalView];
 
    NSLog(@"Adam Custom Event : requestBannerAd with %@", serverParameter);
    
    AdamAdView *adView = [AdamAdView sharedAdView];
    if (![adView.superview isEqual:viewController.view])
    {
        [viewController.view addSubview:adView];
    }
    adView.delegate = self;
    // Adam 배너광고의 경우 320x48 사이즈로 애드몹과는 세로 사이즈에 차이가 있음.
    adView.frame = CGRectMake(0.0, 1.0, 320.0, 48.0);
    adView.clientId = serverParameter;
    
    // Adam AdView의 경우 requestAd를 하면 바로 광고가 노출됨.
    [adView requestAd];
}

// Adam Banner
#pragma mark - AdamAdViewDelegate
- (void)didReceiveAd:(AdamAdView *)adView
{
    NSLog(@"Adam Custom Event : Received");
    
    // 배너광고 view를 AdMob mediation으로 전달
    [self.delegate customEventBanner:self didReceiveAd:adView];
}

- (void)didFailToReceiveAd:(AdamAdView *)adView error:(NSError *)error
{
    NSLog(@"Adam Custom Event : didFailToReceiveAd : %@", error);
    // requestBannerAd에서 add했던 view를 제거함
    [adView removeFromSuperview];
    // AdMob custom event에 배너광고 요청이 실패했음을 알림
    [self.delegate customEventBanner:self didFailAd:error];
}

- (void)willOpenFullScreenAd:(AdamAdView *)adView
{
    NSLog(@"Adam Custom Event : will open");
    // AdMob custom event에 광고가 클릭되어 열리게 될 것임을 알림
    [self.delegate customEventBanner:self clickDidOccurInAd:adView];
}
@end
