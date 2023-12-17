//
//  QuestionCompleteViewController.swift
//  CSFarming
//
//  Created by 홍성준 on 12/15/23.
//

import RIBs
import RxSwift
import UIKit
import BasePresentation

protocol QuestionCompletePresentableListener: AnyObject {}

final class QuestionCompleteViewController: BaseViewController, QuestionCompletePresentable, QuestionCompleteViewControllable {
    
    weak var listener: QuestionCompletePresentableListener?
    
    override func setupLayout() {
        
    }
    
    override func setupAttributes() {
        isSwipeBackEnabled = false
    }
    
}
