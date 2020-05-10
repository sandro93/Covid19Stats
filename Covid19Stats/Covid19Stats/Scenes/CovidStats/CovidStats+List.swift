//
//  CovidStats+List.swift
//  Covid19Stats
//
//  Created by Aleksandre Ebanoidze on 5/8/20.
//  Copyright © 2020 Aleksandre Ebanoidze. All rights reserved.
//

import UIKit

extension CovidStatsViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.presenter?.numberOfItems ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryStatCell.reuseIdentifier, for: indexPath) as? CountryStatCell else {
            fatalError("couldn't get cell with id ProductsCell")
        }
        
        self.presenter?.configure(cell: cell, row: indexPath.row)
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        if self.refreshControl.isRefreshing {
            self.handleRefresh(self.refreshControl)
        }
    }
}
