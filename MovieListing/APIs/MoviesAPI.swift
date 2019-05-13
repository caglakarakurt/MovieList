//
//  MoviesAPI.swift
//  MovieListing
//
//  Created by Çağla Karakurt on 7.05.2019.
//  Copyright © 2019 Çağla Karakurt. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

enum APIError: String, Error {
	case noNetwork = "No Network"
	case serverOverload = "Server is overloaded"
	case permissionDenied = "You don't have permission"
}

protocol APIServiceProtocol {
	func fetchMovie(succeed: @escaping (PopularMoviesResponse) -> Void,
					failed:  @escaping (APIError) -> Void)

	func getMovieDetail(movieId: Int,
						succeed: @escaping (MovieDetail) -> Void,
						failed:  @escaping (APIError) -> Void)
}

class MoviesAPI: APIServiceProtocol  {

	func fetchMovie(succeed: @escaping (PopularMoviesResponse) -> Void,
					 failed:  @escaping (APIError) -> Void) {

		let path = "popular?language=en-US&api_key=fd2b04342048fa2d5f728561866ad52a&page=1"

		Alamofire.request(Endpoints.getPopularMovies + path, method: .get).responseObject { (response: DataResponse<PopularMoviesResponse>) in
			switch response.result {
			case .success:
				print("\(request(Endpoints.getPopularMovies + path, method: .get))")
				var model = PopularMoviesResponse()
				model = response.result.value!
				succeed(model)
			case .failure(let error):
				print(error)
			}
		}
	}

	func getMovieDetail(movieId: Int,
						succeed: @escaping (MovieDetail) -> Void,
						failed:  @escaping (APIError) -> Void) {

		let path = "\(movieId))?language=en-US&api_key=fd2b04342048fa2d5f728561866ad52a"

		Alamofire.request(Endpoints.getPopularMovies + path, method: .get).responseObject { (response: DataResponse<MovieDetail>) in
			switch response.result {
			case .success:
				print("\(request(Endpoints.getMovieDetail + path, method: .get))")
				var model = MovieDetail()
				model = response.result.value!
				succeed(model)
			case .failure(let error):
				print(error)
			}
		}

	}

}
