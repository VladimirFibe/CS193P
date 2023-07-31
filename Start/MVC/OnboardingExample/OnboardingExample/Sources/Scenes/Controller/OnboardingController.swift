import UIKit

class OnboardingController: UIViewController {
    var model: OnboardingModel?
    /// Это вычисляемое свойство преобразует тип родительской view в Onboarding View
    /// Это делается чтобы мы в будущем могли из Controller'a обращаться к элементам View
    private var onboardingView: OnboardingView? {
        guard isViewLoaded else { return nil }
        return view as? OnboardingView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view = OnboardingView()
        model = OnboardingModel()
        configure()
    }
}

extension OnboardingController {
    func configure() {
        guard let models = model?.createModels() else { return }
        models.forEach { [unowned self] model in
            onboardingView?.configure(with: model)
        }
    }
}
