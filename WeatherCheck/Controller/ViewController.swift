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

    }
    
    private func configureNavigationItem() {
        let searchController = UISearchController(searchResultsController: nil)
        // searchController.hidesNavigationBarDuringPresentation = false // searchBar 활성화시 title 표시 여부
        self.navigationItem.searchController = searchController
        self.navigationItem.searchController?.searchBar.placeholder = "Search for a city or airport"
        self.navigationItem.title = "Weather"
        self.navigationItem.hidesSearchBarWhenScrolling = false // 스크롤시 searchBar 표시 여부
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}

