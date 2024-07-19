
import UIKit

class RainyBackgroundView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientLayer()
        addCloudView()
        addRainView()
        addFloatingCloudView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [
            UIColor(hex: "#202037").cgColor,
            UIColor(hex: "#0A0A19").cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        self.layer.insertSublayer(gradientLayer, at: 0)
    }

    private func addFloatingCloudView() {
        let floatingCloudView = FloatingCloudView(frame: self.bounds)
        self.addSubview(floatingCloudView)
    }
    
    private func addCloudView() {
        let cloudView = DarkCloudView(frame: self.bounds)
        self.addSubview(cloudView)
    }
    
    private func addRainView() {
        let rainView = RainView(frame: self.bounds)
        self.addSubview(rainView)
    }
}
