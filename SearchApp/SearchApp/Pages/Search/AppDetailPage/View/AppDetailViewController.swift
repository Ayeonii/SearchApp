//
//  AppDetailViewController.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/19.
//

import UIKit
import RxSwift
import RxDataSources

class AppDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "AppDetailHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "AppDetailHeaderTableViewCell")
            
            tableView.register(UINib(nibName: "AppDetailInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "AppDetailInfoTableViewCell")
            
            tableView.register(UINib(nibName: "AppDetailVersionContentsTableViewCell", bundle: nil), forCellReuseIdentifier: "AppDetailVersionContentsTableViewCell")
            
            tableView.register(UINib(nibName: "AppDetailScreenShotTableViewCell", bundle: nil), forCellReuseIdentifier: "AppDetailScreenShotTableViewCell")
            
            tableView.register(UINib(nibName: "AppDetailPromotionTableViewCell", bundle: nil), forCellReuseIdentifier: "AppDetailPromotionTableViewCell")
        }
    }

    private let name : String
    private var disposeBag = DisposeBag()
    lazy var viewModel = AppDetailViewModel(appName: name)
    
    init(term : String) {
        self.name = term
        super.init(nibName: "SearchResultViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
    }
    
}

extension AppDetailViewController {
    func bindView() {
        viewModel.appInfoSubject
            .bind(to: tableView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: disposeBag)
        
    }

}

