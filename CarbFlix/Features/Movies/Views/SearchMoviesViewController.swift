//
//  SearchMoviesViewController.swift
//  CarbFlix
//
//  Created by Isaac Iniongun on 04/04/2021.
//  Copyright © 2021 Isaac Iniongun. All rights reserved.
//

import UIKit
import RxSwift

class SearchMoviesViewController: BaseViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchMoviesCollectionView: UICollectionView!
    
    var moviesViewModel: IMoviesViewModel!
    override func getViewModel() -> BaseViewModel { moviesViewModel as! BaseViewModel }
    override var horizontalProgressBarYPosition: CGFloat { searchBar.maxY }
    
    override func configureViews() {
        super.configureViews()
        hideNavBar()
        setupSearchMoviesCollectionView()
        moviesViewModel.do {
            $0.emitEmptyMovies()
        }
        configureSearchBar()
    }
    
    fileprivate func setupSearchMoviesCollectionView() {
        searchMoviesCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        moviesViewModel.movies.map({ $0.isEmpty }).distinctUntilChanged().bind(to: searchMoviesCollectionView.rx.isEmpty(message: "Search results will appear here!")).disposed(by: disposeBag)
        moviesViewModel.movies.bind(to: searchMoviesCollectionView.rx.items(cellIdentifier: R.reuseIdentifier.searchMovieCollectionViewCell.identifier, cellType: MovieCollectionViewCell.self)) { index, item, cell in
            
            cell.configureView(movie: item)
            cell.animateViewOnTapGesture { [weak self] in
                self?.moviesViewModel.getMovieDetails(item.imdbID)
            }
            
        }.disposed(by: disposeBag)
    }
    
    fileprivate func configureSearchBar() {
        searchBar.configure()
        searchBar.rx.text.orEmpty
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] text in
                if text.count >= 3 {
                    self?.moviesViewModel.searchMovies(using: text)
                }
            }).disposed(by: disposeBag)
    }
    
    override func showLoading() {
        super.showLoading()
        searchMoviesCollectionView.disableUserInteraction()
    }
    
    override func hideLoading() {
        super.hideLoading()
        searchMoviesCollectionView.enableUserInteraction()
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
extension SearchMoviesViewController: UICollectionViewDelegateFlowLayout {
    
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
