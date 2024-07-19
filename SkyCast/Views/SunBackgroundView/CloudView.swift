
import UIKit

class CloudView: UIView {
    
    private let cloudLayer = CALayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCloudLayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupCloudLayer() {
        cloudLayer.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 200)
        cloudLayer.contents = UIImage(named: Resources.Strings.ImageName.cloudySky)?.cgImage
        cloudLayer.opacity = 0.8
        self.layer.addSublayer(cloudLayer)
    }
}
