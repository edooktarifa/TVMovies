//
//  NowPlayingMovieCell.swift
//  TVMovies
//
//  Created by Phincon on 13/06/22.
//

import UIKit
import Core

class NowPlayingMovieCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var moveToDetailScreen: ((_ responseHandler: (NowPlayingMovie) ) -> Void)?
    
    var vm: NowPlayingMovieVM!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.register(UINib(nibName: "NowPlayingMovieContentCell", bundle: nil), forCellWithReuseIdentifier: "NowPlayingMovieContentCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    func setContent(vm: NowPlayingMovieVM){
        self.vm = vm
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.numberOfTopRatedMovie
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NowPlayingMovieContentCell", for: indexPath) as? NowPlayingMovieContentCell else { return UICollectionViewCell() }
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
