//
//  AnimeQuoteController.swift
//  BYOA.Anime
//
//  Created by Matthew Hill on 2/22/23.
//

import Foundation

class AnimeQuoteController {
    
    static var randomQuote: AnimeQuote?
    
    static func fetchRandomAnimeQuote(completion: @escaping (Bool) -> Void) {
        
        // https://animechan.vercel.app/api/random/anime?title=tokyo ghoul
        
        guard let baseURL = URL(string: Constants.AnimeURL.baseURL) else {completion(false) ; return}
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path.append(contentsOf: Constants.AnimeURL.apiPath)
        urlComponents?.path.append(contentsOf: Constants.AnimeURL.randomAnimePath)
        
        let apiQuery = URLQueryItem(name: Constants.QueryItem.queryKey, value: Constants.QueryItem.queryValue)
        urlComponents?.queryItems = [apiQuery]
        
        guard let finalURL = urlComponents?.url else { completion(false) ; return }
        print("Final URL: \(finalURL)")
        
        //Data Task
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(false)
                return
            }
            if let response = response as? HTTPURLResponse {
                print("Status Code:\(response.statusCode)")
            }
            guard let data = data else { completion(false) ; return}
            do {
                if let topLevel = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String : Any] {
                    let randomQuote = AnimeQuote(animeDict: topLevel)
                    self.randomQuote = randomQuote
                    completion(true)
                }
                
            } catch {
                print(error.localizedDescription)
                completion(false)
                return
            }
        } .resume()
    }
    
}
