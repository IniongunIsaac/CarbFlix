//
//  MovieCollectionViewCell.swift
//  CarbFlix
//
//  Created by Isaac Iniongun on 04/04/2021.
//  Copyright © 2021 Isaac Iniongun. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieDetailsView: MovieDetailsView!
    
    func configureView(movie: MovieSearch) {
        movieDetailsView.do {
            $0.addClearBackground()
            $0.configureView(movie: movie)
        }
    }
}
