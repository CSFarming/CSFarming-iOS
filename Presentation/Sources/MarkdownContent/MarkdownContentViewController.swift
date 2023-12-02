//
//  MarkdownContentViewController.swift
//  CSFarming
//
//  Created by 홍성준 on 12/2/23.
//

import RIBs
import RxSwift
import UIKit
import SwiftUI
import BasePresentation

protocol MarkdownContentPresentableListener: AnyObject {
    func didTapClose()
}

final class MarkdownContentViewController: UIHostingController<MarkdownContentView>, MarkdownContentPresentable, MarkdownContentViewControllable {
    
    weak var listener: MarkdownContentPresentableListener?
    
    func updateMarkdown(_ source: String) {
        rootView.content.update(source)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isMovingFromParent {
            listener?.didTapClose()
        }
    }
    
}
