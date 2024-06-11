//
//  TitleRow.swift
//  ChatApp
//
//  Created by Stephanie Diep on 2022-01-11.
//

import SwiftUI

struct TitleRow: View {
    var imageUrl = URL(string: "https://img.businessoffashion.com/resizer/v2/https%3A%2F%2Fprod-bof-media.s3.eu-west-1.amazonaws.com%2Fimport%2Fprofiles%2Fasset%2F1715%2Fa1f88b4a3c5c5b6761438553fe38ab872d9f59cc.jpeg?auth=7b03563a00ad77e3cd71c6cf0492ac463b993d18a585b2f94fc08539c3f031a2&height=350")
    var name = "David Beckham"
    
    var body: some View {
        HStack(spacing: 20) {
            AsyncImage(url: imageUrl) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .cornerRadius(50)
            } placeholder: {
                ProgressView()
            }
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.title).bold()
                
                Text("Online")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
    }
}

struct TitleRow_Previews: PreviewProvider {
    static var previews: some View {
        TitleRow()
            .background(Color(.init(red: 0.976, green: 0.851, blue: 0.780, alpha: 1)))
    }
}
