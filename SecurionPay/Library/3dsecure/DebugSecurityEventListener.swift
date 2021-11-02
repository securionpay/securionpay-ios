import Foundation
import ipworks3ds_sdk

internal final class DebugSecurityEventListener : SecurityEventListener {
    func alarm(_ severity: Severity, _ event: SecurityEvent) {
        print("[3DS SDK Security Alarm][\(severity.description)] \(event.description)")
    }
}
