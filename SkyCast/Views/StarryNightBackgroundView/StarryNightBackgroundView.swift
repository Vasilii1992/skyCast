
import UIKit

final class StarryNightBackgroundView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientLayer()
        addStarsView()
        addCometView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [
            UIColor(hex: "#000037").cgColor,
            UIColor(hex: "#0A0A19").cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func addStarsView() {
        let starsView = StarsView(frame: self.bounds)
        self.addSubview(starsView)
    }
    
    private func addCometView() {
        let cometView = CometView(frame: self.bounds)
        self.addSubview(cometView)
    }
}
