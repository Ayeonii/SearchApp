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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
