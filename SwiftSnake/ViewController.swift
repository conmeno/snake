import UIKit
import GoogleMobileAds
import AVFoundation

class ViewController: UIViewController, SnakeViewDelegate, GADBannerViewDelegate, GADInterstitialDelegate,AmazonAdInterstitialDelegate,AmazonAdViewDelegate {
    
    
	@IBOutlet var startButton:UIButton?
	var snakeView:SnakeView?
	var timer:NSTimer?
    var timerAd:NSTimer?
    var timerMove:NSTimer?
  
    @IBOutlet weak var adView: UIView!
    
     var savedScore: Int = 0
    @IBOutlet weak var lbScore: UILabel!
    
  
    
    @IBOutlet weak var btPause: UIButton!
    //@IBOutlet weak var btPause: UIButton!
    @IBOutlet weak var adStatusBar: UIView!
    
    @IBOutlet weak var lbHightest: UILabel!
    @IBOutlet weak var lbLevel: UILabel!
    
    
    
  
    
    
    var isPauseGame = false
	var snake:Snake?
	var fruit:Point?
    var numPoint = 5
    var levelScore = 100
    var Level: Int = 1
    var isMove = true
    var themeMusic: [String] = ["1", "2"]
    //let player = AVPlayer(URL: NSBundle.mainBundle().URLForResource("theme", withExtension: "mp3"))
    var bomSound = AVPlayer(URL: NSBundle.mainBundle().URLForResource("gameover", withExtension: "mp3")!)
    var levelUpSound = AVPlayer(URL: NSBundle.mainBundle().URLForResource("levelup", withExtension: "mp3")!)
    var FruitSound = AVPlayer(URL: NSBundle.mainBundle().URLForResource("buzz2", withExtension: "mp3")!)
    
    //adTapsy
 
  
    
    @IBAction func SettingClick(sender: AnyObject) {

        adView.hidden = false
    }
    

    
    
    @IBAction func closeClick(sender: AnyObject) {
        adView.hidden = true
    }
  
    
    
    
    
    @IBAction func ShowAdClick(sender: AnyObject) {
       // showAds()
        MoreGame()
    }
    

    @IBAction func MoreAppClick(sender: AnyObject) {
        MoreGame()
    }

    
    
    @IBAction func RealMoreAppClick(sender: AnyObject) {
        MoreGame()
    }
    
    @IBOutlet weak var InfoBt: UIButton!
    
    
 
 
    
    var audioPlayer: AVAudioPlayer?
    
         func PortraitCheck()->Bool
    {
       
        if(UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation))
        {
            print("Portrait")
            return true
        }
        return false
    }
    
    
    
    
    @IBAction func PauseClick(sender: AnyObject) {
        PauseGame()
    }
   
