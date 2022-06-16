//
//  UpcomingMovieCell.swift
//  TVMovies
//
//  Created by Phincon on 13/06/22.
//

import UIKit
import Core

class UpcomingMovieCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var vm: UpComingMovieVM!
    
    var moveToDetailScreen: ((_ responseHandler: (UpcomingMovie) ) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.register(UINib(nibName: "UpComingMovieContentCell", bundle: nil), forCellWithReuseIdentifier: "UpComingMovieContentCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    func setContent(vm: UpComingMovieVM){
        self.vm = vm
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.numberOfTopRatedMovie
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpComingMovieContentCell", for: indexPath) as? UpComingMovieContentCell else { return UICollectionViewCell() }
        if let item = vm.modelForIndex(at: indexPath.row){
            cell.setContentData(data: item)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = vm.modelForIndex(at: indexPath.row){
            moveToDetailScreen?(item)
        }
    }
}
