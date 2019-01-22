//
//  MovieDetailsScreen.swift
//  UpGradTest
//
//  Created by Verma Mukesh on 21/01/19.
//  Copyright © 2019 Mukesh Verma. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailsScreen: UITableViewController {

    @IBOutlet weak var imgMoviePoster: UIImageView!
    var objMovieInfo : Movie!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblSynopsis: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableHeaderView = UIView.init()
        setUpUI()
    }
    
    // Prepare the UI
    private func setUpUI() {
        guard let viewModel = self.objMovieInfo else { return }
        self.lblMovieTitle.text = viewModel.title ?? "Not Available"
        self.lblSynopsis.text = viewModel.overview ?? "Not Available"
        
        if let strDate = viewModel.release_date {
            
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd"
            
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "MMM dd,yyyy"
            
            if let date = dateFormatterGet.date(from: strDate) {
                print(dateFormatterPrint.string(from: date))
                self.lblReleaseDate.text = dateFormatterPrint.string(from: date)
            } else {
                self.lblReleaseDate.text = "Not Available"
            }
        }
        self.lblRating.text = "\(String(format:"%.2f", viewModel.vote_average ?? 0)) / 10"
        if let imgurl = viewModel.backdrop_path
        {
            let strImgUrl = "https://image.tmdb.org/t/p/w500" + imgurl
            imgMoviePoster.kf.indicatorType = IndicatorType.activity
            imgMoviePoster.kf.setImage(with: URL(string: strImgUrl), placeholder: UIImage(named : "whitePlaceholder"), options: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, url) in
            })
        }
    }
}

extension MovieDetailsScreen
{
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            //16 : 9 ratio
            return (self.view.frame.size.width * 9) / 16
        }
        return UITableView.automaticDimension
    }
}
