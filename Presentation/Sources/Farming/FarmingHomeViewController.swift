//
//  FarmingHomeViewController.swift
//  CSFarming
//
//  Created by 홍성준 on 12/21/23.
//

import RIBs
import RxSwift
import UIKit

protocol FarmingHomePresentableListener: AnyObject {}

final class FarmingHomeViewController: UIViewController, FarmingHomePresentable, FarmingHomeViewControllable {
    
    weak var listener: FarmingHomePresentableListener?
    
}
