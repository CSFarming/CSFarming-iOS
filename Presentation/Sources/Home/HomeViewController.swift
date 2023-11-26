//
//  HomeViewController.swift
//  CSFarming
//
//  Created by 홍성준 on 11/26/23.
//

import UIKit
import RIBs
import RxSwift
import SnapKit
import DesignKit
import BasePresentation

protocol HomePresentableListener: AnyObject {}

final class HomeViewController: BaseViewController, HomePresentable, HomeViewControllable {
    
    weak var listener: HomePresentableListener?
    
    
    override func bind() {
        
    }
    
    override func setupLayout() {
        
    }
    
    override func setupAttributes() {
        view.backgroundColor = .csBlue1
    }
    
}
