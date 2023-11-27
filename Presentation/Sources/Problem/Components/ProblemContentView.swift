//
//  ProblemContentView.swift
//
//
//  Created by 홍성준 on 11/26/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import DesignKit
import BasePresentation

struct ProblemContentViewModel {
    
    let id: Int
    let title: String
    let subtitle: String
    
}

final class ProblemContentView: BaseView {
    
    fileprivate var model: ProblemContentViewModel?
    
    private let folderImageView = UIImageView()
    private let labelStackView = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    func setup(model: ProblemContentViewModel) {
        self.model = model
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        selectAnimate()
    }
    
    override func setupLayout() {
        addSubview(folderImageView)
        addSubview(labelStackView)
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(subtitleLabel)
        
        folderImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        labelStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(folderImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    override func setupAttributes() {
        backgroundColor = .white
        clipsToBounds = true
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.csBlue2.cgColor
        
        folderImageView.image = UIImage(systemName: "folder.fill")?.withRenderingMode(.alwaysTemplate)
        folderImageView.contentMode = .scaleAspectFit
        folderImageView.tintColor = .csBlue5
        
        labelStackView.axis = .vertical
        labelStackView.spacing = 0
        labelStackView.alignment = .fill
        labelStackView.distribution = .fillEqually
        
        titleLabel.textColor = .csBlack
        titleLabel.font = .bodySB
        
        subtitleLabel.textColor = .csBlack
        subtitleLabel.font = .smallR
    }
    
}

extension Reactive where Base: ProblemContentView {
    
    var tap: ControlEvent<ProblemContentViewModel> {
        let source = base.rx.tapGesture
            .compactMap { _ in base.model }
        return ControlEvent(events: source)
    }
    
}
