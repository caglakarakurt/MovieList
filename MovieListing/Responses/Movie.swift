//
//  Movie.swift
//  MovieListing
//
//  Created by Çağla Karakurt on 7.05.2019.
//  Copyright © 2019 Çağla Karakurt. All rights reserved.
//

import Foundation
import ObjectMapper

class PopularMoviesResponse: Codable, Mappable  {
	var results: [Movie] = []

	init() {}

	required init(map: Map) {}

	func mapping(map: Map) {
		results <- map["results"]
	}
}

class Movie: Codable, Mappable {
	var id: Int = 0
	var title: String? = ""
	var poster_path: String? = ""

	init() {}

	required init(map: Map) {}

	func mapping(map: Map) {
		id <- map["id"]
		title <- map["title"]
		poster_path <- map["poster_path"]
	}

}

class MovieDetail: Codable, Mappable {
	var title: String? = ""
	var date: String? = ""
	var overview: String? = ""

	init() {}

	required init(map: Map) {}

	func mapping(map: Map) {
		date <- map["release_date"]
		title <- map["title"]
		overview <- map["overview"]
	}

}
