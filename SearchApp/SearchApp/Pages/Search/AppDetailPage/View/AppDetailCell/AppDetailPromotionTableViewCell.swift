//
//  AppDetailPromotionTableViewCell.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/22.
//

import UIKit


class AppDetailPromotionTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var lastLabel: UILabel!
    @IBOutlet weak var lastLabelView: UIView!
    
    var model : AppDetailPromotionDataModel? {
        didSet {
            self.descriptionLabel.text = model?.promotionData
            
            //2줄 초과일 때, 2줄만 노출하고 나머지 초과된 줄중 3번째 줄을 lastLabel에 노출시킨다.
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
}
