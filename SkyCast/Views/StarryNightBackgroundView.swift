//
//  StarryNightBackgroundView.swift
//  SkyCast
//
//  Created by Василий Тихонов on 17.07.2024.
//
//
import UIKit

class StarryNightBackgroundView: UIView {
    
    private let numberOfStars = 80
    private let baseStarSize: CGFloat = 10.0
    private let starSizeVariation: CGFloat = 4
    
    private var cometLayer: CALayer!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientLayer()
        addStars()
        setupCometLayer()
        startCometAnimationAfterDelay()
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
    
    private func addStars() {
        let upperHalfHeight = bounds.height / 2
        for _ in 0..<numberOfStars {
            let starLayer = CALayer()
            starLayer.contents = UIImage(named: Resources.Strings.ImageName.star)?.cgImage
            
            let starSize = baseStarSize * CGFloat.random(in: 1.0...starSizeVariation)
            
            let xPosition = CGFloat.random(in: 0..<bounds.width)
            let yPosition = CGFloat.random(in: 0..<upperHalfHeight)
            starLayer.frame = CGRect(x: xPosition, y: yPosition, width: starSize, height: starSize)
            self.layer.addSublayer(starLayer)
            addFlickerAnimation(to: starLayer)
        }
    }
    
    private func addFlickerAnimation(to layer: CALayer) {
        let flickerAnimation = CAKeyframeAnimation(keyPath: "opacity")
        flickerAnimation.values = [1.0, 0.3, 1.0]
        flickerAnimation.keyTimes = [0, 0.5, 1]
        flickerAnimation.duration = Double.random(in: 1.0..<3.0)
        flickerAnimation.repeatCount = .infinity
        layer.add(flickerAnimation, forKey: "flickerAnimation")
    }
    
    private func setupCometLayer() {
        cometLayer = CALayer()
        cometLayer.contents = UIImage(named: Resources.Strings.ImageName.comet)?.cgImage
        cometLayer.frame = CGRect(x: bounds.width, y: bounds.height / 4, width: 100, height: 70)
        cometLayer.isHidden = true
        cometLayer.opacity = 1.0 
        cometLayer.shadowColor = UIColor.white.cgColor
        cometLayer.shadowRadius = 10
        cometLayer.shadowOpacity = 1.0
        cometLayer.shadowOffset = CGSize.zero
        self.layer.addSublayer(cometLayer)
        addFlickerAnimation(to: cometLayer)
    }
    
    private func startCometAnimationAfterDelay() {
        Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false) { [weak self] _ in
            self?.animateComet()
        }
    }
    
    private func animateComet() {
        cometLayer.isHidden = false
        let animation = CABasicAnimation(keyPath: "position")
        animation.fromValue = CGPoint(x: bounds.width - 10, y: bounds.height / 6)
        
        animation.toValue = CGPoint(x: bounds.minX, y: bounds.height / 2)
        animation.duration = 5.0
        animation.isRemovedOnCompletion = true
        animation.fillMode = .forwards
        cometLayer.add(animation, forKey: "cometAnimation")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + animation.duration) { [weak self] in
            self?.cometLayer.isHidden = true
            self?.cometLayer.position = CGPoint(x: self?.bounds.width ?? 0, y: self?.bounds.height ?? 0 / 4)
            self?.startCometAnimationAfterDelay()
        }
    }
}
