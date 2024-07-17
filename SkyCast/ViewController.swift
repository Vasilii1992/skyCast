//
//  ViewController.swift
//  SkyCast
//
//  Created by Василий Тихонов on 16.07.2024.
//

import UIKit

class ViewController: UIViewController {
    
    
    private lazy var builder = {
        return ViewBuilder(controller: self)
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        let gradientLayer = CAGradientLayer()
//                gradientLayer.colors = [UIColor.systemBlue.cgColor, UIColor.cyan.cgColor]
//                gradientLayer.startPoint = CGPoint(x: 0.3, y: 1)
//                gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
//                gradientLayer.frame = self.view.bounds
//
//                self.view.layer.addSublayer(gradientLayer)
     //   view.backgroundColor = .systemBlue
        

//        builder.getWeatherSlider()
//        builder.getSnowView()
//        
        let backgroundView = WeatherBackgroundView(frame: self.view.bounds)
        self.view.addSubview(backgroundView)
        
        let sunView = SunView(frame: self.view.bounds)
        self.view.addSubview(sunView)

   }
    



}

