//
//  HomeFarmingViewController.swift
//  CSFarming
//
//  Created by 홍성준 on 12/20/23.
//

import RIBs
import RxSwift
import UIKit
import DesignKit
import BasePresentation

protocol HomeFarmingPresentableListener: AnyObject {
    func didTapChart()
    func viewWillAppear()
}

final class HomeFarmingViewController: BaseViewController, HomeFarmingPresentable, HomeFarmingViewControllable {
    
    weak var listener: HomeFarmingPresentableListener?
    
    private let barHeight: CGFloat = 200
    
    private let titleLabel = UILabel()
    private let chartView = HomeFarmingChartView()
    
    func setup(model: HomeFarmingChartViewModel) {
        chartView.setup(model: model, height: barHeight)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listener?.viewWillAppear()
    }
    
    override func setupLayout() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        view.addSubview(chartView)
        chartView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(barHeight + 100)
        }
    }
    
    override func setupAttributes() {
        view.backgroundColor = .csBlue1
        
        titleLabel.text = "나의 파밍"
        titleLabel.font = .headerSB
        titleLabel.textColor = .csBlack
    }
    
    override func bind() {
        chartView.rx.tapGesture
            .bind(to: chartViewBinder)
            .disposed(by: disposeBag)
    }
    
    private var chartViewBinder: Binder<UITapGestureRecognizer> {
        return Binder(self) { this, _ in
            this.listener?.didTapChart()
        }
    }
    
}
