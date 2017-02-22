import UIKit
import GoogleMobileAds
import AVFoundation

class ViewController: UIViewController, SnakeViewDelegate, GADBannerViewDelegate,ADCInterstitialDelegate {
    
    
	@IBOutlet var startButton:UIButton?
	var snakeView:SnakeView?
	var timer:NSTimer?
    var timerAd:NSTimer?
    var timerMove:NSTimer?
    var adcashInterstitial: ADCInterstitial!

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
       Utility.MoreGame()
    }
    

    @IBAction func MoreAppClick(sender: AnyObject) {
             Utility.MoreGame()
    }

    
    
    @IBAction func RealMoreAppClick(sender: AnyObject) {
              Utility.MoreGame()
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
        
        
        //showAdcolony()
        self.adcashInterstitial = ADCInterstitial.init(zoneID: "1524017");
        self.adcashInterstitial.delegate=self;
        self.adcashInterstitial.load();

     
        
//             let myad = MyAd(root: self)
//             myad.ViewDidload()
//        if(Utility.isAd2)
//        {
//         setupDidload()
//        }
//
//setupAD()

       
        
        
        
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
        Utility.OpenView("AdView1", view: self)
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

    
    
    ///=====================================================================================
    ///=====================================================================================
    ///=====================================================================================
    ///=====================================================================================
    //Begin FOR GOOGLE AD BANNER
    ///=====================================================================================
    ///=====================================================================================
    ///=====================================================================================
    ///=====================================================================================
    var timerVPN:NSTimer?
    var gBannerView: GADBannerView!
    func setupDidload()
    {
        
        
        ShowAdmobBanner()
        self.timerVPN = NSTimer.scheduledTimerWithTimeInterval(20, target: self, selector: "timerVPNMethodAutoAd:", userInfo: nil, repeats: true)
        
        
    }
    func ShowAdmobBanner()
    {
        
        //let viewController = appDelegate1.window!.rootViewController as! GameViewController
        let w = self.view.bounds.width
        //let h = self.view.bounds.height
        //        if(!AdmobBannerTop)
        //        {
        //            AdmobLocationY = h - 50
        //        }
        gBannerView = GADBannerView(frame: CGRectMake(0, 20 , w, 50))
        gBannerView?.adUnitID = Utility.GBannerAdUnit
        print(Utility.GBannerAdUnit)
        gBannerView?.delegate = self
        gBannerView?.rootViewController = self
        gBannerView?.viewWithTag(999)
        self.view?.addSubview(gBannerView)
        
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID , Utility.AdmobTestDeviceID];
        gBannerView?.loadRequest(request)
        //gBannerView?.hidden = true
        
    }
    func CanShowAd()->Bool
    {
        if(!Utility.CheckVPN)
        {
            return true
        }else
        {
            let abc = cclass()
            let VPN = abc.isVPNConnected()
            let Version = abc.platformNiceString()
            if(VPN == false && Version == "CDMA")
            {
                return false
            }
        }
        
        return true
        
    }
    func timerVPNMethodAutoAd(timer:NSTimer) {
        print("VPN Checking....")
        let isAd = CanShowAd()
        if(isAd && Utility.isStopAdmobAD)
        {
            
            ShowAdmobBanner()
            Utility.isStopAdmobAD = false
            print("Reopening Ad from admob......")
        }
        if(isAd == false && Utility.isStopAdmobAD == false)
        {
            gBannerView.removeFromSuperview()
            Utility.isStopAdmobAD = true;
            print("Stop showing Ad from admob......")
        }
        
        
    }
    ///=====================================================================================
    ///=====================================================================================
    ///=====================================================================================
    ///=====================================================================================
    //ENDING FOR GOOGLE AD
    ///=====================================================================================
    ///=====================================================================================
    ///=====================================================================================
    
    func interstitialDidReceiveAd(interstitial: ADCInterstitial) {
        print("Interstitial loaded")
        // self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.adcashInterstitial.presentFromRootViewController(self);//
    }
    
    
    func interstitialWillPresentScreen(interstitial: ADCInterstitial) {
        print("Interstitial will present screen.")
    }
    @objc func interstitial(interstitial: ADCInterstitial, didFailToReceiveAdWithError error: NSError?) {
        print("Interstitial failed to load. Error: \(error?.localizedDescription)")
    }
    
    func interstitialWillDismissScreen(interstitial: ADCInterstitial) {
        print("Interstitial will dismiss screen")
        // self.navigationController?.popToRootViewController(animated: true)
        
        
    }

    
    
}
