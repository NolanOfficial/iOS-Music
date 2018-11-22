//
//  ViewController.swift
//  iOS Music
//
//  Created by Nolan Fuchs on 11/13/18.
//  Copyright © 2018 Nolan Fuchs. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController {

    var genre = GenreScreen()
    
    // Music Controller
    var musicPlayer = MPMusicPlayerController.applicationMusicPlayer
    
    // Items
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    @IBAction func playMusic(_ sender: UIButton) {
        genre.toggleState = 1
        activityIndicator.startAnimating();
        MPMediaLibrary.requestAuthorization { (status) in
            if status == .authorized {
                DispatchQueue.main.async {
                    self.playMusic(genre: sender.currentTitle!)
                    self.dismiss(animated: true, completion: nil)
                    
                }
            }
        }
        
    }
    
    func playMusic(genre: String) {
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating();
        musicPlayer.stop()
        let query = MPMediaQuery()
        let predicate = MPMediaPropertyPredicate(value: genre, forProperty: MPMediaItemPropertyGenre)
        
        query.addFilterPredicate(predicate)
        
        musicPlayer.setQueue(with: query)
        musicPlayer.shuffleMode = .songs
        musicPlayer.play()
        activityIndicator.stopAnimating();
        
    }
    
    
    @IBAction func backToHomeView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}

