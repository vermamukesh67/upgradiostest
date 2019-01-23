//
//  FilterScreen.swift
//  UpGradTest
//
//  Created by Mukesh Verma on 23/01/19.
//  Copyright © 2019 Mukesh Verma. All rights reserved.
//

import UIKit

enum FilterType : Int {
    case PopularType = 0
    case HighRatedType
}


protocol FilterScreenDelegate : class {
    func selectFilter (filter : FilterType)
}


class FilterScreen: UIViewController {
    
    let arrFilters = ["Popularity", "Highest Rated"]
    var filterType : FilterType = .PopularType
    weak var delegate : FilterScreenDelegate?

    // MARK: View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: UIBarButton Events
    
    @IBAction func btnCancelTapped(_ sender: Any) {
        self.dismiss(animated: true) {
        }
    }
    
    @IBAction func btnDoneTapped(_ sender: Any) {
        delegate?.selectFilter(filter: filterType)
        self.dismiss(animated: true) {
            
        }
    }
}

// MARK: UITableView Delegate and DataSource

extension FilterScreen : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFilters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "sortCell")
        cell.textLabel?.text = arrFilters[indexPath.row]
        print(filterType.rawValue)
        if filterType.rawValue == indexPath.row
        {
            cell.accessoryType = .checkmark
        }
        else
        {
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        filterType = FilterType(rawValue: indexPath.row) ?? .PopularType
        tableView.reloadData()
    }
}

