//
//  AppDetailReviewSectionCollectionViewCell.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/23.
//

import UIKit
import Cosmos

struct AppDetailReviewSection {
    var reviewDate : String
    var reviewAlias : String
    var reviewTitle : String
    var reviewDesc : String
    var reviewRaing : Double
    
    var devDate : String
    var devDesc : String
}

class AppDetailReviewSectionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var reviewDate: UILabel!
    @IBOutlet weak var reviewAlias: UILabel!
    @IBOutlet weak var reviewTitle: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var reviewDesc: UILabel!
    @IBOutlet weak var reviewMoreLabel: UILabel!
    @IBOutlet weak var reviewMoreBtn: UIButton!
    
    @IBOutlet weak var devDesc: UILabel!
    @IBOutlet weak var devMoreLabel: UILabel!
    @IBOutlet weak var devDate: UILabel!
    @IBOutlet weak var devMoreBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateCelWithData() {
        
    }

}
