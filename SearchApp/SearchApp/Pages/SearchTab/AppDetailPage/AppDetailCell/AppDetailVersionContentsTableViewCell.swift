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
            self.versionLabel.text = model?.version != nil ? "버전 \(model!.version!)" : ""
            self.lastVersionDateLabel.text = model?.lastDate != nil ? "\(model!.lastDate!)전" : ""
            self.newFunctionContents.text = model?.newDescription ?? ""
        }
        
    }
    @IBOutlet weak var versionHistoryBtn: UIButton!
    
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var lastVersionDateLabel: UILabel!
    @IBOutlet weak var newFunctionContents: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
