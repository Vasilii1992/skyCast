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
        image.heightAnchor.constraint(equalToConstant: 44).isActive = true
        image.widthAnchor.constraint(equalToConstant: 44).isActive = true
    
        return image
    }()

    func setIcon(icon: UIImage) {
        imageView.image = icon
        self.addSubview(imageView)
        self.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.7457833195)
        self.layer.cornerRadius = 25
        self.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),


        ])
        
    }
}
