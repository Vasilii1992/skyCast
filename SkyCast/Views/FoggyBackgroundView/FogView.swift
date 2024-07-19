
import UIKit

class FogView: UIView {
    
    private let fogLayer = CALayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFogLayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupFogLayer() {
        let fogImage = UIImage(named: Resources.Strings.ImageName.fog)?.cgImage
        fogLayer.contents = fogImage
        fogLayer.frame = CGRect(x: -self.bounds.width, y: 0, width: self.bounds.width * 2, height: self.bounds.height / 2)
        fogLayer.opacity = 0.5
        self.layer.addSublayer(fogLayer)
        
        let animation = CABasicAnimation(keyPath: "position.x")
        animation.fromValue = -40
        animation.toValue = self.bounds.width
        animation.duration = 70
        animation.repeatCount = .infinity
        fogLayer.add(animation, forKey: "fogAnimation")
    }
}
