
import UIKit

final class SnowView: UIView {
    
    private var snowLayer = CAEmitterLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSnowLayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupSnowLayer() {
        snowLayer.emitterShape = .line
        snowLayer.emitterPosition = CGPoint(x: bounds.midX, y: 0)
        snowLayer.emitterSize = CGSize(width: bounds.size.width, height: 1)

        let cell = CAEmitterCell()
        cell.contents = UIImage(named: Resources.Strings.ImageName.snowflake)?.cgImage
        cell.birthRate = 10
        cell.lifetime = 20.0
        cell.velocity = 30
        cell.velocityRange = 20
        cell.yAcceleration = 30
        cell.scale = 0.01
        cell.scaleRange = 0.013
        cell.emissionRange = .pi
        
        snowLayer.emitterCells = [cell]
        self.layer.addSublayer(snowLayer)
    }
}
