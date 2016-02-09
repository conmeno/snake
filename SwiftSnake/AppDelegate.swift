import UIKit
import iAd

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ChartboostDelegate {
    var UIiAd: ADBannerView = ADBannerView()
	var window: UIWindow?
	  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let data = Data()
        Chartboost.startWithAppId(data.cAppID, appSignature: data.cSign, delegate: self)
        
        
        AmazonAdRegistration.sharedRegistration().setAppKey("6d874b81dd934a20bb893f950accbfb4")
        AmazonAdRegistration.sharedRegistration().setLogging(true)
        return true
	}
}
