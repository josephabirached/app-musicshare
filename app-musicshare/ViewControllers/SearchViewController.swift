//
//  SearchViewController.swift
//  app-musicshare
//
//  Created by Joseph Abi Rached on 26/01/2021.
//

import UIKit
import FirebaseDatabase

class SearchViewController: UIViewController, UISearchBarDelegate{
    
    var databaseRef: DatabaseReference?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var songList: UITableView!{
        didSet{
            songList.dataSource = self
            songList.allowsSelection = true
        }
    }
    
    
    var songs = [Song]()
    var searchSongs = [Song]()
    var isSearching = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.delegate = self
        
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
            if isSearching{
                if let selectedIndex = songList?.indexPathForSelectedRow![1]{
                    songDetailsShow.artist = searchSongs[selectedIndex].artist
                    songDetailsShow.song = searchSongs[selectedIndex].name
                    songDetailsShow.imageUI = searchSongs[selectedIndex].image
                    songDetailsShow.songURL = searchSongs[selectedIndex].songUrl
                    
                }
            }
            else{
                if let selectedIndex = songList?.indexPathForSelectedRow![1]{
                    songDetailsShow.artist = songs[selectedIndex].artist
                    songDetailsShow.song = songs[selectedIndex].name
                    songDetailsShow.imageUI = songs[selectedIndex].image
                    songDetailsShow.songURL = songs[selectedIndex].songUrl
                }
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchSongs = [Song]()
        for song in songs{
            if song.name.hasPrefix(searchText) || song.artist.hasPrefix(searchText){
                searchSongs.append(song)
            }
        }
        isSearching = true
        songList.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        songList.reloadData()
    }
    
    
    
}

extension SearchViewController: UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching{
            return searchSongs.count
        }
        return songs.count
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = songList.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath)
        
        if isSearching{
            let searchSong = searchSongs[indexPath.row]
            cell.textLabel?.text = searchSong.name
            cell.detailTextLabel?.text = searchSong.artist
            
            return cell
        }
        
        let song = songs[indexPath.row]
        cell.textLabel?.text = song.name
        cell.detailTextLabel?.text = song.artist

        
        return cell
    }
    
}
