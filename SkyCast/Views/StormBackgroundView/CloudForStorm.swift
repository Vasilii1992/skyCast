
import UIKit

class CloudForStorm: UIView {
    
    private let cloudLayer = CALayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCloudLayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupCloudLayer() {
        cloudLayer.frame = CGRect(x: 0, y: 0, width: 600, height: 200)
        cloudLayer.contents = UIImage(named: Resources.Strings.ImageName.darkClouds)?.cgImage
        cloudLayer.opacity = 0.7
        self.layer.addSublayer(cloudLayer)
    }
}
