
import UIKit

class SunBackgroundView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientLayer()
        addSunView()
        addCloudView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [
            UIColor(hex: "#4479DB").cgColor,
            UIColor(hex: "#6FAFF3").cgColor,
            UIColor(hex: "#BEDFFF").cgColor
        ]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        self.layer.addSublayer(gradientLayer)
    }
    
    private func addSunView() {
        let sunView = SunView(frame: self.bounds)
        self.addSubview(sunView)
    }
    
    private func addCloudView() {
        let cloudView = CloudView(frame: self.bounds)
        self.addSubview(cloudView)
    }
}

class SunView: UIView {
    
    private let sunLayer = CALayer()
    private let sunEffectLayer = CAEmitterLayer()
    
    private var displayLink: CADisplayLink?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSunLayer()
        setupSunEffectLayer()
        startDisplayLink()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

    }
    
    private func setupSunLayer() {
        sunLayer.frame = CGRect(x: 160, y: -100, width: 380, height: 380)
        sunLayer.contents = UIImage(named: Resources.Strings.ImageName.sun)?.cgImage
        self.layer.addSublayer(sunLayer)
    }
    
    private func setupSunEffectLayer() {
        sunEffectLayer.emitterPosition = sunLayer.position
        sunEffectLayer.emitterShape = .circle
        sunEffectLayer.emitterSize = CGSize(width: 80, height: 80)
        
        let cell = CAEmitterCell()
        cell.contents = UIImage(named: Resources.Strings.ImageName.sunGlow)?.cgImage
        cell.birthRate = 0.2
        cell.lifetime = 5.0
        cell.velocity = 15
        cell.velocityRange = 5
        cell.scale = 0.2
        cell.scaleRange = 0.1
        cell.alphaSpeed = -0.02
        cell.yAcceleration = -5
        cell.emissionRange = .pi * 2.0 
        
        sunEffectLayer.emitterCells = [cell]
        self.layer.addSublayer(sunEffectLayer)
    }
    
    private func startDisplayLink() {
        displayLink = CADisplayLink(target: self, selector: #selector(updateAnimation))
        displayLink?.add(to: .main, forMode: .default)
    }
    
    @objc private func updateAnimation() {
        sunEffectLayer.setNeedsDisplay()
    }
    
    deinit {
        displayLink?.invalidate()
    }
}

class CloudView: UIView {
    
    private let cloudLayer = CALayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCloudLayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupCloudLayer() {
        cloudLayer.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 200)
        cloudLayer.contents = UIImage(named: Resources.Strings.ImageName.cloudySky)?.cgImage
        cloudLayer.opacity = 0.8
        self.layer.addSublayer(cloudLayer)
    }
}
