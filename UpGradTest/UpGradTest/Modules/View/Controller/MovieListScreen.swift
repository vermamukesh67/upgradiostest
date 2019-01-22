//
//  MovieListScreen.swift
//  UpGradTest
//
//  Created by Verma Mukesh on 21/01/19.
//  Copyright © 2019 Mukesh Verma. All rights reserved.
//

import UIKit

class MovieListScreen: UIViewController {
    
    var equalSpace  = 40
    var isRefreshInProgress = false
    
    @IBOutlet weak var actMovieList: UIActivityIndicatorView!
    @IBOutlet weak var movieListCollectionView: UICollectionView!
    
    private var viewModel = MovieListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareTableView()
        self.observeEvents()
        self.loadMovieData()
    }
    
    /// Prepare the table view.
    private func prepareTableView() {
        switch UIDevice.current.screenType {
        case .iPhones_5_5s_5c_SE:
            equalSpace = 20
        default:
            equalSpace = 40
        }
        MoviePosterCell.registerWithCollectionView(self.movieListCollectionView)
    }
    
    /// Function to observe various event call backs from the viewmodel as well as Notifications.
    private func observeEvents() {
        viewModel.reloadTable = { [weak self] in
            DispatchQueue.main.async {
                self?.movieListCollectionView.reloadData()
                self?.isRefreshInProgress = false
                
            }
        }
        
        viewModel.movieSelected = { [weak self] movie in
            DispatchQueue.main.async {
                self?.navigateToMovieDetailsWithMovieData(movie)
            }
        }
        
    }
    
    private func loadMovieData()
    {
        viewModel.refreshScreen()
    }

}

extension MovieListScreen : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.tableDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviePosterCell", for: indexPath) as! MoviePosterCell
        cell.prepareCell(viewModel: viewModel.tableDataSource[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // 16 : 9 ratio
        let width = Int (self.view.frame.size.width / 2 ) as Int - ( self.equalSpace * 2)
        let height = (width * 16) / 9
        return CGSize(width: width, height: height - (( self.equalSpace)))
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        let value = CGFloat(self.equalSpace)
        
        return UIEdgeInsets.init(top: value, left: value, bottom: value, right: value)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return CGFloat(self.equalSpace)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return CGFloat(self.equalSpace)
    }
    
}

// MARK: Routing

extension MovieListScreen
{
    private func navigateToMovieDetailsWithMovieData(_ movieDetails: Movie) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "MovieDetailsScreen") as! MovieDetailsScreen
//        controller.prepareView(viewModel: placeViewVM)
        navigationController?.pushViewController(controller, animated: true)
    }
}
