//
//  AddItem.swift
//  CoreDataMemoWatchOS WatchKit Extension
//
//  Created by Maxim Macari on 15/2/21.
//

import SwiftUI

struct AddItem: View {
    
    @State var memoText = ""
    
    //getting context from environment
    @Environment(\.managedObjectContext) private var viewContext
    
    //Preesentation
    @Environment(\.presentationMode) var presentation
    
    //Edit options
    var memoItem: Memo?
    
    var body: some View {
        VStack(spacing: 15){
            TextField("Memories...", text: $memoText)
            
            Button(action: {
                addMemo()
            }, label: {
                Text("Save")
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color.orange)
                    .cornerRadius(15)
            })
            .padding(.horizontal)
            .buttonStyle(PlainButtonStyle())
            .disabled(memoText == "")
        }
        .navigationTitle("\(memoItem == nil ? "Add memo" : "Update")")
        .onAppear(){
            //Verify if memoItem has data
            if let memo = memoItem{
                memoText = memo.title ?? ""
            }
            
        }
    }
    
    //Adding memo
    func addMemo(){
        let memo = memoItem == nil ? Memo(context: viewContext) : memoItem!
        
        memo.title = memoText
        memo.dateAdded = Date()
        
        //saving CRUD
        do{
            try viewContext.save()
            //if success we close the view
            presentation.wrappedValue.dismiss()
        }catch{
            print(error.localizedDescription)
        }
    }
}

struct AddItem_Previews: PreviewProvider {
    static var previews: some View {
        AddItem()
    }
}
