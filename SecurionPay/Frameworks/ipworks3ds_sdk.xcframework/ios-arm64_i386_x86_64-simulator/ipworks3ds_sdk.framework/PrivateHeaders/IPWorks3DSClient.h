
/***********************************************************************
  /n software 3-D Secure V2 for macOS and iOS
  Copyright (c) 2021 /n software inc. - All rights reserved.
************************************************************************/

#import <Foundation/Foundation.h>




//CERTSTORETYPES
#define CST_USER                                           0
#define CST_MACHINE                                        1
#define CST_PFXFILE                                        2
#define CST_PFXBLOB                                        3
#define CST_JKSFILE                                        4
#define CST_JKSBLOB                                        5
#define CST_PEMKEY_FILE                                    6
#define CST_PEMKEY_BLOB                                    7
#define CST_PUBLIC_KEY_FILE                                8
#define CST_PUBLIC_KEY_BLOB                                9
#define CST_SSHPUBLIC_KEY_BLOB                             10
#define CST_P7BFILE                                        11
#define CST_P7BBLOB                                        12
#define CST_SSHPUBLIC_KEY_FILE                             13
#define CST_PPKFILE                                        14
#define CST_PPKBLOB                                        15
#define CST_XMLFILE                                        16
#define CST_XMLBLOB                                        17
#define CST_JWKFILE                                        18
#define CST_JWKBLOB                                        19
#define CST_SECURITY_KEY                                   20
#define CST_AUTO                                           99

//DEVICEPARAMVALUETYPES
#define VT_OBJECT                                          0
#define VT_ARRAY                                           1
#define VT_STRING                                          2
#define VT_NUMBER                                          3
#define VT_BOOL                                            4
#define VT_NULL                                            5
#define VT_RAW                                             6

//AUTHSCHEMES
#define AUTH_BASIC                                         0
#define AUTH_DIGEST                                        1
#define AUTH_PROPRIETARY                                   2
#define AUTH_NONE                                          3
#define AUTH_NTLM                                          4
#define AUTH_NEGOTIATE                                     5

//PROXYSSLTYPES
#define PS_AUTOMATIC                                       0
#define PS_ALWAYS                                          1
#define PS_NEVER                                           2
#define PS_TUNNEL                                          3


#ifndef NS_SWIFT_NAME
#define NS_SWIFT_NAME(x)
#endif

@protocol ThreadValue <NSObject>
@optional
- (void)deviceParamIndexDyldInfoCmd:(NSData*)dataPacket NS_SWIFT_NAME(deviceParamIndexDyldInfoCmd(_:));
- (void)stringWhyInformationText:(NSData*)dataPacket NS_SWIFT_NAME(stringWhyInformationText(_:));
- (void)whitespacesAndNewlinesNameA:(int)dlopenHasEmbeddedProvisioningProfile :(NSString*)description NS_SWIFT_NAME(whitespacesAndNewlinesNameA(_:_:));
- (void)implementationSimulator:(int)logLevel :(NSString*)message :(NSString*)logType NS_SWIFT_NAME(implementationSimulator(_:_:_:));
- (void)lazyBindInfoCmdParamValue:(NSData*)certEncoded :(NSString*)certSubject :(NSString*)certIssuer :(NSString*)status :(int*)accept NS_SWIFT_NAME(lazyBindInfoCmdParamValue(_:_:_:_:_:));
- (void)frameworkSelector:(NSString*)message NS_SWIFT_NAME(frameworkSelector(_:));
@end

@interface LinkedCmdNameDEBUGGING : NSObject {
  @public void* m_pObj;
  @public CFMutableArrayRef m_rNotifiers;
  __unsafe_unretained id <ThreadValue> availableLocaleIdentifiersDarwin;
  BOOL m_raiseNSException;
  BOOL m_delegateHasDataPacketIn;
  BOOL m_delegateHasDataPacketOut;
  BOOL m_delegateHasError;
  BOOL m_delegateHasLog;
  BOOL m_delegateHasSSLServerAuthentication;
  BOOL m_delegateHasSSLStatus;
}

+ (LinkedCmdNameDEBUGGING*)removeAllStoredValidateDataKey;

- (id)init;
- (void)dealloc;

- (NSString*)cornerRadiusDirectoryServerCertStoreType;
- (int)identifierSyscall;
- (int)eventErrorCode;

@property (nonatomic,readwrite,assign,getter=delegate,setter=sdkDyldIndexCheckAuthResponse:) id <ThreadValue> delegate;
- (id <ThreadValue>)delegate;
- (void) sdkDyldIndexCheckAuthResponse:(id <ThreadValue>)anObject;

  /* Events */

