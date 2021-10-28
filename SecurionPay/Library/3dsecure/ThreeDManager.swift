import Foundation
import ipworks3ds_sdk

class ThreeDManager: ChallengeStatusReceiver {
    static let shared = ThreeDManager()
    
    var threeDS2Service: ThreeDS2Service
    var sdkTransaction: Transaction?
    var sdkProgressDialog: ProgressView?
    var completion: (_ sucess: Bool, _ error: SecurionPayError?) -> Void = { _, _ in }
    
    init() {
        threeDS2Service = ThreeDS2Service(bundle: Bundle.securionPay)
    }
    
    func initializeSDK(cardBrand: String, certificate: DirectoryServerCertificate?, sdkLicense: String) throws {
        try? threeDS2Service.cleanup()
        guard let certificate = certificate else { return }
        
        let directoryServerInfoList = [DirectoryServerInfo(RID: cardBrand.lowercased(),
                                                           publicKey: certificate.certificate,
                                                           CAs: certificate.caCertificates)]
        
        let clientConfigs: [String]
        let clientEventListener: MyClientEventListener?
        let securityEventListener: MySecurityEventListener?
        
        #if DEBUG
        clientConfigs = ["LogLevel=3", "MaskSensitive=true"]
        clientEventListener = MyClientEventListener()
        securityEventListener = MySecurityEventListener()
        #else
        clientConfigs = ["LogLevel=0", "MaskSensitive=true"]
        clientEventListener = nil
        securityEventListener = nil
        #endif
        
        let builder = ConfigParametersBuilder.init(
            directoryServerInfoList: directoryServerInfoList,
            runtimeLicense: sdkLicense,
            deviceParameterBlacklist: nil,
            clientConfig: clientConfigs,
            appBundleID: ""
        )
        let configParameters = try builder.build()
        try configParameters.addParam(group: nil, paramName: "ShowWhiteBoxInProcessingScreen", paramValue: "true")
        
        try threeDS2Service.initialize(
            configParameters: configParameters,
            locale: nil,
            uiCustomization: uiCustomization(),
            clientEventListener: clientEventListener,
            securityEventListener: securityEventListener
        )
        
        let warnings = try threeDS2Service.getWarnings()
        if warnings.count > 0 {
            // process warning
            // abort the check out if necessary
        }
    }
    
    func showProgressDialog() throws {
        sdkProgressDialog = try sdkTransaction?.getProgressView()
        sdkProgressDialog?.show()
    }
    
    func cancelProgressDialog() {
        sdkProgressDialog?.close()
        sdkProgressDialog = nil
    }
    
    func createTransaction(version: String, cardBrand: String) throws {
        sdkTransaction = try threeDS2Service.createTransaction(cardBrand.lowercased(), version)
    }
    
    func getAuthenticationRequestParameters() throws -> AuthenticationRequestParameters? {
        if sdkTransaction == nil {
            return nil
        }
        return try sdkTransaction!.getAuthenticationRequestParameters()
    }
    
    func startChallenge(_ authResponse : String, _ navigationController: UIViewController, completion: @escaping (Bool, SecurionPayError?) -> Void) throws {
        self.completion = completion
        let challengeParameters = ChallengeParameters(threeDSServerAuthResponse: authResponse)
        try sdkTransaction?.doChallenge(rootViewController: navigationController, challengeParameters: challengeParameters, challengeStatusReceiver: self, timeout: 15)
    }
    
    func closeTransaction() throws {
        if sdkTransaction != nil {
            try sdkTransaction?.close()
            sdkTransaction = nil
        }
    }
    
    func completed(_ completionEvent: CompletionEvent) {
        DispatchQueue.main.async {
            self.completion(true, nil)
        }
        try? self.closeTransaction()
    }
    
    func cancelled() {
        DispatchQueue.main.async {
            self.completion(false, nil)
        }
        try? closeTransaction()
    }
    
    func timedout() {
        DispatchQueue.main.async {
            self.completion(false, .unknown)
        }
        try? closeTransaction()
    }
    
    func protocolError(_ protocolErrorEvent: ProtocolErrorEvent) {
        DispatchQueue.main.async {
            self.completion(false, .unknown)
        }
        try? closeTransaction()
    }
    
    func runtimeError(_ runtimeErrorEvent: RuntimeErrorEvent) {
        DispatchQueue.main.async {
            self.completion(false, .unknown)
        }
        try? closeTransaction()
    }
    
    private func customizeButton(uiCustom: UiCustomization, type: ButtonType, backgroundColor: UIColor, textColor: UIColor) throws {
        let button = uiCustom.getButtonCustomization(buttonType: type)
        button.setBackgroundColor(color: backgroundColor)
        try button.setHeight(height: Style.Layout.Button.height)
        try button.setCornerRadius(cornerRadius: Int(Style.Layout.cornerRadius))
        button.setTextColor(color: textColor)
        try button.setTextFontName(fontName: Style.Font.button.familyName)
    }
    
    private func customizeButtons(uiCustom: UiCustomization) throws {
        try customizeButton(
            uiCustom: uiCustom,
            type: .SUBMIT,
            backgroundColor: Style.Color.primary,
            textColor: .white
        )
        
        try customizeButton(
            uiCustom: uiCustom,
            type: .RESEND,
            backgroundColor: .white,
            textColor: .black
        )
        
        try customizeButton(
            uiCustom: uiCustom,
            type: .NEXT,
            backgroundColor: Style.Color.success,
            textColor: .white
        )
        
        try customizeButton(
            uiCustom: uiCustom,
            type: .CANCEL,
            backgroundColor: .white,
            textColor: .black
        )
        
        try customizeButton(
            uiCustom: uiCustom,
            type: .CONTINUE,
            backgroundColor: Style.Color.success,
            textColor: .white
        )
    }
    
