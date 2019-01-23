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
    var currentFilter : FilterType = .PopularType
    @IBOutlet weak var actMovieList: UIActivityIndicatorView!
    @IBOutlet weak var movieListCollectionView: UICollectionView!
    
    private var viewModel = MovieListViewModel()
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Adding right bar button to refresh the content

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
                self?.actMovieList.stopAnimating()
            }
        }
    }
    
    // MARK: Load Movies
    
    private func loadMovieData()
    {
        if isRefreshInProgress
        {
            return
        }
        isRefreshInProgress = true
        actMovieList.startAnimating()
        viewModel.loadMoreData()
    }
    @IBAction func btnFilterTapped(_ sender: Any) {
        
        presentFilterScreen(currentFilter)
    }
    
}

// MARK: CollectionView Delegate and DataSource

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
        
        // 9 : 16 ratio
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateToMovieDetailsWithMovieData(viewModel.tableDataSource[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == viewModel.tableDataSource.count - 1
        {
            // this is the last cell, load more data
            
            loadMovieData()
        }
    }
}

// MARK: Routing

extension MovieListScreen
{
    private func navigateToMovieDetailsWithMovieData(_ movieDetails: Movie) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "MovieDetailsScreen") as! MovieDetailsScreen
        controller.objMovieInfo = movieDetails
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func presentFilterScreen(_ filterSelected: FilterType) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "filterNavVC") as! UINavigationController
        let filterScr : FilterScreen = controller.viewControllers[0] as! FilterScreen
        filterScr.filterType = filterSelected
        filterScr.delegate = self
        self.present(controller, animated: true) {
            
        }
    }

}

extension MovieListScreen : FilterScreenDelegate
{
    func selectFilter(filter: FilterType) {
        currentFilter = filter
        self.viewModel.SortMovies(filterType: filter)
    }
}
