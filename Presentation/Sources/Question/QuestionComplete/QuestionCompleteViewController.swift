//
//  QuestionCompleteViewController.swift
//  CSFarming
//
//  Created by 홍성준 on 12/15/23.
//

import RIBs
import RxSwift
import UIKit

protocol QuestionCompletePresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class QuestionCompleteViewController: UIViewController, QuestionCompletePresentable, QuestionCompleteViewControllable {

    weak var listener: QuestionCompletePresentableListener?
}
