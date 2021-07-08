//
//  SearchMainViewController.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/19.
//

import UIKit
import RxSwift
import RxCocoa

class SearchMainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.register(UINib(nibName: "SearchMainTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchMainTableViewCell")
        }
    }

    var disposeBag = DisposeBag()
    var viewModel = SearchMainViewModel()
    var searchController : UISearchController?
    var childView : UIViewController?
    
    var isSearchingActivate : Bool {
        let searchController = self.navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false

        return isActive && isSearchBarHasText
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigation()
        self.bindView()

    }
    
    func bindView() {
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)

        searchController?.searchBar.rx.text.orEmpty
            .debounce(RxTimeInterval.microseconds(10), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .debug()
            .subscribe(onNext: {[weak self] text in
                self?.viewModel.setSearchListData(inputText: text)
                self?.removeChildViewController()
            }, onError: { error in
                debugPrint(error)
            })
            .disposed(by: disposeBag)
        
        
        searchController?.searchBar.rx
            .searchButtonClicked
            .debug()
            .subscribe(onNext: { [weak self] in
                guard let self = self, let text = self.searchController?.searchBar.text else { return }
                self.goToResult(text)
            }, onError: { error in
                debugPrint(error)
            })
            .disposed(by: disposeBag)
        
        
        searchController?.searchBar.rx
            .textDidBeginEditing
            .debug()
            .subscribe(onNext: { [weak self] in
                guard let self = self, let text = self.searchController?.searchBar.text else { return }
               
                if text.isEmpty {
                    self.removeChildViewController()
                }
            })
            .disposed(by: disposeBag)
        
        searchController?.searchBar.rx
            .cancelButtonClicked
            .debug()
            .subscribe(onNext: {
                self.removeChildViewController()
            })
            .disposed(by: disposeBag)
        
        
        viewModel.searchListDataSubject
            .debug()
            .bind(to: tableView.rx.items(
                cellIdentifier: "SearchMainTableViewCell",
                cellType: SearchMainTableViewCell.self)
            ){indexPath, data, cell in
                cell.recentLabel.text = data
            }
            .disposed(by: disposeBag)
        
        
        tableView.rx.modelSelected(String.self)
            .debug()
            .subscribe(onNext: { [weak self] model in
                self?.goToResult(model)
            })
            .disposed(by: disposeBag)
        

    }
    
    func setupNavigation() {
        searchController = UISearchController(searchResultsController: nil)
        //searchController?.searchResultsUpdater = self
        
        let navBar = self.navigationController?.navigationBar
        searchController?.searchBar.placeholder = "게임, 앱, 스토리 등"
        searchController?.hidesNavigationBarDuringPresentation = true
        searchController?.obscuresBackgroundDuringPresentation = false
        searchController?.searchBar.setValue("취소", forKey: "cancelButtonText")
        
        navBar?.prefersLargeTitles = true
        navigationItem.title = "검색"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController!

    }

    func addChildViewController(child : UIViewController) {
        self.addChild(child)
        self.view.addSubview(child.view)
        child.didMove(toParent: self)
        self.childView = child
    }
    
    func removeChildViewController() {
        guard let child = self.childView else {return}
        
        guard child.parent != nil else { return }

        child.willMove(toParent: nil)
        child.removeFromParent()
        child.view.removeFromSuperview()
    }
    
    func goToResult(_ text : String) {
        
        searchController?.isActive = true
        self.navigationItem.searchController?.searchBar.text = text
        
        let resultVC = SearchResultViewController(word : text)
        resultVC.modalPresentationStyle = .fullScreen
        resultVC.view.center = CGPoint(x : self.tableView.frame.size.width / 2,
                                       y : self.tableView.frame.size.height / 2)
        
        self.addChildViewController(child : resultVC)

        viewModel.saveRecentSearchData(text)
    }
    
}

extension SearchMainViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.isSearchingActivate(self.navigationItem.searchController) ? CGFloat.leastNormalMagnitude : 50
    }
  
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        let label = UILabel()
        v.addSubview(label)
        v.backgroundColor = .systemBackground
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leftAnchor.constraint(equalTo: v.leftAnchor, constant: 16).isActive = true
        label.centerYAnchor.constraint(equalTo: v.centerYAnchor).isActive = true
        label.textAlignment = .left
        label.text = viewModel.isSearchingActivate(self.navigationItem.searchController) ? "" : "최근 검색어"
        
        return v
    }

}
