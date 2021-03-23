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
    
    var screenShotUrls : [String]?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.collectionView.register(UINib(nibName: "AppDetailScreenshotCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AppDetailScreenshotCollectionViewCell")
    }

    func updateCellWithData(_ data : [String]) {
        self.screenShotUrls = data
    }
}

extension AppDetailScreenShotTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return screenShotUrls?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppDetailScreenshotCollectionViewCell", for: indexPath) as? AppDetailScreenshotCollectionViewCell {
            
            return cell
        }
        return UICollectionViewCell()
    }
}

