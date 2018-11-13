//
//  GenreScreen.swift
//  iOS Music
//
//  Created by Nolan Fuchs on 11/13/18.
//  Copyright © 2018 Nolan Fuchs. All rights reserved.
//

import UIKit
import MediaPlayer

class GenreScreen: UIViewController {

    var musicPlayer = MPMusicPlayerController.applicationMusicPlayer
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func playMusic(_ sender: UIButton) {
        MPMediaLibrary.requestAuthorization { (status) in
            if status == .authorized {
                 DispatchQueue.main.async {
                self.playMusic(genre: sender.currentTitle!)
                }
            }
        }
    }
    
    
    @IBAction func playButton(_ sender: UIButton) {
        musicPlayer.play()
    }
    @IBAction func stopButton(_ sender: UIButton) {
        musicPlayer.stop()
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        musicPlayer.skipToNextItem()
    }
    @IBAction func backButton(_ sender: UIButton) {
        musicPlayer.skipToPreviousItem()
    }
    
    func playMusic(genre: String) {
        
        musicPlayer.stop()
        let query = MPMediaQuery()
        let predicate = MPMediaPropertyPredicate(value: genre, forProperty: MPMediaItemPropertyGenre)
        
        query.addFilterPredicate(predicate)
        
        musicPlayer.setQueue(with: query)
        musicPlayer.shuffleMode = .songs
        musicPlayer.play()
        
        
    }
    
    
    
    

}
