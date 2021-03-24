//
//  AppDetailReviewTableViewCell.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/22.
//

import UIKit



class AppDetailReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var reviewRating: UILabel!
    @IBOutlet weak var numberOfReviewLabel: UILabel!
    @IBOutlet weak var showAllBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
}
