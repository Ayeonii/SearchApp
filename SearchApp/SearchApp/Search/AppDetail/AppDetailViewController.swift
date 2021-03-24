//
//  AppDetailViewController.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/19.
//

import UIKit

enum CellItem{
    case header(AppDetailHeaderDataModel?)
    case detailInfo(AppDetailInfoDataModel?)
    case versionInfo(AppDetailVersionContentsDataModel?)
    case screenShotInfo(AppDetailScreenShotDataModel?)
    case promotionInfo(AppDetailPromotionDataModel?)
}

class AppDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let id : Int
    
    let sectionCnt = 0
    var data : AppDetailData? {
        didSet {
            if let res = data {
                cells.append(CellItem.header(res.headerData))
                cells.append(CellItem.detailInfo(res.infoData))
                cells.append(CellItem.versionInfo(res.versionData))
                cells.append(CellItem.screenShotInfo(res.screenShots))
                cells.append(CellItem.promotionInfo(res.promotionData))
            }
        }
    }
    
    var cells : [CellItem] = []

    init(id : Int) {
        self.id = id
        super.init(nibName: "SearchResultViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let req = SearchAnAppRequestParams(id : self.id)
        CallHttpAPI.callSearchApiApapp(req){ result in
            if let res = result {
                self.data = AppDetailData(res)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        registerTableViewCell()
    }
    
    func registerTableViewCell() {
        tableView.register(UINib(nibName: "AppDetailHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "AppDetailHeaderTableViewCell")
        
        tableView.register(UINib(nibName: "AppDetailInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "AppDetailInfoTableViewCell")
        
        tableView.register(UINib(nibName: "AppDetailVersionContentsTableViewCell", bundle: nil), forCellReuseIdentifier: "AppDetailVersionContentsTableViewCell")
        
        tableView.register(UINib(nibName: "AppDetailScreenShotTableViewCell", bundle: nil), forCellReuseIdentifier: "AppDetailScreenShotTableViewCell")
        
        tableView.register(UINib(nibName: "AppDetailPromotionTableViewCell", bundle: nil), forCellReuseIdentifier: "AppDetailPromotionTableViewCell")
        
        
    }
    
}

extension AppDetailViewController : UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = cells[indexPath.row]
        
        switch cellModel {
        case .header(let header) :
            let cell = tableView.dequeueReusableCell(withIdentifier: "AppDetailHeaderTableViewCell", for: indexPath) as! AppDetailHeaderTableViewCell
            cell.model = header
            return cell
        case .detailInfo(let detailInfo) :
            let cell = tableView.dequeueReusableCell(withIdentifier: "AppDetailInfoTableViewCell", for: indexPath) as! AppDetailInfoTableViewCell
            cell.model = detailInfo
            return cell
        case .versionInfo(let version) :
            let cell = tableView.dequeueReusableCell(withIdentifier: "AppDetailVersionContentsTableViewCell", for: indexPath) as! AppDetailVersionContentsTableViewCell
            cell.model = version
            return cell
            
        
            
        default :
            return UITableViewCell()
        }
        
       

    }

}
