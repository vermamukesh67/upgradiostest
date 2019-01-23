//
//  MovieListViewModel.swift
//  UpGradTest
//
//  Created by Mukesh Verma on 22/01/19.
//  Copyright © 2019 Mukesh Verma. All rights reserved.
//

import Foundation

class MovieListViewModel
{
    /// Data source for the home page table view.
    var tableDataSource: [Movie] = [Movie]()
    private var pageNumber : Int = 1
    private var totalPages : Int = 1
    private var selectedMovietype : MovieType   = .Popular
    private var selectedFilterType : FilterType   = .PopularType
    // MARK: Input
    var viewDidLoad: ()->() = {}
    
    // MARK: Events
    
    var reloadTable: ()->() = { }
    
    // MARK: Output
    var numberOfRows = 0
    
    init() {
        viewDidLoad = { [weak self] in
            self?.selectedFilterType = .PopularType
            self?.getMovieData(completion: {
                self?.SortMovies(filterType: self?.selectedFilterType ?? .PopularType)
            })
        }
    }
    
    /// Method call to inform the view model to refresh the data.
    func refreshScreen() {
        tableDataSource.removeAll()
        self.getMovieData(completion: { [weak self] in
           self?.SortMovies(filterType: self?.selectedFilterType ?? .PopularType)
        })
    }
    
    // Method to prepare the array based on filters
    func SortMovies(filterType : FilterType) {
        
        selectedFilterType = filterType
        prepareTableDataSource()
        reloadTable()
    }
    
    /// Method call to inform the view model to refresh the data.
    func loadMoreData() {
        
        if shouldLoadMoreData (totalPage: self.totalPages, totalPageLoaded: self.pageNumber)
        {
            self.getMovieData(completion: { [weak self] in
                self?.SortMovies(filterType: self?.selectedFilterType ?? .PopularType)
            })
        }
    }
    
    // Condition to check load more data
    func shouldLoadMoreData(totalPage : Int, totalPageLoaded : Int) -> Bool {
        return ( totalPage >= totalPageLoaded )
    }
    
    // Get movie data from api
    private func getMovieData(completion: @escaping ()->()) {
        
        MovieWebService().getPopularMovieList(pageNum: pageNumber) { (movieObject, error) in
            self.tableDataSource += movieObject?.results ?? self.tableDataSource
            self.pageNumber += 1
            self.totalPages = movieObject?.total_pages ?? 1
            completion()
        }
        
    }
    
    /// Prepare the tableDataSource
    private func prepareTableDataSource() {
        numberOfRows = tableDataSource.count
        
        switch selectedFilterType {
        case .PopularType:
            tableDataSource = tableDataSource.sorted(by: { $0.popularity! > $1.popularity! })
            break
        case .HighRatedType:
            tableDataSource = tableDataSource.sorted(by: { $0.vote_average! > $1.vote_average! })

            break
        }
    }
}
