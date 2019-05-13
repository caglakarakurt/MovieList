//
//  MovieListViewModel.swift
//  MovieListing
//
//  Created by Çağla Karakurt on 7.05.2019.
//  Copyright © 2019 Çağla Karakurt. All rights reserved.
//

import Foundation

class MovieListViewModel {
	let apiMovie: APIServiceProtocol

	private var popularMoviesResponse = PopularMoviesResponse()
	private var movie = Movie()
	var isAllowSegue: Bool = false
	var selectedMovie: Movie?
	var reloadTableViewClosure: (()->())?
	var updateLoadingStatus: (()->())?

	private var cellViewModels: [MovieListCellViewModel] = [MovieListCellViewModel]() {
		didSet {
			self.reloadTableViewClosure?()
		}
	}

	var isLoading: Bool = false {
		didSet {
			self.updateLoadingStatus?()
		}
	}

	var numberOfCells: Int {
		return cellViewModels.count
	}

	init( apiMovie: APIServiceProtocol = MoviesAPI()) {
		self.apiMovie = apiMovie
	}

	func initFetch() {
		self.isLoading = true
		apiMovie.fetchMovie(succeed: parse(_:),
							failed: discardFailure(_:))
	}

	func parse(_ response: PopularMoviesResponse) {
		self.popularMoviesResponse = response
		var vms = [MovieListCellViewModel]()
		self.isLoading = false
		for movie in popularMoviesResponse.results {
			vms.append(createCellViewModel(movie: movie))
		}
		self.cellViewModels = vms
	}

	func getCellViewModel( at indexPath: IndexPath ) -> MovieListCellViewModel {
		return cellViewModels[indexPath.row]
	}

	func createCellViewModel(movie: Movie) -> MovieListCellViewModel {
		var descTextContainer: [String] = [String]()
		if let title = movie.title {
			descTextContainer.append(title)
		}
		return MovieListCellViewModel(titleText: movie.title,
									  imageUrl: movie.poster_path ?? "")
	}

	func discardFailure(_ model: Error) {
		print("fail")
	}

}

extension MovieListViewModel {
	func userPressed( at indexPath: IndexPath ){
		let movie = self.popularMoviesResponse.results[indexPath.row]
		self.isAllowSegue = true
		self.selectedMovie = movie
	}
}

struct MovieListCellViewModel {
	let titleText: String?
	let imageUrl: String
}