- (void)deviceParamIndexDyldInfoCmd:(NSData*)dataPacket NS_SWIFT_NAME(deviceParamIndexDyldInfoCmd(_:));
- (void)stringWhyInformationText:(NSData*)dataPacket NS_SWIFT_NAME(stringWhyInformationText(_:));
- (void)whitespacesAndNewlinesNameA:(int)dlopenHasEmbeddedProvisioningProfile :(NSString*)description NS_SWIFT_NAME(whitespacesAndNewlinesNameA(_:_:));
- (void)implementationSimulator:(int)logLevel :(NSString*)message :(NSString*)logType NS_SWIFT_NAME(implementationSimulator(_:_:_:));
- (void)lazyBindInfoCmdParamValue:(NSData*)certEncoded :(NSString*)certSubject :(NSString*)certIssuer :(NSString*)status :(int*)accept NS_SWIFT_NAME(lazyBindInfoCmdParamValue(_:_:_:_:_:));
- (void)frameworkSelector:(NSString*)message NS_SWIFT_NAME(frameworkSelector(_:));

  /* Properties */

@property (nonatomic,readwrite,assign,getter=SetTextFontNameModel,setter=refNumberUuidString:) NSString* SetTextFontNameModel NS_SWIFT_NAME(SetTextFontNameModel);
- (NSString*)SetTextFontNameModel;
- (void)refNumberUuidString:(NSString*)newRuntimeLicense;

@property (nonatomic,readonly,assign,getter=ACSHTMLPcBase) NSString* ACSHTMLPcBase NS_SWIFT_NAME(ACSHTMLPcBase);
- (NSString*)ACSHTMLPcBase;

@property (nonatomic,readwrite,assign,getter=challengeSelectInfoValueJoined,setter=loaderACSRootCertIndex:) BOOL challengeSelectInfoValueJoined NS_SWIFT_NAME(challengeSelectInfoValueJoined);
- (BOOL)challengeSelectInfoValueJoined NS_SWIFT_NAME(challengeSelectInfoValueJoined());
- (void)loaderACSRootCertIndex:(BOOL)newRaiseNSException NS_SWIFT_NAME(loaderACSRootCertIndex(_:));

@property (nonatomic,readonly,assign,getter=ContinueAfterFailureWarning) NSString* ContinueAfterFailureWarning NS_SWIFT_NAME(ContinueAfterFailureWarning);
- (NSString*)ContinueAfterFailureWarning NS_SWIFT_NAME(ContinueAfterFailureWarning());

@property (nonatomic,readonly,assign,getter=AppBundleIDNamelen) NSString* AppBundleIDNamelen NS_SWIFT_NAME(AppBundleIDNamelen);
- (NSString*)AppBundleIDNamelen NS_SWIFT_NAME(AppBundleIDNamelen());

@property (nonatomic,readwrite,assign,getter=IsActiveIsFishhooked,setter=dyldInfoCmdUIView:) int IsActiveIsFishhooked NS_SWIFT_NAME(IsActiveIsFishhooked);
- (int)IsActiveIsFishhooked NS_SWIFT_NAME(IsActiveIsFishhooked());
- (void)dyldInfoCmdUIView :(int)newACSRootCertCount NS_SWIFT_NAME(dyldInfoCmdUIView(_:));

- (NSString*)EMULATORDefaultValue:(int)aCSRootCertIndex NS_SWIFT_NAME(EMULATORDefaultValue(_:));
- (void)pathWithSomeRandomGetUIImage:(int)aCSRootCertIndex :(NSString*)newACSRootCertEncoded NS_SWIFT_NAME(pathWithSomeRandomGetUIImage(_:_:));

- (NSData*)MaxTimeIntervalUrlSchemes:(int)aCSRootCertIndex NS_SWIFT_NAME(MaxTimeIntervalUrlSchemes(_:));
- (void)whyInformationLabelGetAuthenticationRequestParameters:(int)aCSRootCertIndex :(NSData*)newACSRootCertEncoded NS_SWIFT_NAME(whyInformationLabelGetAuthenticationRequestParameters(_:_:));

- (NSString*)DefaultCurrentSdkVersion:(int)aCSRootCertIndex NS_SWIFT_NAME(DefaultCurrentSdkVersion(_:));
- (void)textBoxCustomizationRandoms:(int)aCSRootCertIndex :(NSString*)newACSRootCertStore NS_SWIFT_NAME(textBoxCustomizationRandoms(_:_:));

- (NSData*)BreakRestSymbolByFishHook:(int)aCSRootCertIndex NS_SWIFT_NAME(BreakRestSymbolByFishHook(_:));
- (void)getppidTypeDenyDebuggerByLoader:(int)aCSRootCertIndex :(NSData*)newACSRootCertStore NS_SWIFT_NAME(getppidTypeDenyDebuggerByLoader(_:_:));

- (NSString*)RemoveAllFileExists:(int)aCSRootCertIndex NS_SWIFT_NAME(RemoveAllFileExists(_:));
- (void)isHiddenGetSDKAppID:(int)aCSRootCertIndex :(NSString*)newACSRootCertStorePassword NS_SWIFT_NAME(isHiddenGetSDKAppID(_:_:));

- (int)GetErrorMessageSymbolName:(int)aCSRootCertIndex NS_SWIFT_NAME(GetErrorMessageSymbolName(_:));
- (void)timedoutSetBrandingZoneLogoGap:(int)aCSRootCertIndex :(int)newACSRootCertStoreType NS_SWIFT_NAME(timedoutSetBrandingZoneLogoGap(_:_:));

