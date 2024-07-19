//
//  StormBackgroundView.swift
//  SkyCast
//
//  Created by Василий Тихонов on 18.07.2024.
//

import UIKit

class StormBackgroundView: UIView {
    
    private var lightningLayer: CALayer?
    private var lightningTimer: Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientLayer()
        addCloudView()
        addRainView()
        startLightning()
        addFloatingCloudView(at: CGPoint(x: 50, y: 40)) // First cloud
        addFloatingCloudView(at: CGPoint(x: 150, y: 100)) // Second cloud
        addFloatingCloudView(at: CGPoint(x: -160, y: 60))
        addFloatingCloudView(at: CGPoint(x: -25, y: 170))
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
    
    private func addFloatingCloudView(at position: CGPoint) {
        let floatingCloudLayer = CALayer()
        let cloudWidth: CGFloat = 400
        let cloudHeight: CGFloat = 200
        floatingCloudLayer.frame = CGRect(x: position.x, y: position.y, width: cloudWidth, height: cloudHeight)
        floatingCloudLayer.contents = UIImage(named: Resources.Strings.ImageName.clouds)?.cgImage
        floatingCloudLayer.opacity = 0.6
        self.layer.addSublayer(floatingCloudLayer)
        
        let animation = CABasicAnimation(keyPath: "position.x")
        animation.fromValue = position.x
        animation.toValue = self.bounds.width + cloudWidth
        animation.duration = 120
        animation.repeatCount = .infinity
        floatingCloudLayer.add(animation, forKey: "floatingAnimation")
    }
    
    private func addCloudView() {
        let cloudLayer = CALayer()
        cloudLayer.frame = CGRect(x: 0, y: 0, width: 600, height: 200)
        cloudLayer.contents = UIImage(named: Resources.Strings.ImageName.darkClouds)?.cgImage
        cloudLayer.opacity = 0.7
        self.layer.addSublayer(cloudLayer)
    }
    
    private func addRainView() {
        let rainLayer = CAEmitterLayer()
        rainLayer.emitterShape = .line
        rainLayer.emitterPosition = CGPoint(x: bounds.midX, y: 0)
        rainLayer.emitterSize = CGSize(width: bounds.size.width, height: 1)
        
        let cell = CAEmitterCell()
        cell.contents = UIImage(named: Resources.Strings.ImageName.waterLine)?.cgImage
        cell.birthRate = 2000
        cell.lifetime = 5.0
        cell.velocity = 1000
        cell.velocityRange = 1000
        cell.scale = 0.02
        cell.scaleRange = 0.03
        cell.yAcceleration = 500
        cell.emissionRange = .pi / 4
        
        rainLayer.emitterCells = [cell]
        self.layer.addSublayer(rainLayer)
    }

    private func startLightning() {
        lightningTimer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(addLightning), userInfo: nil, repeats: true)
    }
    
    @objc private func addLightning() {
           lightningLayer?.removeFromSuperlayer()
           
           let lightningLayer = CALayer()
        let lightningImage = UIImage(named:Resources.Strings.ImageName.lightning)?.cgImage
           let lightningImageWidth = lightningImage?.width ?? 0
           let lightningImageHeight = lightningImage?.height ?? 0
           let halfWidth = CGFloat(lightningImageWidth) / 2
           let halfHeight = CGFloat(lightningImageHeight) / 2
           lightningLayer.contents = lightningImage
           lightningLayer.frame = CGRect(
               x: 0,
               y: 10,
               width: halfWidth,
               height: halfHeight
           )
           lightningLayer.opacity = 0.0
           self.layer.insertSublayer(lightningLayer, below: self.layer.sublayers?.last)
           self.lightningLayer = lightningLayer
           
           let flashAnimation = CAKeyframeAnimation(keyPath: "opacity")
           flashAnimation.values = [0.0, 0.5, 1.0, 0.5, 0.0]
           flashAnimation.keyTimes = [0, 0.2, 0.4, 0.6, 1.0]
           flashAnimation.duration = 1.0
           flashAnimation.repeatCount = 1
           
           lightningLayer.add(flashAnimation, forKey: "flashAnimation")
       }
    
    deinit {
        lightningTimer?.invalidate()
    }
}
