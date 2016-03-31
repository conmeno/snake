//
//  AdManagerView.swift
//  Gummy Fighter
//
//  Created by Phuong Nguyen on 2/4/16.
//  Copyright © 2016 PhuongNguyen. All rights reserved.
//

import Foundation
import UIKit



class AdManagerView: UIViewController
{
    
    
    var isAd1 = false//admob full
    var isAd2 = true//admob Banner
    var isAd3 = false//amazon
    var isAd4 = false//adcolony
    var isAd5 = false//startapp
    
         var CheckOnline = true
    
      
    var showOtherAd1 = false //showAd (ngoai tru Admob Banner)
    
    @IBOutlet weak var sw1: UISwitch!
    
    @IBOutlet weak var sw2: UISwitch!
    
    @IBOutlet weak var sw3: UISwitch!
    
    @IBOutlet weak var sw4: UISwitch!
    
    @IBOutlet weak var sw5: UISwitch!
    
  @IBOutlet weak var ShowOtherAd: UISwitch!
    
    @IBOutlet weak var CheckAdOnline: UISwitch!
    
    @IBOutlet weak var textDevice: UITextView!
    
    @IBAction func sw1Action(sender: UISwitch) {
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"ad1")
        NSUserDefaults.standardUserDefaults().synchronize()
       // Utility.Static.isAd1 = sender.on
        
    }
    
    @IBAction func sw2Action(sender: UISwitch) {
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"ad2")
        NSUserDefaults.standardUserDefaults().synchronize()
       // Utility.Static.isAd2 = sender.on
    }
    
    
    @IBAction func sw3Action(sender: UISwitch) {
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"ad3")
        NSUserDefaults.standardUserDefaults().synchronize()
       // Utility.Static.isAd3 = sender.on
    }
    
    
    @IBAction func sw4Action(sender: UISwitch) {
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"ad4")
        NSUserDefaults.standardUserDefaults().synchronize()
      //  Utility.Static.isAd4 = sender.on
    }
    
    @IBAction func sw5Action(sender: UISwitch) {
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"ad5")
        NSUserDefaults.standardUserDefaults().synchronize()
        //  Utility.Static.isAd4 = sender.on
    }
    
       
    @IBAction func ShowOtherAd(sender: UISwitch) {
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"show-other-ad")
        NSUserDefaults.standardUserDefaults().synchronize()
        //Utility.Static.showOtherAd = sender.on
        if(sender.on)
        {
            NSUserDefaults.standardUserDefaults().setObject("true", forKey:"show-other-ad-online")
            NSUserDefaults.standardUserDefaults().synchronize()

        }
    }
    
    @IBAction func CheckAdOnlineAction(sender: UISwitch) {
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"adOnline")
        NSUserDefaults.standardUserDefaults().synchronize()
        //Utility.Static.CheckOnline = sender.on
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CheckAdOptionValue()
        setupDevice()
        
    }
    
    
    //    @IBAction func EditGoogle(sender: AnyObject) {
    //        let storyboard = UIStoryboard(name: "StoryboardAD", bundle: nil)
    //
    //        let WebDetailView = storyboard.instantiateViewControllerWithIdentifier("GoogleAdEditorView") as UIViewController
    //
    //        self.presentViewController(WebDetailView, animated: true, completion: nil)
    //
    //    }
    //    @IBAction func EditChartboost(sender: AnyObject) {
    //        let storyboard = UIStoryboard(name: "StoryboardAD", bundle: nil)
    //
    //        let WebDetailView = storyboard.instantiateViewControllerWithIdentifier("ChartboostAdEditorView") as UIViewController
    //
    //        self.presentViewController(WebDetailView, animated: true, completion: nil)
    //    }
    
    func setupDevice()
    {
        
        var myIDFA: String = ""
        // Check if Advertising Tracking is Enabled
        if ASIdentifierManager.sharedManager().advertisingTrackingEnabled {
            // Set the IDFA
            myIDFA = ASIdentifierManager.sharedManager().advertisingIdentifier.UUIDString
        }
        
        let venderID = UIDevice.currentDevice().identifierForVendor!.UUIDString
        
        
        textDevice.text = "IDFA: \n" + myIDFA + "\nVendorID: \n" + venderID
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
        
        
        // ad3 ...
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("ad3") != nil)
        {
            isAd3 = NSUserDefaults.standardUserDefaults().objectForKey("ad3") as! Bool
            
        }
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("ad4") != nil)
        {
            isAd4 = NSUserDefaults.standardUserDefaults().objectForKey("ad4") as! Bool
            
        }
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("ad5") != nil)
        {
            isAd5 = NSUserDefaults.standardUserDefaults().objectForKey("ad5") as! Bool
            
        }
        if(NSUserDefaults.standardUserDefaults().objectForKey("show-other-ad") != nil)
        {
            showOtherAd1 = NSUserDefaults.standardUserDefaults().objectForKey("show-other-ad") as! Bool
            
        }
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("adOnline") != nil)
        {
            CheckOnline = NSUserDefaults.standardUserDefaults().objectForKey("adOnline") as! Bool
            print(NSUserDefaults.standardUserDefaults().objectForKey("adOnline"))
        }
        

        
        sw1.on = isAd1
        sw2.on = isAd2
        sw3.on = isAd3
        sw4.on = isAd4
        sw5.on = isAd5
        ShowOtherAd.on = showOtherAd1
        //ShowOtherAd1.on = Utility.Static.showOtherAd
        CheckAdOnline.on = CheckOnline
        
    }
    
    
}
