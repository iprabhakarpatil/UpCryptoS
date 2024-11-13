//
//  HomeViewController+UISearchControllerDelegate.swift
//  UpCryptos
//
//  Created by Prabhakar Patil on 13/11/24.
//

import Foundation
import UIKit

extension HomeViewController: UISearchResultsUpdating{
   
    func updateSearchResults(for searchController: UISearchController) {
        
        if let searchText = searchController.searchBar.text {
            
            viewModel.filterItems(for: searchText)
            coinsTableView.reloadSections(IndexSet(integer: 0), with: .top)
        }
    }
    
    
    

}
