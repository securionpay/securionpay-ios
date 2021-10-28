import XCTest
import Foundation
@testable import SecurionPay

final class ExpirationDateFormatterTests: XCTestCase {
    func testDateFormattingEdgeCases() {
        let cases = [
            ("", false, ExpirationDateFormatter.Result(text: "", placeholder: "MM/YY", resignFocus: false)),
            ("0", false, ExpirationDateFormatter.Result(text: "0", placeholder: "MM/YY", resignFocus: false)),
            ("1", false, ExpirationDateFormatter.Result(text: "1", placeholder: "MM/YY", resignFocus: false)),
            ("01", false, ExpirationDateFormatter.Result(text: "01/", placeholder: "MM/YY", resignFocus: false)),
            ("11", false, ExpirationDateFormatter.Result(text: "11/", placeholder: "MM/YY", resignFocus: false)),
            ("12", false, ExpirationDateFormatter.Result(text: "12/", placeholder: "MM/YY", resignFocus: false)),
            ("13", false, ExpirationDateFormatter.Result(text: "1", placeholder: "MM/YY", resignFocus: false)),
            ("14", false, ExpirationDateFormatter.Result(text: "1", placeholder: "MM/YY", resignFocus: false)),
            ("15", false, ExpirationDateFormatter.Result(text: "1", placeholder: "MM/YY", resignFocus: false)),
            ("16", false, ExpirationDateFormatter.Result(text: "1", placeholder: "MM/YY", resignFocus: false)),
            ("17", false, ExpirationDateFormatter.Result(text: "1", placeholder: "MM/YY", resignFocus: false)),
            ("18", false, ExpirationDateFormatter.Result(text: "1", placeholder: "MM/YY", resignFocus: false)),
            ("19", false, ExpirationDateFormatter.Result(text: "1", placeholder: "MM/YY", resignFocus: false)),
            ("2", false, ExpirationDateFormatter.Result(text: "02/", placeholder: "MM/YY", resignFocus: false)),
            ("3", false, ExpirationDateFormatter.Result(text: "03/", placeholder: "MM/YY", resignFocus: false)),
            ("4", false, ExpirationDateFormatter.Result(text: "04/", placeholder: "MM/YY", resignFocus: false)),
            ("5", false, ExpirationDateFormatter.Result(text: "05/", placeholder: "MM/YY", resignFocus: false)),
            ("6", false, ExpirationDateFormatter.Result(text: "06/", placeholder: "MM/YY", resignFocus: false)),
            ("7", false, ExpirationDateFormatter.Result(text: "07/", placeholder: "MM/YY", resignFocus: false)),
            ("8", false, ExpirationDateFormatter.Result(text: "08/", placeholder: "MM/YY", resignFocus: false)),
            ("9", false, ExpirationDateFormatter.Result(text: "09/", placeholder: "MM/YY", resignFocus: false)),
            ("02", false, ExpirationDateFormatter.Result(text: "02/", placeholder: "MM/YY", resignFocus: false)),
            ("03", false, ExpirationDateFormatter.Result(text: "03/", placeholder: "MM/YY", resignFocus: false)),
            ("04", false, ExpirationDateFormatter.Result(text: "04/", placeholder: "MM/YY", resignFocus: false)),
            ("05", false, ExpirationDateFormatter.Result(text: "05/", placeholder: "MM/YY", resignFocus: false)),
            ("06", false, ExpirationDateFormatter.Result(text: "06/", placeholder: "MM/YY", resignFocus: false)),
            ("07", false, ExpirationDateFormatter.Result(text: "07/", placeholder: "MM/YY", resignFocus: false)),
            ("08", false, ExpirationDateFormatter.Result(text: "08/", placeholder: "MM/YY", resignFocus: false)),
            ("09", false, ExpirationDateFormatter.Result(text: "09/", placeholder: "MM/YY", resignFocus: false)),

            ("010", false, ExpirationDateFormatter.Result(text: "01/", placeholder: "MM/YY", resignFocus: false)),
            ("011", false, ExpirationDateFormatter.Result(text: "01/", placeholder: "MM/YY", resignFocus: false)),

            ("0120", false, ExpirationDateFormatter.Result(text: "01/20", placeholder: "MM/YYYY", resignFocus: false)),

            ("01200", false, ExpirationDateFormatter.Result(text: "01/20", placeholder: "MM/YY", resignFocus: false)),
            ("01201", false, ExpirationDateFormatter.Result(text: "01/20", placeholder: "MM/YY", resignFocus: false)),
            ("01202", false, ExpirationDateFormatter.Result(text: "01/202", placeholder: "MM/YYYY", resignFocus: false)),
            ("012020", false, ExpirationDateFormatter.Result(text: "01/202", placeholder: "MM/YYYY", resignFocus: false)),
            ("01228", false, ExpirationDateFormatter.Result(text: "01/22", placeholder: "MM/YY", resignFocus: false)),
            ("0/45", false, ExpirationDateFormatter.Result(text: "0", placeholder: "MM/YY", resignFocus: false)),
            ("1/45", false, ExpirationDateFormatter.Result(text: "01/45", placeholder: "MM/YY", resignFocus: false)),
            ("2/45", false, ExpirationDateFormatter.Result(text: "02/45", placeholder: "MM/YY", resignFocus: false)),
            ("3/45", false, ExpirationDateFormatter.Result(text: "03/45", placeholder: "MM/YY", resignFocus: false)),
            ("4/45", false, ExpirationDateFormatter.Result(text: "04/45", placeholder: "MM/YY", resignFocus: false)),
            ("5/45", false, ExpirationDateFormatter.Result(text: "05/45", placeholder: "MM/YY", resignFocus: false)),
            ("6/45", false, ExpirationDateFormatter.Result(text: "06/45", placeholder: "MM/YY", resignFocus: false)),
            ("7/45", false, ExpirationDateFormatter.Result(text: "07/45", placeholder: "MM/YY", resignFocus: false)),
            ("8/45", false, ExpirationDateFormatter.Result(text: "08/45", placeholder: "MM/YY", resignFocus: false)),
            ("9/45", false, ExpirationDateFormatter.Result(text: "09/45", placeholder: "MM/YY", resignFocus: false)),
            ("14/045", false, ExpirationDateFormatter.Result(text: "1", placeholder: "MM/YY", resignFocus: false)),
            ("20/045", false, ExpirationDateFormatter.Result(text: "02/", placeholder: "MM/YY", resignFocus: false)),
            ("31/045", false, ExpirationDateFormatter.Result(text: "03/", placeholder: "MM/YY", resignFocus: false)),
            ("42/045", false, ExpirationDateFormatter.Result(text: "04/", placeholder: "MM/YY", resignFocus: false)),
            ("53/045", false, ExpirationDateFormatter.Result(text: "05/", placeholder: "MM/YY", resignFocus: false)),
            ("64/045", false, ExpirationDateFormatter.Result(text: "06/", placeholder: "MM/YY", resignFocus: false)),
            ("75/045", false, ExpirationDateFormatter.Result(text: "07/", placeholder: "MM/YY", resignFocus: false)),
            ("86/045", false, ExpirationDateFormatter.Result(text: "08/", placeholder: "MM/YY", resignFocus: false)),
            ("97/045", false, ExpirationDateFormatter.Result(text: "09/", placeholder: "MM/YY", resignFocus: false)),
            ("0/2024", false, ExpirationDateFormatter.Result(text: "0", placeholder: "MM/YY", resignFocus: false)),
            ("161/45", false, ExpirationDateFormatter.Result(text: "1", placeholder: "MM/YY", resignFocus: false)),
            ("261/45", false, ExpirationDateFormatter.Result(text: "02/", placeholder: "MM/YY", resignFocus: false)),
            ("361/45", false, ExpirationDateFormatter.Result(text: "03/", placeholder: "MM/YY", resignFocus: false)),
            ("461/45", false, ExpirationDateFormatter.Result(text: "04/", placeholder: "MM/YY", resignFocus: false)),
            ("561/45", false, ExpirationDateFormatter.Result(text: "05/", placeholder: "MM/YY", resignFocus: false)),
            ("661/45", false, ExpirationDateFormatter.Result(text: "06/", placeholder: "MM/YY", resignFocus: false)),
            ("761/45", false, ExpirationDateFormatter.Result(text: "07/", placeholder: "MM/YY", resignFocus: false)),
            ("861/45", false, ExpirationDateFormatter.Result(text: "08/", placeholder: "MM/YY", resignFocus: false)),
            ("961/45", false, ExpirationDateFormatter.Result(text: "09/", placeholder: "MM/YY", resignFocus: false)),
            ("0/4024", false, ExpirationDateFormatter.Result(text: "0", placeholder: "MM/YY", resignFocus: false)),
            ("10/099", false, ExpirationDateFormatter.Result(text: "10/", placeholder: "MM/YY", resignFocus: false)),
            ("11/099", false, ExpirationDateFormatter.Result(text: "11/", placeholder: "MM/YY", resignFocus: false)),
            ("12/099", false, ExpirationDateFormatter.Result(text: "12/", placeholder: "MM/YY", resignFocus: false)),
//            ("13/3099", false, ExpirationDateFormatter.Result(text: "1", placeholder: "MM/YY", resignFocus: false)),
//            ("23/3099", false, ExpirationDateFormatter.Result(text: "02/", placeholder: "MM/YY", resignFocus: false)),
//            ("33/3099", false, ExpirationDateFormatter.Result(text: "", placeholder: "MM/YY", resignFocus: false)),
//            ("2/2024", false, ExpirationDateFormatter.Result(text: "02/2042", placeholder: "MM/YYYY", resignFocus: true)),
        ]
        
        cases.forEach {
            XCTAssertEqual($0.2, ExpirationDateFormatter.format(inputText: $0.0, backspace: $0.1))
        }
    }
    
