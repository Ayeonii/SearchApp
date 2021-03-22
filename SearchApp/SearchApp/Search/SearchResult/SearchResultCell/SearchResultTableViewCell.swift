//
//  SearchResultTableViewCell.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/21.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var appDesc: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var installBtn: UIButton!
    
    @IBOutlet weak var screenShot1: UIImageView!
    @IBOutlet weak var screenShot2: UIImageView!
    @IBOutlet weak var screenShot3: UIImageView!
    
    var data : AppListData?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImage.image = UIImage()
        appName.text = ""
        appDesc.text = ""
        
        ratingLabel.text = ""
        screenShot1.image = UIImage()
        screenShot2.image = UIImage()
        screenShot3.image = UIImage()
        
    }
    
    func updateCellWithData(_ cellData : AppListData){
        self.data = cellData
        
        self.appName.text = cellData.appName
        self.appDesc.text = cellData.appDesc
        
        
        
        self.iconImage.setImageUrl(cellData.iconImage)
        self.screenShot1.setImageUrl(cellData.screenShot1 ?? "")
        self.screenShot2.setImageUrl(cellData.screenShot2 ?? "")
        self.screenShot3.setImageUrl(cellData.screenShot3 ?? "")
         
    }
}
