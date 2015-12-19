import UIKit
import iAd

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ChartboostDelegate {
    var UIiAd: ADBannerView = ADBannerView()
	var window: UIWindow?
	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        
        //AdTapsy.startSession("55bc9f40e4b0a1b5eb3de2d6");
        Chartboost.startWithAppId("5674df24f78982663101dff2", appSignature: "c0b718cd3af93e84d9baa24ca076114c4eb2d8aa", delegate: self)
 
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
        
        AmazonAdRegistration.sharedRegistration().setAppKey("a520f96277c048fd8627a5dc3ad90f1e")
        AmazonAdRegistration.sharedRegistration().setLogging(true)
        return true
	}
}
