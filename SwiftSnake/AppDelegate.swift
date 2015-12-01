import UIKit
import iAd

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ChartboostDelegate {
    var UIiAd: ADBannerView = ADBannerView()
	var window: UIWindow?
	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        
        //AdTapsy.startSession("55bc9f40e4b0a1b5eb3de2d6");
        Chartboost.startWithAppId("564bf766da15272b4080dfc7", appSignature: "8a02d3ca0696dd85a8b3f4d4f53b78b73542649a", delegate: self)
        //Chartboost.setShouldRequestInterstitialsInFirstSession(false)
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
        
        AmazonAdRegistration.sharedRegistration().setAppKey("729491e1690143fdaed868d15f3b7bbf")
        AmazonAdRegistration.sharedRegistration().setLogging(true)
        return true
	}
}
