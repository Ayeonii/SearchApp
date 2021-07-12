//
//  AppDetailScreenShotTableViewCell.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/22.
//

import UIKit

class AppDetailScreenShotTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var supportDevices: UILabel!
    
    var model : AppDetailScreenShotDataModel? {
        didSet {
            self.screenShotUrls = model?.screenShots
        }
    }
    
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    var screenShotUrls : [String]?
    var flowLayout = UICollectionViewFlowLayout()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        
        flowLayout.scrollDirection = .horizontal
        
        let itemWidth = collectionView.frame.size.width * (2/3)
        let ratio : CGFloat = 696/392
        
        flowLayout.itemSize = CGSize(width : itemWidth, height: itemWidth * ratio)
        
        collectionViewHeight.constant = itemWidth * ratio
        collectionView.collectionViewLayout = flowLayout
        self.collectionView.register(UINib(nibName: "AppDetailScreenshotCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AppDetailScreenshotCollectionViewCell")
    }
}

extension AppDetailScreenShotTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return screenShotUrls?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppDetailScreenshotCollectionViewCell", for: indexPath) as? AppDetailScreenshotCollectionViewCell {
            if let image = screenShotUrls?[indexPath.item] {
                cell.screenShotImage.kf.setImage(with: URL(string: image), placeholder: UIImage(named : "noImgWidth"), options: [.transition(.fade(0.4))])
            }
          
            return cell
        }
        return UICollectionViewCell()
    }
}

