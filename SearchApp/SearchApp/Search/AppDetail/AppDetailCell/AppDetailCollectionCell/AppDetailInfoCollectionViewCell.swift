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
    
    var data : AppDetailInfoData?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func updateCellWithData(data : AppDetailInfoData){
        self.title.text = data.title
        self.content.text = data.content
        self.prefix.text = data.prefix
    }
}
