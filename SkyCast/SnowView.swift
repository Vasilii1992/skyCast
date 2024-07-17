//
//  SnowView.swift
//  SkyCast
//
//  Created by Василий Тихонов on 16.07.2024.
//

import UIKit

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
        cell.scaleRange = 0.02
        cell.emissionRange = .pi
        return cell
    }
}

