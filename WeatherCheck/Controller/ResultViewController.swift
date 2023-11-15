//
//  ResultViewController.swift
//  WeatherCheck
//
//  Created by Jusbug on 10/18/23.
//

import UIKit

class ResultViewController: UIViewController {
    var tableView: UITableView!
    var allCities: [City] = []
    var filteredCities: [City] = []
    var weather: WeatherData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        loadCities()
    }
    
    private func initTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }
    
    private func loadCities() {
        allCities = cities
        filteredCities = allCities
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension ResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(filteredCities[indexPath.row].location), \(filteredCities[indexPath.row].nation)"
        cell.textLabel?.textColor = .lightGray
        return cell
    }
}

// MARK: - UITableViewDataSource
extension ResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let secondVC = storyboard.instantiateViewController(withIdentifier: "secondViewController") as? SecondViewController else {
            return
        }
        
        if let weather = weather {
            secondVC.setBackgroundImageOnTime(weather: weather)
        }
        
        secondVC.modalTransitionStyle = .coverVertical
        secondVC.modalPresentationStyle = .popover
        
        self.present(secondVC, animated: true, completion: nil)
    }
}
