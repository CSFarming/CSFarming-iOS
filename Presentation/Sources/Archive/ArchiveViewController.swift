//
//  ArchiveViewController.swift
//  CSFarming
//
//  Created by 홍성준 on 12/3/23.
//

import RIBs
import RxSwift
import UIKit
import BasePresentation

protocol ArchivePresentableListener: AnyObject {}

final class ArchiveViewController: BaseViewController, ArchivePresentable, ArchiveViewControllable {
    
    weak var listener: ArchivePresentableListener?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupTabBar()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTabBar()
    }
    
    private func setupTabBar() {
        tabBarItem = UITabBarItem(
            title: "학습",
            image: UIImage(systemName: "folder"),
            selectedImage: UIImage(systemName: "folder.fill")
        )
    }
    
}
