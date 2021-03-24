//
//  SearchResultTableViewCell.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/21.
//

import UIKit
import Cosmos

class SearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var appDesc: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingStarView: CosmosView!
    
    
    @IBOutlet weak var installBtn: UIButton!
    @IBOutlet weak var screenShot1: UIImageView!
    @IBOutlet weak var screenShot2: UIImageView!
    @IBOutlet weak var screenShot3: UIImageView!
    
    var data : AppListData?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setImageRound(iconImage)
        self.setImageRound(screenShot1)
        self.setImageRound(screenShot2)
        self.setImageRound(screenShot3)
        
    }
    
    func setImageRound(_ imageV : UIImageView) {
        imageV.layer.cornerRadius = 13
        imageV.layer.borderWidth = 0.2
        imageV.layer.borderColor = UIColor.lightGray.cgColor
        imageV.contentMode = .scaleAspectFill
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImage.image = UIImage()
        appName.text = ""
        appDesc.text = ""
        ratingLabel.text = ""
        
        ratingLabel.text = ""
        screenShot1.image = UIImage()
        screenShot2.image = UIImage()
        screenShot3.image = UIImage()
        
    }
    
    func updateCellWithData(_ cellData : AppListData){
        self.data = cellData
        
        self.appName.text = cellData.appName
        self.appDesc.text = cellData.appDesc
        self.ratingLabel.text = String(cellData.commentRating.countNum())
        
        let userRating = cellData.rating ?? 0.0
        self.ratingStarView.rating = round(userRating * 10) / 10
        
        self.iconImage.setImageUrl(cellData.iconImage)
        self.screenShot1.setImageUrl(cellData.screenShot1 ?? "")
        self.screenShot2.setImageUrl(cellData.screenShot2 ?? "")
        self.screenShot3.setImageUrl(cellData.screenShot3 ?? "")
        
        self.installBtn.layer.cornerRadius = installBtn.frame.height / 2
    }
}
