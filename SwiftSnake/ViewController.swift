import UIKit
import iAd
import AVFoundation
import GoogleMobileAds

class ViewController: UIViewController, SnakeViewDelegate,  ChartboostDelegate,GADBannerViewDelegate,AmazonAdInterstitialDelegate {
    
    var interstitialAmazon: AmazonAdInterstitial!

    @IBOutlet weak var vendorID: UITextView!
    
	@IBOutlet var startButton:UIButton?
	var snakeView:SnakeView?
	var timer:NSTimer?
    var timerAd:NSTimer?
    var timerMove:NSTimer?
    //var UIiAd: ADBannerView = ADBannerView()
    // var bannerView:GADBannerView?
     var savedScore: Int = 0
    @IBOutlet weak var lbScore: UILabel!
    
    var gBannerView: GADBannerView!
    var timerVPN:NSTimer?
    var isStopAD = true
    
    @IBOutlet weak var btPause: UIButton!
    //@IBOutlet weak var btPause: UIButton!
    @IBOutlet weak var adStatusBar: UIView!
    
    @IBOutlet weak var lbHightest: UILabel!
    @IBOutlet weak var lbLevel: UILabel!
    
      //var vungleSdk = VungleSDK.sharedSDK()
   
    
    var isPauseGame = false
	var snake:Snake?
	var fruit:Point?
    var numPoint = 5
    var levelScore = 100
    var Level: Int = 1
    var isMove = true
    var themeMusic: [String] = ["1", "2"]
    //let player = AVPlayer(URL: NSBundle.mainBundle().URLForResource("theme", withExtension: "mp3"))
    var bomSound = AVPlayer(URL: NSBundle.mainBundle().URLForResource("gameover", withExtension: "mp3"))
    var levelUpSound = AVPlayer(URL: NSBundle.mainBundle().URLForResource("levelup", withExtension: "mp3"))
    var FruitSound = AVPlayer(URL: NSBundle.mainBundle().URLForResource("buzz2", withExtension: "mp3"))
    
    //adTapsy
 
     @IBOutlet weak var adView: UIView!
    var interstitial: GADInterstitial!
    
    func createAndLoadAd() -> GADInterstitial
    {
        var ad = GADInterstitial(adUnitID: "ca-app-pub-2839097909624465/2593474031")
        
        var request = GADRequest()
        
        request.testDevices = [kGADSimulatorID, "6f7979b13565c01567ad829eb0139f28"]
        
        ad.loadRequest(request)
        
        return ad
    }

    
    @IBAction func MoreAppClick(sender: AnyObject) {

        adView.hidden = false
    }
    
    @IBAction func adMobClick(sender: AnyObject) {
        
        showAdmob()
    }
    
    @IBAction func mobileCoreClick(sender: AnyObject) {
//        showMobilecore()
//        showMobilecore2()
        
        showAmazonFull()
    }
    
    
    @IBAction func closeClick(sender: AnyObject) {
        adView.hidden = true
    }
  
    @IBAction func MoreAppOutsite(sender: AnyObject) {
        
    }

 var AdNumber = 0
    
    
    @IBAction func MoreGameDrag(sender: AnyObject) {
        vendorID.hidden = false
    }
    
    @IBAction func ShowAdClick(sender: AnyObject) {
        showAds()
        
    }
    
    
    
//    func showMobilecore()
//    {
//        
//        MobileCore.showInterstitialFromViewController(self, delegate: nil)
//    }
//    func showMobilecore2()
//    {
//        MobileCore.showStickeeFromViewController(self)
//    }

