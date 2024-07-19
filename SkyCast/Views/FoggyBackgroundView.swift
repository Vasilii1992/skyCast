
import UIKit

class FoggyBackgroundView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientLayer()
        addFogView()
        addCloudView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [
            UIColor(hex: "#4D547B").cgColor,
            UIColor(hex: "#976375").cgColor
        ]
        gradientLayer.locations = [0.5, 0.8]
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func addCloudView() {
        let cloudView = CloudView(frame: self.bounds)
        self.addSubview(cloudView)
    }
    
    private func addFogView() {
        let fogView = FogView(frame: self.bounds)
        self.addSubview(fogView)
    }
}

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
