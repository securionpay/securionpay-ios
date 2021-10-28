import Foundation
import XCTest

final class Sleep {
    static func seconds(_ seconds: UInt32) {
        _ = XCTContext.runActivity(named: "Sleeping for \(seconds) seconds.") { _ in
            sleep(seconds)
        }
    }
    
    static func miliseconds(_ miliseconds: UInt32) {
        _ = XCTContext.runActivity(named: "Sleeping for \(miliseconds) miliseconds.") { _ in
            usleep(miliseconds * 1000)
        }
    }
}

