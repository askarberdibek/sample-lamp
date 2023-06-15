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

func flashlightToggle(on: Bool) {
    guard let device = AVCaptureDevice.default(for: .video) else {return}
    do {
        try device.lockForConfiguration()

        if on {
            for _ in 1...100 {
                device.torchMode = .on
                Thread.sleep(forTimeInterval: 0.2)
                device.torchMode = .off
                Thread.sleep(forTimeInterval: 0.2)
            }
        } else {
            device.torchMode = .off
        }

        device.unlockForConfiguration()
    } catch {
        print("Не удалось управлять фонариком: \(error.localizedDescription)")
    }
}


struct ContentView: View {
    @State private var isFlashing = false
    @State private var isPlaying = false // Свойство в качестве триггера
    var body: some View {
        VStack {
            Button {
                isPlaying = true // Изменение свойства спровоцирует вызов функции Фонарика
                // Switch between the play and stop button
                toggleTorch(on: isPlaying)
            } label: {
                Image(systemName: isPlaying ? "sun.max.fill": "sun.max")
                    .font(.system(size: 100))
                    .foregroundColor(isPlaying ? .white: .gray)
                    .shadow(color: isPlaying ? Color.white : Color.gray, radius: 10, x: 0, y: 0)
            }
            Button {
                isPlaying = false // Изменение свойства спровоцирует вызов/отключение функции Фонарика
                // Switch between the play and stop button
                isFlashing.toggle()
                flashlightToggle(on: isFlashing)
                
            } label: {
                Image(systemName: isFlashing ? "sun.max.circle.fill" : "sun.max.circle")
                    .font(.system(size: 100))
                    .foregroundColor(isFlashing ? .white: .gray)
                    .shadow(color: isFlashing ? Color.white : Color.gray, radius: 10, x: 0, y: 0)
            }
            Text("Мигание фонарика")
//            Toggle("Мигание фонарика", isOn: $isFlashing)
//                .padding()
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
