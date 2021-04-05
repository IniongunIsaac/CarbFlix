//
//  FavoriteMoviesViewController.swift
//  CarbFlix
//
//  Created by Isaac Iniongun on 04/04/2021.
//  Copyright © 2021 Isaac Iniongun. All rights reserved.
//

import UIKit

class FavoriteMoviesViewController: BaseViewController {
    
    @IBOutlet weak var favoriteMoviesCollectionView: UICollectionView!
    
    var moviesViewModel: IMoviesViewModel!
    override func getViewModel() -> BaseViewModel { moviesViewModel as! BaseViewModel }
    override var horizontalProgressBarYPosition: CGFloat { favoriteMoviesCollectionView.minY - 5 }
    
    override func configureViews() {
        super.configureViews()
        hideNavBar()
        setupFavoriteMoviesCollectionView()
        moviesViewModel.do {
            $0.emitEmptyFavoriteMovies()
            $0.getFavoriteMovies()
        }
    }
    
    fileprivate func setupFavoriteMoviesCollectionView() {
        favoriteMoviesCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        moviesViewModel.favoriteMovies.map({ $0.isEmpty }).distinctUntilChanged().bind(to: favoriteMoviesCollectionView.rx.isEmpty()).disposed(by: disposeBag)
        moviesViewModel.favoriteMovies.bind(to: favoriteMoviesCollectionView.rx.items(cellIdentifier: R.reuseIdentifier.favoriteMovieCollectionViewCell.identifier, cellType: MovieCollectionViewCell.self)) { index, item, cell in
            
            cell.configureView(movie: item.movie)
            cell.animateViewOnTapGesture { [weak self] in
                self?.showMovieDetailsViewController(movie: item, showAddToFavorites: false)
            }
            
        }.disposed(by: disposeBag)
    }

}

//MARK: - UICollectionViewDelegateFlowLayout
extension FavoriteMoviesViewController: UICollectionViewDelegateFlowLayout {
    
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
