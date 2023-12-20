//
//  HomeFarmingViewController.swift
//  CSFarming
//
//  Created by 홍성준 on 12/20/23.
//

import RIBs
import RxSwift
import UIKit
import DesignKit
import BasePresentation

protocol HomeFarmingPresentableListener: AnyObject {}

final class HomeFarmingViewController: BaseViewController, HomeFarmingPresentable, HomeFarmingViewControllable {
    
    weak var listener: HomeFarmingPresentableListener?
    
}
