//
//  UITableViewExtension.swift
//  SearchApp
//
//  Created by 이아연 on 2021/07/12.
//

import UIKit

extension UITableView {
    
    func setNoDataPlaceholder(_ message : String) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        label.text = message
        label.sizeToFit()
        
        self.isScrollEnabled = false
        self.backgroundView = label
        self.separatorStyle = .none
    }
    
    func removeNoDataPlaceholder() {
        self.isScrollEnabled = true
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
