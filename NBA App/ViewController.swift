//
//  ViewController.swift
//  NBA App
//
//  Created by Zaid Omar on 2020-10-22.
//  Copyright © 2020 Zaid Omar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var listOfStandings = [StandingsDetail]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = "\(self.listOfStandings.count) Standings Found"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let standingsRequest = StandingsRequest()
        standingsRequest.getStandings{ [ weak self ] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let standings):
                self?.listOfStandings = standings
            }
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped me!")
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfStandings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let standings = listOfStandings[indexPath.row]
        cell.textLabel?.text = standings.date.date
        //cell.detailTextLabel?.text = standings.date.date
        
        
        return cell
    }
}


