//
//  UITableView+dequeueReusable.swift
//  Reddit
//
//  Created by Andrew Chersky on 11.11.2020.
//

import UIKit

extension UITableView {
    
    func dequeueReusableCell<T: UITableViewCell>(forType cellType: T.Type, for indexPath: IndexPath) -> T {
        let reusableIdentifier = String(describing: cellType)
        return dequeueReusableCell(withIdentifier: reusableIdentifier, for: indexPath) as! T
    }
    
    func dequeueReusableHeaderFooterView<T: UIView>(forType viewType: T.Type) -> T {
        let reusableIdentifier = String(describing: viewType)
        return dequeueReusableHeaderFooterView(withIdentifier: reusableIdentifier) as! T
    }
}

