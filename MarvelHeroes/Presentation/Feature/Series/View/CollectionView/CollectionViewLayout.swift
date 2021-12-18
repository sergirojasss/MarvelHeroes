//
//  CollectionViewLayout.swift
//  MarvelHeroes
//
//  Created by ROJAS SERRA Sergi on 18/12/21.
//

import UIKit

final class CustomCollectionViewLayout: UICollectionViewFlowLayout {

    // MARK: - Constants
    private struct Constants {
        static let defaultCellWidth: CGFloat = 200
        static let defaultCellHeight: CGFloat = 200
        static let leftMargin: CGFloat = 20
        static let rightMargin: CGFloat = 20
        static let topMargin: CGFloat = 4
        static let bottomMargin: CGFloat = 20
        static let margins: CGFloat = 30
    }

    private var defaultCellSize: CGSize {
        let defaultSize = CGSize(width: Constants.defaultCellWidth, height: Constants.defaultCellHeight)
        guard let collectionView = collectionView else { return defaultSize}
        guard var cellWidth = collectionView.superview?.frame.size.width else { return defaultSize }
        cellWidth -= Constants.margins * 2
        cellWidth = cellWidth / 2

        return CGSize(width: cellWidth, height: defaultSize.height)
    }

    // MARK: - lifeCycle
    override func prepare() {
        super.prepare()
        self.itemSize = defaultCellSize
        self.sectionInset = UIEdgeInsets(top: Constants.topMargin,
                                         left: Constants.leftMargin,
                                         bottom: Constants.bottomMargin,
                                         right:  Constants.rightMargin)
    }

}
