//
//  SearchResultTableViewCell.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/21.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var appDesc: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var installBtn: UIButton!
    
    @IBOutlet weak var screenShot1: UIImageView!
    @IBOutlet weak var screenShot2: UIImageView!
    @IBOutlet weak var screenShot3: UIImageView!
    
    var data : AppListData?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImage.image = UIImage(named : "")
        appName.text = ""
        appDesc.text = ""
        
        ratingLabel.text = ""
        screenShot1.image = UIImage(named : "")
        screenShot2.image = UIImage(named : "")
        screenShot3.image = UIImage(named : "")
        
    }
    
    func updateCellWithData(_ cellData : AppListData){
        self.data = cellData
        
        self.appName.text = cellData.appName
        self.appDesc.text = cellData.appDesc

        
        let iconUrl = URL(string: cellData.iconImage)
        let screenShot1Url = URL(string : cellData.screenShot1 ?? "")
        let screenShot2Url = URL(string : cellData.screenShot2 ?? "")
        let screenShot3Url = URL(string : cellData.screenShot3 ?? "")
        
        DispatchQueue.global().async {
            do {
                let iconData = try? Data(contentsOf: iconUrl!)
                let screen1Data = try? Data(contentsOf: screenShot1Url!)
                let screen2Data = try? Data(contentsOf: screenShot2Url!)
                let screen3Data = try? Data(contentsOf: screenShot3Url!)
                
                DispatchQueue.main.async { [self] in
                    if let data = iconData {
                        iconImage.image = UIImage(data: data)
                    }
                    if let data = screen1Data {
                        screenShot1.image = UIImage(data: data)
                    }
                    if let data = screen2Data {
                        screenShot2.image = UIImage(data: data)
                    }
                    if let data = screen3Data {
                        screenShot3.image = UIImage(data: data)
                    }
                }
            } catch {
               print(error)
            }
        }
    }
}
