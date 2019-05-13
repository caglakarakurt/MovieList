//
//  MovieDetailViewController.swift
//  MovieListing
//
//  Created by Çağla Karakurt on 7.05.2019.
//  Copyright © 2019 Çağla Karakurt. All rights reserved.
//

import UIKit
import SDWebImage

class MovieDetailViewController: UIViewController {

	lazy var viewModel: MovieDetailViewModel = {
		return MovieDetailViewModel()
	}()

	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var lblTitle: UILabel!
	@IBOutlet weak var lblMovieDetail: UILabel!
	@IBOutlet weak var lblDate: UILabel!

	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationItem.title = "Content Detail"
		if let imageUrl = viewModel.imageUrl {
			imageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original\(imageUrl)")) { (image, error, type, url) in
			}
		}
		viewModel.initFetch()
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
			self.configureView()
		}
	}

	func configureView() {
		lblTitle.text = viewModel.title
		lblMovieDetail.text = viewModel.detail
		lblDate.text = viewModel.date
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

}
