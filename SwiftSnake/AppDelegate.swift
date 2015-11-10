import UIKit
import iAd

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ChartboostDelegate {
    var UIiAd: ADBannerView = ADBannerView()
	var window: UIWindow?
	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        
        //AdTapsy.startSession("55bc9f40e4b0a1b5eb3de2d6");
        Chartboost.startWithAppId("5640665f2fdf347c6ceddf17", appSignature: "132b0b0a693dea3ac08eec4670ae941378f6c4b5", delegate: self)
        
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
//        MobileCore.initWithToken("3D2A61TO0BGWAT07RD8KE6PBLZK7S", logLevel: DEBUG_LOG_LEVEL, adUnits:
//            [NSNumber (unsignedInt: AD_UNIT_ALL_UNITS.value)])
        
        AmazonAdRegistration.sharedRegistration().setAppKey("6d874b81dd934a20bb893f950accbfb4")
        AmazonAdRegistration.sharedRegistration().setLogging(true)
        return true
	}
}
