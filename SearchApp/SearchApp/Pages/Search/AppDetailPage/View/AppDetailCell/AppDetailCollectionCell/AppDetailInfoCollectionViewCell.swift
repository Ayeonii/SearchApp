//
//  AppDetailInfoCollectionViewCell.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/23.
//

import UIKit

class AppDetailInfoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var prefix: UILabel!
    
    var model : AppDetailInfoDataCellModel? {
        didSet {
            self.title.text = model?.title ?? ""
            self.content.text = model?.content ?? ""
            self.prefix.text = model?.prefix ?? ""
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
