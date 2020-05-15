//
//  ViewController.swift
//  CustomLogin
//
//  Created by Adelmo Brunelli on 09/05/2020.
//  Copyright © 2020 Adelmo Brunelli. All rights reserved.
//

import UIKit
import AVKit // libreria per contenuti video

class ViewController: UIViewController {
    
    
    var videoPlayer:AVPlayer?
    
    var videoPlayerLayer:AVPlayerLayer?
    
    

    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpElements()
        
    }
   /*
    override func viewWillAppear(_ animated: Bool) {
        
        // setto il video in sottofondo
        setUpVideo()
    }
   */
    func setUpElements(){
            
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
    }
 /*
    func setUpVideo(){
        
        // otteniamo il percorso dell'oggetto nel bundle
        let bundlePath = Bundle.main.path(forResource: "loginpg", ofType: "mp4")
        
        guard bundlePath != nil else{
            return
        }
        // creiamo un URL da questo
        let url = URL(fileURLWithPath: bundlePath!)
        // creiamo l'oggetto video player
        let item = AVPlayerItem(url: url)
        // creiamo il player
        videoPlayer = AVPlayer(playerItem: item)
        // creiamo il layer
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        // aggiustiamo la dimensione e i frame
        videoPlayerLayer?.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        // lo aggiungiamo alla view e lo facciamo iniziare
        videoPlayer?.playImmediately(atRate: 0.3)
        
        
    }*/


}

