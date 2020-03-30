//
//  ContentView.swift
//  Cupcake Corner
//
//  Created by Aaryan Kothari on 30/03/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import SwiftUI

//class User: ObservableObject, Codable{
//    enum CodingKeys : CodingKey{
//    case name
//    }
//
//    @Published var name = "Aaryan Kothari"
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        name = try container.decode(String.self, forKey: .name)
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//
//        try container.encode(name, forKey: .name)
//    }
//}
struct Response: Codable{
    var results : [Result]
}

struct Result : Codable{
    var trackId : Int
    var trackName : String
    var collectionName :String
}

struct ContentView: View {
    
    @State var results = [Result]()
    
    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment:.leading){
            Text(item.trackName)
                .font(.headline)
            Text(item.collectionName)
            }
        }.onAppear(perform: loadData)
    }
    
    func loadData(){
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else{
            print("INVALID URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data){
                    DispatchQueue.main.async {
                        self.results = decodedResponse.results
                    }
                    return
                }
            }
            print("FETCH FAILED: \(error?.localizedDescription ?? "Some Error")")
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
