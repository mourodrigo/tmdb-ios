//  UICollectionView+.swift
//  tmdb

import Foundation
import UIKit

// ************************************************
// MARK: - UICollectionReusableView
// ************************************************

extension UICollectionReusableView {

    public static var identifier: String {
        return String(describing: self)
    }

    public static var nibName: String {
        return self.identifier
    }

    public static var nib: UINib {
        return UINib(nibName: nibName, bundle: nil)
    }
}

// ************************************************
// MARK: - UICollectionView
// ************************************************

extension UICollectionView {

    enum SupplementaryView {
        case header
        case footer

        var identifier: String {
            switch self {
            case .header:
                return UICollectionView.elementKindSectionHeader
            case .footer:
                return UICollectionView.elementKindSectionFooter
            }
        }
    }

    func registerCell<CellType: UICollectionViewCell>(_: CellType.Type) {
        self.register(CellType.nib, forCellWithReuseIdentifier: CellType.identifier)
    }

    func registerSupplementaryView<ViewType: UICollectionReusableView>(_: ViewType.Type, view: SupplementaryView) {
        self.register(ViewType.nib, forSupplementaryViewOfKind: view.identifier, withReuseIdentifier: ViewType.identifier)
    }

    func dequeueReusableCell<CellType: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> CellType {

        if let cell = self.dequeueReusableCell(withReuseIdentifier: CellType.identifier, for: indexPath) as? CellType {
            return cell
        } else {
            fatalError("Could not dequeue cell with identifier: \(CellType.identifier)")
        }
    }

    func dequeueReusableSupplementaryView<ViewType: UICollectionReusableView>(_ view: SupplementaryView, forIndexPath indexPath: IndexPath) -> ViewType {

        if let cell = self.dequeueReusableSupplementaryView(ofKind: view.identifier, withReuseIdentifier: ViewType.identifier, for: indexPath) as? ViewType {
            return cell
        } else {
            fatalError("Could not dequeue supplementary view with identifier: \(ViewType.identifier)")
        }
    }
}