    private func uiCustomization() throws -> UiCustomization {
        let uiCustom = UiCustomization()
        uiCustom.setBackground(color: .white)
        
        try customizeButtons(uiCustom: uiCustom)
        
        let labelCustomization = uiCustom.getLabelCustomization()
        labelCustomization.setHeadingTextColor(color: .black)
        try labelCustomization.setHeadingTextAlignment(textAlignment: .left)
        try labelCustomization.setHeadingTextFontName(fontName: Style.Font.title.fontName)
        try labelCustomization.setHeadingTextFontSize(fontSize: Int(Style.Font.title.pointSize))
        
        try labelCustomization.setTextFontName(
            forLabelType: .INFO_LABEL,
            fontName: Style.Font.tileLabel.fontName)
        try labelCustomization.setTextColor(
            forLabelType: .INFO_LABEL,
            color: .black)
        try labelCustomization.setTextFontSize(
            forLabelType: .INFO_LABEL,
            fontSize: Style.Font.tileLabel.pointSize)
        
        try labelCustomization.setTextFontName(
            forLabelType: .INFO_TEXT,
            fontName: Style.Font.body.fontName)
        try labelCustomization.setTextColor(
            forLabelType: .INFO_TEXT,
            color: .black)
        try labelCustomization.setTextFontSize(
            forLabelType: .INFO_TEXT,
            fontSize: Style.Font.body.pointSize)
        
        try labelCustomization.setTextFontName(
            forLabelType: .WHY_INFO,
            fontName: Style.Font.tileLabel.fontName)
        try labelCustomization.setTextColor(
            forLabelType: .WHY_INFO,
            color: .black)
        try labelCustomization.setTextFontSize(
            forLabelType: .WHY_INFO,
            fontSize: Style.Font.tileLabel.pointSize)
        
        try labelCustomization.setTextFontName(
            forLabelType: .WHY_INFO_TEXT,
            fontName: Style.Font.body.fontName)
        try labelCustomization.setTextColor(
            forLabelType: .WHY_INFO_TEXT,
            color: .black)
        try labelCustomization.setTextFontSize(
            forLabelType: .WHY_INFO_TEXT,
            fontSize: Style.Font.body.pointSize)
        
        try labelCustomization.setTextFontName(
            forLabelType: .EXPANDABLE_INFO,
            fontName: Style.Font.tileLabel.fontName)
        try labelCustomization.setTextColor(
            forLabelType: .EXPANDABLE_INFO,
            color: .black)
        try labelCustomization.setTextFontSize(
            forLabelType: .EXPANDABLE_INFO,
            fontSize: Style.Font.tileLabel.pointSize)
        
        try labelCustomization.setTextFontName(
            forLabelType: .EXPANDABLE_INFO_TEXT,
            fontName: Style.Font.body.fontName)
        try labelCustomization.setTextColor(
            forLabelType: .EXPANDABLE_INFO_TEXT,
            color: .black)
        try labelCustomization.setTextFontSize(
            forLabelType: .EXPANDABLE_INFO_TEXT,
            fontSize: Style.Font.body.pointSize)
        
        try labelCustomization.setTextFontName(
            forLabelType: .SELECTION_LIST,
            fontName: Style.Font.body.fontName)
        try labelCustomization.setTextColor(
            forLabelType: .SELECTION_LIST,
            color: .black)
        try labelCustomization.setTextFontSize(
            forLabelType: .SELECTION_LIST,
            fontSize: Style.Font.body.pointSize)
        
        let toolbarCustomization = uiCustom.getToolbarCustomization()
        try toolbarCustomization.setButtonText(buttonText: .localized("Cancel"))
        toolbarCustomization.setTextColor(color: .white)
        try toolbarCustomization.setTextFontName(fontName: Style.Font.body.fontName)
        try toolbarCustomization.setTextFontSize(fontSize: Int(Style.Font.body.pointSize))
        
        try labelCustomization.setBackgroundColor(forLabelType: .EXPANDABLE_INFO, color: .clear)
        try labelCustomization.setBackgroundColor(forLabelType: .EXPANDABLE_INFO_TEXT, color: .clear)
        try labelCustomization.setBackgroundColor(forLabelType: .WHY_INFO, color: .clear)
        try labelCustomization.setBackgroundColor(forLabelType: .WHY_INFO_TEXT, color: .clear)
        
        return uiCustom
    }
}


class MyClientEventListener: ClientEventListener {
    
    func onDataPacketIn(_ dataPacket: Data) {
        
    }
    
    func onDataPacketOut(_ dataPacket: Data) {
        
    }
    
    func onError(_ errorCode: Int32, _ description: String) {
        
    }
    
    func onLog(_ logLevel: Int32, _ message: String, _ logType: String) {
        print("[3DS SDK][\(logType)] \(message)")
    }
    
    func onSSLServerAuthentication(_ certEncoded: Data, _ certSubject: String, _ certIssuer: String, _ status: String, _ accept: UnsafeMutablePointer<Int32>) {
    }
    
    func onSSLStatus(_ message: String) {
    }
}

class MySecurityEventListener : SecurityEventListener {
    func alarm(_ severity: Severity, _ event: SecurityEvent) {
        //        TransactionManager.transactionManager.showToast("Security alaem: [" + severity.description + "] " + event.description)
    }
    
}