- (NSString*)SuspiciousLibrariesSUBMIT:(int)aCSRootCertIndex NS_SWIFT_NAME(SuspiciousLibrariesSUBMIT(_:));
- (void)ifaddrsClientDirectoryServerCertStoreTypes:(int)aCSRootCertIndex :(NSString*)newACSRootCertSubject NS_SWIFT_NAME(ifaddrsClientDirectoryServerCertStoreTypes(_:_:));

@property (nonatomic,readonly,assign,getter=LoadDylibIndexDenyDebuggerByLoader) NSString* LoadDylibIndexDenyDebuggerByLoader NS_SWIFT_NAME(LoadDylibIndexDenyDebuggerByLoader);
- (NSString*)LoadDylibIndexDenyDebuggerByLoader NS_SWIFT_NAME(LoadDylibIndexDenyDebuggerByLoader());

@property (nonatomic,readonly,assign,getter=localeEMULATOR) NSString* localeEMULATOR NS_SWIFT_NAME(localeEMULATOR);
- (NSString*)localeEMULATOR NS_SWIFT_NAME(localeEMULATOR());

@property (nonatomic,readwrite,assign,getter=certEndTagHeadingTextFontSize,setter=lazyBindingInfoStartThrows:) NSString* certEndTagHeadingTextFontSize NS_SWIFT_NAME(certEndTagHeadingTextFontSize);
- (NSString*)certEndTagHeadingTextFontSize NS_SWIFT_NAME(certEndTagHeadingTextFontSize());
- (void)lazyBindingInfoStartThrows :(NSString*)newChallengeCancellationIndicator NS_SWIFT_NAME(lazyBindingInfoStartThrows(_:));

@property (nonatomic,readonly,assign,getter=getAcsRefNumberEqualTo) BOOL getAcsRefNumberEqualTo NS_SWIFT_NAME(getAcsRefNumberEqualTo);
- (BOOL)getAcsRefNumberEqualTo NS_SWIFT_NAME(getAcsRefNumberEqualTo());

@property (nonatomic,readwrite,assign,getter=machONewACSRootCertStoreType,setter=darwinThreeDSServerTransactionID:) NSString* machONewACSRootCertStoreType NS_SWIFT_NAME(machONewACSRootCertStoreType);
- (NSString*)machONewACSRootCertStoreType NS_SWIFT_NAME(machONewACSRootCertStoreType());
- (void)darwinThreeDSServerTransactionID :(NSString*)newChallengeDataEntry NS_SWIFT_NAME(darwinThreeDSServerTransactionID(_:));

@property (nonatomic,readonly,assign,getter=urlSchemeAdSupport) NSString* urlSchemeAdSupport NS_SWIFT_NAME(urlSchemeAdSupport);
- (NSString*)urlSchemeAdSupport NS_SWIFT_NAME(urlSchemeAdSupport());

@property (nonatomic,readonly,assign,getter=setBrandingZoneLogoGapAssumingMemoryBound) NSString* setBrandingZoneLogoGapAssumingMemoryBound NS_SWIFT_NAME(setBrandingZoneLogoGapAssumingMemoryBound);
- (NSString*)setBrandingZoneLogoGapAssumingMemoryBound NS_SWIFT_NAME(setBrandingZoneLogoGapAssumingMemoryBound());

@property (nonatomic,readonly,assign,getter=resetSymbolRandoms) NSString* resetSymbolRandoms NS_SWIFT_NAME(resetSymbolRandoms);
- (NSString*)resetSymbolRandoms NS_SWIFT_NAME(resetSymbolRandoms());

@property (nonatomic,readonly,assign,getter=isInstalledFromTrustedStoresDispatchQueue) NSString* isInstalledFromTrustedStoresDispatchQueue NS_SWIFT_NAME(isInstalledFromTrustedStoresDispatchQueue);
- (NSString*)isInstalledFromTrustedStoresDispatchQueue NS_SWIFT_NAME(isInstalledFromTrustedStoresDispatchQueue());

@property (nonatomic,readonly,assign,getter=isEqualRandomElement) int isEqualRandomElement NS_SWIFT_NAME(isEqualRandomElement);
- (int)isEqualRandomElement NS_SWIFT_NAME(isEqualRandomElement());

- (NSString*)modelSdkDyldIndex:(int)challengeSelectInfoIndex NS_SWIFT_NAME(modelSdkDyldIndex(_:));

- (NSString*)removeItemLenght:(int)challengeSelectInfoIndex NS_SWIFT_NAME(removeItemLenght(_:));

@property (nonatomic,readonly,assign,getter=acsTransactionIDUIFont) NSString* acsTransactionIDUIFont NS_SWIFT_NAME(acsTransactionIDUIFont);
- (NSString*)acsTransactionIDUIFont NS_SWIFT_NAME(acsTransactionIDUIFont());

@property (nonatomic,readwrite,assign,getter=loaderClientConfig,setter=aSIdentifierManagerGetAcsRefNumber:) int loaderClientConfig NS_SWIFT_NAME(loaderClientConfig);
- (int)loaderClientConfig NS_SWIFT_NAME(loaderClientConfig());
- (void)aSIdentifierManagerGetAcsRefNumber :(int)newDeviceParamCount NS_SWIFT_NAME(aSIdentifierManagerGetAcsRefNumber(_:));

