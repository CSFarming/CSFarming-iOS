//
//  ArchiveListViewController.swift
//  CSFarming
//
//  Created by 홍성준 on 12/2/23.
//

import UIKit
import RIBs
import RxSwift
import RxCocoa
import SnapKit
import BasePresentation

protocol ArchiveListPresentableListener: AnyObject {
    func didTapClose()
    func didTap(at indexPath: IndexPath)
}

final class ArchiveListViewController: BaseViewController, ArchiveListPresentable, ArchiveListViewControllable {
    
    weak var listener: ArchiveListPresentableListener?
    
    private var models: [ArchiveListCellModel] = []
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    override func setupLayout() {
        view.addSubview(navigationView)
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func setupAttributes() {
        view.backgroundColor = .csBlue1
        
        navigationView.setup(model: .init(
            leftButtonType: .back,
            rightButtonType: .none
        ))
        
        tableView.backgroundColor = .csBlue1
        tableView.separatorStyle = .none
        tableView.register(ArchiveListCell.self)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func bind() {
        navigationView.rx.leftButtonDidTap
            .bind(to: closeBinder)
            .disposed(by: disposeBag)
        
    }
    
    private var closeBinder: Binder<Void> {
        return Binder(self) { this, _ in
            this.listener?.didTapClose()
        }
    }
    
    func updateTitle(_ title: String) {
        navigationView.updateTitle(title)
    }
    
    func updateModels(_ models: [ArchiveListCellModel]) {
        self.models = models
        tableView.reloadData()
    }
    
}

extension ArchiveListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listener?.didTap(at: indexPath)
    }
    
}

extension ArchiveListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = models[safe: indexPath.row] else {
            return UITableViewCell()
        }
        let cell = tableView.dequeue(ArchiveListCell.self, for: indexPath)
        cell.setup(model: model)
        return cell
    }
    
}
