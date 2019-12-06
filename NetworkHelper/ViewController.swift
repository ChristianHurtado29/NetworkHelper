//
//  ViewController.swift
//  NetworkHelper
//
//  Created by Christian Hurtado on 12/6/19.
//  Copyright © 2019 Christian Hurtado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    //let urlString = "https://cdn.vox-cdn.com/thumbor/CTVIrY0EoLGvFbW0VPiRJ1VX8dM=/0x0:4662x3108/1820x1213/filters:focal(1792x430:2536x1174):format(webp)/cdn.vox-cdn.com/uploads/chorus_image/image/65759535/1173872401.jpg.0.jpg"
    let urlString = "https://icatcare.org/app/uploads/2018/07/Thinking-of-getting-a-cat.png"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let networkHelper = NetworkHelper() // this is an instance of networkhelper
        // unable to use because of a singleton
        
        // does not compile since initialier is private
        // let networkHelp = NetworkHelper.shared
        loadJokes()
        loadPodcasts()
    }
    
    @IBAction func loadImagePressed(_ sender: UIBarButtonItem) {
        NetworkHelper.shared.performDataTask(with: urlString) { (result) in
            switch result {
            case.failure(let appError):
                print("appError: \(appError)")
            case.success(let data):
                let image = UIImage(data: data)
                
                DispatchQueue.main.async{
                    self.imageView.image = image
                }
            }
        }
    }
    
    func loadJokes() {
        let jokes = JokeAPIClient.getJokes()
        print("loadJokes: \(jokes.count)")
    }
    
    func loadPodcasts() {
        let podcasts = PodcastAPIClient.getPodcast{ (result) in
            switch result {
            case.failure(let appError):
                print("appError: \(appError)")
            case .success(let podcasts):
                print("\(podcasts.count) were found")
            }
        }
        
    }
}
