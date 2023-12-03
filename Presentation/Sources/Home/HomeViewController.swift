//
//  HomeViewController.swift
//  CSFarming
//
//  Created by 홍성준 on 11/26/23.
//

import UIKit
import RIBs
import CoreUtil
import RxSwift
import SnapKit
import DesignKit
import BasePresentation

protocol HomePresentableListener: AnyObject {
    func didSelect(at indexPath: IndexPath)
    func viewWillAppear()
}

final class HomeViewController: BaseViewController, HomePresentable, HomeViewControllable {
    
    weak var listener: HomePresentableListener?
    
    private var sections: [HomeSection] = []
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listener?.viewWillAppear()
    }
    
    override func setupAttributes() {
        view.backgroundColor = .csBlue1
        
        tableView.backgroundColor = .csBlue1
        tableView.separatorStyle = .none
        tableView.register(HomePostCell.self)
        tableView.register(HomeProblemCell.self)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func updateSections(_ sections: [HomeSection]) {
        self.sections = sections
        tableView.reloadData()
    }
    
    private func setupTabBar() {
        tabBarItem = UITabBarItem(
            title: "홈", 
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
    }
    
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listener?.didSelect(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = sections[safe: section]?.header else { return nil }
        let label: UILabel = {
            let label = UILabel()
            label.font = .headerSB
            label.textColor = .csBlack
            label.text = header
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

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[safe: section]?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = sections[safe: indexPath.section]?.items[safe: indexPath.row] else {
            return UITableViewCell()
        }
        
        switch item {
        case .recentPost(let model):
            let cell = tableView.dequeue(HomePostCell.self, for: indexPath)
            cell.setup(model: model)
            return cell
            
        case .recentProblem(let model):
            let cell = tableView.dequeue(HomeProblemCell.self, for: indexPath)
            cell.setup(model: model)
            return cell
        }
    }
    
}