    func testDateFormattingCorrectShortYear() {
        let cases = Array(21...99)
            .map { ("01/\($0)", false, ExpirationDateFormatter.Result(text: "01/\($0)", placeholder: "MM/YY", resignFocus: true)) }
        
        cases.forEach {
            XCTAssertEqual($0.2, ExpirationDateFormatter.format(inputText: $0.0, backspace: $0.1))
        }
    }
    
    func testDateFormattingCorrectLongYear() {
        let cases = Array(2021...2099)
            .map { ("01/\($0)", false, ExpirationDateFormatter.Result(text: "01/\($0)", placeholder: "MM/YYYY", resignFocus: true)) }
        
        cases.forEach {
            XCTAssertEqual($0.2, ExpirationDateFormatter.format(inputText: $0.0, backspace: $0.1))
        }
    }
    
    func testDateFormattingWithBackspace() {
        let cases = [
            ("03/", true, ExpirationDateFormatter.Result(text: "03", placeholder: "MM/YY", resignFocus: false))
        ]
        
        cases.forEach {
            XCTAssertEqual($0.2, ExpirationDateFormatter.format(inputText: $0.0, backspace: $0.1))
        }
    }
}

extension ExpirationDateFormatter.Result: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.resignFocus == rhs.resignFocus &&
        lhs.text == rhs.text &&
        lhs.placeholder == rhs.placeholder
    }
}