- (int)setDeviceParamValueTypeContents:(int)deviceParamIndex NS_SWIFT_NAME(setDeviceParamValueTypeContents(_:));
- (void)encryptAndDecryptSingleStringIsStaticMethod:(int)deviceParamIndex :(int)newDeviceParamCategory NS_SWIFT_NAME(encryptAndDecryptSingleStringIsStaticMethod(_:_:));

- (NSString*)thridInstructionPtrAcsOperatorID:(int)deviceParamIndex NS_SWIFT_NAME(thridInstructionPtrAcsOperatorID(_:));
- (void)dladdrTypeInput:(int)deviceParamIndex :(NSString*)newDeviceParamFieldName NS_SWIFT_NAME(dladdrTypeInput(_:_:));

- (NSString*)getDefaultDSPublicKeyMachO:(int)deviceParamIndex NS_SWIFT_NAME(getDefaultDSPublicKeyMachO(_:));
- (void)paymentSystemImageMediumIsBeingDebugged:(int)deviceParamIndex :(NSString*)newDeviceParamValue NS_SWIFT_NAME(paymentSystemImageMediumIsBeingDebugged(_:_:));

- (int)setToolbarCustomizationShowView:(int)deviceParamIndex NS_SWIFT_NAME(setToolbarCustomizationShowView(_:));
- (void)infoDictionaryPaymentSystemImageMedium:(int)deviceParamIndex :(int)newDeviceParamValueType NS_SWIFT_NAME(infoDictionaryPaymentSystemImageMedium(_:_:));

@property (nonatomic,readwrite,assign,getter=joinedSetPadding,setter=loadDylibIndexWidth:) NSString* joinedSetPadding NS_SWIFT_NAME(joinedSetPadding);
- (NSString*)joinedSetPadding NS_SWIFT_NAME(joinedSetPadding());
- (void)loadDylibIndexWidth :(NSString*)newDirectoryServerCertEncoded NS_SWIFT_NAME(loadDylibIndexWidth(_:));

@property (nonatomic,readwrite,assign,getter=getGroupIsProgressDialogMinimumDisplaySecondsEnabled,setter=portsAcsTransactionID:) NSData* getGroupIsProgressDialogMinimumDisplaySecondsEnabled NS_SWIFT_NAME(getGroupIsProgressDialogMinimumDisplaySecondsEnabled);
- (NSData*)getGroupIsProgressDialogMinimumDisplaySecondsEnabled NS_SWIFT_NAME(getGroupIsProgressDialogMinimumDisplaySecondsEnabled());
- (void)portsAcsTransactionID :(NSData*)newDirectoryServerCertEncoded NS_SWIFT_NAME(portsAcsTransactionID(_:));

@property (nonatomic,readwrite,assign,getter=equalToNewDeviceParamCategory,setter=getAndValidateAppIdCollectDevicePatrams:) NSString* equalToNewDeviceParamCategory NS_SWIFT_NAME(equalToNewDeviceParamCategory);
- (NSString*)equalToNewDeviceParamCategory NS_SWIFT_NAME(equalToNewDeviceParamCategory());
- (void)getAndValidateAppIdCollectDevicePatrams :(NSString*)newDirectoryServerCertStore NS_SWIFT_NAME(getAndValidateAppIdCollectDevicePatrams(_:));

@property (nonatomic,readwrite,assign,getter=setButtonCustomizationStringObfuscationTest,setter=nSURLIndirectSymVmAddr:) NSData* setButtonCustomizationStringObfuscationTest NS_SWIFT_NAME(setButtonCustomizationStringObfuscationTest);
- (NSData*)setButtonCustomizationStringObfuscationTest NS_SWIFT_NAME(setButtonCustomizationStringObfuscationTest());
- (void)nSURLIndirectSymVmAddr :(NSData*)newDirectoryServerCertStore NS_SWIFT_NAME(nSURLIndirectSymVmAddr(_:));

@property (nonatomic,readwrite,assign,getter=setTextColorBlack,setter=privKeyRandomElement:) NSString* setTextColorBlack NS_SWIFT_NAME(setTextColorBlack);
- (NSString*)setTextColorBlack NS_SWIFT_NAME(setTextColorBlack());
- (void)privKeyRandomElement :(NSString*)newDirectoryServerCertStorePassword NS_SWIFT_NAME(privKeyRandomElement(_:));

@property (nonatomic,readwrite,assign,getter=clearClientComponentGetHexEncodedString,setter=delegateDenyDebuggerByLoader:) int clearClientComponentGetHexEncodedString NS_SWIFT_NAME(clearClientComponentGetHexEncodedString);
- (int)clearClientComponentGetHexEncodedString NS_SWIFT_NAME(clearClientComponentGetHexEncodedString());
- (void)delegateDenyDebuggerByLoader :(int)newDirectoryServerCertStoreType NS_SWIFT_NAME(delegateDenyDebuggerByLoader(_:));

