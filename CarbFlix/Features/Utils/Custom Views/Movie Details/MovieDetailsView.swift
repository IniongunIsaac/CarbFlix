//
//  MovieDetailsView.swift
//  CarbFlix
//
//  Created by Isaac Iniongun on 04/04/2021.
//  Copyright © 2021 Isaac Iniongun. All rights reserved.
//

import UIKit

class MovieDetailsView: BaseView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    
    override var kContentView: UIView { contentView }
    override var nibName: String { R.nib.movieDetailsView.name }
    
    func configureView(movie: MovieSearch) {
        posterImageView.roundCorners([.topLeft, .topRight], radius: 5)
        movie.do {
            posterImageView.setImageFromURL(url: $0.poster)
            titleLabel.text = $0.title
            directorLabel.text = $0.type.capitalized
            yearLabel.text = $0.year
        }
    }
}
