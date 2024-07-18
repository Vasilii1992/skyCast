//
//  WeatherCell.swift
//  SkyCast
//
//  Created by Василий Тихонов on 16.07.2024.
//
import UIKit

class WeatherCell: UICollectionViewCell {
    
    static let identifire = "WeatherCell"
    
    
   private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.heightAnchor.constraint(equalToConstant: 40).isActive = true
        image.widthAnchor.constraint(equalToConstant: 40).isActive = true
    
        return image
    }()
    
    private lazy var weatherLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.font = UIFont.systemFont(ofSize: 14,weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false

        
        return label
    }()
    
    
    func setWeather(_ weather: Weather) {
        imageView.image = weather.image
        weatherLabel.text = weather.type
        
        self.addSubview(imageView)
        self.addSubview(weatherLabel)
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 25
        self.clipsToBounds = true
        
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            weatherLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            weatherLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5)
            
        ])
    }

}
