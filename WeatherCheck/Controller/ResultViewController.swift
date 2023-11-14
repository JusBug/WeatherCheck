//
//  ResultViewController.swift
//  WeatherCheck
//
//  Created by Jusbug on 10/18/23.
//

import UIKit

class ResultViewController: UIViewController {
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
    }
    
    private func initTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .systemBlue
        view.addSubview(tableView)
    }
}

// MARK: - UITableViewDelegate
extension ResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Result \(indexPath.row)"
        return cell
    }


}
// MARK: - UITableViewDataSource
extension ResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
