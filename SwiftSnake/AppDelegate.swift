import UIKit
import iAd

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var UIiAd: ADBannerView = ADBannerView()
	var window: UIWindow?
	  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
     
        //============================
        //==========FOR AD============
        //============================
        
        
        Utility.SetUpAdData()
        if(Utility.isAd3)
        {
            AmazonAdRegistration.sharedRegistration().setAppKey(Utility.Amazonkey)
            AmazonAdRegistration.sharedRegistration().setLogging(true)
        }
        if(Utility.isAd4)
        {
            AdColony.configureWithAppID(Utility.AdcolonyAppID, zoneIDs: [Utility.AdcolonyZoneID], delegate: nil, logging: true)
        }
        //        if(Utility.isAd7)
        //        {
        //
        //        }
        
        if(Utility.isAd5 || Utility.isAd6)
        {
            Chartboost.startWithAppId(Utility.CBAppID, appSignature: Utility.CBSign, delegate: nil)
            print(Utility.CBAppID + " " + Utility.CBSign)
        }
        
        //============================
        //======END FOR AD============
        //============================
        
        
        
        
        return true
    }
    func unityAdsVideoCompleted(rewardItemKey : String, skipped : Bool) {
        NSLog("Video completed: %@: %@", skipped, rewardItemKey)
    }
}
