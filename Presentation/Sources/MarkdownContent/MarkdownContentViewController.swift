//
//  MarkdownContentViewController.swift
//  CSFarming
//
//  Created by 홍성준 on 12/2/23.
//

import RIBs
import RxSwift
import UIKit
import BasePresentation

protocol MarkdownContentPresentableListener: AnyObject {}

final class MarkdownContentViewController: BaseViewController, MarkdownContentPresentable, MarkdownContentViewControllable {
    
    weak var listener: MarkdownContentPresentableListener?
    
    
    
}
