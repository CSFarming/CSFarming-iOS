//
//  ProblemCreateViewController.swift
//  CSFarming
//
//  Created by 홍성준 on 12/17/23.
//

import RIBs
import RxSwift
import UIKit

protocol ProblemCreatePresentableListener: AnyObject {}

final class ProblemCreateViewController: UIViewController, ProblemCreatePresentable, ProblemCreateViewControllable {
    
    weak var listener: ProblemCreatePresentableListener?
    
}
