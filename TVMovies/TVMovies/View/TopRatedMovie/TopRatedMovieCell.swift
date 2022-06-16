//
//  TopRatedMovieCell.swift
//  TVMovies
//
//  Created by Phincon on 13/06/22.
//

import UIKit
import Domain
import Core

class TopRatedMovieCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var collectionViews: UICollectionView!
    
    var vm: TopRateMovieVM!
    
    var moveToDetailScreen: ((_ responseHandler: (TopRateMovie) ) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionViews.register(UINib(nibName: "TopRatedMovieContentCell", bundle: nil), forCellWithReuseIdentifier: "TopRatedMovieContentCell")
        collectionViews.dataSource = self
        collectionViews.delegate = self
    }
    
    func setContent(vm: TopRateMovieVM){
        self.vm = vm
        collectionViews.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.numberOfTopRatedMovie
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopRatedMovieContentCell", for: indexPath) as? TopRatedMovieContentCell else { return UICollectionViewCell() }
        
        if let item = vm.modelForIndex(at: indexPath.row){
            cell.setContentData(data: item)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionViews.frame.width / 3, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = vm.modelForIndex(at: indexPath.row){
            moveToDetailScreen?(item)
        }
    }
}
