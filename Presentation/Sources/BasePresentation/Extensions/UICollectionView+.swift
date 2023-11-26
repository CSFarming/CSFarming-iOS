//
//  UICollectionView+.swift
//
//
//  Created by 홍성준 on 11/26/23.
//

import UIKit

extension UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
}

public extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_ cell: T.Type) {
        self.register(cell, forCellWithReuseIdentifier: cell.identifier)
    }
    
    func dequeue<T: UICollectionViewCell>(_ cell: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cell.identifier, for: indexPath) as? T else {
            fatalError("\(cell)을 등록하지 않았습니다")
        }
        return cell
    }

}
