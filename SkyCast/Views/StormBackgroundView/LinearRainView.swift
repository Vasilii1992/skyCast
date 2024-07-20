
import UIKit

final class LinearRainView: UIView {
    
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
        cell.birthRate = 1500
        cell.lifetime = 5.0
        cell.velocity = 1000
        cell.velocityRange = 1000
        cell.scale = 0.02
        cell.scaleRange = 0.03
        cell.yAcceleration = 500
        cell.emissionRange = .pi * 4
        
        rainLayer.emitterCells = [cell]
        self.layer.addSublayer(rainLayer)
    }
}