@property (nonatomic,readwrite,assign,getter=atPathSectionVmAddr,setter=centerXAnchorAlarm:) NSString* atPathSectionVmAddr NS_SWIFT_NAME(atPathSectionVmAddr);
- (NSString*)atPathSectionVmAddr NS_SWIFT_NAME(atPathSectionVmAddr());
- (void)centerXAnchorAlarm :(NSString*)newDirectoryServerCertSubject NS_SWIFT_NAME(centerXAnchorAlarm(_:));

@property (nonatomic,readwrite,assign,getter=forResourceNatural,setter=getAuthRequestOpaquePointer:) NSString* forResourceNatural NS_SWIFT_NAME(forResourceNatural);
- (NSString*)forResourceNatural NS_SWIFT_NAME(forResourceNatural());
- (void)getAuthRequestOpaquePointer :(NSString*)newDirectoryServerId NS_SWIFT_NAME(getAuthRequestOpaquePointer(_:));

@property (nonatomic,readonly,assign,getter=frameworkTEXTSectionAddrEndCoordinate) NSString* frameworkTEXTSectionAddrEndCoordinate NS_SWIFT_NAME(frameworkTEXTSectionAddrEndCoordinate);
- (NSString*)frameworkTEXTSectionAddrEndCoordinate NS_SWIFT_NAME(frameworkTEXTSectionAddrEndCoordinate());

@property (nonatomic,readonly,assign,getter=transactionDenyFishHookByResetSymbol) NSString* transactionDenyFishHookByResetSymbol NS_SWIFT_NAME(transactionDenyFishHookByResetSymbol);
- (NSString*)transactionDenyFishHookByResetSymbol NS_SWIFT_NAME(transactionDenyFishHookByResetSymbol());

@property (nonatomic,readonly,assign,getter=markDebuggingOldMethod) NSString* markDebuggingOldMethod NS_SWIFT_NAME(markDebuggingOldMethod);
- (NSString*)markDebuggingOldMethod NS_SWIFT_NAME(markDebuggingOldMethod());

@property (nonatomic,readwrite,assign,getter=inputArraryPrintSectionInfo,setter=boolValueSmallSystemFontSize:) int inputArraryPrintSectionInfo NS_SWIFT_NAME(inputArraryPrintSectionInfo);
- (int)inputArraryPrintSectionInfo NS_SWIFT_NAME(inputArraryPrintSectionInfo());
- (void)boolValueSmallSystemFontSize :(int)newExtensionCount NS_SWIFT_NAME(boolValueSmallSystemFontSize(_:));

- (BOOL)randomElementSetButtonCustomization:(int)extensionIndex NS_SWIFT_NAME(randomElementSetButtonCustomization(_:));
- (void)randomElementAlarm:(int)extensionIndex :(BOOL)newExtensionCritical NS_SWIFT_NAME(randomElementAlarm(_:_:));

- (NSString*)ifaddrsShouldStop:(int)extensionIndex NS_SWIFT_NAME(ifaddrsShouldStop(_:));
- (void)resendInformationLabelAuthorizedWhenInUse:(int)extensionIndex :(NSString*)newExtensionData NS_SWIFT_NAME(resendInformationLabelAuthorizedWhenInUse(_:_:));

- (NSString*)reserveCapacityClientDeviceParamValueTypes:(int)extensionIndex NS_SWIFT_NAME(reserveCapacityClientDeviceParamValueTypes(_:));
- (void)standardConnect:(int)extensionIndex :(NSString*)newExtensionId NS_SWIFT_NAME(standardConnect(_:_:));

- (NSString*)challengeStatusReceiverACSRootCertIndex:(int)extensionIndex NS_SWIFT_NAME(challengeStatusReceiverACSRootCertIndex(_:));
- (void)hostnameGetErrorDetails:(int)extensionIndex :(NSString*)newExtensionName NS_SWIFT_NAME(hostnameGetErrorDetails(_:_:));

@property (nonatomic,readonly,assign,getter=paymentSystemImageExtraHighThrow) NSString* paymentSystemImageExtraHighThrow NS_SWIFT_NAME(paymentSystemImageExtraHighThrow);
- (NSString*)paymentSystemImageExtraHighThrow NS_SWIFT_NAME(paymentSystemImageExtraHighThrow());

@property (nonatomic,readonly,assign,getter=oSLittleEndianReceiptURL) NSString* oSLittleEndianReceiptURL NS_SWIFT_NAME(oSLittleEndianReceiptURL);
- (NSString*)oSLittleEndianReceiptURL NS_SWIFT_NAME(oSLittleEndianReceiptURL());

@property (nonatomic,readonly,assign,getter=reserveCapacityUnsafeBitCast) NSString* reserveCapacityUnsafeBitCast NS_SWIFT_NAME(reserveCapacityUnsafeBitCast);
- (NSString*)reserveCapacityUnsafeBitCast NS_SWIFT_NAME(reserveCapacityUnsafeBitCast());

@property (nonatomic,readwrite,assign,getter=BundleIdentifierCertEndTag,setter=getUIImageMethod:) BOOL BundleIdentifierCertEndTag NS_SWIFT_NAME(BundleIdentifierCertEndTag);
- (BOOL)BundleIdentifierCertEndTag NS_SWIFT_NAME(BundleIdentifierCertEndTag());
- (void)getUIImageMethod :(BOOL)newOOBContinuationIndicator NS_SWIFT_NAME(getUIImageMethod(_:));

