//
//  ProblemViewController.swift
//  CSFarming
//
//  Created by 홍성준 on 11/26/23.
//

import UIKit
import DesignKit
import BasePresentation
import RIBs
import RxSwift

protocol ProblemPresentableListener: AnyObject {}

final class ProblemViewController: BaseViewController, ProblemPresentable, ProblemViewControllable {
    
    weak var listener: ProblemPresentableListener?
    
    override func setupLayout() {
        
    }
    
    override func setupAttributes() {
        view.backgroundColor = .csBlue1
    }
    
}