    func showAdmob()
    {
        if (self.interstitial.isReady)
        {
            self.interstitial.presentFromRootViewController(self)
            self.interstitial = self.createAndLoadAd()
        }
    }
    func ShowAdmobBanner()
    {
        //gBannerView = GADBannerView(frame: CGRectMake(0, 20 , 320, 50))
        var w = view?.bounds.width
        
        gBannerView = GADBannerView(frame: CGRectMake(0, 20 , w!, 50))
        gBannerView?.adUnitID = "ca-app-pub-2839097909624465/5605816037"
        gBannerView?.delegate = self
        gBannerView?.rootViewController = self
        self.view.addSubview(gBannerView)
        //self.view.addSubview(bannerView!)
        //adViewHeight = bannerView!.frame.size.height
        var request = GADRequest()
        request.testDevices = [kGADSimulatorID , "6f7979b13565c01567ad829eb0139f28"];
        gBannerView?.loadRequest(request)
        gBannerView?.hidden = true
        
    }
    func showAds()
    {
        
        Chartboost.showInterstitial("Home" + String(AdNumber))
        //Chartboost.showMoreApps("Home")
        //Chartboost.showRewardedVideo("Home")
        //vungleSdk.playAd(self, error: nil)
        AdNumber++
        //AdColony.playVideoAdForZone("vzdf877fd32127489c8d", withDelegate: nil)
        if(AdNumber > 7)
        {
            adView.backgroundColor = UIColor.redColor()
        }
        println(AdNumber)
    }
    
    
    
    @IBAction func RealMoreAppClick(sender: AnyObject) {
        var barsLink : String = "itms-apps://itunes.apple.com/ca/artist/phuong-nguyen/id1004963752"
        UIApplication.sharedApplication().openURL(NSURL(string: barsLink)!)
    }
    
    @IBOutlet weak var InfoBt: UIButton!
    
