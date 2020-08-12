//  AppCoordinator.swift
//  tmdb

import Foundation
import UIKit

protocol AppCoordinatorProtocol {
    var topMostCoordinator: BaseCoordinator? { get }
    var topMostViewController: UIViewController? { get }

	func append(_ coordinator: BaseCoordinator)
	func remove(_ coordinator: BaseCoordinator)
    func removeLast()

	func presentViewController(_ viewController: UIViewController)
}

class AppCoordinator: AppCoordinatorProtocol {

	//*************************************************
	// MARK: - Init Life cycle
	//*************************************************

	init(rootCoordinator: BaseCoordinator) {
		self.append(rootCoordinator)
	}

	//*************************************************
	// MARK: - Coordinators
	//*************************************************

    var topMostCoordinator: BaseCoordinator? {
        return _coordinators.last
    }

	private var _coordinators: [BaseCoordinator] = []

	func append(_ coordinator: BaseCoordinator) {
		_coordinators.append(coordinator)
	}
	func remove(_ coordinator: BaseCoordinator) {
		_coordinators.removeAll { (coord) -> Bool in return coordinator.identifier ==  coord.identifier }
	}

    func removeLast() {
		guard _coordinators.isEmpty == false else { return }
		_coordinators.removeLast()
	}

	//*************************************************
	// MARK: - ViewControllers
	//*************************************************

	var topMostViewController: UIViewController? {
		return topMostCoordinator?.topMostViewController
	}

	//*************************************************
	// MARK: - Navigation
	//*************************************************

	func presentViewController(_ viewController: UIViewController) {
		topMostViewController?.present(viewController, animated: true)
	}

}
