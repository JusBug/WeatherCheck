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
        tableView.backgroundColor = .systemBlue
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
    }
}
