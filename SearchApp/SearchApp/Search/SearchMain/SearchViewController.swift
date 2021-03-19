//
//  SearchViewController.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/19.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var recentList : [String]? = StoredData.shared.getRecentSearchData() {
        didSet {
           // rowNum = recentList == nil ? 0 : recentList!.count
            UIView.performWithoutAnimation({
                self.tableView.reloadData()
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCellid")
        setupNavigation()
    }
    
    func setupNavigation() {
        let searchController = UISearchController(searchResultsController: nil)
        let navBar = self.navigationController?.navigationBar
        
        searchController.searchBar.placeholder = "게임, 앱, 스토리 등"
        searchController.hidesNavigationBarDuringPresentation = false
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
        return 30 //DataListcount
    }
  
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "최근 검색어"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCellid", for: indexPath) as? SearchTableViewCell {
            
            
            return cell
        }
        return UITableViewCell()
    }
}
