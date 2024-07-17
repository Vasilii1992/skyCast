//
//  WeatherBackgroundView.swift
//  SkyCast
//
//  Created by Василий Тихонов on 16.07.2024.
//
import UIKit

class WeatherBackgroundView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientLayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradientLayer()
    }
    
    private func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [
            UIColor(red: 68/255, green: 121/255, blue: 219/255, alpha: 1).cgColor,
            UIColor(red: 111/255, green: 175/255, blue: 243/255, alpha: 1).cgColor,
            UIColor(red: 190/255, green: 223/255, blue: 255/255, alpha: 1).cgColor
        ]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        self.layer.addSublayer(gradientLayer)
    }
}

class SunView: UIView {
    
    private let sunLayer = CALayer()
    private let sunEffectLayer = CAEmitterLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSunLayer()
        setupSunEffectLayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSunLayer()
        setupSunEffectLayer()
    }
    
    private func setupSunLayer() {
        sunLayer.frame = CGRect(x: self.bounds.width - 200, y: -30, width: 280, height: 280)
        sunLayer.contents = UIImage(named: "sun")?.cgImage
        self.layer.addSublayer(sunLayer)
    }
    
    private func setupSunEffectLayer() {
        sunEffectLayer.emitterPosition = sunLayer.position
        sunEffectLayer.emitterShape = .circle
        sunEffectLayer.emitterSize = CGSize(width: 80, height: 80)
        
        let cell = CAEmitterCell()
        cell.contents = UIImage(named: "sun_glow")?.cgImage
        cell.birthRate = 1  // Slower birth rate
        cell.lifetime = 1.0  // Longer lifetime
        cell.velocity = 20  // Slower velocity
        cell.velocityRange = 5
        cell.scale = 0.2
        cell.scaleRange = 0.1
        cell.alphaSpeed = -0.1  // Slower alpha speed
        cell.yAcceleration = -15  // Less acceleration
        cell.emissionRange = .pi * 2.0
        
        sunEffectLayer.emitterCells = [cell]
        self.layer.addSublayer(sunEffectLayer)
    }
}
