//  BaseViewController.swift
//  tmdb


import UIKit
import RxSwift

//************************************************
// MARK: - Protocol + Default Values
//************************************************

protocol BaseViewControllerProtocol {}

//************************************************
// MARK: - Base UIViewController
//************************************************

class BaseViewController: UIViewController, BaseViewControllerProtocol {

    //************************************************
    // MARK: - Properties
    //************************************************

    private let _disposeBag = DisposeBag()

    var navigationBarLargeTitleDisplayMode: UINavigationItem.LargeTitleDisplayMode {
        // default value... if any descendant class needs another value this method must be override
        return .never
    }

    var viewModel: BaseViewModelProtocol { fatalError("\(String(describing: type(of: self))) must override viewModel property.") }

    //************************************************
    // MARK: - Lifecycle
    //************************************************

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(nibName: String? = nil) {
        super.init(nibName: nibName, bundle: nil)
        print("🆕 ---> \(String(describing: type(of: self)))")
    }

    deinit {
        print("☠️ ---> \(String(describing: type(of: self)))")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.largeTitleDisplayMode = self.navigationBarLargeTitleDisplayMode
        self.bindViewState()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    //************************************************
    // MARK: - Bind ViewState (Loading/Normal)
    //************************************************

    func bindViewState() {
        viewModel.isLoading.drive(
            onNext: { [weak self] (value) in
                if value {
                    self?.showLoading()
                } else {
                    self?.hideLoading()
                }
            }
        ).disposed(by: _disposeBag)
    }

    //************************************************
    // MARK: - Loading/Activity
    //************************************************

    func showLoading(text: String? = nil) {
        let parent = self.navigationController ?? self
        LoadingView.show(on: parent.view)
    }

    func hideLoading() {
        LoadingView.hide()
    }

}

//************************************************
// MARK: - Base UITabBarController
//************************************************

class BaseTabBarController: UITabBarController, BaseViewControllerProtocol {

    //************************************************
    // MARK: - Lifecycle
    //************************************************

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(nibName: String? = nil) {
        super.init(nibName: nibName, bundle: nil)

        let identifier = String(describing: type(of: self))
        print("init 🆕 ---> \(identifier)")
    }

    deinit {
        let identifier = String(describing: type(of: self))
        print("deinit ☠️ ---> \(identifier)")
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
