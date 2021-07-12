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
       // screenShotImage.makeRadius()
        
        let ratio : CGFloat = 696/392
        self.screenShotImage.addConstraint(NSLayoutConstraint(item: screenShotImage!, attribute: .height, relatedBy: .equal, toItem: screenShotImage!, attribute: .width, multiplier: ratio, constant: 0))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.screenShotImage.image = nil
        self.screenShotImage.contentMode = .scaleAspectFill
    }
}
