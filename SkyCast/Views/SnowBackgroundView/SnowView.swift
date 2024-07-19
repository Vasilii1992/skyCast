
import UIKit

class SnowView: UIView {
    
    override class var layerClass: AnyClass {
        return CAEmitterLayer.self
    }
    
    private var emitterLayer: CAEmitterLayer {
        return self.layer as! CAEmitterLayer
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupEmitter()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupEmitter() {
        emitterLayer.emitterShape = .line
        emitterLayer.emitterPosition = CGPoint(x: bounds.midX, y: 0)
        emitterLayer.emitterSize = CGSize(width: bounds.size.width, height: 1)
        emitterLayer.emitterCells = [makeSnowflakeCell()]
    }
    
    private func makeSnowflakeCell() -> CAEmitterCell {
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
        return cell
    }
}
