//
//  QuoteDetailViewController.swift
//  BYOA.Anime
//
//  Created by Matthew Hill on 2/22/23.
//

import UIKit

class QuoteDetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var animeTitleLabel: UILabel!
    @IBOutlet weak var animeQuoteLabel: UILabel!
    @IBOutlet weak var characterTitleLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRandomQuote()
    }
    // MARK: -  properties
    
    var animeQuote: AnimeQuote?
 
    
    // MARK: - functions
    
    func fetchRandomQuote() {
        AnimeQuoteController.fetchRandomAnimeQuote { success in
            if success == true {
                self.animeQuote = AnimeQuoteController.randomQuote
                DispatchQueue.main.async {
                    self.updateViews()
                }
            }
        }
    }
    
    func updateViews() {
        guard let animeQuote = animeQuote else { return }
        animeTitleLabel.text = "Anime: \(animeQuote.anime)"
        animeQuoteLabel.text = "Quote: \(animeQuote.quote)"
        characterTitleLabel.text = "Character: \(animeQuote.character)"
    }
}
