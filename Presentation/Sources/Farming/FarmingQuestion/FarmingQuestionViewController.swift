//
//  FarmingQuestionViewController.swift
//  CSFarming
//
//  Created by 홍성준 on 12/23/23.
//

import RIBs
import RxSwift
import UIKit

protocol FarmingQuestionPresentableListener: AnyObject {}

final class FarmingQuestionViewController: UIViewController, FarmingQuestionPresentable, FarmingQuestionViewControllable {
    
    weak var listener: FarmingQuestionPresentableListener?
    
}
