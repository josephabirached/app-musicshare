//
//  HomeViewController.swift
//  app-musicshare
//
//  Created by Joseph Abi Rached on 14/01/2021.
//

import UIKit
import FirebaseDatabase

class HomeViewController: UIViewController{
    
    var databaseRef: DatabaseReference?
    @IBOutlet weak var songList: UITableView!{
        didSet{
            songList.dataSource = self
            songList.allowsSelection = true
        }
    }
    var songs = [Song]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        databaseRef = Database.database().reference().child("Songs")
        databaseRef?.observe(.childAdded){[weak self] (snapshot) in
            let key = snapshot.key
            guard let value = snapshot.value as? [String: Any] else {return}
            if let name = value["name"] as? String , let artist = value["artist"] as? String , let image = value["image"] as? String , let songUrl = value["songUrl"] as? String{
                let song = Song(id: key, name: name, artist: artist, image: image, songUrl: songUrl)
                self?.songs.append(song)
                if let row = self?.songs.count{
                    let indexPath = IndexPath(row: row-1, section: 0)
                    self?.songList.insertRows(at: [indexPath], with: .automatic)
                }
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "songDetail"{
            let songDetailsShow = segue.destination as! SongViewController
            if let selectedIndex = songList?.indexPathForSelectedRow![1]{
                
                songDetailsShow.artist = songs[selectedIndex].artist
                songDetailsShow.song = songs[selectedIndex].name
                songDetailsShow.imageUI = songs[selectedIndex].image
                songDetailsShow.songURL = songs[selectedIndex].songUrl
                
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let song = songs[indexPath.row]
        let cell = songList.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath)
        
        cell.textLabel?.text = song.name
        cell.detailTextLabel?.text = song.artist
        
        return cell
    }
    

    
    
    
    
    
}
