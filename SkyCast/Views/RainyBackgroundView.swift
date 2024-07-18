//
//  RainyBackgroundView.swift
//  SkyCast
//
//  Created by Василий Тихонов on 17.07.2024.
//

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
            UIColor(red: 32/255, green: 32/255, blue: 55/255, alpha: 1).cgColor, // lighter dark blue
            UIColor(red: 10/255, green: 10/255, blue: 25/255, alpha: 1).cgColor // lighter almost black
        ]
        gradientLayer.locations = [0.0, 1.0]
        self.layer.insertSublayer(gradientLayer, at: 0)
    }

    
    private func addFloatingCloudView() {
        let floatingCloudLayer = CALayer()
        let cloudWidth: CGFloat = 400
        let cloudHeight: CGFloat = 200
        floatingCloudLayer.frame = CGRect(x: -cloudWidth, y: 60, width: cloudWidth, height: cloudHeight)
        floatingCloudLayer.contents = UIImage(named: "clouds3")?.cgImage
        floatingCloudLayer.opacity = 0.7
        self.layer.addSublayer(floatingCloudLayer)
        
        // Animation to make the cloud float slowly
        let animation = CABasicAnimation(keyPath: "position.x")
        animation.fromValue = -80
        animation.toValue = self.bounds.width + cloudWidth
        animation.duration = 70 // Adjust duration as needed
        animation.repeatCount = .infinity
        floatingCloudLayer.add(animation, forKey: "floatingAnimation")
    }
    
    private func addCloudView() {
        let cloudLayer = CALayer()
        cloudLayer.frame = CGRect(x: 0, y: -50, width: 600, height: 200)
        cloudLayer.contents = UIImage(named: "clouds")?.cgImage
        cloudLayer.opacity = 0.7
        self.layer.addSublayer(cloudLayer)
    }
    
    private func addRainView() {
        let rainLayer = CAEmitterLayer()
        rainLayer.emitterShape = .line
        rainLayer.emitterPosition = CGPoint(x: bounds.midX, y: 0)
        rainLayer.emitterSize = CGSize(width: bounds.size.width, height: 1)
        
        let cell = CAEmitterCell()
        cell.contents = UIImage(named: "drop of rain")?.cgImage
        cell.birthRate = 1000
        cell.lifetime = 5.0
        cell.velocity = 1000
        cell.velocityRange = 900
        cell.scale = 0.002
        cell.scaleRange = 0.003
        cell.yAcceleration = 500
        cell.emissionRange = .pi / 4
        
        rainLayer.emitterCells = [cell]
        self.layer.addSublayer(rainLayer)
    }
}
