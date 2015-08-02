import UIKit
import iAd

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var UIiAd: ADBannerView = ADBannerView()
	var window: UIWindow?
	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        
        AdTapsy.startSession("55bc9f40e4b0a1b5eb3de2d6");
		return true
	}
}
