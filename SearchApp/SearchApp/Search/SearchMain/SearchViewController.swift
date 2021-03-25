//
//  SearchViewController.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/19.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var filteredData : [String]?
    var searchController : UISearchController?
    var childView : UIViewController?
    
    var isSearchingActivate : Bool {
        let searchController = self.navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
    
        return isActive && isSearchBarHasText
    }
    
    private var recentList : [String]? = StoredData.shared.getRecentSearchData() {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupTableView()
        self.setupNavigation()
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCellid")
    }
    
    func setupNavigation() {
        searchController = UISearchController(searchResultsController: nil)
        searchController?.searchResultsUpdater = self
        searchController?.searchBar.delegate = self
        
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

    func saveRecentSearchData(_ txt : String) {
           
        if self.recentList == nil {
            self.recentList = [txt]
            self.filteredData = [txt]
        } else {
            var uniqueList = self.recentList?.filter {$0 != txt}
            uniqueList!.append(txt)
            self.recentList = uniqueList
        }
        StoredData.shared.setRecentSearchData(param: self.recentList)
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
        ImageCacahe.shared.removeAllObjects()
    }
    
    func goToResult(_ text : String) {
        
        searchController?.isActive = true

        self.navigationItem.searchController?.searchBar.text = text
        let resultVC = SearchResultViewController(word : text)
        resultVC.modalPresentationStyle = .fullScreen
        resultVC.view.center = CGPoint(x : self.tableView.frame.size.width / 2,
                                       y : self.tableView.frame.size.height / 2)
        
        self.addChildViewController(child : resultVC)

        self.saveRecentSearchData(text)
    }
    
}

extension SearchViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchingActivate ? filteredData?.count ?? 0 : recentList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return isSearchingActivate ? CGFloat.leastNormalMagnitude : 50
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
        label.text = isSearchingActivate ? "" : "최근 검색어"
        
        return v
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCellid", for: indexPath) as? SearchTableViewCell {
            var tableData : [String]
            
            if isSearchingActivate {
                guard let filtered = self.filteredData else {return cell}
                tableData = filtered.reversed()
            } else  {
                guard let recent = self.recentList else {return cell}
                tableData = recent.reversed()
            }

            cell.recentLabel.text = tableData[indexPath.row]
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var texts : [String]
        if isSearchingActivate {
            guard let data = filteredData else {return}
            texts = data.reversed()
        } else {
            guard let data =  recentList else {return }
            texts = data.reversed()
        }
        
        let text = texts[indexPath.row]
        
        self.goToResult(text)
    }
    
    
}

extension SearchViewController : UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let text = searchController.searchBar.text else { return }
        guard let recentData = self.recentList else {return}
        
        self.filteredData = recentData.filter {
            $0.hasPrefix(text)
        }
        
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar : UISearchBar) {
        guard let text = searchBar.text else {return}
        self.goToResult(text)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        guard let text = searchBar.text else {return true}
        if text.isEmpty {
            self.removeChildViewController()
        }
        return true
    }

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.removeChildViewController()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.removeChildViewController()
    }
}
