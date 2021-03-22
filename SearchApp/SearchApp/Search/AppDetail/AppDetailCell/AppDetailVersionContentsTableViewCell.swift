//
//  AppDetailVersionContentsTableViewCell.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/22.
//

import UIKit

class AppDetailVersionContentsTableViewCell: UITableViewCell {

    @IBOutlet weak var versionHistoryBtn: UIButton!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var lastVersionDateLabel: UILabel!
    @IBOutlet weak var newFunctionContents: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
