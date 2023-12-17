//
//  QuestionCreateViewController.swift
//  CSFarming
//
//  Created by 홍성준 on 12/17/23.
//

import RIBs
import RxSwift
import UIKit

protocol QuestionCreatePresentableListener: AnyObject {}

final class QuestionCreateViewController: UIViewController, QuestionCreatePresentable, QuestionCreateViewControllable {
    
    weak var listener: QuestionCreatePresentableListener?
    
}