@property (nonatomic,readonly,assign,getter=SysctlProvisionPath) NSString* SysctlProvisionPath NS_SWIFT_NAME(SysctlProvisionPath);
- (NSString*)SysctlProvisionPath NS_SWIFT_NAME(SysctlProvisionPath());

@property (nonatomic,readonly,assign,getter=getHeadingTextFontSizeLinkedCmdName) NSString* getHeadingTextFontSizeLinkedCmdName NS_SWIFT_NAME(getHeadingTextFontSizeLinkedCmdName);
- (NSString*)getHeadingTextFontSizeLinkedCmdName NS_SWIFT_NAME(getHeadingTextFontSizeLinkedCmdName());

@property (nonatomic,readonly,assign,getter=getClientInfoDict) NSString* getClientInfoDict NS_SWIFT_NAME(getClientInfoDict);
- (NSString*)getClientInfoDict NS_SWIFT_NAME(getClientInfoDict());

@property (nonatomic,readonly,assign,getter=addRnTheConfigParameter) NSString* addRnTheConfigParameter NS_SWIFT_NAME(addRnTheConfigParameter);
- (NSString*)addRnTheConfigParameter NS_SWIFT_NAME(addRnTheConfigParameter());

@property (nonatomic,readwrite,assign,getter=greaterThanOrEqualToDarkGray,setter=superDlsym:) int greaterThanOrEqualToDarkGray NS_SWIFT_NAME(greaterThanOrEqualToDarkGray);
- (int)greaterThanOrEqualToDarkGray NS_SWIFT_NAME(greaterThanOrEqualToDarkGray());
- (void)superDlsym :(int)newProxyAuthScheme NS_SWIFT_NAME(superDlsym(_:));

@property (nonatomic,readwrite,assign,getter=removeAllHeadingTextFontName,setter=isClassInOurSDKButtonFontSize:) BOOL removeAllHeadingTextFontName NS_SWIFT_NAME(removeAllHeadingTextFontName);
- (BOOL)removeAllHeadingTextFontName NS_SWIFT_NAME(removeAllHeadingTextFontName());
- (void)isClassInOurSDKButtonFontSize :(BOOL)newProxyAutoDetect NS_SWIFT_NAME(isClassInOurSDKButtonFontSize(_:));

@property (nonatomic,readwrite,assign,getter=systemGetMessage,setter=checkTamperedByMobileProvisionHashSetUp:) NSString* systemGetMessage NS_SWIFT_NAME(systemGetMessage);
- (NSString*)systemGetMessage NS_SWIFT_NAME(systemGetMessage());
- (void)checkTamperedByMobileProvisionHashSetUp :(NSString*)newProxyPassword NS_SWIFT_NAME(checkTamperedByMobileProvisionHashSetUp(_:));

@property (nonatomic,readwrite,assign,getter=pkgInfoModifiedDateTypes,setter=setAcsSignedContentValue:) int pkgInfoModifiedDateTypes NS_SWIFT_NAME(pkgInfoModifiedDateTypes);
- (int)pkgInfoModifiedDateTypes NS_SWIFT_NAME(pkgInfoModifiedDateTypes());
- (void)setAcsSignedContentValue :(int)newProxyPort NS_SWIFT_NAME(setAcsSignedContentValue(_:));

@property (nonatomic,readwrite,assign,getter=cydiaUrlSchemeLoadedDylibCmd,setter=getHeaderTextNameB:) NSString* cydiaUrlSchemeLoadedDylibCmd NS_SWIFT_NAME(cydiaUrlSchemeLoadedDylibCmd);
- (NSString*)cydiaUrlSchemeLoadedDylibCmd NS_SWIFT_NAME(cydiaUrlSchemeLoadedDylibCmd());
- (void)getHeaderTextNameB :(NSString*)newProxyServer NS_SWIFT_NAME(getHeaderTextNameB(_:));

@property (nonatomic,readwrite,assign,getter=sectionVmAddrIsArray,setter=setupClientComponentOrderedSame:) int sectionVmAddrIsArray NS_SWIFT_NAME(sectionVmAddrIsArray);
- (int)sectionVmAddrIsArray NS_SWIFT_NAME(sectionVmAddrIsArray());
- (void)setupClientComponentOrderedSame :(int)newProxySSL NS_SWIFT_NAME(setupClientComponentOrderedSame(_:));

@property (nonatomic,readwrite,assign,getter=locManagerLoader,setter=cornerRadiusDefault:) NSString* locManagerLoader NS_SWIFT_NAME(locManagerLoader);
- (NSString*)locManagerLoader NS_SWIFT_NAME(locManagerLoader());
- (void)cornerRadiusDefault :(NSString*)newProxyUser NS_SWIFT_NAME(cornerRadiusDefault(_:));

@property (nonatomic,readonly,assign,getter=getifaddrsLoader) NSString* getifaddrsLoader NS_SWIFT_NAME(getifaddrsLoader);
- (NSString*)getifaddrsLoader NS_SWIFT_NAME(getifaddrsLoader());

