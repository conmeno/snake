import UIKit
import iAd

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ChartboostDelegate {
    var UIiAd: ADBannerView = ADBannerView()
	var window: UIWindow?
	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        
        //AdTapsy.startSession("55bc9f40e4b0a1b5eb3de2d6");
        Chartboost.startWithAppId("55c567c15b14534ed45164e4", appSignature: "569fa2cb4c58987c064943e05f3e372bb1b5e9f1", delegate: self)
        
        //vungle
        // Override point for customization after application launch.
//        var appID = "1018638464"
//        var sdk = VungleSDK.sharedSDK()
//        // start vungle publisher library
//        sdk.startWithAppId(appID)
//        sdk.setLoggingEnabled(true)
        
        //end vung le
        //adcolony\
        //AdColony.configureWithAppID("app56898cd1f44e4d7e89", zoneIDs: ["vzdf877fd32127489c8d"], delegate: nil, logging: true)
        MobileCore.initWithToken("3D2A61TO0BGWAT07RD8KE6PBLZK7S", logLevel: DEBUG_LOG_LEVEL, adUnits:
            [NSNumber (unsignedInt: AD_UNIT_ALL_UNITS.value)])
        
		return true
	}
}