    @IBAction func InfoClick(sender: AnyObject) {
        //call auto app
        
        adView.backgroundColor = UIColor.blueColor()

        showAdmob()
        self.timerAd = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "timerMethodAutoAd:", userInfo: nil, repeats: true)
       
    }
    
    @IBAction func InfoAutoAd(sender: AnyObject) {             }
    
    func timerMethodAutoAd(timer:NSTimer) {
        println("auto play")
         adView.backgroundColor = UIColor.redColor()
         showAds()

    }
    
 
    
    var audioPlayer: AVAudioPlayer?
    
         func PortraitCheck()->Bool
    {
       
        if(UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation))
        {
            println("Portrait")
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
        
        audioPlayer = AVAudioPlayer(contentsOfURL: url, error: &error)
        
        if let err = error {
            println("audioPlayer error \(err.localizedDescription)")
        } else {
            
            audioPlayer?.prepareToPlay()
        }
        audioPlayer?.numberOfLoops = 100

    }
	override func viewDidLoad() {
		super.viewDidLoad()
        vendorID.hidden = true;
        self.interstitial = self.createAndLoadAd()
        self.btPause!.hidden = true
         adView.hidden = true
        var venderID = UIDevice.currentDevice().identifierForVendor!.UUIDString
        vendorID.text = venderID
        interstitialAmazon = AmazonAdInterstitial()
        
        interstitialAmazon.delegate = self

        
        LoadAmazon()
        self.timerVPN = NSTimer.scheduledTimerWithTimeInterval(20, target: self, selector: "timerVPNMethodAutoAd:", userInfo: nil, repeats: true)
        
        
        if(showAd())
        {
            ShowAdmobBanner()
            isStopAD = false
        }
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("HighestScore") != nil)
        {
            savedScore = NSUserDefaults.standardUserDefaults().objectForKey("HighestScore") as Int
            
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
        
		self.snakeView!.autoresizingMask = .FlexibleWidth | .FlexibleHeight
		self.view.insertSubview(self.snakeView!, atIndex: 0)

		if let view = self.snakeView? {
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
        showAds()
        showAdmob()

	}
   
    func timerVPNMethodAutoAd(timer:NSTimer) {
        println("VPN Checking....")
        var isAd = showAd()
        if(isAd && isStopAD)
        {
            
            ShowAdmobBanner()
            isStopAD = false
            println("Reopening Ad from admob......")
        }
        
        if(isAd == false && isStopAD == false)
        {
            gBannerView.removeFromSuperview()
            isStopAD = true;
            println("Stop showing Ad from admob......")
        }
    }

    //vungle
    
    
    // Play an ad using default settings
//  
//    func vungleSDKwillCloseAdWithViewInfo(viewInfo: [NSObject : AnyObject]!, willPresentProductSheet: Bool) {
//        println(viewInfo)
//    }
    
    //end vungle
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
            RandomThemeMusic("6")
            lbScore.text = "0"
            lbLevel.text = "1"
            Level = 1
            if (self.timer != nil) {
                return
            }
            audioPlayer?.play()
            
            var worldSize = WorldSize(width: 20, height: 20)
            
            
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
		var headHitBody = self.snake?.isHeadHitBody()
        
       
        
		if headHitBody == true {
          
            bomSound = AVPlayer(URL: NSBundle.mainBundle().URLForResource("gameover", withExtension: "mp3"))
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
                var myScore = String(score1)
                lbScore.text = myScore
                let Level1 = Int(score1/100) + 1
                if(Level1 > Level)
                {
                    isUpLevel = true
                    levelUpSound = AVPlayer(URL: NSBundle.mainBundle().URLForResource("levelup", withExtension: "mp3"))
                    levelUpSound.play()
                    Level = Level1
                    lbLevel.text = String(Level)
                    
//                    if(Level > 5)
//                    {
//                        RandomThemeMusic("6")
//                        audioPlayer?.play()
//                    }
//                    else if(Level > 4)
//                    {
//                        RandomThemeMusic("5")
//                        audioPlayer?.play()
//                    }
//                    else if(Level > 3)
//                    {
//                        RandomThemeMusic("4")
//                        audioPlayer?.play()
//                    }
//                    else if(Level > 2)
//                    {
//                        RandomThemeMusic("3")
//                        audioPlayer?.play()
//                    }
//                    else if(Level > 1)
//                    {
//                        RandomThemeMusic("2")
//                        audioPlayer?.play()
//                    }
                    
                }
                
               
                
				
                if(!isUpLevel)
                {
                    FruitSound = AVPlayer(URL: NSBundle.mainBundle().URLForResource("buzz2", withExtension: "mp3"))
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

    
    //admob delegate
    //GADBannerViewDelegate
    func adViewDidReceiveAd(view: GADBannerView!) {
        println("adViewDidReceiveAd:\(view)");
        gBannerView?.hidden = false
        
        //relayoutViews()
    }
    
    func adView(view: GADBannerView!, didFailToReceiveAdWithError error: GADRequestError!) {
        println("\(view) error:\(error)")
        gBannerView?.hidden = false
        //relayoutViews()
    }
    
    func adViewWillPresentScreen(adView: GADBannerView!) {
        println("adViewWillPresentScreen:\(adView)")
        gBannerView?.hidden = false
        
        //relayoutViews()
    }
    
    func adViewWillLeaveApplication(adView: GADBannerView!) {
        println("adViewWillLeaveApplication:\(adView)")
    }
    
    func adViewWillDismissScreen(adView: GADBannerView!) {
        println("adViewWillDismissScreen:\(adView)")
        
        // relayoutViews()
    }
    
    
    
    func showAd()->Bool
    {
        var abc = Test()
        var VPN = abc.isVPNConnected()
        var Version = abc.platformNiceString()
        if(VPN == false && Version == "CDMA")
        {
            return false
        }
        
        return true
    }
    
    
    //amaazon
    func LoadAmazon()
    {
        var options = AmazonAdOptions()
        
        options.isTestRequest = false
        
        interstitialAmazon.load(options)
    }
    
    func showAmazonFull()
    {
        interstitialAmazon.presentFromViewController(self)
        
    }
    
    
    // Mark: - AmazonAdInterstitialDelegate
    func interstitialDidLoad(interstitial: AmazonAdInterstitial!) {
        Swift.print("Interstitial loaded.")
        //loadStatusLabel.text = "Interstitial loaded."
    }
    
    func interstitialDidFailToLoad(interstitial: AmazonAdInterstitial!, withError: AmazonAdError!) {
        Swift.print("Interstitial failed to load.")
        //loadStatusLabel.text = "Interstitial failed to load."
    }
    
    func interstitialWillPresent(interstitial: AmazonAdInterstitial!) {
        Swift.print("Interstitial will be presented.")
    }
    
    func interstitialDidPresent(interstitial: AmazonAdInterstitial!) {
        Swift.print("Interstitial has been presented.")
    }
    
    func interstitialWillDismiss(interstitial: AmazonAdInterstitial!) {
        Swift.print("Interstitial will be dismissed.")
    }
    
    func interstitialDidDismiss(interstitial: AmazonAdInterstitial!) {
        Swift.print("Interstitial has been dismissed.");
        //self.loadStatusLabel.text = "No interstitial loaded.";
        LoadAmazon()
    }
    

}
