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

    // Music Controller
    var musicPlayer = MPMusicPlayerController.applicationMusicPlayer
    
    // Items
    @IBOutlet weak var albumCoverImage: UIImageView!
    @IBOutlet weak var timeOfSong: UISlider!
    @IBOutlet weak var currentSongTime: UILabel!
    @IBOutlet weak var remainingSongTime: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistAndAlbumLabel: UILabel!
    @IBOutlet weak var volumeSlider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
                
    }
    
    @IBAction func playButton(_ sender: UIButton) {
        musicPlayer.play()
    }
    
    @IBAction func pauseButton(_ sender: Any) {
        musicPlayer.pause()
    }
    @IBAction func nextButton(_ sender: UIButton) {
        musicPlayer.skipToNextItem()
    }
    @IBAction func backButton(_ sender: UIButton) {
        musicPlayer.skipToPreviousItem()
    }
    
    
    
    
    
    

}
