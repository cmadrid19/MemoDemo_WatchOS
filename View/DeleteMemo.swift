//
//  DeleteMemo.swift
//  CoreDataMemoWatchOS WatchKit Extension
//
//  Created by Maxim Macari on 15/2/21.
//

import SwiftUI

struct DeleteMemo: View {
    
    //Core data feetch request
    //We are egetting memos at descending order by using added or modified date...
    @FetchRequest(entity: Memo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Memo.dateAdded, ascending: false)], animation: .easeIn) var results: FetchedResults<Memo>
    
    
    @State var deleteMemoItem: Memo?
    @State var deleteMemo = false
    
    @Environment(\.managedObjectContext) var viewContext
    
    var body: some View {
        List(results){ item in
            
            HStack(spacing: 10) {
                VStack(alignment: .leading, spacing: 6, content: {
                    Text(item.title ?? "")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                    
                    
                    Text(item.dateAdded ?? Date(), style: .date)
                        .font(.system(size: 8))
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                })
            }
            
            Spacer(minLength: 4)
            
            Button(action: {
                // storring curreente memo
                deleteMemoItem = item
                deleteMemo.toggle()
            }, label: {
                Image(systemName: "trash")
                    .font(.callout)
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color.red)
                    .cornerRadius(8)
            })
            .buttonStyle(PlainButtonStyle())
            
        }
        .listStyle(CarouselListStyle())
        .padding(.top)
        .overlay(
            Text(results.isEmpty ? "No memo to delete." : "")
        )
        .navigationTitle("Deletee memo")
        .alert(isPresented: $deleteMemo, content: {
            Alert(title: Text("Confirm"), message: Text("To deelete this memo"), primaryButton: .default(Text("Ok"), action: {
                deleteMemo(memo: deleteMemoItem!)
            }), secondaryButton: .destructive(Text("Cancel")))
        })
        
    }
    
    
    //Delete memo
    func deleteMemo(memo: Memo) {
        viewContext.delete(memo)
        
        do{
            try viewContext.save()
        }catch{
            print(error.localizedDescription)
        }
    }
    
}


struct DeleteMemo_Previews: PreviewProvider {
    static var previews: some View {
        DeleteMemo()
    }
}
