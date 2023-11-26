//
//  NavigationView.swift
//
//
//  Created by 홍성준 on 11/26/23.
//

import UIKit
import RxSwift
import RxCocoa

public struct NavigationViewModel {
    
    let title: String
    let leftButtonType: NavigationViewButtonType
    let rightButtonType: NavigationViewButtonType
    
    public init(title: String, leftButtonType: NavigationViewButtonType, rightButtonType: NavigationViewButtonType) {
        self.title = title
        self.leftButtonType = leftButtonType
        self.rightButtonType = rightButtonType
    }
    
}

public final class NavigationView: UIView {
        
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .bodySB
        label.textColor = .csBlack
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate lazy var leftButton = makeNavigationViewButton()
    fileprivate lazy var rightButton = makeNavigationViewButton()
    
    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = .csBlue2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    public func setup(model: NavigationViewModel) {
        titleLabel.text = model.title
        leftButton.type = model.leftButtonType
        rightButton.type = model.rightButtonType
    }
    
    public func updateTitle(_ title: String) {
        titleLabel.text = title
    }
    
    public func showSeparator() {
        separator.isHidden = false
    }
    
    public func hideSeparator() {
        separator.isHidden = true
    }
    
}

public extension Reactive where Base: NavigationView {
    
    var leftButtonDidTap: ControlEvent<Void> {
        let source = base.leftButton.rx.tap
        return ControlEvent(events: source)
    }
    
    var rightButtonDidTap: ControlEvent<Void> {
        let source = base.rightButton.rx.tap
        return ControlEvent(events: source)
    }
    
}


private extension NavigationView {
    
    func setupViews() {
        backgroundColor = .csBlue1
        [titleLabel, leftButton, rightButton, separator].forEach(addSubview)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            leftButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            leftButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            rightButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            rightButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            separator.leadingAnchor.constraint(equalTo: leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor),
            separator.bottomAnchor.constraint(equalTo: bottomAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func makeNavigationViewButton() -> NavigationViewButton {
        let button = NavigationViewButton()
        button.tintColor = .csBlack
        button.contentMode = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        return button
    }
    
}
