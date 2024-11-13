//
//  ViewController.swift
//  UpCryptos
//
//  Created by Prabhakar Patil on 12/11/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var coinsTableView: UITableView!
    
    var viewModel: HomeViewModel = .init(networkService: NetworkService(session: .shared))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupTableView()
        
        Task{
            await fetchData()
        }
    }
    
    /// Setup Navigation bar components
    private func setupNavigationBar(){
        
        let filterBarButton = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle"), style: .plain, target: self, action: #selector(filterTapped))
        
        navigationItem.rightBarButtonItem = filterBarButton
        setupSearchBar()
    }
    
    
    /// Table view cell, delegate & datasource setups.
    private func setupTableView(){
        
        coinsTableView.register(UINib(nibName: "CoinTableViewCell", bundle: nil), forCellReuseIdentifier: "CoinTableViewCell")
        coinsTableView.dataSource = self
        coinsTableView.delegate = self
        coinsTableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    /// Search bar configurations
    private func setupSearchBar(){
        
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Coins"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    
    //TODO: - To be implemented.
    @objc
    private func filterTapped(){
 
    }

}

// MARK: - Networking Requests
extension HomeViewController{
    
    
    fileprivate func fetchData() async{
        
        do {
            _ = try await viewModel.fetchCurrencies(from: .currencies)
            DispatchQueue.main.async {
                self.coinsTableView.reloadSections(IndexSet(integer: 0), with: .top)
            }
        }
        catch (let error){
            print("Error:", error.localizedDescription)
        }
    }
}
