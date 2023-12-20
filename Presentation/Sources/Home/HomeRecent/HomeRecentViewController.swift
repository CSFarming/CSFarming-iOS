//
//  HomeRecentViewController.swift
//  CSFarming
//
//  Created by 홍성준 on 12/20/23.
//

import RIBs
import RxSwift
import UIKit
import DesignKit
import BasePresentation

protocol HomeRecentPresentableListener: AnyObject {}

final class HomeRecentViewController: BaseViewController, HomeRecentPresentable, HomeRecentViewControllable {
    
    weak var listener: HomeRecentPresentableListener?
    
}
