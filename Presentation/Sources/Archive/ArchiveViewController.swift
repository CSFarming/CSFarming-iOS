//
//  ArchiveViewController.swift
//  CSFarming
//
//  Created by 홍성준 on 12/3/23.
//

import RIBs
import RxSwift
import UIKit
import CoreUtil
import SnapKit
import DesignKit
import BasePresentation

protocol ArchivePresentableListener: AnyObject {
    func didSelect(at indexPath: IndexPath)
}

final class ArchiveViewController: BaseViewController, ArchivePresentable, ArchiveViewControllable {
    
    weak var listener: ArchivePresentableListener?
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    private var models: [ArchiveCellModel] = []
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupTabBar()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTabBar()
    }
    
    override func setupLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func setupAttributes() {
        view.backgroundColor = .csBlue1
        
        tableView.backgroundColor = .csBlue1
        tableView.separatorStyle = .none
        tableView.register(ArchiveCell.self)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupTabBar() {
        tabBarItem = UITabBarItem(
            title: "학습",
            image: UIImage(systemName: "folder"),
            selectedImage: UIImage(systemName: "folder.fill")
        )
    }
    
    func updateModels(_ models: [ArchiveCellModel]) {
        self.models = models
        tableView.reloadData()
    }
    
}

extension ArchiveViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listener?.didSelect(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label: UILabel = {
            let label = UILabel()
            label.font = .headerSB
            label.textColor = .csBlack
            label.text = "디렉토리"
            return label
        }()
        
        let containerView: UIView = {
            let containerView = UIView()
            containerView.backgroundColor = .csBlue1
            containerView.addSubview(label)
            return containerView
        }()

        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
        return containerView
    }
    
}

extension ArchiveViewController: UITableViewDataSource {
    
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
        let cell = tableView.dequeue(ArchiveCell.self, for: indexPath)
        cell.setup(model: model)
        return cell
    }
    
}
