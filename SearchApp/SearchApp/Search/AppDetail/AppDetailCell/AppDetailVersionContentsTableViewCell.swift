//
//  AppDetailVersionContentsTableViewCell.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/22.
//

import UIKit

class AppDetailVersionContentsTableViewCell: UITableViewCell {

    var model : AppDetailVersionContentsDataModel? {
        didSet{
            if let data = model {
                self.versionLabel.text = data.version != nil ? "버전 \(data.version!)" : ""
                self.lastVersionDateLabel.text = data.lastDate != nil ? "\(data.lastDate!)전" : ""
                self.newFunctionContents.text = data.newDescription ?? ""
            }
        }
    }
    @IBOutlet weak var versionHistoryBtn: UIButton!
    
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var lastVersionDateLabel: UILabel!
    @IBOutlet weak var newFunctionContents: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
