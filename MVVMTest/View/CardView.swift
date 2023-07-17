//
//  CarView.swift
//  MVVMTest
//
//  Created by Muhammad Tafani Rabbani on 17/07/23.
//

import SwiftUI

struct CardView: View{
    let album : Album
    var body: some View{
        HStack{
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 50,height: 50)
            VStack(alignment:.leading){
                Text(album.songTitle)
                    .bold()
                    .font(.system(size: 20))
                Text(album.name)
                    .font(.system(size: 14))
            }
            Spacer()
            VStack {
                Text("\(album.downloads)")
                Text("Downloads")
            }
        }
    }
}
