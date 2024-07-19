
import UIKit

class LightningView: UIView {
    
    private var lightningLayer: CALayer?
    private var lightningTimer: Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        startLightning()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func startLightning() {
        lightningTimer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(addLightning), userInfo: nil, repeats: true)
    }
    
    @objc private func addLightning() {
        lightningLayer?.removeFromSuperlayer()
        
        let lightningLayer = CALayer()
        let lightningImage = UIImage(named: Resources.Strings.ImageName.lightning)?.cgImage
        let lightningImageWidth = lightningImage?.width ?? 0
        let lightningImageHeight = lightningImage?.height ?? 0
        let halfWidth = CGFloat(lightningImageWidth) / 2
        let halfHeight = CGFloat(lightningImageHeight) / 2
        lightningLayer.contents = lightningImage
        lightningLayer.frame = CGRect(
            x: 0,
            y: 10,
            width: halfWidth,
            height: halfHeight
        )
        lightningLayer.opacity = 0.0
        self.layer.insertSublayer(lightningLayer, below: self.layer.sublayers?.last)
        self.lightningLayer = lightningLayer
        
        let flashAnimation = CAKeyframeAnimation(keyPath: "opacity")
        flashAnimation.values = [0.0, 0.5, 1.0, 0.5, 0.0]
        flashAnimation.keyTimes = [0, 0.2, 0.4, 0.6, 1.0]
        flashAnimation.duration = 1.0
        flashAnimation.repeatCount = 1
        
        lightningLayer.add(flashAnimation, forKey: "flashAnimation")
    }
    
    deinit {
        lightningTimer?.invalidate()
    }
}
