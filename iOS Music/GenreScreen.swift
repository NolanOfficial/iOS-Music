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
    
    let size = CGSize(width: 343, height: 307)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       currentSongTime.text = "\(musicPlayer.currentPlaybackTime)"
        remainingSongTime.text = "\(musicPlayer.currentPlaybackRate)"
        songNameLabel.text = musicPlayer.nowPlayingItem?.title ?? "Song Name"
        artistAndAlbumLabel.text = "\(musicPlayer.nowPlayingItem?.albumArtist ?? "Artist Name") - \(musicPlayer.nowPlayingItem?.albumTitle ?? "Album Name")"
        albumCoverImage.image = musicPlayer.nowPlayingItem?.artwork?.image(at: size)
                
    }
    
    @IBAction func playButton(_ sender: UIButton) {
        
        musicPlayer.play()
    }
    
    @IBAction func pauseButton(_ sender: Any) {
        musicPlayer.pause()
    }
    @IBAction func nextButton(_ sender: UIButton) {
        musicPlayer.stop()
        musicPlayer.prepareToPlay()
        musicPlayer.skipToNextItem()
        musicPlayer.play()
        songNameLabel.text = musicPlayer.nowPlayingItem?.title ?? "Song Name"
        artistAndAlbumLabel.text = "\(musicPlayer.nowPlayingItem?.albumArtist ?? "Artist Name") - \(musicPlayer.nowPlayingItem?.albumTitle ?? "Album Name")"
        albumCoverImage.image = musicPlayer.nowPlayingItem?.artwork?.image(at: size)
        
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        musicPlayer.stop()
        musicPlayer.skipToPreviousItem()
        musicPlayer.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.songNameLabel.text = self.musicPlayer.nowPlayingItem?.title ?? "Song Name"
            self.artistAndAlbumLabel.text = "\(self.musicPlayer.nowPlayingItem?.albumArtist ?? "Artist Name") - \(self.musicPlayer.nowPlayingItem?.albumTitle ?? "Album Name")"
            self.albumCoverImage.image = self.musicPlayer.nowPlayingItem?.artwork?.image(at: self.size)
        }
        
    }
    
    @IBAction func changeVolume(_ sender: UISlider) {
        MPVolumeView.setVolume(volumeSlider.value)
        print(volumeSlider.value)
    }

}

extension MPVolumeView {
    static func setVolume(_ volume: Float) {
        let volumeView = MPVolumeView()
        let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
            slider?.value = volume
        }
    }
}
