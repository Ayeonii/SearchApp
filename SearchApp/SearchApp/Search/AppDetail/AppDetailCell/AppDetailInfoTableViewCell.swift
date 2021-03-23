//
//  AppDetailInfoTableViewCell.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/22.
//

import UIKit

class AppDetailInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var data : [AppDetailInfoData]?
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func updateCellWithData(detailData : [AppDetailInfoData]) {
        self.data = detailData
    }
}

extension AppDetailInfoTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppDetailInfoCollectionViewCell", for: indexPath) as? AppDetailInfoCollectionViewCell {
            
            if let cellData = data {
                cell.updateCellWithData(data: cellData[indexPath.row])
            }
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
}