//    @IBAction func PauseClick(sender: AnyObject) {
//        PauseGame()
//        
//    }
    func RandomThemeMusic(Mp3Name : String)
    {
        audioPlayer?.stop()
       
        
        let url = NSURL.fileURLWithPath(
            NSBundle.mainBundle().pathForResource(Mp3Name,
                ofType: "mp3")!)
        
        var error: NSError?
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: url)
        } catch let error1 as NSError {
            error = error1
            audioPlayer = nil
        }
        
        if let err = error {
            print("audioPlayer error \(err.localizedDescription)")
        } else {
            
            audioPlayer?.prepareToPlay()
        }
        audioPlayer?.numberOfLoops = 100

    }
	override func viewDidLoad() {
		super.viewDidLoad()
  
        self.btPause!.hidden = true
       
        
        adView.hidden = true
     
//        if(Utility.Static.showOtherAd)
//        {
//             let myad = MyAd(root: self)
//             myad.ViewDidload()
//            
//        }
//        
//       
//        if(Utility.Static.isAd2)
//        {
//         setupDidload()
//        }
//        
setupAD()

       
        
        
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("HighestScore") != nil)
        {
            savedScore = NSUserDefaults.standardUserDefaults().objectForKey("HighestScore") as! Int
            
        }
        lbHightest.text = String(savedScore)
        lbScore.text = "0"
        lbLevel.text = "1"
        
        let size1: CGFloat     = self.view.frame.size.width - 50
        //let screenWidth = self.view.frame.size.width
        //let screenHeight = self.view.frame.size.height
        let x1: CGFloat = 25 //(screenWidth / 2) - (260 / 2)
        
        let frame1 = CGRectMake(x1, 150, size1, size1)
        
        
        self.snakeView = SnakeView(frame: frame1)//CGRectMake(50, 50, 50, 50))
        
		self.snakeView!.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
		self.view.insertSubview(self.snakeView!, atIndex: 0)

		if let view = self.snakeView {
			view.delegate = self
		}
		for direction in [UISwipeGestureRecognizerDirection.Right,
			UISwipeGestureRecognizerDirection.Left,
			UISwipeGestureRecognizerDirection.Up,
			UISwipeGestureRecognizerDirection.Down] {
				let gr = UISwipeGestureRecognizer(target: self, action: "swipe:")
				gr.direction = direction
				self.view.addGestureRecognizer(gr)
		}
        
        
        // AdTapsy.showInterstitial(self);
         //AdTapsy.setDelegate(self);
       
        //vungleSdk.delegate = self
        //showAds()
        //showAdmob()

	}
    
    @IBAction func MoreGameDrapOutsite(sender: AnyObject) {
       // AdOption.hidden  = false
     
        
        //OpenView("AdView1", view: self)
        
    }
    
 
    @IBAction func StartDrag(sender: AnyObject) {
        OpenView("AdView1", view: self)
    }
    
    
    
   
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	func swipe (gr:UISwipeGestureRecognizer) {
		let direction = gr.direction
		switch direction {
		case UISwipeGestureRecognizerDirection.Right:
			if (self.snake?.changeDirection(Direction.right) != nil) {
				self.snake?.lockDirection()
			}
		case UISwipeGestureRecognizerDirection.Left:
			if (self.snake?.changeDirection(Direction.left) != nil) {
				self.snake?.lockDirection()
			}
		case UISwipeGestureRecognizerDirection.Up:
			if (self.snake?.changeDirection(Direction.up) != nil) {
				self.snake?.lockDirection()
			}
		case UISwipeGestureRecognizerDirection.Down:
			if (self.snake?.changeDirection(Direction.down) != nil) {
				self.snake?.lockDirection()
			}
		default:
			assert(false, "This could not happen")
		}
	}

	func makeNewFruit() {
		srandomdev()
		let worldSize = self.snake!.worldSize
		var x = 0, y = 0
		while (true) {
			x = random() % worldSize.width
			y = random() % worldSize.height
			var isBody = false
			for p in self.snake!.points {
				if p.x == x && p.y == y {
					isBody = true
					break
				}
			}
			if !isBody {
				break
			}
		}
		self.fruit = Point(x: x, y: y)
	}
    func PauseGame()
    {
        
            self.timer!.invalidate()
            self.timer = nil
            isPauseGame = true
            self.startButton!.hidden = false
            self.btPause!.hidden = true
            audioPlayer?.pause()
        
    }

	func startGame() {
        self.btPause!.hidden = false
        self.startButton!.hidden = true
        if(isPauseGame)
        {
            self.timer = NSTimer.scheduledTimerWithTimeInterval(0.09, target: self, selector: "timerMethod:", userInfo: nil, repeats: true)
            isPauseGame = false
            audioPlayer?.play()
        }else
        {
            RandomThemeMusic("1")
            lbScore.text = "0"
            lbLevel.text = "1"
            Level = 1
            if (self.timer != nil) {
                return
            }
            audioPlayer?.play()
            
            let worldSize = WorldSize(width: 20, height: 20)
            
            
            self.snake = Snake(inSize: worldSize, length: 2)
            self.makeNewFruit()
            self.timer = NSTimer.scheduledTimerWithTimeInterval(0.09, target: self, selector: "timerMethod:", userInfo: nil, repeats: true)
            
            //        self.timerMove = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "timerMethodCheckMove:", userInfo: nil, repeats: true)
            self.snakeView!.setNeedsDisplay()
        }
        
	}
	func endGame() {
		self.startButton!.hidden = false
        self.btPause!.hidden = true
		self.timer!.invalidate()
		self.timer = nil
	}

    func timerMethodCheckMove(timer:NSTimer) {
        isMove = false
    }
	func timerMethod(timer:NSTimer) {
        
        var isUpLevel = false
         var score1 = (self.snake!.points.count - 3)*10

            //        if(!isMove)
//        {return}
		self.snake?.move()
		let headHitBody = self.snake?.isHeadHitBody()
        
       
        
		if headHitBody == true {
          
            bomSound = AVPlayer(URL: NSBundle.mainBundle().URLForResource("gameover", withExtension: "mp3")!)
            bomSound.play()
              audioPlayer?.stop()
            
            if(score1 > savedScore)
            {
                lbHightest.text = String(score1)
                NSUserDefaults.standardUserDefaults().setObject(score1, forKey:"HighestScore")
                NSUserDefaults.standardUserDefaults().synchronize()
            }

			self.endGame()
			return
		}

		let head = self.snake?.points[0]
		if head?.x == self.fruit?.x &&
			head?.y == self.fruit?.y {
                self.snake!.increaseLength(1)
                score1 = (self.snake!.points.count - 3)*10
                let myScore = String(score1)
                lbScore.text = myScore
                let Level1 = Int(score1/100) + 1
                if(Level1 > Level)
                {
                    isUpLevel = true
                    levelUpSound = AVPlayer(URL: NSBundle.mainBundle().URLForResource("levelup", withExtension: "mp3")!)
                    levelUpSound.play()
                    Level = Level1
                    lbLevel.text = String(Level)
                    
                    if(Level > 5)
                    {
                        RandomThemeMusic("6")
                        audioPlayer?.play()
                    }
                    else if(Level > 4)
                    {
                        RandomThemeMusic("5")
                        audioPlayer?.play()
                    }
                    else if(Level > 3)
                    {
                        RandomThemeMusic("4")
                        audioPlayer?.play()
                    }
                    else if(Level > 2)
                    {
                        RandomThemeMusic("3")
                        audioPlayer?.play()
                    }
                    else if(Level > 1)
                    {
                        RandomThemeMusic("2")
                        audioPlayer?.play()
                    }
                    
                }
                
               
                
				
                if(!isUpLevel)
                {
                    FruitSound = AVPlayer(URL: NSBundle.mainBundle().URLForResource("buzz2", withExtension: "mp3")!)
                    FruitSound.play()
                }
                self.makeNewFruit()
		}

		self.snake?.unlockDirection()
		self.snakeView!.setNeedsDisplay()
	}

    var isStarted = false
	@IBAction func start(sender:AnyObject) {
		self.startGame()
        isStarted = true
	}

	func snakeForSnakeView(view:SnakeView) -> Snake? {
		return self.snake
	}
	func pointOfFruitForSnakeView(view:SnakeView) -> Point? {
		return self.fruit
	}

    
    
    //========================================================================================================================
    //========================================================================================================================
    //========================================================================================================================
    //===========================ADVERTISING======FOR-ADVERTISING=======ADVERTISING===========================================
    //============================================SIMPLE=VERSION==============================================================
    //========================================================================================================================
    //========================================================================================================================
    //========================================================================================================================
    //========================================================================================================================
    //========================================================================================================================
    //========================================================================================================================
    //===========================ADVERTISING======FOR-ADVERTISING=======ADVERTISING===========================================
    //============================================SIMPLE=VERSION==============================================================
    //========================================================================================================================
    //========================================================================================================================
    //========================================================================================================================
    //========================================================================================================================
    //========================================================================================================================
    //========================================================================================================================
    //===========================ADVERTISING======FOR-ADVERTISING=======ADVERTISING===========================================
    //============================================SIMPLE=VERSION==============================================================
    //========================================================================================================================
    //========================================================================================================================
    //========================================================================================================================
    
    
    var isStopAD = true
    var gBannerView: GADBannerView!
    var interstitial: GADInterstitial!
    var timerVPN:NSTimer?
    var timerAmazon:NSTimer?
    var interstitialAmazon: AmazonAdInterstitial!
    var isAd1 = false//admob full
    var isAd2 = true//admob Banner
    var isAd3 = false//amazon
    var isAd4 = false//adcolony
    var isAd5 = false//startapp
    var amazonLocationY:CGFloat = 20.0
    var timerAdColony:NSTimer?
    let data = Data()
    var CheckOnline = true
    
    var GBannerAdUnit: String = ""
    var GFullAdUnit: String = ""
    
    var AdcolonyAppID: String = ""
    var AdcolonyZoneID: String = ""
    var AdmobTestDeviceID: String = ""
    
    var Amazonkey = ""
    
       
    var showOtherAd = false //showAd (ngoai tru Admob Banner)
    
    
    func setupAD()
    {
        CheckAdOptionValue()
        if(showAd())
        {
            if(isAd1)
            {
                self.interstitial = self.createAndLoadAd()
                showAdmob()
            }
            if(isAd2)
            {
                ShowAdmobBanner()
                self.timerVPN = NSTimer.scheduledTimerWithTimeInterval(20, target: self, selector: "timerVPNMethodAutoAd:", userInfo: nil, repeats: true)
            }
            
            if(isAd3)
            {
                amazonLocationY = self.view.bounds.height - 50
                
                interstitialAmazon = AmazonAdInterstitial()
                interstitialAmazon.delegate = self
                
                loadAmazonFull()
                showAmazonFull()
            }else
            {
                amazonLocationY = self.view.bounds.height
            }
            
            if(isAd4)
            {
                showAdcolony()
                self.timerAdColony = NSTimer.scheduledTimerWithTimeInterval(30, target: self, selector: "timerAdColony:", userInfo: nil, repeats: true)
            }
            
            
            
            showAmazonBanner()
            self.timerAmazon = NSTimer.scheduledTimerWithTimeInterval(30, target: self, selector: "timerMethodAutoAmazon:", userInfo: nil, repeats: true)
            
        }
    }
    
    func showAdcolony()
    {
        AdColony.playVideoAdForZone(data.AdcolonyZoneID, withDelegate: nil)
    }
    func timerAdColony(timer:NSTimer) {
        
        if(showAd())
        {
            showAdcolony()
        }
    }
    
    func ShowAdmobBanner()
    {
        //let viewController = appDelegate1.window!.rootViewController as! GameViewController
        let w = self.view.bounds.width
        //let h = viewController.view.bounds.height
        gBannerView = GADBannerView(frame: CGRectMake(0, 20 , w, 50))
        gBannerView?.adUnitID = data.gBanner
        gBannerView?.delegate = self
        gBannerView?.rootViewController = self
        self.view?.addSubview(gBannerView)
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID , data.TestDeviceID];
        gBannerView?.loadRequest(request)
        //gBannerView?.hidden = true
        
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
            self.interstitial.presentFromRootViewController(self)
            self.interstitial = self.createAndLoadAd()
        }
    }
    
    
    
    
    func buttonAction(sender:UIButton!)
    {
        print("New game")
        
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
        GBannerAdUnit = data.gBanner
        GFullAdUnit = data.gFull
        
        Amazonkey = data.AmazonKey
        
        AdcolonyAppID = data.AdcolonyAppID
        AdcolonyZoneID = data.AdcolonyZoneID
        AdmobTestDeviceID = data.TestDeviceID
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
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("adOnline") != nil)
        {
            CheckOnline = NSUserDefaults.standardUserDefaults().objectForKey("adOnline") as! Bool
            print(NSUserDefaults.standardUserDefaults().objectForKey("adOnline"))
        }
        
        
        
        
        
        //GEt Ad unit online
        
        if(CheckOnline)
        {
            
            let xmlSetup = ADXML()
            xmlSetup.LoadXML()
        }
        SetupAdOnline()
        
        
    }
    
    
    func SetupAdOnline()
    {
        
        //google
        if(NSUserDefaults.standardUserDefaults().objectForKey("gBannerOnline") != nil)
        {
            GBannerAdUnit = NSUserDefaults.standardUserDefaults().objectForKey("gBannerOnline") as! String
            
        }
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("gFullOnline") != nil)
        {
            GFullAdUnit = NSUserDefaults.standardUserDefaults().objectForKey("gFullOnline") as! String
        }
        
        //get edited appid & sign from Adcolony
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("adcolonyAppID") != nil)
        {
            AdcolonyAppID = NSUserDefaults.standardUserDefaults().objectForKey("adcolonyAppID") as! String
            
        }
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("adcolonyZoneID") != nil)
        {
            AdcolonyZoneID = NSUserDefaults.standardUserDefaults().objectForKey("adcolonyZoneID") as! String
            
        }
        
        
        //get amazon online id
        if(NSUserDefaults.standardUserDefaults().objectForKey("amazon") != nil)
        {
            Amazonkey = NSUserDefaults.standardUserDefaults().objectForKey("amazon") as! String
            
        }
        
        //get CDMA status
        if(NSUserDefaults.standardUserDefaults().objectForKey("show-other-ad-online") != nil)
        {
            let tempCDMA = NSUserDefaults.standardUserDefaults().objectForKey("show-other-ad-online") as! String
            if(tempCDMA == "true")
            {
                showOtherAd = true
            }else
            {
                showOtherAd = false
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
    
    
    
    func MoreGame()
    {
        let barsLink : String = "itms-apps://itunes.apple.com/ca/developer/phuong-nguyen/id1004963752"
        UIApplication.sharedApplication().openURL(NSURL(string: barsLink)!)
    }
    func OpenView(viewName: String, view: UIViewController)
    {
        let storyboard = UIStoryboard(name: "StoryboardAD", bundle: nil)
        
        let WebDetailView = storyboard.instantiateViewControllerWithIdentifier(viewName) as UIViewController
        
        view.presentViewController(WebDetailView , animated: true, completion: nil)
        
    }
    
    
    //GADBannerViewDelegate
    func adViewDidReceiveAd(view: GADBannerView!) {
        print("adViewDidReceiveAd:\(view)");
        
        //relayoutViews()
    }
    
    func adView(view: GADBannerView!, didFailToReceiveAdWithError error: GADRequestError!) {
        print("\(view) error:\(error)")
        
        //relayoutViews()
    }
    
    func adViewWillPresentScreen(adView: GADBannerView!) {
        print("adViewWillPresentScreen:\(adView)")
        
        //relayoutViews()
    }
    
    func adViewWillLeaveApplication(adView: GADBannerView!) {
        print("adViewWillLeaveApplication:\(adView)")
    }
    
    func adViewWillDismissScreen(adView: GADBannerView!) {
        print("adViewWillDismissScreen:\(adView)")
        
        // relayoutViews()
    }
    
    
    
    
    //amazon
    ///////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    @IBOutlet var amazonAdView: AmazonAdView!
    func showAmazonBanner()
    {
        amazonAdView = AmazonAdView(adSize: AmazonAdSize_320x50)
        loadAmazonAdWithUserInterfaceIdiom(UIDevice.currentDevice().userInterfaceIdiom, interfaceOrientation: UIApplication.sharedApplication().statusBarOrientation)
        amazonAdView.delegate = nil
        self.view.addSubview(amazonAdView)
    }
    
    
    func loadAmazonAdWithUserInterfaceIdiom(userInterfaceIdiom: UIUserInterfaceIdiom, interfaceOrientation: UIInterfaceOrientation) -> Void {
        
        let options = AmazonAdOptions()
        options.isTestRequest = false
        let x = (self.view.bounds.width - 320)/2
        //viewController.view.bounds.height - 50
        if (userInterfaceIdiom == UIUserInterfaceIdiom.Phone) {
            amazonAdView.frame = CGRectMake(x, amazonLocationY, 320, 50)
        } else {
            amazonAdView.removeFromSuperview()
            
            if (interfaceOrientation == UIInterfaceOrientation.Portrait) {
                amazonAdView = AmazonAdView(adSize: AmazonAdSize_728x90)
                amazonAdView.frame = CGRectMake((self.view.bounds.width-728.0)/2.0, amazonLocationY, 728.0, 90.0)
            } else {
                amazonAdView = AmazonAdView(adSize: AmazonAdSize_1024x50)
                amazonAdView.frame = CGRectMake((self.view.bounds.width-1024.0)/2.0, amazonLocationY, 1024.0, 50.0)
            }
            self.view.addSubview(amazonAdView)
            amazonAdView.delegate = nil
        }
        
        amazonAdView.loadAd(options)
    }
    func timerMethodAutoAmazon(timer:NSTimer) {
        print("auto load amazon")
        if(showAd())
        {
            showAmazonBanner()
        }
        
        
    }
    
    ////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////
    
    //////////////////////
    //amazonfull
    //////////////////////
    func loadAmazonFull()
    {
        let options = AmazonAdOptions()
        
        options.isTestRequest = false
        
        interstitialAmazon.load(options)
    }
    func showAmazonFull()
    {
        interstitialAmazon.presentFromViewController(self)
        
    }
    
    /////////////////////////////////////////////////////////////
    // Mark: - AmazonAdViewDelegate
    // Mark: - AmazonAdViewDelegate
    func viewControllerForPresentingModalView() -> UIViewController {
        return self
    }
    
    func adViewDidLoad(view: AmazonAdView!) -> Void {
        self.view.addSubview(amazonAdView)
    }
    
    func adViewDidFailToLoad(view: AmazonAdView!, withError: AmazonAdError!) -> Void {
        print("Ad Failed to load. Error code \(withError.errorCode): \(withError.errorDescription)")
    }
    
    func adViewWillExpand(view: AmazonAdView!) -> Void {
        print("Ad will expand")
    }
    
    func adViewDidCollapse(view: AmazonAdView!) -> Void {
        print("Ad has collapsed")
    }
    
    ///////////
    //full delegate
    // Mark: - AmazonAdInterstitialDelegate
    func interstitialDidLoad(interstitial: AmazonAdInterstitial!) {
        Swift.print("Interstitial loaded.", terminator: "")
        //loadStatusLabel.text = "Interstitial loaded."
        showAmazonFull()
    }
    
    func interstitialDidFailToLoad(interstitial: AmazonAdInterstitial!, withError: AmazonAdError!) {
        Swift.print("Interstitial failed to load.", terminator: "")
        //loadStatusLabel.text = "Interstitial failed to load."
    }
    
    func interstitialWillPresent(interstitial: AmazonAdInterstitial!) {
        Swift.print("Interstitial will be presented.", terminator: "")
    }
    
    func interstitialDidPresent(interstitial: AmazonAdInterstitial!) {
        Swift.print("Interstitial has been presented.", terminator: "")
    }
    
    func interstitialWillDismiss(interstitial: AmazonAdInterstitial!) {
        Swift.print("Interstitial will be dismissed.", terminator: "")
        
    }
    
    func interstitialDidDismiss(interstitial: AmazonAdInterstitial!) {
        Swift.print("Interstitial has been dismissed.", terminator: "");
        //self.loadStatusLabel.text = "No interstitial loaded.";
        //loadAmazonFull();
    }
    
 
    //========================================================================================================================
    //========================================================================================================================
    //========================================================================================================================
    //===========================ADVERTISING======FOR-ADVERTISING=======ADVERTISING===========================================
    //============================================SIMPLE=VERSION==============================================================
    //========================================================================================================================
    //========================================================================================================================
    //========================================================================================================================

}
