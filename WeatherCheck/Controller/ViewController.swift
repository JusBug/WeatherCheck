//
//  ViewController.swift
//  WeatherCheck
//
//  Created by Jusbug on 2023/10/09.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cityCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        ininDelegateAndDataSource()
        registerNib()
    }
    
    private func configureNavigationItem() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = true // searchBar 활성화시 백그라운드 어둡게
        // searchController.hidesNavigationBarDuringPresentation = false // searchBar 활성화시 title 표시 여부
        self.navigationItem.searchController = searchController
        self.navigationItem.searchController?.searchBar.placeholder = "Search for a city or airport"
        self.navigationItem.title = "Weather"
        self.navigationItem.hidesSearchBarWhenScrolling = true // 스크롤시 searchBar 표시 여부
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func ininDelegateAndDataSource() {
        cityCollectionView.delegate = self
        cityCollectionView.dataSource = self
    }
    
    private func registerNib() {
        cityCollectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
}


