//
//  ViewController.swift
//  WeatherCheck
//
//  Created by Jusbug on 2023/10/09.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var cityCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        ininDelegateAndDataSource()
        registerNib()
        configureLayout()
    }
    
    private func configureNavigationItem() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = true // searchBar 활성화시 백그라운드 어둡게
        searchController.hidesNavigationBarDuringPresentation = false // searchBar 활성화시 title 표시 여부
        self.navigationItem.searchController = searchController
        self.navigationItem.searchController?.searchBar.tintColor = UIColor.white // 텍스트 컬러를 white로 설정
        self.navigationItem.searchController?.searchBar.placeholder = "Search for a city or airport"
        self.navigationItem.title = "Weather"
        self.navigationItem.hidesSearchBarWhenScrolling = false // 스크롤시 searchBar 표시 여부
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func ininDelegateAndDataSource() {
        cityCollectionView.delegate = self
        cityCollectionView.dataSource = self
    }
    
    private func registerNib() {
        cityCollectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }
    
    private func configureLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        cityCollectionView.collectionViewLayout = layout
    }
    
    @IBAction func tapEditButton(_ sender: Any) {
        print("dasdasds")
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let editList = UIAlertAction(title: "Edit List", style: .default)
        let celsius = UIAlertAction(title: "Celsius", style: .default)
        let fahrenheit = UIAlertAction(title: "Fahrenheit", style: .default)
        let cancel = UIAlertAction(title: "Cancel", style: .destructive)
        
        actionSheet.addAction(editList)
        actionSheet.addAction(celsius)
        actionSheet.addAction(fahrenheit)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true, completion: nil)
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "secondViewController") else { return }
        
        secondVC.modalTransitionStyle = .coverVertical
        secondVC.modalPresentationStyle = .fullScreen
        self.present(secondVC, animated: true, completion: nil)
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 10, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}


