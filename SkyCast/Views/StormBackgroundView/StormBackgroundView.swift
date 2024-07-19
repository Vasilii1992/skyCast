

import UIKit

class StormBackgroundView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientLayer()
        addCloudView()
        addRainView()
        addLightningView()
        addMultipleFloatingCloudViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [
            UIColor(hex: "#1A2036").cgColor,
            UIColor(hex: "#0A0A19").cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func addCloudView() {
        let cloudView = CloudForStorm(frame: self.bounds)
        self.addSubview(cloudView)
    }
    
    private func addRainView() {
        let rainView = LinearRainView(frame: self.bounds)
        self.addSubview(rainView)
    }
    
    private func addLightningView() {
        let lightningView = LightningView(frame: self.bounds)
        self.addSubview(lightningView)
    }
    
    private func addMultipleFloatingCloudViews() {
        let positions = [
            CGPoint(x: 50, y: 40),
            CGPoint(x: 150, y: 100),
            CGPoint(x: -160, y: 60),
            CGPoint(x: -25, y: 170)
        ]
        
        for position in positions {
            let floatingCloudView = FloatingDarkCloudView(frame: self.bounds, position: position)
            self.addSubview(floatingCloudView)
        }
    }
}
