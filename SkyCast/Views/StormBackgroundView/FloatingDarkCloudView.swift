
import UIKit

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
