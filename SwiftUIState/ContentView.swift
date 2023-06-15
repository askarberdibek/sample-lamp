//
//  ContentView.swift
//  SwiftUIState
//
//  Created by askar on 13/6/23.
//

import SwiftUI
import AVFoundation

func toggleTorch(on: Bool){
    guard let device = AVCaptureDevice.default(for: .video) else {return}
    if device.hasTorch{
        do{
            try device.lockForConfiguration()
            device.torchMode = on ? .on : .off
            device.unlockForConfiguration()
        }catch{
            print("Torch could not be used")
        }
    }else{
        print("Torch is not available")
    }
}

struct ContentView: View {
    @State private var isPlaying = false // Свойство в качестве триггера
    var body: some View {
        VStack {
            Button {
                isPlaying.toggle() // Изменение свойства спровоцирует вызов функции Фонарика
                // Switch between the play and stop button
                toggleTorch(on: isPlaying)
            } label: {
                Image(systemName: isPlaying ? "sun.max.fill": "sun.max")
                    .font(.system(size: 150))
                    .foregroundColor(isPlaying ? .white: .gray)
                    .shadow(color: isPlaying ? Color.white : Color.gray, radius: 10, x: 0, y: 0)

            }
        }
        .padding()
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
