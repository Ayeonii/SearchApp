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
    
    var rowNum = 1
    var listData : [AppListData]?
    
    init(word : String) {
        self.searchWord = word
        super.init(nibName: "SearchResultViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        let req = SearchRequestParams(searchTerm: searchWord, entity: "software")
        
        CallHttpAPI.callSearchApi(req){ result in
            if let res = result {
                self.rowNum = res.resultCount ?? 0
                self.listData = AppListDataConvertor(res).getAppListData()
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "SearchResultTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchResultTableViewCell")
    }
    
}

extension SearchResultViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return rowNum
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell", for: indexPath) as? SearchResultTableViewCell {
            
            if let data = self.listData {
                cell.updateCellWithData(data[indexPath.row])
            }
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    
}
