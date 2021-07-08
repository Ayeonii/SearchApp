//
//  AppDetailHeaderTableViewCell.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/22.
//

import UIKit
import Kingfisher


class AppDetailHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var appSubName: UILabel!
    
    @IBOutlet weak var installBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    
    var model : AppDetailHeaderDataModel? {
        didSet{
            self.iconImage.kf.setImage(with: URL(string: model?.iconImage ?? ""),placeholder: UIImage(named : "noImgWidth"))
            self.appName.text = model?.appName ?? ""
            self.appSubName.text = model?.appDesc ?? ""
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.iconImage.contentMode = .scaleAspectFill
    }

}
