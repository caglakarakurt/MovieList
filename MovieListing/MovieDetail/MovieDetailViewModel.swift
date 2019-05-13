//
//  MovieDetailViewModel.swift
//  MovieListing
//
//  Created by Çağla Karakurt on 12.05.2019.
//  Copyright © 2019 Çağla Karakurt. All rights reserved.
//

import Foundation

class MovieDetailViewModel {
	let apiMovie: APIServiceProtocol
	private var movie = MovieDetail()
	var imageUrl: String?
	var movieId: Int?
	var title: String?
	var detail: String?
	var date: String?


	init( apiMovie: APIServiceProtocol = MoviesAPI()) {
		self.apiMovie = apiMovie
	}

	func initFetch() {
		apiMovie.getMovieDetail(movieId: movieId ?? 0,
								succeed: parse(_:),
								failed: discardFailure(_:))
	}

	func parse(_ response: MovieDetail) {
		self.title = response.title
		self.detail = response.overview
		self.date = response.date
	}

	func discardFailure(_ model: Error) {
		print("fail")
	}
}
