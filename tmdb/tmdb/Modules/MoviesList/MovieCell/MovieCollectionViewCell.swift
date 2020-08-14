//
//  MovieCollectionViewCell.swift
//  tmdb
//
//  Created by mourodrigo on 8/14/20.
//  Copyright © 2020 mourodrigo. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    private var _movie: Movie?

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(movie: Movie) {
        _movie = movie
        nameLabel.text = movie.title
    }

}
