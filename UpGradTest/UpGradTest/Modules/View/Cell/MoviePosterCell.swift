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
    
    private func setUpUI() {
        imgMoviePoster.kf.indicatorType = IndicatorType.activity
        imgMoviePoster.kf.setImage(with: URL(string: ""), placeholder: UIImage(named : "whitePlaceholder"), options: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, url) in
        })
    }
}
