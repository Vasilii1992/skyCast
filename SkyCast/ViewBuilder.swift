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

    private var currentBackgroundView: UIView?

    var controller: UIViewController
    var view: UIView

    init(controller: UIViewController) {
        self.controller = controller
        self.view = controller.view
    }
    
    
    func setBackgroundView(_ weatherBackgroundView: UIView ) {
        self.view.insertSubview(weatherBackgroundView, belowSubview: weatherCollection)
        weatherBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherBackgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
            weatherBackgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            weatherBackgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            weatherBackgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        currentBackgroundView = weatherBackgroundView
    }
    
    func getSnowView() {
        let weatherBackgroundView = SnowBackgroundView(frame: self.view.bounds)
        setBackgroundView(weatherBackgroundView)
    }
    
    func getClearWeather() {
        let weatherBackgroundView = SunBackgroundView(frame: self.view.bounds)
        setBackgroundView(weatherBackgroundView)
    }
    
    func getRainyView() {
        let weatherBackgroundView = RainyBackgroundView(frame: self.view.bounds)
        setBackgroundView(weatherBackgroundView)
    }
    
    func getStarryNightView() {
        let weatherBackgroundView = StarryNightBackgroundView(frame: self.view.bounds)
        setBackgroundView(weatherBackgroundView)
    }
    
    func getFoggyView() {
        let weatherBackgroundView = FoggyBackgroundView(frame: self.view.bounds)
        setBackgroundView(weatherBackgroundView)
    }
    
    func getStormView() {
        let weatherBackgroundView = StormBackgroundView(frame: self.view.bounds)
        setBackgroundView(weatherBackgroundView)
    }
    
    func selectRandomCell() {
       guard let weatherCollection = weatherCollection else { return }
       let randomIndex = Int.random(in: 0..<ViewManager.shared.weathers.count)
       let indexPath = IndexPath(item: randomIndex, section: 0)
       weatherCollection.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
       collectionView(weatherCollection, didSelectItemAt: indexPath)
   }

    func getWeatherSlider() {
        
        let weatherTitle = manager.slideTitle(titleText: Resources.Strings.weatherTitleText)
        
        weatherCollection = manager.getCollection(dataSource: self, delegate: self)
        weatherCollection.register(WeatherCell.self, forCellWithReuseIdentifier: WeatherCell.identifire)
        
        view.addSubview(weatherCollection)
        view.addSubview(weatherTitle)

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
        manager.weathers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCell.identifire, for: indexPath) as? WeatherCell else {
            return UICollectionViewCell()
        }
        let weather = manager.weathers[indexPath.item]
        cell.setWeather(weather)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        currentBackgroundView?.removeFromSuperview()
        
        for cell in collectionView.visibleCells {
            cell.layer.borderWidth = 0
            cell.layer.borderColor = nil
        }

        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.layer.borderWidth = 3
            cell.layer.borderColor = UIColor.systemBlue.cgColor
        }

        switch indexPath.item {
        case 0:
            getClearWeather()
        case 1:
            getSnowView()
        case 2:
            getRainyView()
        case 3:
            getStarryNightView()
        case 4:
            getFoggyView()
        case 5:
            getStormView()

        default:
            break
        }
    }
}
