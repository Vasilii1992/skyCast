
import UIKit

class RainyBackgroundView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientLayer()
        addCloudView()
        addRainView()
        addFloatingCloudView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [
            UIColor(hex: "#202037").cgColor,
            UIColor(hex: "#0A0A19").cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        self.layer.insertSublayer(gradientLayer, at: 0)
    }

    private func addFloatingCloudView() {
        let floatingCloudView = FloatingCloudView(frame: self.bounds)
        self.addSubview(floatingCloudView)
    }
    
    private func addCloudView() {
        let cloudView = DarkCloudView(frame: self.bounds)
        self.addSubview(cloudView)
    }
    
    private func addRainView() {
        let rainView = RainView(frame: self.bounds)
        self.addSubview(rainView)
    }
}

class FloatingCloudView: UIView {
    
    private let floatingCloudLayer = CALayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFloatingCloudLayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupFloatingCloudLayer() {
        let cloudWidth: CGFloat = 400
        let cloudHeight: CGFloat = 200
        floatingCloudLayer.frame = CGRect(x: -cloudWidth, y: 60, width: cloudWidth, height: cloudHeight)
        floatingCloudLayer.contents = UIImage(named: Resources.Strings.ImageName.whiteClouds)?.cgImage
        floatingCloudLayer.opacity = 0.7
        self.layer.addSublayer(floatingCloudLayer)
        
        let animation = CABasicAnimation(keyPath: "position.x")
        animation.fromValue = -80
        animation.toValue = self.bounds.width + cloudWidth
        animation.duration = 70
        animation.repeatCount = .infinity
        floatingCloudLayer.add(animation, forKey: "floatingAnimation")
    }
}

class DarkCloudView: UIView {
    
    private let cloudLayer = CALayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCloudLayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupCloudLayer() {
        cloudLayer.frame = CGRect(x: 0, y: -50, width: 600, height: 200)
        cloudLayer.contents = UIImage(named: Resources.Strings.ImageName.clouds)?.cgImage
        cloudLayer.opacity = 0.7
        self.layer.addSublayer(cloudLayer)
    }
}

class RainView: UIView {
    
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
        cell.contents = UIImage(named: Resources.Strings.ImageName.dropOfRain)?.cgImage
        cell.birthRate = 1000
        cell.lifetime = 5.0
        cell.velocity = 1000
        cell.velocityRange = 900
        cell.scale = 0.008
        cell.scaleRange = 0.01
        cell.yAcceleration = 500
        cell.emissionRange = .pi / 4
        
        rainLayer.emitterCells = [cell]
        self.layer.addSublayer(rainLayer)
    }
}

