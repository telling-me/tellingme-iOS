//
//  UITabBarItem+.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/10/01.
//

import UIKit

/**
 TabBarItem Enum for setting UITabBar Items
 */
enum TabBarItemType: Int, CaseIterable {
    case home
    case myAnswerList
    case myLibrary
    case communicationList
}

extension TabBarItemType {
    
    var pageIndex: Int {
        switch self {
        case .home:
            return 0
        case .myAnswerList:
            return 1
        case .myLibrary:
            return 2
        case .communicationList:
            return 3
        }
    }
    
    var deselectedIcon: UIImage? {
        switch self {
        case .home:
            return ImageLiterals.TabHomeDeselected
        case .myAnswerList:
            return ImageLiterals.TabMyAnswerListDeselected
        case .myLibrary:
            return ImageLiterals.TabMyLibraryDeselected
        case .communicationList:
            return ImageLiterals.TabCommunicationDeselected
        }
    }
    
    var selectedIcon: UIImage? {
        switch self {
        case .home:
            return ImageLiterals.TabHomeSelected
        case .myAnswerList:
            return ImageLiterals.TabMyAnswerListSelected
        case .myLibrary:
            return ImageLiterals.TabMyLibrarySelected
        case .communicationList:
            return ImageLiterals.TabCommunicationSelected
        }
    }
    
    public func setTabBarItem() -> UITabBarItem {
        return UITabBarItem(title: "", image: deselectedIcon, selectedImage: selectedIcon)
    }
}
