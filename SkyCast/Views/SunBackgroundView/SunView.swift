
import UIKit

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
