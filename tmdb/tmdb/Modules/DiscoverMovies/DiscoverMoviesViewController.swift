//  DiscoverMoviesViewController.swift
//  tmdb

import UIKit
import RxSwift
import RxCocoa
import Cartography

class DiscoverMoviesViewController: BaseViewController {
    //************************************************
    // MARK: - @IBOutlets
    //************************************************
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackViewContainer: UIStackView!

    var refreshControl = UIRefreshControl()

    //************************************************
    // MARK: - Private Properties
    //************************************************

    private weak var _viewModel: DiscoverMoviesViewModelProtocol!
    override var viewModel: BaseViewModelProtocol { return _viewModel }
    private let _disposeBag = DisposeBag()

    //************************************************
    // MARK: - Lifecycle
    //************************************************

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(viewModel: DiscoverMoviesViewModelProtocol) {
        _viewModel = viewModel
        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupOnLoad()
    }

    //************************************************
    // MARK: - Setup
    //************************************************

    private func setupOnLoad() {

        self.navigationItem.title = "TMDB"

        #if DEBUG

        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "DEBUG",
                                                                      style: .plain,
                                                                      target: self,
                                                                      action: #selector(self.debug))

        #endif

        refreshControl.attributedTitle = NSAttributedString(string: "Atualizando...")
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        scrollView.refreshControl = refreshControl


        _viewModel.state.bind { (viewModelState) in
            switch viewModelState {
            case .new(genreList: let list):
                self.stackViewContainer.addArrangedSubview(list.viewController.view)
                Cartography.constrain(list.viewController.view, self.view) { (listView, container) in
                    listView.height == 220 //container size for movies
                }
                self.refreshControl.endRefreshing()
            case .loading:
                DispatchQueue.main.async {
                    self.refreshControl.beginRefreshing()
                }
            case .error(error: let error):
                print("VIEW MODEL ERROR \(error)")
            }
        }.disposed(by: _disposeBag)

    }

    @objc private func refresh() {
        for subView in stackViewContainer.subviews {
            stackViewContainer.removeArrangedSubview(subView)
        }
        _viewModel.handleReload()
    }

    #if DEBUG
    @objc private func debug() {

        let alert = UIAlertController(title: "DEBUG ONLY", message: "Ação disponível apenas em ambiente debug. Conheça o desenvolvedor!", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction.init(title: "Claro!", style: .default, handler: { (_ ) in
            self._viewModel.handleDebugMenu()
        }))

        alert.addAction(UIAlertAction.init(title: "Naah..", style: .cancel, handler: { (_ ) in
        }))

        self.present(alert, animated: true, completion: nil)
    }
    #endif
}
