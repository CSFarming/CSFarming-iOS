//
//  FarmingChartViewController.swift
//  CSFarming
//
//  Created by 홍성준 on 12/26/23.
//

import RIBs
import RxSwift
import UIKit
import DesignKit
import BasePresentation

protocol FarmingChartPresentableListener: AnyObject {}

final class FarmingChartViewController: UIViewController, FarmingChartPresentable, FarmingChartViewControllable {
    
    weak var listener: FarmingChartPresentableListener?
    
}
