//
//  CovidStatsViewController.swift
//  Covid19Stats
//
//  Created by Aleksandre Ebanoidze on 5/7/20.
//  Copyright © 2020 Aleksandre Ebanoidze. All rights reserved.
//

import UIKit

class CovidStatsViewController: UIViewController, CovidStatsView {
    
    var presenter: CovidStatsPresenter?
    let configurator = CovidStatsConfiguratorImplementation()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
                     #selector(handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        //refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.startLoading()
        self.configurator.configure(covidStatsViewController: self)
        self.presenter?.viewDidLoad()
        self.setupTableView()
    }
    
    
    private func setupTableView()
    {
        self.tableView.register(UINib(nibName: CountryStatCell.className, bundle: nil), forCellReuseIdentifier: CountryStatCell.reuseIdentifier)
        
        self.tableView.addSubview(self.refreshControl)
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.refreshControl.endRefreshing()
        self.startLoading()
        self.presenter?.refresh()
    }
    
    func refreshTableView() {
        self.tableView.reloadData()
        
    }
    
    func displayData() {
        self.stopLoading()
        self.tableView.reloadData()
    }
    
    func displayDataFetchError(title: String, message: String) {
        self.present(UIAlertController(title: title, message: message, preferredStyle: .alert), animated: true, completion: nil)
        self.stopLoading()
        self.refreshControl.endRefreshing()
    }
    
    
}
