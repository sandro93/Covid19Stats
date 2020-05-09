//
//  CovidStatsPresenter.swift
//  Covid19Stats
//
//  Created by Aleksandre Ebanoidze on 5/8/20.
//  Copyright © 2020 Aleksandre Ebanoidze. All rights reserved.
//

import Foundation

protocol CovidStatsPresenter {
    func viewDidLoad ()
    func configure(cell:CountryStatCell,row:Int)
    func refresh()
    //func didSelect(for row: Int)
//    func pushToLogin()
//    func pushToProviders()
//    func pushFromCollectionView(id:String, storyBoardId:String)
    var numberOfItems: Int { get }
}

protocol CovidStatsView: class {
    func refreshTableView()
    func displayData()
    func displayDataFetchError(title: String, message: String)
    //func pushToVC (with product:Product)
}

class CovidStatsPresenterImplementation: CovidStatsPresenter {
    
    fileprivate weak var view: CovidStatsView?
    fileprivate let displayCountryStatsUseCase: DisplayCountryStatsUseCase?
    
    var countryStatsArray: [CountryStat] = []
    
    init(view:CovidStatsView?, displayCountryStatsUseCase:DisplayCountryStatsUseCase?) {
        self.view = view
        self.displayCountryStatsUseCase = displayCountryStatsUseCase
    }
    
    func viewDidLoad() {
        self.fetchData(forceDownload: false)
    }
    
    var numberOfItems: Int  {
        return countryStatsArray.count
    }
    
    func configure(cell: CountryStatCell, row: Int) {
        cell.fill(with: self.countryStatsArray[row])
    }
    
    func handleFetchedData(_ countryStats: [CountryStat]) {
        self.countryStatsArray = countryStats
        self.view?.displayData()
    }
    
    func handleDataFetchError(_ error: Error) {
        self.view?.displayDataFetchError(title: "Error", message: error.localizedDescription)
    }
    
    func refresh() {
        self.fetchData(forceDownload: true)
    }
    
    private func fetchData(forceDownload: Bool) {
         self.displayCountryStatsUseCase?.fetchCountryStats(forceDownload: forceDownload, completionHandler: { [weak self] (result) in
             switch result {
             case let .success(countryStats):
                 self?.handleFetchedData(countryStats)
             case let .failure(error):
                 self?.handleDataFetchError(error)
             }
         })
    }
}
