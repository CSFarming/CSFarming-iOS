//
//  QuestionCompleteViewController.swift
//  CSFarming
//
//  Created by 홍성준 on 12/15/23.
//

import RIBs
import RxSwift
import UIKit

protocol QuestionCompletePresentableListener: AnyObject {}

final class QuestionCompleteViewController: UIViewController, QuestionCompletePresentable, QuestionCompleteViewControllable {
    
    weak var listener: QuestionCompletePresentableListener?
    
}
