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
        definesPresentationContext = true
        self.setupTableView()
        self.setupNavigation()
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCellid")
    }
    
    func setupNavigation() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
        let navBar = self.navigationController?.navigationBar
        
        searchController.searchBar.placeholder = "게임, 앱, 스토리 등"
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.setValue("취소", forKey: "cancelButtonText")
        
        navBar?.prefersLargeTitles = true
        navigationItem.title = "검색"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        
        let profileButton = UIButton()
        profileButton.setBackgroundImage(UIImage(named: "earth_icon"), for: .normal)
        profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        navBar?.addSubview(profileButton)
        profileButton.frame = CGRect(x: self.view.frame.width, y: 0, width: 50, height: 50)
        
        var constraints: [NSLayoutConstraint] = []
        constraints.append(NSLayoutConstraint(item: profileButton, attribute: .trailingMargin, relatedBy: .equal, toItem: navBar, attribute: .trailingMargin, multiplier: 1.0, constant: -16))
        constraints.append(NSLayoutConstraint(item: profileButton, attribute: .bottom, relatedBy: .equal, toItem: navBar, attribute: .bottom, multiplier: 1.0, constant: -searchController.searchBar.frame.height - 6))
        
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func profileButtonTapped(sender : Any) {
        
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
        v.backgroundColor = .clear
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
                tableData = filtered
            } else  {
                guard let recent = self.recentList else {return cell}
                tableData = recent
            }

            cell.recentLabel.text = tableData[indexPath.row]
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let clickedData : String
        
        if isSearchingActivate {
            guard let data =  filteredData else {return}
            clickedData = data[indexPath.row]
        } else {
            guard let data =  recentList else {return }
            clickedData = data[indexPath.row]
        }
        
        self.navigationItem.searchController?.searchBar.text = clickedData
        let resultVC = SearchResultViewController(word : clickedData)
        self.navigationController?.pushViewController(resultVC, animated: true)
        self.saveRecentSearchData(clickedData)
        
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
        let text = searchBar.text ?? ""
        
        self.navigationItem.searchController?.searchBar.text = text
        let resultVC = SearchResultViewController(word : text)
        self.navigationController?.pushViewController(resultVC, animated: true)
        self.saveRecentSearchData(text)
        
    }
    
    func saveRecentSearchData(_ txt : String) {
           
        if self.recentList == nil {
            self.recentList = [txt]
            self.filteredData = [txt]
        } else {
            //중복값 제거
            var uniqueList = self.recentList?.filter {$0 != txt}
            uniqueList!.append(txt)
            self.recentList = uniqueList
        }
        StoredData.shared.setRecentSearchData(param: self.recentList)
    }
}
