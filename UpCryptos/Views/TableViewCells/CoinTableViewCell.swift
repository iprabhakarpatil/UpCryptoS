//
//  CoinTableViewCell.swift
//  UpCryptos
//
//  Created by Prabhakar Patil on 12/11/24.
//

import UIKit

class CoinTableViewCell: UITableViewCell {
    
    @IBOutlet weak var currencyName: UILabel!
    @IBOutlet weak var currencyCode: UILabel!
    @IBOutlet weak var currencyIcon: UIImageView!
    @IBOutlet weak var newTagImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        currencyIcon.image = nil
        newTagImage.isHidden = true
    }
    
    func configureCell(with currency: CurrencyModel){
        currencyName.text = currency.name
        currencyCode.text = currency.symbol
        
        if currency.isActive{
            if currency.type == "coin"{
                currencyIcon.image = #imageLiteral(resourceName: "active-coin")
            } else {
                currencyIcon.image = #imageLiteral(resourceName: "active-token")
            }
        } else {
            currencyIcon.image = #imageLiteral(resourceName: "inactive-crypto")
        }
        
        newTagImage.isHidden = !currency.isNew
    }
    
}
