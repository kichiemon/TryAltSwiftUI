//
//  ViewController.swift
//  TryAltSwiftUI
//
//  Created by ikuya on 2020/09/19.
//

import UIKit
import AltSwiftUI
import protocol AltSwiftUI.ObservableObject
import class AltSwiftUI.Published

struct ExampleView: View {
    var viewStore = ViewValues()
    
    @StateObject var exampleModel = ExampleModel()
    @State private var exampleInOrder: Bool = false
    @State private var offset: CGPoint = .zero
    @State private var imageGeometry: GeometryProxy = .default
    
    var body: View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(exampleModel.exampleList) { example in
                        NavigationLink(destination: ExampleDetailView(exampleInOrder: $exampleInOrder, example: example)) {
                            ExampleCell(example: example)
                        }
                    }
                }
            }
            .contentOffset($offset)
            .navigationBarTitle("My Example Store", displayMode: .inline)
            .onAppear {
                exampleModel.load()
            }
        }
    }
    
    var exampleInOrderView: View {
        VStack {
            Text("Preparing Example")
                .font(.title)
            Text("Please wait...")
            
            Button("Cancel") {
                withAnimation {
                    exampleInOrder = false
                }
            }
            .frame(width: 120, height: 30)
            .cornerRadius(10)
            .background(Color.blue)
            .accentColor(Color.white)
            .padding(.top, 20)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 50)
        .background(Color(white: 0.9))
    }
}

struct ExampleCell: View {
    var viewStore = ViewValues()
    let example: Example
    
    var body: View {
        HStack {
            Text("\(example.name)")
                .padding(.leading, 10)
            Spacer()
            Text("\(example.price)")
        }
        .frame(height: 40)
        .padding(10)
    }
}

struct ExampleDetailView: View {
    var viewStore = ViewValues()
    
    @Binding var exampleInOrder: Bool
    let example: Example
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: View {
        VStack(alignment: .trailing, spacing: 10) {
            Button("Order") {
                exampleInOrder = true
                presentationMode.wrappedValue.dismiss()
            }
            .font(.headline)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(10)
        .navigationBarTitle(example.name, displayMode: .large)
    }
}
