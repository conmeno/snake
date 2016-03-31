import UIKit
import iAd

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var UIiAd: ADBannerView = ADBannerView()
	var window: UIWindow?
    let data = Data()
	  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        var AdcolonyAppID: String = ""
        var AdcolonyZoneID: String = ""
        
        var Amazonkey = ""
        Amazonkey = data.AmazonKey
        
        AdcolonyAppID = data.AdcolonyAppID
        AdcolonyZoneID = data.AdcolonyZoneID
        if(NSUserDefaults.standardUserDefaults().objectForKey("adcolonyAppID") != nil)
        {
            AdcolonyAppID = NSUserDefaults.standardUserDefaults().objectForKey("adcolonyAppID") as! String
            
        }
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("adcolonyZoneID") != nil)
        {
            AdcolonyZoneID = NSUserDefaults.standardUserDefaults().objectForKey("adcolonyZoneID") as! String
            
        }
        if(NSUserDefaults.standardUserDefaults().objectForKey("amazon") != nil)
        {
            Amazonkey = NSUserDefaults.standardUserDefaults().objectForKey("amazon") as! String
            
        }

       
        //Utility.Static.SetUpAdData()

        
        //if(Utility.isAd3)
        //{
            AmazonAdRegistration.sharedRegistration().setAppKey(Amazonkey)
            AmazonAdRegistration.sharedRegistration().setLogging(true)
        //}

        
        //if(Utility.Static.isAd4)
        //{
            AdColony.configureWithAppID( AdcolonyAppID, zoneIDs: [AdcolonyZoneID], delegate: nil, logging: true)
        //}
        
        return true
	}
}
