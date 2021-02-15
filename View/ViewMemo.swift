//
//  ViewMemo.swift
//  CoreDataMemoWatchOS WatchKit Extension
//
//  Created by Maxim Macari on 15/2/21.
//

import SwiftUI
import CoreData

struct ViewMemo: View {
    
    //Core data feetch request
    //We are egetting memos at descending order by using added or modified date...
    @FetchRequest(entity: Memo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Memo.dateAdded, ascending: false)], animation: .easeIn) var results: FetchedResults<Memo>
    
    var body: some View {
        List(results){ item in
            
            HStack(spacing: 10) {
                VStack(alignment: .leading, spacing: 3, content: {
                    Text(item.title ?? "")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                    
                    Text("Last Modification")
                        .font(.system(size: 8))
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                        .padding(.top, 4)
                    
                    Text(item.dateAdded ?? Date(), style: .date)
                        .font(.system(size: 8))
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                })
            }
            
            Spacer(minLength: 4)
            
            //Edit button
            NavigationLink(
                destination: AddItem(memoItem: item),
                label: {
                    Image(systemName: "square.and.pencil")
                        .font(.callout)
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.orange)
                        .cornerRadius(8)
                })
                .buttonStyle(PlainButtonStyle())
            
            
        }
        .listStyle(CarouselListStyle())
        .padding(.top)
        .overlay(
            Text(results.isEmpty ? "No data found." : "")
        )
        .navigationTitle("Memos")
    }
}

struct ViewMemo_Previews: PreviewProvider {
    static var previews: some View {
        ViewMemo()
    }
}
