
import UIKit

final class ViewBuilder: NSObject {
    
    private let manager = ViewManager.shared
    private var weatherCollection: UICollectionView!
    
    private var currentBackgroundView: UIView?
    
    var controller: UIViewController
    var view: UIView
    
    init(controller: UIViewController) {
        self.controller = controller
        self.view = controller.view
    }
    
   private func setBackgroundView(_ weatherBackgroundView: UIView ) {
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
    
    //MARK: random screen switching
    func selectRandomCell() {
        guard let weatherCollection = weatherCollection else { return }
        let randomIndex = Int.random(in: 0..<ViewManager.shared.weathers.count)
        let indexPath = IndexPath(item: randomIndex, section: 0)
        weatherCollection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            weatherCollection.selectItem(at: indexPath, animated: true, scrollPosition: [])
            self.collectionView(weatherCollection, didSelectItemAt: indexPath)
        }
    }
    
    //MARK: Animation of the transition between screens
   private func animateBackgroundTransition(to newBackgroundView: UIView) {
        guard let currentBackgroundView = currentBackgroundView else {
            setBackgroundView(newBackgroundView)
            newBackgroundView.alpha = 0
            UIView.animate(withDuration: 1.8, animations: {
                newBackgroundView.alpha = 1
            })
            return
        }
        
        newBackgroundView.alpha = 0
        setBackgroundView(newBackgroundView)
        
        UIView.animate(withDuration: 1.8, animations: {
            currentBackgroundView.alpha = 0
            newBackgroundView.alpha = 1
        }, completion: { _ in
            currentBackgroundView.removeFromSuperview()
        })
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


//MARK: - UICollectionViewDataSource, UICollectionViewDelegate
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
        for cell in collectionView.visibleCells {
            cell.layer.borderWidth = 0
            cell.layer.borderColor = nil
        }
        
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.layer.borderWidth = 3
            cell.layer.borderColor = UIColor.systemBlue.cgColor
        }
        
        let newBackgroundView: UIView
        switch indexPath.item {
        case 0:
            newBackgroundView = SunBackgroundView(frame: self.view.bounds)
        case 1:
            newBackgroundView = FoggyBackgroundView(frame: self.view.bounds)
        case 2:
            newBackgroundView = RainyBackgroundView(frame: self.view.bounds)
        case 3:
            newBackgroundView = StarryNightBackgroundView(frame: self.view.bounds)
        case 4:
            newBackgroundView = SnowBackgroundView(frame: self.view.bounds)
        case 5:
            newBackgroundView = StormBackgroundView(frame: self.view.bounds)
        default:
            return
        }
        
        animateBackgroundTransition(to: newBackgroundView)
    }
}
