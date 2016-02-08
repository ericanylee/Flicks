//
//  collectionViewController.swift
//  MovieViewer
//
//  Created by Erica Lee on 1/31/16.
//  Copyright © 2016 Erica Lee. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class collectionViewController: UIViewController,UICollectionViewDelegate,
UICollectionViewDataSource{

    
    @IBOutlet weak var CollectionView: UICollectionView!
    var movies: [NSDictionary]?
    var endpoint: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        CollectionView.dataSource = self
        CollectionView.delegate = self
        
        //initializing UIRefreshControl
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        
        //being added to the list view
        CollectionView.insertSubview(refreshControl, atIndex: 0)
        
        refreshControlAction(refreshControl)
        
    }
    // Makes a network request to get updated data
    // Updates the tableView with the new data
    // Hides the RefreshControl
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        // ... Create the NSURLRequest (myRequest) ...
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/\(endpoint)?api_key=\(apiKey)")
        let request = NSURLRequest(URL: url!)
        
        // Configure session so that completion handler is executed on main UI thread
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            //NSLog("response: \(responseDictionary)") the same as printing it out
                            
                            self.movies = responseDictionary["results"] as! [NSDictionary]
                            // Reload the tableView now that there is new data
                            self.CollectionView.reloadData()
                            
                            // Tell the refreshControl to stop spinning
                            refreshControl.endRefreshing()
                            
                            //NSLog("Response: \(responseDictionary)") //printing the retrieved data out
                            
                    }
                }
                else {
                    print("Data is NIL-  no network connection?")
                }
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                
        }) //end of assigning task
        
        task.resume()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
        func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
            if let moview = movies{
                return movies!.count
            } else{
                return 0
            }
        }
        
        func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
            let cell = CollectionView.dequeueReusableCellWithReuseIdentifier("CollectionCell", forIndexPath: indexPath) as! collectionViewCell
            
            let movie = movies![indexPath.row]
            let title = movie["title"] as! String
            let overview = movie["overview"] as! String
        let posterBaseUrl = "http://image.tmdb.org/t/p/w500"
            
            //safely get a poster path by using if let
            if let posterPath = movie["poster_path"] as? String{
                    let posterUrl = NSURL(string: posterBaseUrl + posterPath)
                    cell.PosterCell.setImageWithURL(posterUrl!)
            }
            else {
                // No poster image. Can either set to nil (no image) or a default movie poster image
                // that you include as an asset
                cell.PosterCell.image = nil
            }

            return cell
        }
}


/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


