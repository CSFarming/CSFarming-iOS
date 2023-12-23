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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .csWhite
        rootView.updateCloseAction { [weak self] in
            self?.didTapClose()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isMovingFromParent {
            listener?.didTapClose()
        }
    }
    
    func updateMarkdown(_ source: String) {
        rootView.updateSource(source)
    }
    
    func updateTitle(_ title: String) {
        rootView.updateTitle(title)
    }
    
    func didTapClose() {
        listener?.didTapClose()
    }
    
}
