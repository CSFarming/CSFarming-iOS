//
//  ProblemCreateButton.swift
//
//
//  Created by 홍성준 on 12/17/23.
//

import UIKit
import SnapKit
import DesignKit
import BasePresentation

final class ProblemCreateView: BaseView {
    
    private let plusImageView = UIImageView()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        selectAnimate()
    }
    
    override func setupLayout() {
        addSubview(plusImageView)
        plusImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
    }
    
    override func setupAttributes() {
        backgroundColor = .csBlue5
        layer.cornerRadius = 25
        layer.borderWidth = 1
        layer.borderColor = UIColor.csBlue2.cgColor
        
        plusImageView.image = UIImage(systemName: "plus")?.withRenderingMode(.alwaysTemplate)
        plusImageView.tintColor = .csWhite
        plusImageView.contentMode = .scaleAspectFit
    }
    
}
