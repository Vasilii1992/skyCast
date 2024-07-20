
import UIKit

final class FloatingCloudView: UIView {
    
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
