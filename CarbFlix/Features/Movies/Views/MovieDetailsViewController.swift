//
//  MovieDetailsViewController.swift
//  CarbFlix
//
//  Created by Isaac Iniongun on 04/04/2021.
//  Copyright © 2021 Isaac Iniongun. All rights reserved.
//

import UIKit
import AttributedStringBuilder

class MovieDetailsViewController: BaseViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var ratedLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var otherDetailsLabel: UILabel!
    @IBOutlet weak var backNavView: UIView!
    
    var movie: MovieDetail!
    var showAddToFavorites = true
    
    var moviesViewModel: IMoviesViewModel!
    override func getViewModel() -> BaseViewModel { moviesViewModel as! BaseViewModel }
    
    override func configureViews() {
        super.configureViews()
        
        backNavView.addPopGesture(on: self)
        
        favoriteImageView.do {
            $0.showView(showAddToFavorites)
            $0.animateViewOnTapGesture { [weak self] in
                guard let self = self else { return }
                self.moviesViewModel.addMovieToFavorites(self.movie)
            }
        }
        
        movie.do {
            posterImageView.setImageFromURL(url: $0.poster.orNA)
            titleLabel.text = $0.title
            yearLabel.text = $0.year
            ratedLabel.text = $0.rated
            runtimeLabel.text = $0.runtime
            otherDetailsLabel.attributedText = AttributedStringBuilder()
                .text("Country: \($0.country.orNA)")
                .newlines(2)
                .text("Language: \($0.language.orNA)")
                .newlines(2)
                .text("Released: \($0.released.orNA)")
                .newlines(2)
                .text("Director: \($0.director.orNA)")
                .newlines(2)
                .text("Genre: \($0.genre.orNA)")
                .newlines(2)
                .text("Writer: \($0.writer.orNA)")
                .newlines(2)
                .text("Actors: \($0.actors.orNA)")
                .newlines(2)
                .text("Plot: \($0.plot.orNA)")
                .newlines(2)
                .text("Awards: \($0.awards.orNA)")
                .newlines(2)
                .text("Ratings: \($0.ratingsText)")
                .newlines(2)
                .text("Metascore: \($0.metascore.orNA)")
                .newlines(2)
                .text("IMDB Rating: \($0.imdbRating.orNA)")
                .newlines(2)
                .text("IMDB Votes: \($0.imdbVotes.orNA)")
                .newlines(2)
                .text("IMDB ID: \($0.imdbID)")
                .newlines(2)
                .text("Type: \($0.type.orNA.capitalized)")
                .newlines(2)
                .text("Box Office: \($0.boxOffice.orNA)")
                .newlines(2)
                .text("Production: \($0.production.orNA)")
                .newlines(2)
                .text("Website: \($0.website.orNA)")
                .attributedString
        }
    }

}
