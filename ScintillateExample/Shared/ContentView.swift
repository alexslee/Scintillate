//
//  ContentView.swift
//  Shared
//
//  Created by Alex Lee on 4/1/22.
//

import SwiftUI
import Scintillate

struct ContentView: View {
    var body: some View {
      #if os(macOS)
        NSViewProvider(viewProvider: { DummyNSView() })
        .padding()
      #endif
      #if os(iOS)
        UIViewProvider(viewProvider: { DummyUIView() })
        .padding()
      #endif
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
