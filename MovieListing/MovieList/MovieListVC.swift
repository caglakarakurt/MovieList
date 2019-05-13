//
//  MovieListVC.swift
//  MovieListing
//
//  Created by Çağla Karakurt on 7.05.2019.
//  Copyright © 2019 Çağla Karakurt. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class MovieListVC: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!

	lazy var viewModel: MovieListViewModel = {
		return MovieListViewModel()
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		initView()
		initViewModel()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	func initView() {
		self.navigationItem.title = "Contents"
		tableView.estimatedRowHeight = 200
		tableView.rowHeight = UITableView.automaticDimension
	}

	func initViewModel() {
		viewModel.updateLoadingStatus = { [weak self] () in
			DispatchQueue.main.async {
				let isLoading = self?.viewModel.isLoading ?? false
				if isLoading {
					self?.activityIndicator.startAnimating()
					UIView.animate(withDuration: 0.2, animations: {
						self?.tableView.alpha = 0.0
					})
				} else {
					self?.activityIndicator.stopAnimating()
					UIView.animate(withDuration: 0.2, animations: {
						self?.tableView.alpha = 1.0
					})
				}
			}
		}

		viewModel.reloadTableViewClosure = { [weak self] () in
			DispatchQueue.main.async {
				self?.tableView.reloadData()
			}
		}

		viewModel.initFetch()
	}

}

extension MovieListVC: UITableViewDelegate, UITableViewDataSource {

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCellIdentifier", for: indexPath) as? MovieListTableViewCell else {
			fatalError("Cell not exist")
		}
		let cellViewModel = viewModel.getCellViewModel( at: indexPath )
		cell.movieListCellViewModel = cellViewModel
		return cell
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.numberOfCells
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 200.0
	}

	func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
		self.viewModel.userPressed(at: indexPath)
		if viewModel.isAllowSegue {
			return indexPath
		} else {
			return nil
		}
	}

}

extension MovieListVC {
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let vc = segue.destination as? MovieDetailViewController,
			let movie = viewModel.selectedMovie {
			vc.viewModel.imageUrl = movie.poster_path
			vc.viewModel.movieId = movie.id
		}
	}
}

class MovieListTableViewCell: UITableViewCell {
	@IBOutlet weak var mainImageView: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var descContainerHeightConstraint: NSLayoutConstraint!
	var movieListCellViewModel : MovieListCellViewModel? {
		didSet {
			nameLabel.text = movieListCellViewModel?.titleText
			mainImageView?.sd_setImage(with: URL( string: "https://image.tmdb.org/t/p/original\(movieListCellViewModel!.imageUrl)"), completed: nil)
		}
	}
}
