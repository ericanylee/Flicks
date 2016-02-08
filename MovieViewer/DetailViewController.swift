//
//  DetailViewController.swift
//  MovieViewer
//
//  Created by Erica Lee on 2/1/16.
//  Copyright © 2016 Erica Lee. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    var movie : NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: infoView.frame.origin.y + infoView.frame.size.height+50)
        
        let title = movie["title"] as! String
        titleLabel.text = title
        let overview = movie["overview"] as! String
        overviewLabel.text = overview
        overviewLabel.sizeToFit()

        let date = movie["release_date"] as! String
        durationLabel.text = date
        durationLabel.sizeToFit()
        
        let rating = movie["popularity"] as! Double
        ratingLabel.text = String(format: "%.2f%", rating)
        
        let posterBaseUrl = "http://image.tmdb.org/t/p/w500"
        
        //safely get a poster path by using if let
        if let posterPath = movie["poster_path"] as? String {
            //if the poster path is not nil, this following will be executed
            let posterUrl = NSURL(string: posterBaseUrl + posterPath)
            posterImageView.setImageWithURL(posterUrl!)
        }
            
        else {
            // No poster image. Can either set to nil (no image) or a default movie poster image
            // that you include as an asset
            posterImageView = nil
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
