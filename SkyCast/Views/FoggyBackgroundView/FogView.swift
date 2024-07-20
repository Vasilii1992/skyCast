
import UIKit

final class FogView: UIView {
    
    private let fogLayer = CALayer()
    
    init(frame: CGRect, position: CGPoint) {
        super.init(frame: frame)
        setupFogLayer(at: position)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupFogLayer(at position: CGPoint) {
        let fogImage = UIImage(named: Resources.Strings.ImageName.fog)?.cgImage
        fogLayer.contents = fogImage
        fogLayer.frame = CGRect(x: position.x, y: position.y, width: self.bounds.width * 2, height: self.bounds.height / 2)
        fogLayer.opacity = 0.4
        self.layer.addSublayer(fogLayer)
        
        let animation = CABasicAnimation(keyPath: "position.x")
        animation.fromValue = 10
        animation.toValue = self.bounds.width
        animation.duration = 70
        animation.repeatCount = .infinity
        fogLayer.add(animation, forKey: "fogAnimation")
    }
}
