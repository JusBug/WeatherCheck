//
//  ViewController.swift
//  WeatherCheck
//
//  Created by Jusbug on 2023/10/09.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var cityCollectionView: UICollectionView!
    var weather: WeatherData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        initDelegateAndDataSource()
        registerNib()
        configureLayout()
        callAPIManager()
    }
    
    private func configureNavigationItem() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater = self
        self.navigationItem.searchController = searchController
        self.navigationItem.searchController?.searchBar.tintColor = UIColor.white
        self.navigationItem.searchController?.searchBar.placeholder = "Search for a city or airport"
        self.navigationItem.title = "Weather"
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func initDelegateAndDataSource() {
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
    
    private func callAPIManager() {
        APIManager().fetchData { result in
            let jsonDecoder = JSONDecoder()
            switch result {
            case .success(let data):
                do {
                    let decodedData = try jsonDecoder.decode(WeatherData.self, from: data)
                    self.weather = decodedData
                    print(decodedData)
                    DispatchQueue.main.async {
                        self.cityCollectionView.reloadData()
                    }
                } catch {
                    print("Decoding Error: \(error)")
                }
            case .failure(let error):
                print("Failure: \(error)")
            }
        }
    }

}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weather?.timezone.count ?? 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        
        if let weather = weather {
            let weatherInfo = weather
            let daily = weather.daily[indexPath.item]
            cell.configureLables(with: weatherInfo, more: daily)
            cell.configureFont()
        }
        
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "secondViewController") else { return }
        
        secondVC.modalTransitionStyle = .coverVertical
        secondVC.modalPresentationStyle = .fullScreen
        
        self.navigationController?.pushViewController(secondVC, animated: true)
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

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        
        print(text)
    }
}
