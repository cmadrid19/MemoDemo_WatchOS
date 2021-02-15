//
//  Home.swift
//  CoreDataMemoWatchOS WatchKit Extension
//
//  Created by Maxim Macari on 15/2/21.
//

import SwiftUI

struct Home: View {
    var body: some View {
        //To get frame
        GeometryReader { geo in
            
            let rect = geo.frame(in: .global)
            
            VStack(spacing: 15){
                HStack(spacing: 15){
                    
                    NavigationLink(
                        destination: AddItem(),
                        label: {
                            NavButton(image: "plus", title: "Memo", rect: rect, color: Color.green.opacity(0.9))
                        })
                        .buttonStyle(PlainButtonStyle())
                    
                    NavigationLink(
                        destination: DeleteMemo(),
                        label: {
                            NavButton(image: "trash", title: "Delete", rect: rect, color: Color.red.opacity(0.9))
                        })
                        .buttonStyle(PlainButtonStyle())
                        
                    
                    
                }
                .frame(width: rect.width, alignment: .center)
                
                HStack(spacing: 15){
                    NavigationLink(
                        destination: ViewMemo(),
                        label: {
                            NavButton(image: "doc.plaintext", title: "Memo", rect: rect, color: Color.blue.opacity(0.9))
                        })
                        .buttonStyle(PlainButtonStyle())
                    
                    
                    NavButton(image: "star", title: "Rating", rect: rect, color: Color.orange.opacity(0.9))
                    
                }
                .frame(width: rect.width, alignment: .center)
            }
        }
    }
}

struct NavButton: View {
    var image: String
    var title: String
    var rect: CGRect
    var color: Color
    
    var body: some View{
        VStack(spacing: 8){
            Image(systemName: image)
                .font(.title2)
                .frame(width: rect.width / 3, height: rect.width / 3, alignment: .center)
                .background(
                    color
                )
                .clipShape(Circle())
            
            Text(title)
                .font(.system(size: 10))
                .foregroundColor(.white)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
