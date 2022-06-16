//
//  SearchMovieViewController.swift
//  TVMovies
//
//  Created by Phincon on 15/06/22.
//

import UIKit
import RxSwift
import Core

class SearchMovieViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController()
    
    var vmPopulerMovie: PopulerMovieVM!
    var disposeBag = DisposeBag()
    
    var searchList = [PopulerMovie]()
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupView()
    }
    
    func setupView() {
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
            self.tableView.tableHeaderView = searchController.searchBar
        }
        
        searchController.searchBar.delegate = self
        searchController.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.searchTextField.textColor = .white
        navigationItem.hidesSearchBarWhenScrolling = false
        self.title = "Search Game"
        
        vmPopulerMovie = PopulerMovieInjection.shared.container.resolve(PopulerMovieVM.self)!
        
        tableView.register(UINib(nibName: "SearchMovieCell", bundle: nil), forCellReuseIdentifier: "SearchMovieCell")
        tableView.dataSource = self
        tableView.delegate = self
        fetchVM()
        vmPopulerMovie.getListPopulerMovie()
    }
    
    func fetchVM(){
        vmPopulerMovie.getListPopulerMovieData.drive(onNext: {
            [unowned self] nowPlayingMovie in
            
            self.tableView.reloadData()
            
        }).disposed(by: disposeBag)
    }
    
}

extension SearchMovieViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchList.count
        }else {
            return vmPopulerMovie.numberOfTopPopulerMovie
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchMovieCell", for: indexPath) as? SearchMovieCell else { return UITableViewCell() }
        
        if searching{
                cell.setContentData(data: searchList[indexPath.row])
        } else {
            if let item = vmPopulerMovie.modelForIndex(at: indexPath.row){
                cell.setContentData(data: item)
            }
        }
        
        return cell
    }
    
}

extension SearchMovieViewController: UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {}
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchController.searchBar.searchTextField.textColor = .black
        
        searchList = searchText.isEmpty ? vmPopulerMovie.searchIndex(): vmPopulerMovie.searchIndex().filter{ $0.populerMovieTitle?.range(of: searchText, options: .caseInsensitive) != nil }
        
        searchList.removeDuplicates()
        
        searching = true
        tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searching{
            self.moveToDetail(data: searchList[indexPath.row])
        }else{
            if let item = vmPopulerMovie.modelForIndex(at: indexPath.row){
                self.moveToDetail(data: item)
            }
        }
    }
    
    func moveToDetail(data: PopulerMovie){
        let vc = DetailMovieViewController()
        vc.populerMovie = data
        vc.typeMovie = .populerMovie
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
