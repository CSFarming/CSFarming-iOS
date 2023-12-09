//
//  QuestionViewController.swift
//  CSFarming
//
//  Created by 홍성준 on 12/9/23.
//

import RIBs
import RxSwift
import UIKit

protocol QuestionPresentableListener: AnyObject {}

final class QuestionViewController: UIViewController, QuestionPresentable, QuestionViewControllable {
    
    weak var listener: QuestionPresentableListener?
    
}
