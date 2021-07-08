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
    
    var model : AppListDataCellModel? {
        didSet {
            if let data = model {
                self.appName.text = data.appName
                self.appDesc.text = data.appDesc
                self.ratingLabel.text = String(data.commentRating.countNum())
                
                let userRating = data.rating ?? 0.0
                self.ratingStarView.rating = round(userRating * 10) / 10
    
                self.iconImage.kf.setImage(with: URL(string: data.iconImage), placeholder: UIImage(named : "noImgWidth"), options: [.transition(.fade(0.4))])
                self.screenShot1.kf.setImage(with: URL(string: data.screenShot1 ?? ""),placeholder: UIImage(named : "noImgWidth"), options: [.transition(.fade(0.4))])
                self.screenShot2.kf.setImage(with: URL(string: data.screenShot2 ?? ""),placeholder: UIImage(named :"noImgWidth"), options: [.transition(.fade(0.4))])
                self.screenShot3.kf.setImage(with: URL(string: data.screenShot3 ?? ""),placeholder: UIImage(named :"noImgWidth"), options: [.transition(.fade(0.4))])
                
                
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setImageRound(iconImage)
        self.setImageRound(screenShot1)
        self.setImageRound(screenShot2)
        self.setImageRound(screenShot3)
        self.installBtn.layer.cornerRadius = installBtn.frame.height / 2
        
        let ratio : CGFloat = 696/392
        
        self.screenShot1.addConstraint(NSLayoutConstraint(item: screenShot1!, attribute: .height, relatedBy: .equal, toItem: screenShot1!, attribute: .width, multiplier: ratio, constant: 0))
        self.screenShot2.addConstraint(NSLayoutConstraint(item: screenShot2!, attribute: .height, relatedBy: .equal, toItem: screenShot2!, attribute: .width, multiplier: ratio, constant: 0))
        self.screenShot3.addConstraint(NSLayoutConstraint(item: screenShot3!, attribute: .height, relatedBy: .equal, toItem: screenShot3!, attribute: .width, multiplier: ratio, constant: 0))
    
    }
    
    func setImageRound(_ imageV : UIImageView) {
       // imageV.makeRadius()
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
    
}
