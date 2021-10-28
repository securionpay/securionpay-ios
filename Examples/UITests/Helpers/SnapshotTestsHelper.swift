import Foundation
import SnapshotTesting
import XCTest

public func imageSnapshot(
    precision: Float = 0.97,
    sleepBefore: Bool = true,
    file: StaticString = #file,
    line: Int = #line,
    function: String = #function) {
    if SnapshotTestsHelperConfig.shouldRecordAllSnapshots {
        record = true
    }
    let recordDescription: String = (record ? "Recording" : "Checking")
    let context: String = recordDescription +
        " image snapshot with precision: " +
        String(describing: precision) +
        (sleepBefore ? ", sleeping before." : ".")
    XCTContext.runActivity(named: context) { _ in
        if sleepBefore {
            Sleep.seconds(3)
        }
        let image = XCUIApplication().screenshot().image
        let size = image.size
        let result = verifySnapshot(
            matching: UIImage(cgImage: (image.cgImage?.cropping(to: CGRect(x: 0, y: 132, width: size.width*3, height: size.height*3)))!),
            as: .image(precision: precision),
            file: file,
            testName: function + "." + XCUIDevice.currentDeviceSize() + "." + XCUIDevice.operatingSystemVersion
        )
        if !SnapshotTestsHelperConfig.shouldRecordAllSnapshots {
            XCTAssertNil(result, result ?? "", file: file, line: UInt(line))
        }
    }
    
    if SnapshotTestsHelperConfig.shouldRecordAllSnapshots {
        record = false
    }
}

private func normalizeSnapshotString(snapshot: String) -> String {
    var currentTabCounter = 0
    var currentLineArray: [String] = []
    var result: String = ""
    let lines = (snapshot.components(separatedBy: "Path to element:").first ?? "").components(separatedBy: "\n")
    for line in lines {
        let numberOfTabs = line.numberOfTrailingSpaces()
        if numberOfTabs == currentTabCounter {
            currentLineArray.append(line
                .trimmingCharacters(in: CharacterSet(charactersIn: " "))
                .replacingOccurrences(of: "\t", with: " ")
            )
        } else {
            currentTabCounter = numberOfTabs
            currentLineArray.sort()
            currentLineArray.forEach {
                result.append($0 + "\n")
            }
            currentLineArray = []
            currentLineArray.append(line.replacingOccurrences(of: "\t", with: " "))
        }
    }
    return result
}

extension String {
    func numberOfTrailingSpaces() -> Int {
        var result: Int = 0
        for character in self {
            if character == " " { result += 1 }
            else { break }
        }
        return result
    }
}
