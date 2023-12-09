//
//  QuestionInteractor.swift
//  CSFarming
//
//  Created by 홍성준 on 12/9/23.
//

import RIBs
import RxSwift
import QuestionInterface
import QuestionService

protocol QuestionRouting: ViewableRouting {}

protocol QuestionPresentable: Presentable {
    var listener: QuestionPresentableListener? { get set }
}

protocol QuestionInteractorDependency: AnyObject {
    var directory: String { get }
    var questionService: QuestionServiceInterface { get }
}

final class QuestionInteractor: PresentableInteractor<QuestionPresentable>, QuestionInteractable, QuestionPresentableListener {
    
    weak var router: QuestionRouting?
    weak var listener: QuestionListener?
    
    private let dependency: QuestionInteractorDependency
    private let disposeBag = DisposeBag()
    
    init(
        presenter: QuestionPresentable,
        dependency: QuestionInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        fetchQuestionList()
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    func didTapClose() {
        listener?.questionDidTapClose()
    }
    
    private func fetchQuestionList() {
        dependency.questionService
            .requestQuestions(directory: dependency.directory)
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(
                with: self,
                onSuccess: { this, list in
                    print(list)
                },
                onFailure: { this, error in
                    print(error.localizedDescription)
                }
            )
            .disposed(by: disposeBag)
    }
    
}
