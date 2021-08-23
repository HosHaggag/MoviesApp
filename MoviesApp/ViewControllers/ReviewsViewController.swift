//
//  ReviewsViewController.swift
//  MoviesApp
//
//  Created by Hossam on 22/08/2021.
//

import UIKit

class ReviewsViewController: UIViewController {
    
    
    
    @IBOutlet var labelScroll: UIScrollView!
    
    @IBOutlet var reviewsContent: UILabel!
    
    var value = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        labelScroll.contentLayoutGuide.bottomAnchor.constraint(equalTo: reviewsContent.bottomAnchor).isActive = true

        reviewsContent.text = value
        print(value)
        
            }
    

    

}
