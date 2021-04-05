//
//  Movies.swift
//  CarbFlix
//
//  Created by Isaac Iniongun on 04/04/2021.
//  Copyright © 2021 Isaac Iniongun. All rights reserved.
//

import UIKit

class MoviesViewController: BaseViewController {
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    var moviesViewModel: IMoviesViewModel!
    override func getViewModel() -> BaseViewModel { moviesViewModel as! BaseViewModel }
    override var horizontalProgressBarYPosition: CGFloat { moviesCollectionView.minY - 10 }
    
    override func configureViews() {
        super.configureViews()
        hideNavBar()
        setupMoviesCollectionView()
        moviesViewModel.do {
            $0.emitEmptyMovies()
            $0.getMovies()
        }
    }
    
    fileprivate func setupMoviesCollectionView() {
        moviesCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        moviesViewModel.movies.map({ $0.isEmpty }).distinctUntilChanged().bind(to: moviesCollectionView.rx.isEmpty()).disposed(by: disposeBag)
        moviesViewModel.movies.bind(to: moviesCollectionView.rx.items(cellIdentifier: R.reuseIdentifier.movieCollectionViewCell.identifier, cellType: MovieCollectionViewCell.self)) { index, item, cell in
            
            cell.configureView(movie: item)
            cell.animateViewOnTapGesture { [weak self] in
                self?.moviesViewModel.getMovieDetails(item.imdbID)
            }
            
        }.disposed(by: disposeBag)
    }
    
    override func showLoading() {
        super.showLoading()
        moviesCollectionView.disableUserInteraction()
    }
    
    override func hideLoading() {
        super.hideLoading()
        moviesCollectionView.enableUserInteraction()
    }
    
    override func setChildViewControllerObservers() {
        super.setChildViewControllerObservers()
        observeMovie()
    }
    
    fileprivate func observeMovie() {
        moviesViewModel.movie.bind { [weak self] movie in
            self?.showMovieDetailsViewController(movie: movie)
        }.disposed(by: disposeBag)
    }

}

//MARK: - UICollectionViewDelegateFlowLayout
extension MoviesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.width / 2) - 10, height: 324)
    }
    
}
