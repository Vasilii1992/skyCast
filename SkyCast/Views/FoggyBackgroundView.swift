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


/*
 Ты IOS разработчик. Нам нужно добавить на экран появление молнии, которая у нас в Assets называется "lightning".Анимация молнии такая: Она появляется постепенно,а не сразу вся.Нужно сделать так чтобы молния появлялась раз в 7 секунд на экране за облаками которые двигаются.
 
 You are an iOS developer. We need to add the appearance of lightning to the screen, which is called "lightning" in our Assets.The lightning animation is like this: It appears gradually, and not all at once.You need to make sure that lightning appears every 7 seconds on the screen behind the clouds that are moving.
 
  Here is our code:
 
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
         floatingCloudLayer.contents = UIImage(named: "clouds")?.cgImage
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
         cloudLayer.contents = UIImage(named: "dark clouds")?.cgImage
         cloudLayer.opacity = 0.7
         self.layer.addSublayer(cloudLayer)
     }
     
     private func addRainView() {
         let rainLayer = CAEmitterLayer()
         rainLayer.emitterShape = .line
         rainLayer.emitterPosition = CGPoint(x: bounds.midX, y: 0)
         rainLayer.emitterSize = CGSize(width: bounds.size.width, height: 1)
         
         let cell = CAEmitterCell()
         cell.contents = UIImage(named: "water line")?.cgImage
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
         lightningTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(addLightning), userInfo: nil, repeats: true)
     }
     
     @objc private func addLightning() {
         lightningLayer?.removeFromSuperlayer()
         
         let lightningLayer = CALayer()
         lightningLayer.frame = self.bounds
         lightningLayer.backgroundColor = UIColor.white.cgColor
         lightningLayer.opacity = 0.0
         self.layer.addSublayer(lightningLayer)
         self.lightningLayer = lightningLayer
         
         let flashAnimation = CAKeyframeAnimation(keyPath: "opacity")
         flashAnimation.values = [0.0, 1.0, 0.0]
         flashAnimation.keyTimes = [0, 0.1, 0.2]
         flashAnimation.duration = 0.2
         flashAnimation.repeatCount = 1
         
         lightningLayer.add(flashAnimation, forKey: "flashAnimation")
     }
     
     deinit {
         lightningTimer?.invalidate()
     }
 }


 
 */
