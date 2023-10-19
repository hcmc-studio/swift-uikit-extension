//
//  UITableView+.swift
//
//
//  Created by Ji-Hwan Kim on 10/16/23.
//

import Foundation
import UIKit

open class XUITableView: UITableView {}

extension UITableView {
    public func dequeue<Cell: XUITableViewCell<Never>>(
        cell: Cell.Type,
        identifier: String,
        for indexPath: IndexPath
    ) -> Cell {
        let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! Cell
        cell.indexPath = indexPath
        cell.bind()
        
        return cell
    }
    
    public func dequeue<Cell: XUITableViewCell<Delegate>, Delegate>(
        cell: Cell.Type,
        identifier: String,
        for indexPath: IndexPath,
        delegate: Delegate
    ) -> Cell {
        let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! Cell
        cell.indexPath = indexPath
        cell.delegate = delegate
        cell.bind()
        
        return cell
    }
}
