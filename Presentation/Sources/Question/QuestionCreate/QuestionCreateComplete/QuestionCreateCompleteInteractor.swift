//
//  QuestionCreateCompleteInteractor.swift
//  CSFarming
//
//  Created by 홍성준 on 12/18/23.
//

import RIBs
import RxSwift
import QuestionService

protocol QuestionCreateCompleteRouting: ViewableRouting {}

protocol QuestionCreateCompletePresentable: Presentable {
    var listener: QuestionCreateCompletePresentableListener? { get set }
    func setup(title: String, subtitle: String, questions: [Question])
}

protocol QuestionCreateCompleteListener: AnyObject {
    func questionCreateCompleteDidTapClose()
    func questionCreateCompleteDidFinish()
}

protocol QuestionCreateCompleteInteractorDependency: AnyObject {
    var title: String { get }
    var subtitle: String { get }
    var category: String { get }
    var questions: [Question] { get }
    var questionService: QuestionServiceInterface { get }
}

final class QuestionCreateCompleteInteractor: PresentableInteractor<QuestionCreateCompletePresentable>, QuestionCreateCompleteInteractable, QuestionCreateCompletePresentableListener {
    
    weak var router: QuestionCreateCompleteRouting?
    weak var listener: QuestionCreateCompleteListener?
    
    private let dependency: QuestionCreateCompleteInteractorDependency
    private let disposeBag = DisposeBag()
    
    init(
        presenter: QuestionCreateCompletePresentable,
        dependency: QuestionCreateCompleteInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        presenter.setup(title: dependency.title, subtitle: dependency.subtitle, questions: dependency.questions)
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    func didTapClose() {
        listener?.questionCreateCompleteDidTapClose()
    }
    
    func didTapCreate() {
        dependency.questionService
            .insertQuestion(element: .init(
                title: dependency.title,
                subtitle: dependency.subtitle,
                category: dependency.category,
                questions: dependency.questions
            ))
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(
                with: self,
                onSuccess: { this, _ in
                    this.listener?.questionCreateCompleteDidFinish()
                },
                onFailure: { this, error in
                    dump("# ERROR: \(error.localizedDescription)")
                }
            )
            .disposed(by: disposeBag)
    }
    
    func didTapShare() {
        
    }
    
}
