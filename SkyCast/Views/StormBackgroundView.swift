

import UIKit

class StormBackgroundView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientLayer()
        addCloudView()
        addRainView()
        addLightningView()
        addMultipleFloatingCloudViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [
            UIColor(hex: "#1A2036").cgColor,
            UIColor(hex: "#0A0A19").cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func addCloudView() {
        let cloudView = CloudForStorm(frame: self.bounds)
        self.addSubview(cloudView)
    }
    
    private func addRainView() {
        let rainView = LinearRainView(frame: self.bounds)
        self.addSubview(rainView)
    }
    
    private func addLightningView() {
        let lightningView = LightningView(frame: self.bounds)
        self.addSubview(lightningView)
    }
    
    private func addMultipleFloatingCloudViews() {
        let positions = [
            CGPoint(x: 50, y: 40),
            CGPoint(x: 150, y: 100),
            CGPoint(x: -160, y: 60),
            CGPoint(x: -25, y: 170)
        ]
        
        for position in positions {
            let floatingCloudView = FloatingDarkCloudView(frame: self.bounds, position: position)
            self.addSubview(floatingCloudView)
        }
    }
}

class CloudForStorm: UIView {
    
    private let cloudLayer = CALayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCloudLayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupCloudLayer() {
        cloudLayer.frame = CGRect(x: 0, y: 0, width: 600, height: 200)
        cloudLayer.contents = UIImage(named: Resources.Strings.ImageName.darkClouds)?.cgImage
        cloudLayer.opacity = 0.7
        self.layer.addSublayer(cloudLayer)
    }
}

class FloatingDarkCloudView: UIView {
    
    private let floatingCloudLayer = CALayer()
    
    init(frame: CGRect, position: CGPoint) {
        super.init(frame: frame)
        setupFloatingCloudLayer(at: position)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupFloatingCloudLayer(at position: CGPoint) {
        let cloudWidth: CGFloat = 400
        let cloudHeight: CGFloat = 200
        floatingCloudLayer.frame = CGRect(x: position.x, y: position.y, width: cloudWidth, height: cloudHeight)
        floatingCloudLayer.contents = UIImage(named: Resources.Strings.ImageName.clouds)?.cgImage
        floatingCloudLayer.opacity = 0.6
        self.layer.addSublayer(floatingCloudLayer)
        
        let animation = CABasicAnimation(keyPath: "position.x")
        animation.fromValue = position.x
        animation.toValue = self.bounds.width + cloudWidth
        animation.duration = 120
        animation.repeatCount = .infinity
        floatingCloudLayer.add(animation, forKey: "floatingAnimation")
    }
}

class LinearRainView: UIView {
    
    private let rainLayer = CAEmitterLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupRainLayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupRainLayer() {
        rainLayer.emitterShape = .line
        rainLayer.emitterPosition = CGPoint(x: bounds.midX, y: 0)
        rainLayer.emitterSize = CGSize(width: bounds.size.width, height: 1)
        
        let cell = CAEmitterCell()
        cell.contents = UIImage(named: Resources.Strings.ImageName.waterLine)?.cgImage
        cell.birthRate = 2000
        cell.lifetime = 5.0
        cell.velocity = 1000
        cell.velocityRange = 1000
        cell.scale = 0.02
        cell.scaleRange = 0.03
        cell.yAcceleration = 500
        cell.emissionRange = .pi / 4
        
        rainLayer.emitterCells = [cell]
        self.layer.addSublayer(rainLayer)
    }
}

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
