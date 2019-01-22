//
//  MoviePosterCell.swift
//  UpGradTest
//
//  Created by Verma Mukesh on 21/01/19.
//  Copyright © 2019 Mukesh Verma. All rights reserved.
//

import UIKit
import Kingfisher

class MoviePosterCell: ReusableCollectionViewCell {
    @IBOutlet weak var imgMoviePoster: UIImageView!
    
    var viewModel : Movie!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
    }
    
    func prepareCell(viewModel: Movie) {
        self.viewModel = viewModel
        setUpUI()
    }
    
    private func setUpUI() {
         guard let viewModel = self.viewModel else { return }
        
        if let imgurl = viewModel.poster_path
        {
            let strImgUrl = "https://image.tmdb.org/t/p/w500" + imgurl
            imgMoviePoster.kf.indicatorType = IndicatorType.activity
            imgMoviePoster.kf.setImage(with: URL(string: strImgUrl), placeholder: UIImage(named : "whitePlaceholder"), options: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, url) in
            })
        }
        
       
    }
}
