//  MoviesListCollectionViewController.swift
//  tmdb

import UIKit

private let reuseIdentifier = "MovieCollectionViewCell"

import UIKit
import RxSwift
import RxCocoa

class MoviesListCollectionViewController: BaseViewController {
    //************************************************
    // MARK: - @IBOutlets
    //************************************************
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var genreLabel: UILabel!

    //************************************************
    // MARK: - Private Properties
    //************************************************

    private weak var _viewModel: MoviesListCollectionViewModelProtocol!
    override var viewModel: BaseViewModelProtocol { return _viewModel }
    private let _disposeBag = DisposeBag()

    //************************************************
    // MARK: - Lifecycle
    //************************************************

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(viewModel: MoviesListCollectionViewModelProtocol) {
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
        // Register cell classes
        collectionView.registerCell(MovieCollectionViewCell.self)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

        _viewModel.status.bind { (status) in
            DispatchQueue.main.async {
                switch status {
                case .ready:
                    self.collectionView.reloadData()
                case .loading:
                    break // todo loading
                case .error(error: _):
                    //removes itself if having an error to load
                    self.view.removeFromSuperview()
                }
            }
        }.disposed(by: _disposeBag)

        self.genreLabel.text = "" //default value
        _viewModel.genreText.bind { (text) in
            self.genreLabel.text = text
        }.disposed(by: _disposeBag)
    }

}

extension MoviesListCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _viewModel.numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                            for: indexPath) as? MovieCollectionViewCell
            else { fatalError("Error while dequeueReusableCell on \(String(describing: self))")}

        let movie = _viewModel.item(for: indexPath.row)

        cell.setup(movie: movie)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        _viewModel.didSelectItem(at: indexPath.row)
    }

}
