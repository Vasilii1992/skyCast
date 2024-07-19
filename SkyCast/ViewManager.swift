
import UIKit

class ViewManager {
    
    static let shared = ViewManager()
    private init() {}
    
    let weathers: [Weather] = [
        .init(image: UIImage(systemName: Resources.Strings.ImageNameForWeatherType.sunny)!, type: Resources.Strings.TypeOfWeathers.sunny),
        .init(image: UIImage(systemName: Resources.Strings.ImageNameForWeatherType.fog)!, type: Resources.Strings.TypeOfWeathers.fog),
        .init(image: UIImage(systemName: Resources.Strings.ImageNameForWeatherType.rain)!, type: Resources.Strings.TypeOfWeathers.rain),
        .init(image: UIImage(systemName: Resources.Strings.ImageNameForWeatherType.night)!, type: Resources.Strings.TypeOfWeathers.night),
        .init(image: UIImage(systemName: Resources.Strings.ImageNameForWeatherType.snow)!, type: Resources.Strings.TypeOfWeathers.snow),
        .init(image: UIImage(systemName: Resources.Strings.ImageNameForWeatherType.storm)!, type: Resources.Strings.TypeOfWeathers.storm),
    ]

    func slideTitle(titleText: String) -> UILabel {
        let title = UILabel()
        title.text = titleText
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 24,weight: .bold)
        title.textColor = .white
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }
    
    func getCollection(dataSource: UICollectionViewDataSource, delegate: UICollectionViewDelegate) -> UICollectionView {
        let collection: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: 100, height: 100)
            layout.minimumLineSpacing = 15
            layout.minimumInteritemSpacing = 0
            layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
            
            let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collection.delegate = delegate
            collection.dataSource = dataSource
            collection.translatesAutoresizingMaskIntoConstraints = false
            collection.heightAnchor.constraint(equalToConstant: 110).isActive = true
            collection.backgroundColor = .clear
            collection.showsHorizontalScrollIndicator = false
            collection.alpha = 0.5
            
            return collection
        }()
        
        return collection
    }
}
