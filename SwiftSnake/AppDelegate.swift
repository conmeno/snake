import UIKit
import iAd

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var UIiAd: ADBannerView = ADBannerView()
	var window: UIWindow?
	  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
       
        Utility.SetUpAdData()
//        
//        if(Utility.isAd2)
//        {
//            Chartboost.startWithAppId(Utility.ChartboostAppID, appSignature: Utility.ChartboostSign, delegate: self)
//        }
//        
        if(Utility.isAd3)
        {
            AmazonAdRegistration.sharedRegistration().setAppKey(Utility.Amazonkey)
            AmazonAdRegistration.sharedRegistration().setLogging(true)
        }
//
//        if(Utility.isAd8)
//        {
//            
//            //vungle
//            //let sdk = VungleSDK.sharedSDK()
//            //sdk.startWithAppId(Utility.VungleID)
//        }
//        
//        
//        
//        //applovin
//        if(Utility.isAd9)
//        {
//            ALSdk.initializeSdk()
//        }
//        
        if(Utility.isAd4)
        {
            AdColony.configureWithAppID(Utility.AdcolonyAppID, zoneIDs: [Utility.AdcolonyZoneID], delegate: nil, logging: true)
        }
        
        return true
	}
}
