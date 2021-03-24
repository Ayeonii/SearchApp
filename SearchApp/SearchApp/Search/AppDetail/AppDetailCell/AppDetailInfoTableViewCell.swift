//
//  AppDetailInfoTableViewCell.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/22.
//

import UIKit

class AppDetailInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    var model : AppDetailInfoDataModel? {
        didSet{
            self.data = model?.detailInfo
        }
    }
    var data : [AppDetailInfoDataCellModel]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
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
