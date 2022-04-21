//
//  MovieListViewController.swift
//  DN_Homework_3
//
//  Created by Consultant on 16/01/1401 AP.
//

import UIKit
import Combine
import CoreData

protocol MovieListVCProtocol: AnyObject {
    var viewModel : MovieListViewModelProtocol? {get set}
}

class MovieListVC: UIViewController, MovieListVCProtocol {
    
    internal var viewModel : MovieListViewModelProtocol?
    private var subcribers = Set<AnyCancellable>()
    var userName: String?
    //private var movies = [Movie]()
    private var favouriteMovies = [Movie]()
    
    
    
    private lazy var refreshAction: UIAction = UIAction { [weak self] _ in
        self?.refresh()
    }
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl(frame: .zero, primaryAction: refreshAction)
        
        return refresh
    }()
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textAlignment = .left
        //nameLabel.backgroundColor = .red
        nameLabel.text = "Hello, \(UserDefaults.standard.string(forKey: "userName") ?? "User name")"
        nameLabel.font = nameLabel.font.withSize(22)
        
        return nameLabel
    } ()
    
    lazy var segmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["Movies List","Favorites"])
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.selectedSegmentIndex = 0
        segmentControl.layer.cornerRadius = 9
        segmentControl.layer.masksToBounds = true
        
        segmentControl.addTarget(self, action: #selector(segmentAction(_:)), for: .valueChanged)
        return segmentControl
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.layer.cornerRadius = 9
        searchBar.layer.masksToBounds = true
        
        return searchBar
    }()
   
    private lazy var movieListView: UITableView = {
        let movieListView = UITableView()
        movieListView.translatesAutoresizingMaskIntoConstraints = false
        movieListView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.indentifier)
        movieListView.backgroundColor = .lightGray
        movieListView.dataSource = self
        movieListView.delegate = self
        movieListView.prefetchDataSource = self
        movieListView.addSubview(refreshControl)
        
        return movieListView
    }()
    
    private lazy var logOutButton: UIButton = {
        let logOutButton = UIButton(frame: .zero, primaryAction: logOutAction)
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        logOutButton.setTitle("Log Out", for: .normal)
        logOutButton.setTitleColor(.red, for: .normal)
        logOutButton.backgroundColor = .white
        
        
        return logOutButton
    }()
    private lazy var logOutAction:UIAction = UIAction { [weak self] _ in
        self?.logOut()
        self?.goToViewController()
    }
    private func logOut() {
        UserDefaults.standard.removeObject(forKey: "userName")
    }
    private func goToViewController(){
        let destination = ViewController()
        navigationController?.pushViewController(destination, animated: true)
        //present(destination, animated: true, completion: nil)
    }
    
    @objc private func segmentAction(_ sender: UISegmentedControl){
        switch sender.selectedSegmentIndex{
        case 0:
            viewModel?.getMovies()
        case 1:
            viewModel?.getFavourite()
        default:
            break
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        MovieListViewControllerConfigurator.assemblingMVVM(view: self)
        setUpUI()
        setUpBinding()
        
    }
    private func loadFavourites() {
        
        MovieListViewControllerConfigurator.assemblingMVVM(view: self)
        setUpUI()
        favouriteMovies = (viewModel?.getFavourite())!
        DispatchQueue.main.async {
            self.movieListView.reloadData()
        }
    }
    private func refresh(){
        viewModel?.forceUpdate()
    }
    
    private func setUpBinding() {
        viewModel?
            .publisherMovies
            .sink(receiveValue: { [weak self] _ in
                DispatchQueue.main.async {
                    self?.movieListView.reloadData()
                    self?.refreshControl.endRefreshing()
                }
            })
            .store(in: &subcribers)
        
        viewModel?
            .publisherCache
            .sink(receiveValue: { [weak self] _ in
                DispatchQueue.main.async {
                    self?.movieListView.reloadData()
                }
            })
            .store(in: &subcribers)
        viewModel?.getMovies()
    }

    private func setUpUI(){
        view.addSubview(nameLabel)
        view.addSubview(segmentControl)
        view.addSubview(searchBar)
        view.addSubview(movieListView)
        view.addSubview(logOutButton)
        
        
        let safeArea = view.safeAreaLayoutGuide
        
        nameLabel.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: safeArea.topAnchor, constant: 40).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        
        segmentControl.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        segmentControl.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        segmentControl.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        
        searchBar.topAnchor.constraint(equalTo: segmentControl.bottomAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        
        movieListView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        movieListView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        movieListView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        movieListView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -40).isActive = true
        
        logOutButton.topAnchor.constraint(equalTo: movieListView.bottomAnchor).isActive = true
        logOutButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        logOutButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        logOutButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        
    }


}
extension MovieListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("movies count: \(viewModel?.totalRows)")
        return viewModel?.totalRows ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.indentifier, for: indexPath) as! MovieCell
        
        let row = indexPath.row
        
        cell.showDetailButton.tag = indexPath.row
        cell.showDetailButton.addTarget(self, action: #selector(showDetail(sender: )), for: .touchUpInside)
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.white.cgColor
        
        let title = viewModel?.getTitle(by: row)
        let overView = viewModel?.getOverview(by: row)
        let data = viewModel?.getImageData(by: row)
        //print(data)
        
        
        cell.configureMovieCell( title: title, overview: overView, imageData: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 150
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let movieId = viewModel?.getMovieId(by: row)
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
            viewModel?.removeFavourite(by: movieId!)
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
            viewModel?.saveFavourite(by: row)
        }
    }
    
    
    @objc private func showDetail(sender: UIButton) {
        let destination = MovieDetailViewController()
        let selectedRow = IndexPath(row: sender.tag, section: 0)
        print(selectedRow)
        destination.status = false
        
        navigationController?.pushViewController(destination, animated: true)
    }
}

extension MovieListVC: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        let indexes = indexPaths.map {$0.row}
        let total = viewModel?.totalRows ?? 0

        if indexes.contains(total - 1){
            viewModel?.loadMoreMovies()
        }
    }
}

