//
//  AppDetailVersionContentsTableViewCell.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/22.
//

import UIKit

struct AppDetailVersionContentsData {
    var version : String
    var newDescription : String
    var lastDate : String
}

class AppDetailVersionContentsTableViewCell: UITableViewCell {

    var data : AppDetailVersionContentsData?
    @IBOutlet weak var versionHistoryBtn: UIButton!
    
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var lastVersionDateLabel: UILabel!
    @IBOutlet weak var newFunctionContents: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateCellWithData(data : AppDetailVersionContentsData ) {
        self.data = data
        
        versionLabel.text = "버전 \(data.version)"
        lastVersionDateLabel.text = "\(data.lastDate)전"
        newFunctionContents.text = data.newDescription
        
        
        
    }
    
}
