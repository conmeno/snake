//
//  Data.swift
//  Buddha2
//
//  Created by Phuong Nguyen on 6/9/15.
//  Copyright (c) 2015 Phuong Nguyen. All rights reserved.
//

import Foundation
import GoogleMobileAds
class MyAd:NSObject {
    
        
    let viewController:UIViewController
    var isStopAD = true
    var gBannerView: GADBannerView!
    var interstitial: GADInterstitial!
    var timerVPN:NSTimer?
    var timerAd10:NSTimer?
    var timerAd60:NSTimer?
    
    var isAd1 = true
    var isAd2 = true
    var isAd3 = false
    var isAd4 = false
    
    var isFirsAdmob = false
    var isFirstChart = false
    
    var AdNumber = 1
    let data = Data()
    
    init(root: UIViewController )
    {
               self.viewController = root
        
    }
    func ViewDidload()
    {
        //setupButton()
        
        CheckAdOptionValue()
        if(showAd())
        {
            ShowAdmobBanner()
            if(isAd1)
            {
                self.interstitial = self.createAndLoadAd()
                showAdmob()
            }
           
            
            self.timerVPN = NSTimer.scheduledTimerWithTimeInterval(20, target: self, selector: "timerVPNMethodAutoAd:", userInfo: nil, repeats: true)
            
            self.timerAd10 = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "timerAD10:", userInfo: nil, repeats: true)
            
            
            
            if(isAd2)
            {
                showChartBoost()
            }
            if(isAd3)
            {
                self.timerAd60 = NSTimer.scheduledTimerWithTimeInterval(90, target: self, selector: "timerAD60:", userInfo: nil, repeats: true)
            }
        }
        
    }
    
    func createAndLoadAd() -> GADInterstitial
    {
        let ad = GADInterstitial(adUnitID: data.gFull)
        
        let request = GADRequest()
        
        request.testDevices = [kGADSimulatorID, data.TestDeviceID]
        
        ad.loadRequest(request)
        
        return ad
    }
    func showAdmob()
    {
        
        
        if (self.interstitial.isReady)
        {
            self.interstitial.presentFromRootViewController(viewController)
            self.interstitial = self.createAndLoadAd()
        }
    }
    
    
    func setupButton(){
        
        let button   = UIButton(type: UIButtonType.System) as UIButton
        button.frame = CGRectMake(10, 80, 65, 40)
        button.backgroundColor = UIColor.blackColor()
        let image = UIImage(named: "reload.png")
        button.imageView!.image = image
        button.setTitle("Reset", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        //button.titleLabel?.textColor = UIColor.whiteColor()
        button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        viewController.view?.addSubview(button)
        
    }
    
    func buttonAction(sender:UIButton!)
    {
        print("New game")
        
    }
    
    
    func ShowAdmobBanner()
    {
        //let viewController = appDelegate1.window!.rootViewController as! GameViewController
        let w = viewController.view.bounds.width
        //let h = viewController.view.bounds.height
        gBannerView = GADBannerView(frame: CGRectMake(0, 20 , w, 50))
        gBannerView?.adUnitID = data.gBanner
        gBannerView?.delegate = nil
        gBannerView?.rootViewController = viewController
        viewController.view?.addSubview(gBannerView)
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID , data.TestDeviceID];
        gBannerView?.loadRequest(request)
        //gBannerView?.hidden = true
        
    }
    
    func showAd()->Bool
    {
        let abc = cclass()
        let VPN = abc.isVPNConnected()
        let Version = abc.platformNiceString()
        if(VPN == false && Version == "CDMA")
        {
            return false
        }
        
        return true
    }
    
    func CheckAdOptionValue()
    {
        //ad1 admob
        if(NSUserDefaults.standardUserDefaults().objectForKey("ad1") != nil)
        {
            isAd1 = NSUserDefaults.standardUserDefaults().objectForKey("ad1") as! Bool
            
        }
        
        //ad2 charboost
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("ad2") != nil)
        {
            isAd2 = NSUserDefaults.standardUserDefaults().objectForKey("ad2") as! Bool
            
        }
        
        
        //ad3 ...
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("ad3") != nil)
        {
            isAd3 = NSUserDefaults.standardUserDefaults().objectForKey("ad3") as! Bool
            
        }
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("ad4") != nil)
        {
            isAd4 = NSUserDefaults.standardUserDefaults().objectForKey("ad4") as! Bool
            
        }
        
       
        
    }
    
    
    
    func timerAD10(timer:NSTimer) {
        
        if(showAd())
        {
            if(isAd1 && isFirsAdmob == false)
            {
                if(self.interstitial.isReady)
                {
                    showAdmob()
                    isFirsAdmob = true
                }
            }
            if(isAd2 && isFirstChart == false)
            {
                Chartboost.showInterstitial("First stage")
              
                isFirstChart = true
            }
        }
        
        if(isFirsAdmob && isFirstChart)
        {
            timerAd10?.invalidate()
        }
        
        
    }
    func timerAD60(timer:NSTimer) {
        
        if(showAd())
        {
            if(isAd2)
            {
               showChartBoost()
            }
            
        }
        
        
        
    }

    
    func timerVPNMethodAutoAd(timer:NSTimer) {
        print("VPN Checking....")
        let isAd = showAd()
        if(isAd && isStopAD)
        {
            
            ShowAdmobBanner()
            isStopAD = false
            print("Reopening Ad from admob......")
        }
        
        if(isAd == false && isStopAD == false)
        {
            gBannerView.removeFromSuperview()
            isStopAD = true;
            print("Stop showing Ad from admob......")
        }
        
    }
    
    
    
    
    
    func showChartBoost()
    {
        Chartboost.closeImpression()
        Chartboost.showInterstitial("Home" + String(AdNumber))
        AdNumber++
        print(AdNumber)
    }
    
    
    
    
    
    
}
