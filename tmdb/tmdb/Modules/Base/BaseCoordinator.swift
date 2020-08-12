//  BaseCoordinator.swift
//  tmdb

import Foundation
import UIKit
import RxSwift


enum CoordinatorPresentedMode {
	case none
	case push
	case present
}

protocol BaseCoordinatorProtocol: class {

	var identifier: String { get }
	var presentedMode: CoordinatorPresentedMode { get }

	// Default ViewController and NavigationController references
	var viewController: UIViewController { get }
	var navigationController: UINavigationController? { get }

	// Specific ViewController references
	// Override these if you need to change the viewController used for each context (Push or Present)
	var viewControllerToPush: UIViewController { get }
	var viewControllerToPresent: UIViewController { get }

	// TopMostViewController reference used to present others viewControllers (on <present> flow)
	var topMostViewController: UIViewController { get }

	// Push | Present
	func push(_ presentedCoordinator: BaseCoordinator)
	func present(_ presentedCoordinator: BaseCoordinator, presentationStyle: UIModalPresentationStyle)

	// Dismiss | Pop | PopToRoot | PopToViewController
	func dismiss(onCompletion: VoidClosure?)
	func pop()
	func popToRoot()
	func popToViewController(_ viewController: UIViewController)
}

extension BaseCoordinatorProtocol {

	//************************************************
	// MARK: - Dismiss | Pop | PopToRoot | PopToViewController
	//************************************************

	func dismiss(onCompletion: VoidClosure? = nil) {
		viewControllerToPresent.dismiss(animated: true, completion: onCompletion)
	}

	func pop() {
		navigationController?.popViewController(animated: true)
	}

	func popToRoot() {
		navigationController?.popToRootViewController(animated: true)
	}

	func popToViewController(_ viewController: UIViewController) {
		navigationController?.popToViewController(viewController, animated: true)
	}
}

class BaseCoordinator: BaseCoordinatorProtocol {

	//************************************************
	// MARK: - Properties
	//************************************************

	private var _presentedMode: CoordinatorPresentedMode = .none
	var presentedMode: CoordinatorPresentedMode { return _presentedMode }

	private var _classType: String { return String(describing: type(of: self)) }

	private var _disposeBag: DisposeBag?

	private var _presentedCoordinator: BaseCoordinator?

    var identifier = String.getUUID()

    var presentedCoordinator: BaseCoordinator? { return _presentedCoordinator }

	// Default ViewController and NavigationController references
	var viewController: UIViewController { fatalError("`viewController` property needs to be implemented by \(_classType)") }
	var navigationController: UINavigationController? { return viewController.navigationController }

	// Specific ViewController references
	// Override these if you need to change the viewController used for each context (Push or Present)
	var viewControllerToPush: UIViewController { return viewController }
	var viewControllerToPresent: UIViewController { return viewController.navigationController ?? viewController }

	// TopMostViewController reference used to present others viewControllers (on <present> flow)
	var topMostViewController: UIViewController { return viewController.navigationController?.topViewController ?? viewController }

	//************************************************
	// MARK: - Lifecycle
	//************************************************

	init() {
		print("🆕 ---> \(String(describing: type(of: self)))")
	}

	deinit {
		print("☠️ ---> \(String(describing: type(of: self)))")
	}

	//************************************************
	// MARK: - Push | Present
	//************************************************

	/// Use this to push the presentedCoordinator's viewController into navigation statck
	///
	/// This method takes care about retain and release the references of presented coordinator (and its resources) automatically.
	func push(_ presentedCoordinator: BaseCoordinator) {

		// check if navigationController is available
		guard let navigationController = self.navigationController else {
			fatalError("\(_classType) doesn't have a valid UINavigationController")
		}

		// we need to retain the presentedCoordinator's reference to avoid release it from memory
		_presentedCoordinator = presentedCoordinator
		SharedLocator.shared.appCoordinator.append(presentedCoordinator)

		// just push presentedCoordinator's viewController into navigation stack
		navigationController.pushViewController(presentedCoordinator.viewControllerToPush, animated: true)
		presentedCoordinator._presentedMode = .push

		// Now the MAGIC happens...
		//
		// We'll observe viewController's `didMoveToParentViewController` method until `parentViewController` is null.
		// This means the viewController was popped from navigation stack and we can release all references safety.
		let disposeBag = DisposeBag()
		_disposeBag = disposeBag
		presentedCoordinator.viewControllerToPush.rx
			.didMoveToParentViewController
			.subscribe(onNext: { [weak self] (parentViewController) in

				if parentViewController == nil {
					SharedLocator.shared.appCoordinator.remove(presentedCoordinator)
					self?._presentedCoordinator = nil
					self?._disposeBag = nil
				}
			})
			.disposed(by: disposeBag)
	}

	/// Use this to present the presentedCoordinator's viewController.
	///
	/// This method takes care about retain and release the references of presented coordinator (and its resources) automatically.
    func present(_ presentedCoordinator: BaseCoordinator, presentationStyle: UIModalPresentationStyle = .fullScreen) {

		// we need to retain the presentedCoordinator's reference to avoid release it from memory
		_presentedCoordinator = presentedCoordinator
		SharedLocator.shared.appCoordinator.append(presentedCoordinator)

		// just present presentedCoordinator's viewController
		presentedCoordinator.viewControllerToPresent.modalPresentationStyle = presentationStyle
		self.viewController.present(presentedCoordinator.viewControllerToPresent, animated: true)
		presentedCoordinator._presentedMode = .present

		// Now the MAGIC happens...
		//
		// We'll observe viewController's `isDismissing` property until its value is true.
		// This means the viewController was closed (dismiss) and we can release all presentedCoordinator's reference safety.
		let disposeBag = DisposeBag()
		_disposeBag = disposeBag
		presentedCoordinator.viewControllerToPresent.rx
			.dismiss
			.subscribe(onNext: { [weak self] _ in
				// foUINavigationController's dismiss is called when some kind of UIViewController is dismissed...
				// we need to check if the `presentedViewController` is one of these subtypes instance;
				// In these cases this logic will be stoped.
				// Known subtypes:
				// - UIAlertController
				// - UIActivityViewController

                let presentedViewController = presentedCoordinator.viewControllerToPresent.presentedViewController
				guard (presentedViewController is UIAlertController) == false else {
					return
				}
				SharedLocator.shared.appCoordinator.remove(presentedCoordinator)
				self?._presentedCoordinator = nil
				self?._disposeBag = nil
			})
			.disposed(by: disposeBag)
	}
}

// Equatable
extension BaseCoordinator: Equatable {

	static func == (lhs: BaseCoordinator, rhs: BaseCoordinator) -> Bool {
		return lhs.identifier == rhs.identifier
	}
}

