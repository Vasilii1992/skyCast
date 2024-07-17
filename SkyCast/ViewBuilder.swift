//
//  ViewBuilder.swift
//  SkyCast
//
//  Created by Василий Тихонов on 16.07.2024.
//

import UIKit


class ViewBuilder: NSObject {
    
    private let manager = ViewManager.shared
    private var weatherCollection: UICollectionView!
    
    var controller: UIViewController
    var view: UIView

    init(controller: UIViewController) {
        self.controller = controller
        self.view = controller.view
    }
    
    
    func getSnowView() {
        let snowView = SnowView(frame: view.bounds)
        snowView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(snowView)
        view.sendSubviewToBack(snowView)
    }
    
    
    
    func getWeatherSlider() {
        
        let weatherTitle = manager.slideTitle(titleText: "Варианты Погоды")
        
        weatherCollection = manager.getCollection(dataSource: self, delegate: self)
        weatherCollection.register(WeatherCell.self, forCellWithReuseIdentifier: WeatherCell.identifire)
        
        view.addSubview(weatherTitle)
        view.addSubview(weatherCollection)
        
        NSLayoutConstraint.activate([
            
            weatherTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            weatherTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            weatherTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            
            
            
            weatherCollection.topAnchor.constraint(equalTo: weatherTitle.bottomAnchor, constant: 40),
            weatherCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            weatherCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5)
            
        
        ])
        
        
    }
    
}
extension ViewBuilder: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        manager.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCell.identifire, for: indexPath) as? WeatherCell else {
            return UICollectionViewCell()
        }
        let icon = manager.images[indexPath.item]
        cell.setIcon(icon: icon)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
   
    }
    
    
}
