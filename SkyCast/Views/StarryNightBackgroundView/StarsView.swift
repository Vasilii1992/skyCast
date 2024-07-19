
import UIKit

class StarsView: UIView {
    
    private let numberOfStars = 80
    private let baseStarSize: CGFloat = 10.0
    private let starSizeVariation: CGFloat = 4
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addStars()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func addStars() {
        let upperHalfHeight = bounds.height / 2
        for _ in 0..<numberOfStars {
            let starLayer = CALayer()
            starLayer.contents = UIImage(named: Resources.Strings.ImageName.star)?.cgImage
            
            let starSize = baseStarSize * CGFloat.random(in: 1.0...starSizeVariation)
            
            let xPosition = CGFloat.random(in: 0..<bounds.width)
            let yPosition = CGFloat.random(in: 0..<upperHalfHeight)
            starLayer.frame = CGRect(x: xPosition, y: yPosition, width: starSize, height: starSize)
            self.layer.addSublayer(starLayer)
            addFlickerAnimation(to: starLayer)
        }
    }
    
    private func addFlickerAnimation(to layer: CALayer) {
        let flickerAnimation = CAKeyframeAnimation(keyPath: "opacity")
        flickerAnimation.values = [1.0, 0.3, 1.0]
        flickerAnimation.keyTimes = [0, 0.5, 1]
        flickerAnimation.duration = Double.random(in: 1.0..<3.0)
        flickerAnimation.repeatCount = .infinity
        layer.add(flickerAnimation, forKey: "flickerAnimation")
    }
}
