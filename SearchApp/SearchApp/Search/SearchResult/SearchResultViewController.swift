//
//  SearchResultViewController.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/19.
//

import UIKit

class SearchResultViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let searchWord : String
    
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
    
    override func loadView() {
        super.loadView()
        
        self.tableView?.isHidden = true
        let req = SearchRequestParams(searchTerm: searchWord, entity: "software")
        CallHttpAPI.callSearchApi(req){ result in
            if let res = result {
                self.rowNum = res.resultCount ?? 0
                self.listData = AppListData(res).data
            }
            self.tableView?.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        tableView.register(UINib(nibName: "SearchResultTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchResultTableViewCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "NoSearchResultCell")
    }
}

extension SearchResultViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if rowNum == 0 {
            return 1
        }
        
        return rowNum
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if rowNum == 0 {
            return self.tableView.frame.height
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let data = self.listData?[indexPath.row] else {return}
        
        let term = data.appName
        let vc = AppDetailViewController(term : term)
        vc.id = data.appId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if rowNum == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NoSearchResultCell", for: indexPath)
            
            let noSearchLabel = UILabel()
            cell.addSubview(noSearchLabel)
            
            noSearchLabel.translatesAutoresizingMaskIntoConstraints = false
            noSearchLabel.text = "검색결과가 없습니다."
            noSearchLabel.textAlignment = .center
            noSearchLabel.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
            noSearchLabel.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
            noSearchLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
            noSearchLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell", for: indexPath) as! SearchResultTableViewCell
            
            guard let data = self.listData?[indexPath.row] else {return cell}
            cell.model = data
            cell.selectionStyle = .none
        
            return cell
        }
    }
 
}
