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
    // MARK: Input
    var viewDidLoad: ()->() = {}
    
    // MARK: Events
    
    var reloadTable: ()->() = { }
    
    // MARK: Output
    var numberOfRows = 0
    
    init() {
        viewDidLoad = { [weak self] in
            
            self?.getMovieData(completion: {
                self?.prepareTableDataSource()
                self?.reloadTable()
            })
        }
    }
    
    /// Method call to inform the view model to refresh the data.
    func refreshScreen() {
        tableDataSource.removeAll()
        self.getMovieData(completion: { [weak self] in
            
            self?.prepareTableDataSource()
            self?.reloadTable()
        })
    }
    
    /// Method call to inform the view model to refresh the data.
    func loadMoreData() {
        
        if totalPages >= self.pageNumber
        {
            self.getMovieData(completion: { [weak self] in
                self?.prepareTableDataSource()
                self?.reloadTable()
            })
        }
    }
    
    private func getMovieData(completion: @escaping ()->()) {
        
        MovieWebService().getPopularMovieList(movieType: selectedMovietype, pageNum: pageNumber) { (movieObject, error) in
            self.tableDataSource += movieObject?.results ?? self.tableDataSource
            self.pageNumber += 1
            self.totalPages = movieObject?.total_pages ?? 1
            completion()
        }
        
    }
    
    /// Prepare the tableDataSource
    private func prepareTableDataSource() {
        numberOfRows = tableDataSource.count
    }
    
}
