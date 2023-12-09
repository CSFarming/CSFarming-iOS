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
    
    let path: String
    let title: String
    
}

final class ProblemContentView: BaseView {
    
    fileprivate var model: ProblemContentViewModel?
    
    private let folderImageView = UIImageView()
    private let titleLabel = UILabel()
    
    func setup(model: ProblemContentViewModel) {
        self.model = model
        titleLabel.text = model.title
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        selectAnimate()
    }
    
    override func setupLayout() {
        addSubview(folderImageView)
        addSubview(titleLabel)
        
        folderImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        titleLabel.snp.makeConstraints { make in
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
        
        titleLabel.textColor = .csBlack
        titleLabel.font = .bodySB
    }
    
}

extension Reactive where Base: ProblemContentView {
    
    var tap: ControlEvent<ProblemContentViewModel> {
        let source = base.rx.tapGesture
            .compactMap { _ in base.model }
        return ControlEvent(events: source)
    }
    
}
