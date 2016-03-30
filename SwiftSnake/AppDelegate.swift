import UIKit
import iAd

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var UIiAd: ADBannerView = ADBannerView()
	var window: UIWindow?
	  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        Utility.SetUpAdData()
        
        
        //if(Utility.isAd3)
        //{
        AmazonAdRegistration.sharedRegistration().setAppKey(Utility.Amazonkey)
        AmazonAdRegistration.sharedRegistration().setLogging(true)
        //}
        
        
        if(Utility.isAd4)
        {
            AdColony.configureWithAppID(Utility.AdcolonyAppID, zoneIDs: [Utility.AdcolonyZoneID], delegate: nil, logging: true)
        }
        
        if(Utility.isAd5)
        {
            
            let sdk: STAStartAppSDK = STAStartAppSDK.sharedInstance()
            sdk.appID = Utility.StartAppAppID
            sdk.devID = Utility.StartAppAccountID
            //            sdk.showSplashAd()
            //            sdk.
        }
        
        return true
	}
}
