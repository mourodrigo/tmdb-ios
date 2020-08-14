//  MovieCollectionViewCell.swift
//  tmdb

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    private var _movie: Movie?

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    let imageRepository = SharedLocator.shared.imageRepository

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(movie: Movie) {
        _movie = movie
        nameLabel.text = movie.title
        guard   let posterPath = SharedLocator.shared.configurationRepository.posterPath(),
                let url = URL(string: "\(posterPath)/\(movie.posterPath)")
                else { return }

        imageRepository.getImage(for: url, onSuccess: { [weak self] (image, resolvedURL) in
            if url == resolvedURL {
                self?.imageView.image = image
            }
        }) { (error) in
            print("Could not find image on \(url)")
        }

    }

}
