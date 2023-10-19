//
//  ResultViewController.swift
//  WeatherCheck
//
//  Created by Jusbug on 10/18/23.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var filteredCities = [City]()
    var allCities = cities
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDelgateAndDataSource()
        registerNib()
        self.view.backgroundColor = .systemBlue
    }
    
    private func initDelgateAndDataSource() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func registerNib() {
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "resultCell")
    }
}

extension ResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        
        let city = filteredCities[indexPath.row]
        
        cell.cityLabel.text = "\(city.location), \(city.nation)"
        
        return cell
    }
}
