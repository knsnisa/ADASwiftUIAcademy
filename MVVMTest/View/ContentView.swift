//
//  ContentView.swift
//  MVVMTest
//
//  Created by Muhammad Tafani Rabbani on 16/07/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel : ContentViewModel = ContentViewModel()
    var body: some View {
        ZStack {
            if viewModel.isLoading{
                ProgressView()
                 .progressViewStyle(CircularProgressViewStyle())
            }else{
                VStack(alignment: .leading){
                    Button("Fetch Data"){
//                        fetchData()
                        viewModel.fetchData()
                    }
                    ScrollView{
                        if !viewModel.albumList.isEmpty{
                            ForEach(0...viewModel.albumList.count-1,id: \.self) { i in
                                CardView(album: viewModel.albumList[i])
                            }
                        }
                    }
                }
            }
        }.padding()
    }
    
}



