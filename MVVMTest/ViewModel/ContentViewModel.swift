//
//  ContentViewModel.swift
//  MVVMTest
//
//  Created by Muhammad Tafani Rabbani on 17/07/23.
//

import SwiftUI


class ContentViewModel:ObservableObject{
    @Published var isLoading = false
    @Published var albumList : [Album] = []
    
    func fetchData(){
        self.isNotLoading()
        guard let url = URL(string: "https://api.npoint.io/b4ffb6a155d78507ac1d") else {
            print("Invalid URL")
            self.isNotLoading()
            return
        }
        
        // Create a URLSession instance
        let session = URLSession(configuration: .default)

//        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { [weak self] (data, response, error) in
            
            guard let self = self else {return}
            
            // Check for errors
            if let error = error {
                print("Error: \(error.localizedDescription)")
                self.isNotLoading()
                
                return
            }
            
            // Ensure a valid HTTP response
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response")
                self.isNotLoading()
                return
            }
            
            // Check if data is available
            guard let data = data else {
                print("No data received")
                self.isNotLoading()
                return
            }
            
            // Process the data
            do {
                // Convert the data to JSON
                let responseObject = try JSONDecoder().decode([Album].self, from: data)
                
                DispatchQueue.main.async {
                    print(responseObject)
                    self.albumList = responseObject
                    withAnimation {
                        self.isLoading = false
                    }
                }
                

            } catch {
                self.isNotLoading()
                print("JSON serialization error: \(error.localizedDescription)")
            }
        }

        // Start the data task
        task.resume()
    }
    
    func isNotLoading(){
        DispatchQueue.main.async {
            withAnimation {
                self.isLoading = false
            }
        }
    }
}
