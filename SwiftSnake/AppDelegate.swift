import UIKit
import iAd

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UnityAdsDelegate {
    var UIiAd: ADBannerView = ADBannerView()
	var window: UIWindow?
    let data = Data()
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
        if(Utility.isAd7)
        {
            
//            let sdk = VungleSDK.sharedSDK()
//            // start vungle publisher library
//            sdk.startWithAppId(Utility.VungleID)
//            sdk.setLoggingEnabled(true)
//            sdk.clearCache()
//            sdk.clearSleep()
            
            
             HeyzapAds.startWithPublisherID(Utility.HeyzapID)
        }
        
        if(Utility.isAd5)
        {
            //UNITY ADS
            UnityAds.sharedInstance().delegate = self
            UnityAds.sharedInstance().setTestMode(true)
            UnityAds.sharedInstance().startWithGameId(Utility.UnityGameID, andViewController: self.window?.rootViewController)
            
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC)))
            
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                if UnityAds.sharedInstance().canShow() {
                    UnityAds.sharedInstance().show()
                }
                else {
                    NSLog("%@","Cannot show it yet!")
                }
            }
        }
        
        if(Utility.isAd8)
        {
            let sonicDelegate:ISDelegate  = ISDelegate()
            var myIDFA: String = ""
            // Check if Advertising Tracking is Enabled
            if ASIdentifierManager.sharedManager().advertisingTrackingEnabled {
                // Set the IDFA
                myIDFA = ASIdentifierManager.sharedManager().advertisingIdentifier.UUIDString
            }
            Supersonic.sharedInstance().setISDelegate(sonicDelegate)
            Supersonic.sharedInstance().initISWithAppKey(Utility.SonicID, withUserId: myIDFA)
            Supersonic.sharedInstance().loadIS()
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
