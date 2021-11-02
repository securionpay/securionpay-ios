import Foundation
import ipworks3ds_sdk

internal final class ThreeDManager: ChallengeStatusReceiver {
    static let shared = ThreeDManager()
    
    var threeDS2Service: ThreeDS2Service
    var sdkTransaction: Transaction?
    var sdkProgressDialog: ProgressView?
    var completion: (_ sucess: Bool, _ error: SecurionPayError?) -> Void = { _, _ in }
    
    init() {
        threeDS2Service = ThreeDS2Service(bundle: Bundle.securionPay)
    }
    
    func initializeSDK(cardBrand: String, certificate: DirectoryServerCertificate?, sdkLicense: String, bundleIdentifier: String) throws -> [Warning] {
        try? threeDS2Service.cleanup()
        guard let certificate = certificate else { return [] }
        
        let directoryServerInfoList = [DirectoryServerInfo(RID: cardBrand.lowercased(),
                                                           publicKey: certificate.certificate,
                                                           CAs: certificate.caCertificates)]
        
        let clientConfigs: [String]
        let clientEventListener: DebugEventListener?
        let securityEventListener: DebugSecurityEventListener?
        
        #if DEBUG
        clientConfigs = ["LogLevel=3", "MaskSensitive=true"]
        clientEventListener = DebugEventListener()
        securityEventListener = DebugSecurityEventListener()
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
            appBundleID: bundleIdentifier
        )
        let configParameters = try builder.build()
        try configParameters.addParam(group: nil, paramName: "ShowWhiteBoxInProcessingScreen", paramValue: "true")
        
        try threeDS2Service.initialize(
            configParameters: configParameters,
            locale: nil,
            uiCustomization: ThreeDUICustomizationFactory().uiCustomization(),
            clientEventListener: clientEventListener,
            securityEventListener: securityEventListener
        )
        
        return try threeDS2Service.getWarnings().filter { $0.getID() != "SW04"}
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
}
