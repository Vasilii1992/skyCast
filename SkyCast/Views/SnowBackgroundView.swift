//
//  SnowView.swift
//  SkyCast
//
//  Created by Василий Тихонов on 16.07.2024.
//

import UIKit

class SnowBackgroundView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientLayer()
        addSunView()
        addCloudView()
        addSnowView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [
            UIColor(hex: "#4479DB").cgColor,
            UIColor(hex: "#6FAFF3").cgColor,
            UIColor(hex: "#BEDFFF").cgColor
        ]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        self.layer.addSublayer(gradientLayer)
    }
    
    private func addSnowView() {
        let snowView = SnowView(frame: self.bounds)
        self.addSubview(snowView)
    }
    
    
    private func addSunView() {
        let sunView = SunView(frame: self.bounds)
        self.addSubview(sunView)
    }
    
    private func addCloudView() {
        let cloudView = CloudView(frame: self.bounds)
        self.addSubview(cloudView)
    }
}


class SnowView: UIView {
    
    override class var layerClass: AnyClass {
        return CAEmitterLayer.self
    }
    
    private var emitterLayer: CAEmitterLayer {
        return self.layer as! CAEmitterLayer
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupEmitter()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupEmitter()
    }
    
    private func setupEmitter() {
        emitterLayer.emitterShape = .line
        emitterLayer.emitterPosition = CGPoint(x: bounds.midX, y: 0)
        emitterLayer.emitterSize = CGSize(width: bounds.size.width, height: 1)
        emitterLayer.emitterCells = [makeSnowflakeCell()]
    }
    
    private func makeSnowflakeCell() -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.contents = UIImage(named: "snowflake")?.cgImage
       // количество снежинок
        cell.birthRate = 10
        // время жизни
        cell.lifetime = 20.0
        cell.velocity = 30
        
        cell.velocityRange = 20
        cell.yAcceleration = 30
        // рахмер снежинок
        cell.scale = 0.01
        cell.scaleRange = 0.013
        cell.emissionRange = .pi
        return cell
    }
}

