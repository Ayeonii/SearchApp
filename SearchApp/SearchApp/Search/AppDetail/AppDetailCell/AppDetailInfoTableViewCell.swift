//
//  AppDetailInfoTableViewCell.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/22.
//

import UIKit

class AppDetailInfoTableViewCell: UITableViewCell {

    
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    var model : AppDetailInfoDataModel? {
        didSet{
            self.data = model?.detailInfo
        }
    }
    var data : [AppDetailInfoDataCellModel]?
    var flowLayout = UICollectionViewFlowLayout()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: collectionView.frame.size.width / 3, height: collectionView.frame.size.height)
        collectionViewHeight.constant = collectionView.frame.size.height
            
        collectionView.collectionViewLayout = flowLayout
        
        collectionView.register(UINib(nibName: "AppDetailInfoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AppDetailInfoCollectionViewCell")
    }
}

extension AppDetailInfoTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppDetailInfoCollectionViewCell", for: indexPath) as? AppDetailInfoCollectionViewCell {
            if let cellData = data {
                cell.model = cellData[indexPath.item]
            }
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
}
