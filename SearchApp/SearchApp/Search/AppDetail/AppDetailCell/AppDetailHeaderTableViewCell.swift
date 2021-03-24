//
//  AppDetailHeaderTableViewCell.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/22.
//

import UIKit


class AppDetailHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var appSubName: UILabel!
    
    @IBOutlet weak var installBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    
    var model : AppDetailHeaderDataModel? {
        didSet{
            self.iconImage.setImageUrl(model?.iconImage ?? "")
            self.appName.text = model?.appName ?? ""
            self.appSubName.text = model?.appDesc ?? ""
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
//
//    func updateCellWithData(data : AppDetailHeaderData) {
//        self.iconImage.setImageUrl(data.iconImage ?? "")
//        self.appName.text = data.appName
//        self.appSubName.text = data.appDesc
//    }
}
