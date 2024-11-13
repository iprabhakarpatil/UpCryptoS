//
//  HomeViewController+UITableViewDatasource.swift
//  UpCryptos
//
//  Created by Prabhakar Patil on 13/11/24.
//

import Foundation
import UIKit

extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CoinTableViewCell", for: indexPath) as? CoinTableViewCell else {
            
            fatalError("Failed to dequeueReusableCell with identifier CoinTableViewCell")
        }
        
        let currency = viewModel.filteredItems[indexPath.row]
        cell.configureCell(with: currency)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
        
}
