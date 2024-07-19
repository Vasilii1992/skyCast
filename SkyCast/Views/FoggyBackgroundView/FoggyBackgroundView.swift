
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
