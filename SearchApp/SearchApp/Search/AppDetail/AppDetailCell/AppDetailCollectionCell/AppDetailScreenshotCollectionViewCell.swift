//
//  AppDetailScreenshotCollectionViewCell.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/23.
//

import UIKit

class AppDetailScreenshotCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var screenShotImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        screenShotImage.makeRadiusAndAspectFill()
    }

}
