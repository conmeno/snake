import UIKit
import iAd

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ChartboostDelegate {
    var UIiAd: ADBannerView = ADBannerView()
	var window: UIWindow?
	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        
        //AdTapsy.startSession("55bc9f40e4b0a1b5eb3de2d6");
        Chartboost.startWithAppId("566cdd81a8b63c775fcdefb6", appSignature: "15a4f0ed84135ce4bd6e963eb362fe83d38c93d0", delegate: self)
        
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
