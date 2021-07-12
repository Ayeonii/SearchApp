//
//  ReactiveExtensions.swift
//  SearchApp
//
//  Created by 이아연 on 2021/07/12.
//

import RxSwift
import RxCocoa

extension Reactive where Base: UITableView {
    
    func isEmpty(message: String) -> Binder<Bool> {
        return Binder(base) { tableView, isEmpty in
            if isEmpty {
                tableView.setNoDataPlaceholder(message)
            } else {
                tableView.removeNoDataPlaceholder()
            }
        }
    }
}
