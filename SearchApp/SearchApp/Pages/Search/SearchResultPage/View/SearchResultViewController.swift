//
//  SearchResultViewController.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/19.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class SearchResultViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.separatorStyle = .none
            tableView.register(UINib(nibName: "SearchResultTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchResultTableViewCell")
        }
    }
    let searchWord : String
    
    lazy var viewModel = SearchResultViewModel(searchWord: searchWord)
    private var disposeBag = DisposeBag()
   
    var rowNum = 0
    var listData : [AppListDataCellModel]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    init(word : String) {
        self.searchWord = word
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

extension SearchResultViewController {
    
    func bindView() {

        viewModel.searchResultSubject
            .debug()
            .bind(to: tableView.rx.items(
                cellIdentifier: "SearchResultTableViewCell",
                cellType: SearchResultTableViewCell.self)
            ){indexPath, data, cell in
                cell.model = data
                cell.selectionStyle = .none
            }
            .disposed(by: disposeBag)
        
        viewModel.searchResultSubject
            .map({ $0.count <= 0 })
            .distinctUntilChanged()
            .bind(to: tableView.rx.isEmpty(message: "검색결과가 없습니다."))
            .disposed(by: disposeBag)
        
        
        tableView.rx.modelSelected(AppListDataCellModel.self)
            .debug()
            .subscribe(onNext: { [weak self] model in
                let vc = AppDetailViewController(term : model.appName)
                self?.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
