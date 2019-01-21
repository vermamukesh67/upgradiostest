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
    
    @IBOutlet weak var actMovieList: UIActivityIndicatorView!
    @IBOutlet weak var movieListCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch UIDevice.current.screenType {
        case .iPhones_5_5s_5c_SE:
            equalSpace = 20
        default:
            equalSpace = 40
        }
        MoviePosterCell.registerWithCollectionView(self.movieListCollectionView)
    }
}

extension MovieListScreen : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviePosterCell", for: indexPath)
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

extension MovieListScreen
{
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == ""
        {
            
        }
    }
}
