import Foundation
import ipworks3ds_sdk

internal final class DebugEventListener: ClientEventListener {
    func onDataPacketIn(_ dataPacket: Data) {}
    func onDataPacketOut(_ dataPacket: Data) {}
    func onSSLServerAuthentication(_ certEncoded: Data, _ certSubject: String, _ certIssuer: String, _ status: String, _ accept: UnsafeMutablePointer<Int32>) {}
    func onSSLStatus(_ message: String) {}
    
    func onError(_ errorCode: Int32, _ description: String) {
        print("[3DS SDK Error][\(errorCode)] \(description)")
    }
    
    func onLog(_ logLevel: Int32, _ message: String, _ logType: String) {
        print("[3DS SDK][\(logType)] \(message)")
    }
}
