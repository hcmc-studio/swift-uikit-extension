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
    public func dequeue<Cell: XUITableViewCell>(
        cell: Cell.Type,
        identifier: String,
        for indexPath: IndexPath
    ) -> Cell {
        let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! Cell
        cell.bind()
        
        return cell
    }
}