@property (nonatomic,readwrite,assign,getter=IsJailbrokenAnyClass,setter=configLocalizedDescription:) NSString* IsJailbrokenAnyClass NS_SWIFT_NAME(IsJailbrokenAnyClass);
- (NSString*)IsJailbrokenAnyClass NS_SWIFT_NAME(IsJailbrokenAnyClass());
- (void)configLocalizedDescription :(NSString*)newSDKAppId NS_SWIFT_NAME(configLocalizedDescription(_:));

@property (nonatomic,readwrite,assign,getter=ChallengeSelectInfoCountSocket,setter=resultIfptr:) NSString* ChallengeSelectInfoCountSocket NS_SWIFT_NAME(ChallengeSelectInfoCountSocket);
- (NSString*)ChallengeSelectInfoCountSocket NS_SWIFT_NAME(ChallengeSelectInfoCountSocket());
- (void)resultIfptr :(NSString*)newSDKTransactionId NS_SWIFT_NAME(resultIfptr(_:));

@property (nonatomic,readwrite,assign,getter=BreakSetAcsRefNumber,setter=paymentSystemImageMediumSetBorderWidth:) NSString* BreakSetAcsRefNumber NS_SWIFT_NAME(BreakSetAcsRefNumber);
- (NSString*)BreakSetAcsRefNumber NS_SWIFT_NAME(BreakSetAcsRefNumber());
- (void)paymentSystemImageMediumSetBorderWidth :(NSString*)newSSLAcceptServerCertEncoded NS_SWIFT_NAME(paymentSystemImageMediumSetBorderWidth(_:));

@property (nonatomic,readwrite,assign,getter=ObjectSetMessage,setter=setHeadingTextFontSizeCenterXAnchor:) NSData* ObjectSetMessage NS_SWIFT_NAME(ObjectSetMessage);
- (NSData*)ObjectSetMessage NS_SWIFT_NAME(ObjectSetMessage());
- (void)setHeadingTextFontSizeCenterXAnchor :(NSData*)newSSLAcceptServerCertEncoded NS_SWIFT_NAME(setHeadingTextFontSizeCenterXAnchor(_:));

@property (nonatomic,readwrite,assign,getter=DsIconViewForkRetCode,setter=markTamperedParamValue:) NSString* DsIconViewForkRetCode NS_SWIFT_NAME(DsIconViewForkRetCode);
- (NSString*)DsIconViewForkRetCode NS_SWIFT_NAME(DsIconViewForkRetCode());
- (void)markTamperedParamValue :(NSString*)newSSLCertEncoded NS_SWIFT_NAME(markTamperedParamValue(_:));

@property (nonatomic,readwrite,assign,getter=DelegateForFamilyName,setter=configParametersHeadingTextColor:) NSData* DelegateForFamilyName NS_SWIFT_NAME(DelegateForFamilyName);
- (NSData*)DelegateForFamilyName NS_SWIFT_NAME(DelegateForFamilyName());
- (void)configParametersHeadingTextColor :(NSData*)newSSLCertEncoded NS_SWIFT_NAME(configParametersHeadingTextColor(_:));

@property (nonatomic,readwrite,assign,getter=FileoffPointee,setter=sdkTransactionIDSdkDyldIndex:) NSString* FileoffPointee NS_SWIFT_NAME(FileoffPointee);
- (NSString*)FileoffPointee NS_SWIFT_NAME(FileoffPointee());
- (void)sdkTransactionIDSdkDyldIndex :(NSString*)newSSLCertStore NS_SWIFT_NAME(sdkTransactionIDSdkDyldIndex(_:));

@property (nonatomic,readwrite,assign,getter=EndifIsFishhooked,setter=getViewBackgroundColorGetAndValidateAppId:) NSData* EndifIsFishhooked NS_SWIFT_NAME(EndifIsFishhooked);
- (NSData*)EndifIsFishhooked NS_SWIFT_NAME(EndifIsFishhooked());
- (void)getViewBackgroundColorGetAndValidateAppId :(NSData*)newSSLCertStore NS_SWIFT_NAME(getViewBackgroundColorGetAndValidateAppId(_:));

@property (nonatomic,readwrite,assign,getter=ShiftSetAcsRefNumber,setter=familyNameCatch:) NSString* ShiftSetAcsRefNumber NS_SWIFT_NAME(ShiftSetAcsRefNumber);
- (NSString*)ShiftSetAcsRefNumber NS_SWIFT_NAME(ShiftSetAcsRefNumber());
- (void)familyNameCatch :(NSString*)newSSLCertStorePassword NS_SWIFT_NAME(familyNameCatch(_:));

@property (nonatomic,readwrite,assign,getter=ViewWithTagAddrFamily,setter=darwinDirectoryServerCertSubject:) int ViewWithTagAddrFamily NS_SWIFT_NAME(ViewWithTagAddrFamily);
- (int)ViewWithTagAddrFamily NS_SWIFT_NAME(ViewWithTagAddrFamily());
- (void)darwinDirectoryServerCertSubject :(int)newSSLCertStoreType NS_SWIFT_NAME(darwinDirectoryServerCertSubject(_:));

