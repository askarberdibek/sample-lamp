//import SwiftUI
//import Dispatch
//import AVFoundation
//
//struct FlashingView: View {
//    @State private var isFlashing = false
//    private let device = AVCaptureDevice.default(for: AVMediaType.video)
//
//    var body: some View {
//        VStack {
//            Text("Пример задержки и мигания фонарика")
//                .padding()
//
//            Toggle("Мигание фонарика", isOn: $isFlashing)
//                .padding()
//
//            Button(action: {
//                delayWithDispatchQueue()
//            }) {
//                Text("Запустить задержку")
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//        }
//    }
//
//    func delayWithDispatchQueue() {
//        guard let device = device, device.hasTorch else { return }
//        print("delayWithDispatchQueue")
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            self.flashlightToggle()
//        }
//    }
//
//    func flashlightToggle() {
//        guard let device = device, device.hasTorch else { return }
//
//        do {
//            try device.lockForConfiguration()
//
//            if isFlashing {
//                for _ in 1...5 {
//                    device.torchMode = .on
//                    Thread.sleep(forTimeInterval: 0.2)
//                    device.torchMode = .off
//                    Thread.sleep(forTimeInterval: 0.2)
//                }
//            } else {
//                device.torchMode = .off
//            }
//
//            device.unlockForConfiguration()
//        } catch {
//            print("Не удалось управлять фонариком: \(error.localizedDescription)")
//        }
//    }
//}
//
//struct FlashingView_Previews: PreviewProvider {
//    static var previews: some View {
//        FlashingView()
//    }
//}
