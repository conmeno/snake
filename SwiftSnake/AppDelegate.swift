import UIKit
import iAd

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var UIiAd: ADBannerView = ADBannerView()
	var window: UIWindow?
    let data = Data()
	  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
       
        //Utility.Static.SetUpAdData()

        
        //if(Utility.isAd3)
        //{
            AmazonAdRegistration.sharedRegistration().setAppKey(Utility.Static.Amazonkey)
            AmazonAdRegistration.sharedRegistration().setLogging(true)
        //}

        
        //if(Utility.Static.isAd4)
        //{
            AdColony.configureWithAppID(Utility.Static.AdcolonyAppID, zoneIDs: [Utility.Static.AdcolonyZoneID], delegate: nil, logging: true)
        //}
        
        return true
	}
}
