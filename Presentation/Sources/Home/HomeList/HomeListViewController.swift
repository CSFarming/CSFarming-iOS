//
//  HomeListViewController.swift
//  CSFarming
//
//  Created by 홍성준 on 12/2/23.
//

import RIBs
import RxSwift
import UIKit

protocol HomeListPresentableListener: AnyObject {}

final class HomeListViewController: UIViewController, HomeListPresentable, HomeListViewControllable {
    
    weak var listener: HomeListPresentableListener?
    
}