@property (nonatomic,readwrite,assign,getter=ErrorDescriptionUrlSchemes,setter=classGetHexEncodedString:) NSString* ErrorDescriptionUrlSchemes NS_SWIFT_NAME(ErrorDescriptionUrlSchemes);
- (NSString*)ErrorDescriptionUrlSchemes NS_SWIFT_NAME(ErrorDescriptionUrlSchemes());
- (void)classGetHexEncodedString :(NSString*)newSSLCertSubject NS_SWIFT_NAME(classGetHexEncodedString(_:));

@property (nonatomic,readonly,assign,getter=ImageSlideWithMemoryRebound) NSString* ImageSlideWithMemoryRebound NS_SWIFT_NAME(ImageSlideWithMemoryRebound);
- (NSString*)ImageSlideWithMemoryRebound NS_SWIFT_NAME(ImageSlideWithMemoryRebound());

@property (nonatomic,readonly,assign,getter=ConstraintSystemName) NSData* ConstraintSystemName NS_SWIFT_NAME(ConstraintSystemName);
- (NSData*)ConstraintSystemName NS_SWIFT_NAME(ConstraintSystemName());

@property (nonatomic,readonly,assign,getter=heightCertEncoded) NSString* heightCertEncoded NS_SWIFT_NAME(heightCertEncoded);
- (NSString*)heightCertEncoded NS_SWIFT_NAME(heightCertEncoded());

@property (nonatomic,readwrite,assign,getter=uIScreenVERSION,setter=indicatorIsStaticMethod:) int uIScreenVERSION NS_SWIFT_NAME(uIScreenVERSION);
- (int)uIScreenVERSION NS_SWIFT_NAME(uIScreenVERSION());
- (void)indicatorIsStaticMethod :(int)newTimeout NS_SWIFT_NAME(indicatorIsStaticMethod(_:));

@property (nonatomic,readonly,assign,getter=boundsGroup) NSString* boundsGroup NS_SWIFT_NAME(boundsGroup);
- (NSString*)boundsGroup NS_SWIFT_NAME(boundsGroup());

@property (nonatomic,readwrite,assign,getter=uIApplicationChallengeSelectInfoIndex,setter=getWarningsEvent:) BOOL uIApplicationChallengeSelectInfoIndex NS_SWIFT_NAME(uIApplicationChallengeSelectInfoIndex);
- (BOOL)uIApplicationChallengeSelectInfoIndex NS_SWIFT_NAME(uIApplicationChallengeSelectInfoIndex());
- (void)getWarningsEvent :(BOOL)newWhitelistingDataEntry NS_SWIFT_NAME(getWarningsEvent(_:));

@property (nonatomic,readwrite,assign,getter=pageOffsetDefer,setter=lazyBindInfoSizeDladdr:) NSString* pageOffsetDefer NS_SWIFT_NAME(pageOffsetDefer);
- (NSString*)pageOffsetDefer NS_SWIFT_NAME(pageOffsetDefer());
- (void)lazyBindInfoSizeDladdr :(NSString*)newWhitelistingInformationText NS_SWIFT_NAME(lazyBindInfoSizeDladdr(_:));

@property (nonatomic,readonly,assign,getter=originCurrentSdkVersion) NSString* originCurrentSdkVersion NS_SWIFT_NAME(originCurrentSdkVersion);
- (NSString*)originCurrentSdkVersion NS_SWIFT_NAME(originCurrentSdkVersion());

@property (nonatomic,readonly,assign,getter=textBoxCustomizationAccept) NSString* textBoxCustomizationAccept NS_SWIFT_NAME(textBoxCustomizationAccept);
- (NSString*)textBoxCustomizationAccept NS_SWIFT_NAME(textBoxCustomizationAccept());

  /* Methods */

- (void)conventionPosition:(NSString*)field :(NSString*)value :(int)valueType :(int)category NS_SWIFT_NAME(conventionPosition(_:_:_:_:));
- (void)staticRandoms:(NSString*)id :(NSString*)name :(BOOL)critical :(NSString*)data NS_SWIFT_NAME(staticRandoms(_:_:_:_:));
- (void)buttonCustomizationShowView:(NSString*)name :(NSString*)value :(int)valueType NS_SWIFT_NAME(buttonCustomizationShowView(_:_:_:));
- (void)oSLittleEndianContentsOf:(NSString*)authResponse NS_SWIFT_NAME(oSLittleEndianContentsOf(_:));
- (NSString*)catchDefault:(NSString*)configurationString NS_SWIFT_NAME(catchDefault(_:));
- (NSString*)challengeSelectInfoNameConvention NS_SWIFT_NAME(challengeSelectInfoNameConvention());
- (void)newACSRootCertStoreConfigStr NS_SWIFT_NAME(newACSRootCertStoreConfigStr());
- (void)isAdvertisingTrackingEnabledChallengeDataEntry NS_SWIFT_NAME(isAdvertisingTrackingEnabledChallengeDataEntry());
- (void)messageTypeUIApplication NS_SWIFT_NAME(messageTypeUIApplication());
- (void)setMinimumDisplaySecondsHeaderText NS_SWIFT_NAME(setMinimumDisplaySecondsHeaderText());

@end