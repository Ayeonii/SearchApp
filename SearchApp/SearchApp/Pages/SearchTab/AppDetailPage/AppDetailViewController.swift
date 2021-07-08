//
//  AppDetailViewController.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/19.
//

import UIKit
import RxSwift

enum AppDetailCellItem{
    case header(AppDetailHeaderDataModel?)
    case detailInfo(AppDetailInfoDataModel?)
    case versionInfo(AppDetailVersionContentsDataModel?)
    case screenShotInfo(AppDetailScreenShotDataModel?)
    case promotionInfo(AppDetailPromotionDataModel?)
}

class AppDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var disposeBag = DisposeBag()
    var id : Int?
    let name : String
    
    let sectionCnt = 0
    var data : AppDetailData? {
        didSet {
            if let res = data {
                var tmpCells : [AppDetailCellItem] = []
                
                tmpCells.append(AppDetailCellItem.header(res.headerData))
                tmpCells.append(AppDetailCellItem.detailInfo(res.infoData))
                tmpCells.append(AppDetailCellItem.versionInfo(res.versionData))
                tmpCells.append(AppDetailCellItem.screenShotInfo(res.screenShots))
                tmpCells.append(AppDetailCellItem.promotionInfo(res.promotionData))
                
                cells = tmpCells
                self.tableView.reloadData()
            }
        }
    }

    var cells : [AppDetailCellItem] = []
    
    init(term : String) {
        self.name = term
        super.init(nibName: "SearchResultViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        let req = SearchRequestParams(searchTerm: name)
        CallHttpAPI.callSearchApi(req)
            .subscribe(onNext: { res in
                self.data = AppDetailData(res)
            }, onError: { error in
                debugPrint(error)
            }, onCompleted: {
                debugPrint("Completed!")
            })
            .disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        registerTableViewCell()
    }
    
}

extension AppDetailViewController {
    
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
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellModel = cells[indexPath.row]
        
        switch cellModel {
        case .header(let header) :
            let cell = tableView.dequeueReusableCell(withIdentifier: "AppDetailHeaderTableViewCell", for: indexPath) as! AppDetailHeaderTableViewCell
            cell.model = header
            cell.selectionStyle = .none
            return cell
        case .detailInfo(let detailInfo) :
            let cell = tableView.dequeueReusableCell(withIdentifier: "AppDetailInfoTableViewCell", for: indexPath) as! AppDetailInfoTableViewCell
            cell.model = detailInfo
            cell.selectionStyle = .none
            return cell
        case .versionInfo(let version) :
            let cell = tableView.dequeueReusableCell(withIdentifier: "AppDetailVersionContentsTableViewCell", for: indexPath) as! AppDetailVersionContentsTableViewCell
            cell.model = version
            cell.selectionStyle = .none
            return cell
        case .screenShotInfo(let screenshot) :
            let cell = tableView.dequeueReusableCell(withIdentifier: "AppDetailScreenShotTableViewCell", for: indexPath) as! AppDetailScreenShotTableViewCell
            cell.model = screenshot
            cell.selectionStyle = .none
            return cell
        case .promotionInfo(let desc) :
            let cell = tableView.dequeueReusableCell(withIdentifier: "AppDetailPromotionTableViewCell", for: indexPath) as! AppDetailPromotionTableViewCell
            cell.model = desc
            cell.selectionStyle = .none
            return cell
            
        }

    }

}
