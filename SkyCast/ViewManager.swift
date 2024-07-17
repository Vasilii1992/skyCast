//
//  ViewManager.swift
//  SkyCast
//
//  Created by Василий Тихонов on 16.07.2024.
//

import UIKit


class ViewManager {
    
    static let shared = ViewManager()
    private init() {}
    
    let images: [UIImage] = [.init(systemName: "sun.min")!, .init(systemName: "sun.snow.fill")!,.init(systemName: "sun.min")!, .init(systemName: "sun.snow.fill")!,.init(systemName: "sun.min")!, .init(systemName: "sun.snow.fill")!,.init(systemName: "sun.min")!, .init(systemName: "sun.snow.fill")!]
    
    
    
    
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
           // collection.restorationIdentifier = id
            collection.delegate = delegate
            collection.dataSource = dataSource
            collection.translatesAutoresizingMaskIntoConstraints = false
            collection.heightAnchor.constraint(equalToConstant: 110).isActive = true
            collection.backgroundColor = .clear
            collection.showsHorizontalScrollIndicator = false
            
            return collection
        }()
        
        return collection
    }
    
    
    
}
