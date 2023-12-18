//
//  QuestionCreateCompleteViewController.swift
//  CSFarming
//
//  Created by 홍성준 on 12/18/23.
//

import RIBs
import RxSwift
import UIKit

protocol QuestionCreateCompletePresentableListener: AnyObject {}

final class QuestionCreateCompleteViewController: UIViewController, QuestionCreateCompletePresentable, QuestionCreateCompleteViewControllable {
    
    weak var listener: QuestionCreateCompletePresentableListener?
    
}
