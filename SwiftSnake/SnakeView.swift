import UIKit

protocol SnakeViewDelegate {
	func snakeForSnakeView(view:SnakeView) -> Snake?
	func pointOfFruitForSnakeView(view:SnakeView) -> Point?
}
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}
class SnakeView : UIView {
	var delegate:SnakeViewDelegate?

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.backgroundColor = UIColor.purpleColor()
	}

    override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = UIColor(netHex:0xd4edc7)
        
       
    }
    

	override func drawRect(rect: CGRect) {
		super.drawRect(rect)
        
         
        
		if let snake:Snake = delegate?.snakeForSnakeView(self) {
			let worldSize = snake.worldSize
			if worldSize.width <= 0 || worldSize.height <= 0 {
				return
			}
			let w = Int(Float(self.bounds.size.width) / Float(worldSize.width))
			let h = Int(Float(self.bounds.size.height) / Float(worldSize.height))

			UIColor.blackColor().set()
			let points = snake.points
            var isHead = true
			for point in points {
				let rect = CGRect(x: point.x * w, y: point.y * h, width: w, height: h)
                if(isHead)
                {
                   UIColor(netHex:0x438DC7).set()
                   isHead = false
                }else
                {
                    UIColor.purpleColor().set()
                   
                }
				UIBezierPath(rect: rect).fill()
			}

			if let fruit = delegate?.pointOfFruitForSnakeView(self) {
				UIColor.orangeColor().set()
				let rect = CGRect(x: fruit.x * w, y: fruit.y * h, width: w, height: h)
				UIBezierPath(ovalInRect: rect).fill()
			}
		}
	}
}
