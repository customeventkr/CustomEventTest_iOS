//
//  ViewController.h
//  CustomEvent
//

#import <UIKit/UIKit.h>
#import "GADBannerView.h"
#import "GADInterstitial.h"
    
@interface ViewController : UIViewController <GADInterstitialDelegate>
{
    GADBannerView *bannerView_;
    GADInterstitial *interstitial_;
}

@end
