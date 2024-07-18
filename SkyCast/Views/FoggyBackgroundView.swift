//
//  WeatherViewController.swift
//  SkyCast
//
//  Created by Василий Тихонов on 18.07.2024.
//


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
        let fogLayer = CALayer()
        let fogImage = UIImage(named: "fog")?.cgImage
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


extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let mask = 0x000000FF
        let r = Int(rgb >> 16) & mask
        let g = Int(rgb >> 8) & mask
        let b = Int(rgb) & mask

        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
