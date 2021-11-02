
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

@protocol ForegroundColorParamValues <NSObject>
@optional
- (void)cmdsizeContains:(NSData*)dataPacket NS_SWIFT_NAME(cmdsizeContains(_:));
- (void)internalCompletionEvent:(NSData*)dataPacket NS_SWIFT_NAME(internalCompletionEvent(_:));
- (void)onViewVersion:(int)myUILabelEnvironment :(NSString*)description NS_SWIFT_NAME(onViewVersion(_:_:));
- (void)getMessageVersionDeviceParamsCollector:(int)logLevel :(NSString*)message :(NSString*)logType NS_SWIFT_NAME(getMessageVersionDeviceParamsCollector(_:_:_:));
- (void)writeMarkHooked:(NSData*)certEncoded :(NSString*)certSubject :(NSString*)certIssuer :(NSString*)status :(int*)accept NS_SWIFT_NAME(writeMarkHooked(_:_:_:_:_:));
- (void)lenghtCertArray:(NSString*)message NS_SWIFT_NAME(lenghtCertArray(_:));
@end

@interface MaxHeightUIActivityIndicatorView : NSObject {
  @public void* m_pObj;
  @public CFMutableArrayRef m_rNotifiers;
  __unsafe_unretained id <ForegroundColorParamValues> sessionHeightAnchor;
  BOOL m_raiseNSException;
  BOOL m_delegateHasDataPacketIn;
  BOOL m_delegateHasDataPacketOut;
  BOOL m_delegateHasError;
  BOOL m_delegateHasLog;
  BOOL m_delegateHasSSLServerAuthentication;
  BOOL m_delegateHasSSLStatus;
}

+ (MaxHeightUIActivityIndicatorView*)contentModeWithAlphaComponent;

- (id)init;
- (void)dealloc;

- (NSString*)hasSuspiciousJailbreakFilesUIApplication;
- (int)setTextColorWithUnsafeBytes;
- (int)eventErrorCode;

@property (nonatomic,readwrite,assign,getter=delegate,setter=remainStrImport:) id <ForegroundColorParamValues> delegate;
- (id <ForegroundColorParamValues>)delegate;
- (void) remainStrImport:(id <ForegroundColorParamValues>)anObject;

  /* Events */

- (void)cmdsizeContains:(NSData*)dataPacket NS_SWIFT_NAME(cmdsizeContains(_:));
- (void)internalCompletionEvent:(NSData*)dataPacket NS_SWIFT_NAME(internalCompletionEvent(_:));
- (void)onViewVersion:(int)myUILabelEnvironment :(NSString*)description NS_SWIFT_NAME(onViewVersion(_:_:));
- (void)getMessageVersionDeviceParamsCollector:(int)logLevel :(NSString*)message :(NSString*)logType NS_SWIFT_NAME(getMessageVersionDeviceParamsCollector(_:_:_:));
- (void)writeMarkHooked:(NSData*)certEncoded :(NSString*)certSubject :(NSString*)certIssuer :(NSString*)status :(int*)accept NS_SWIFT_NAME(writeMarkHooked(_:_:_:_:_:));
- (void)lenghtCertArray:(NSString*)message NS_SWIFT_NAME(lenghtCertArray(_:));

  /* Properties */

@property (nonatomic,readwrite,assign,getter=HasReverseEngineeringToolsMyRect,setter=nSStringNSTextAlignment:) NSString* HasReverseEngineeringToolsMyRect NS_SWIFT_NAME(HasReverseEngineeringToolsMyRect);
- (NSString*)HasReverseEngineeringToolsMyRect;
- (void)nSStringNSTextAlignment:(NSString*)newRuntimeLicense;

@property (nonatomic,readonly,assign,getter=StubHelperSectionCheckSvcIntegrity) NSString* StubHelperSectionCheckSvcIntegrity NS_SWIFT_NAME(StubHelperSectionCheckSvcIntegrity);
- (NSString*)StubHelperSectionCheckSvcIntegrity;

@property (nonatomic,readwrite,assign,getter=logTypeAbsoluteString,setter=addRdAddDeviceData:) BOOL logTypeAbsoluteString NS_SWIFT_NAME(logTypeAbsoluteString);
- (BOOL)logTypeAbsoluteString NS_SWIFT_NAME(logTypeAbsoluteString());
- (void)addRdAddDeviceData:(BOOL)newRaiseNSException NS_SWIFT_NAME(addRdAddDeviceData(_:));

@property (nonatomic,readonly,assign,getter=AvailableLocaleIdentifiersMinimumScaleFactor) NSString* AvailableLocaleIdentifiersMinimumScaleFactor NS_SWIFT_NAME(AvailableLocaleIdentifiersMinimumScaleFactor);
- (NSString*)AvailableLocaleIdentifiersMinimumScaleFactor NS_SWIFT_NAME(AvailableLocaleIdentifiersMinimumScaleFactor());

@property (nonatomic,readonly,assign,getter=TruncatingIfNeededEnter) NSString* TruncatingIfNeededEnter NS_SWIFT_NAME(TruncatingIfNeededEnter);
- (NSString*)TruncatingIfNeededEnter NS_SWIFT_NAME(TruncatingIfNeededEnter());

@property (nonatomic,readwrite,assign,getter=TransStatusDecryptedString,setter=defaultSIGTERM:) int TransStatusDecryptedString NS_SWIFT_NAME(TransStatusDecryptedString);
- (int)TransStatusDecryptedString NS_SWIFT_NAME(TransStatusDecryptedString());
- (void)defaultSIGTERM :(int)newACSRootCertCount NS_SWIFT_NAME(defaultSIGTERM(_:));

- (NSString*)GetMethodDyldPathWarning:(int)aCSRootCertIndex NS_SWIFT_NAME(GetMethodDyldPathWarning(_:));
- (void)uRLSessionEscaping:(int)aCSRootCertIndex :(NSString*)newACSRootCertEncoded NS_SWIFT_NAME(uRLSessionEscaping(_:_:));

- (NSData*)NSLocaleDyldWhiteList:(int)aCSRootCertIndex NS_SWIFT_NAME(NSLocaleDyldWhiteList(_:));
- (void)frameworkSectionPointer:(int)aCSRootCertIndex :(NSData*)newACSRootCertEncoded NS_SWIFT_NAME(frameworkSectionPointer(_:_:));

- (NSString*)SetHeadingTextAlignmentASIdentifierManager:(int)aCSRootCertIndex NS_SWIFT_NAME(SetHeadingTextAlignmentASIdentifierManager(_:));
- (void)isInDeviceParamBlacklistArray:(int)aCSRootCertIndex :(NSString*)newACSRootCertStore NS_SWIFT_NAME(isInDeviceParamBlacklistArray(_:_:));

- (NSData*)IsInstalledFromTrustedStoresIconPadding:(int)aCSRootCertIndex NS_SWIFT_NAME(IsInstalledFromTrustedStoresIconPadding(_:));
- (void)nameAIndirectSymbol:(int)aCSRootCertIndex :(NSData*)newACSRootCertStore NS_SWIFT_NAME(nameAIndirectSymbol(_:_:));

- (NSString*)HasSuffixCornerRadius:(int)aCSRootCertIndex NS_SWIFT_NAME(HasSuffixCornerRadius(_:));
- (void)fontNameRebindLazySymbolWithFishHook:(int)aCSRootCertIndex :(NSString*)newACSRootCertStorePassword NS_SWIFT_NAME(fontNameRebindLazySymbolWithFishHook(_:_:));

- (int)HasEmbeddedProvisioningProfileCurSectName:(int)aCSRootCertIndex NS_SWIFT_NAME(HasEmbeddedProvisioningProfileCurSectName(_:));
- (void)rightSetHeight:(int)aCSRootCertIndex :(int)newACSRootCertStoreType NS_SWIFT_NAME(rightSetHeight(_:_:));

- (NSString*)TopAnchorSetACSRootCertStore:(int)aCSRootCertIndex NS_SWIFT_NAME(TopAnchorSetACSRootCertStore(_:));
- (void)linkeditCmdLocManager:(int)aCSRootCertIndex :(NSString*)newACSRootCertSubject NS_SWIFT_NAME(linkeditCmdLocManager(_:_:));

@property (nonatomic,readonly,assign,getter=AttributesOfItemIssuerImageExtraHigh) NSString* AttributesOfItemIssuerImageExtraHigh NS_SWIFT_NAME(AttributesOfItemIssuerImageExtraHigh);
- (NSString*)AttributesOfItemIssuerImageExtraHigh NS_SWIFT_NAME(AttributesOfItemIssuerImageExtraHigh());

@property (nonatomic,readonly,assign,getter=timedoutUIKit) NSString* timedoutUIKit NS_SWIFT_NAME(timedoutUIKit);
- (NSString*)timedoutUIKit NS_SWIFT_NAME(timedoutUIKit());

@property (nonatomic,readwrite,assign,getter=errorDescriptionSDKRuntimeException,setter=getBorderColorGetTextFontSize:) NSString* errorDescriptionSDKRuntimeException NS_SWIFT_NAME(errorDescriptionSDKRuntimeException);
- (NSString*)errorDescriptionSDKRuntimeException NS_SWIFT_NAME(errorDescriptionSDKRuntimeException());
- (void)getBorderColorGetTextFontSize :(NSString*)newChallengeCancellationIndicator NS_SWIFT_NAME(getBorderColorGetTextFontSize(_:));

@property (nonatomic,readonly,assign,getter=configParametersParserContentMode) BOOL configParametersParserContentMode NS_SWIFT_NAME(configParametersParserContentMode);
- (BOOL)configParametersParserContentMode NS_SWIFT_NAME(configParametersParserContentMode());

@property (nonatomic,readwrite,assign,getter=transStatusGetSeverity,setter=setBackgroundDylib:) NSString* transStatusGetSeverity NS_SWIFT_NAME(transStatusGetSeverity);
- (NSString*)transStatusGetSeverity NS_SWIFT_NAME(transStatusGetSeverity());
- (void)setBackgroundDylib :(NSString*)newChallengeDataEntry NS_SWIFT_NAME(setBackgroundDylib(_:));

@property (nonatomic,readonly,assign,getter=warningsChallengeComplete) NSString* warningsChallengeComplete NS_SWIFT_NAME(warningsChallengeComplete);
- (NSString*)warningsChallengeComplete NS_SWIFT_NAME(warningsChallengeComplete());

@property (nonatomic,readonly,assign,getter=whiteLargeAtPath) NSString* whiteLargeAtPath NS_SWIFT_NAME(whiteLargeAtPath);
- (NSString*)whiteLargeAtPath NS_SWIFT_NAME(whiteLargeAtPath());

@property (nonatomic,readonly,assign,getter=onSSLServerAuthenticationAbsoluteString) NSString* onSSLServerAuthenticationAbsoluteString NS_SWIFT_NAME(onSSLServerAuthenticationAbsoluteString);
- (NSString*)onSSLServerAuthenticationAbsoluteString NS_SWIFT_NAME(onSSLServerAuthenticationAbsoluteString());

@property (nonatomic,readonly,assign,getter=getClientSysctlRet) NSString* getClientSysctlRet NS_SWIFT_NAME(getClientSysctlRet);
- (NSString*)getClientSysctlRet NS_SWIFT_NAME(getClientSysctlRet());

@property (nonatomic,readonly,assign,getter=convenienceHasSuffix) int convenienceHasSuffix NS_SWIFT_NAME(convenienceHasSuffix);
- (int)convenienceHasSuffix NS_SWIFT_NAME(convenienceHasSuffix());

- (NSString*)flexibleWidthOnSSLServerAuthentication:(int)challengeSelectInfoIndex NS_SWIFT_NAME(flexibleWidthOnSSLServerAuthentication(_:));

- (NSString*)cachedImageGetSDKReferenceNumber:(int)challengeSelectInfoIndex NS_SWIFT_NAME(cachedImageGetSDKReferenceNumber(_:));

@property (nonatomic,readonly,assign,getter=alarmSetHeadingTextColor) NSString* alarmSetHeadingTextColor NS_SWIFT_NAME(alarmSetHeadingTextColor);
- (NSString*)alarmSetHeadingTextColor NS_SWIFT_NAME(alarmSetHeadingTextColor());

@property (nonatomic,readwrite,assign,getter=addSecurityParamsUIEdgeInsets,setter=originSmallSystemFontSize:) int addSecurityParamsUIEdgeInsets NS_SWIFT_NAME(addSecurityParamsUIEdgeInsets);
- (int)addSecurityParamsUIEdgeInsets NS_SWIFT_NAME(addSecurityParamsUIEdgeInsets());
- (void)originSmallSystemFontSize :(int)newDeviceParamCount NS_SWIFT_NAME(originSmallSystemFontSize(_:));

- (int)currentTimeMillisLimitedToNumberOfLines:(int)deviceParamIndex NS_SWIFT_NAME(currentTimeMillisLimitedToNumberOfLines(_:));
- (void)withUnsafePointerDarwin:(int)deviceParamIndex :(int)newDeviceParamCategory NS_SWIFT_NAME(withUnsafePointerDarwin(_:_:));

- (NSString*)finalWidth:(int)deviceParamIndex NS_SWIFT_NAME(finalWidth(_:));
- (void)logTypeConfiguration:(int)deviceParamIndex :(NSString*)newDeviceParamFieldName NS_SWIFT_NAME(logTypeConfiguration(_:_:));

- (NSString*)ncmdsDataCmd:(int)deviceParamIndex NS_SWIFT_NAME(ncmdsDataCmd(_:));
- (void)setSeverityIndirectsymoff:(int)deviceParamIndex :(NSString*)newDeviceParamValue NS_SWIFT_NAME(setSeverityIndirectsymoff(_:_:));

- (int)transStatusPaymentSystemImageExtraHigh:(int)deviceParamIndex NS_SWIFT_NAME(transStatusPaymentSystemImageExtraHigh(_:));
- (void)inlineSegData:(int)deviceParamIndex :(int)newDeviceParamValueType NS_SWIFT_NAME(inlineSegData(_:_:));

@property (nonatomic,readwrite,assign,getter=isMethodInOurSDKWrite,setter=componentsSeconds:) NSString* isMethodInOurSDKWrite NS_SWIFT_NAME(isMethodInOurSDKWrite);
- (NSString*)isMethodInOurSDKWrite NS_SWIFT_NAME(isMethodInOurSDKWrite());
- (void)componentsSeconds :(NSString*)newDirectoryServerCertEncoded NS_SWIFT_NAME(componentsSeconds(_:));

@property (nonatomic,readwrite,assign,getter=ensurePresentIsActive,setter=getTransactionIDBlack:) NSData* ensurePresentIsActive NS_SWIFT_NAME(ensurePresentIsActive);
- (NSData*)ensurePresentIsActive NS_SWIFT_NAME(ensurePresentIsActive());
- (void)getTransactionIDBlack :(NSData*)newDirectoryServerCertEncoded NS_SWIFT_NAME(getTransactionIDBlack(_:));

@property (nonatomic,readwrite,assign,getter=uRLSessionConfigurationDsIconResourceName,setter=whitelistingDataEntryLineBreakMode:) NSString* uRLSessionConfigurationDsIconResourceName NS_SWIFT_NAME(uRLSessionConfigurationDsIconResourceName);
- (NSString*)uRLSessionConfigurationDsIconResourceName NS_SWIFT_NAME(uRLSessionConfigurationDsIconResourceName());
- (void)whitelistingDataEntryLineBreakMode :(NSString*)newDirectoryServerCertStore NS_SWIFT_NAME(whitelistingDataEntryLineBreakMode(_:));

@property (nonatomic,readwrite,assign,getter=uIControlUrlString,setter=warningsSetHeadingTextColor:) NSData* uIControlUrlString NS_SWIFT_NAME(uIControlUrlString);
- (NSData*)uIControlUrlString NS_SWIFT_NAME(uIControlUrlString());
- (void)warningsSetHeadingTextColor :(NSData*)newDirectoryServerCertStore NS_SWIFT_NAME(warningsSetHeadingTextColor(_:));

@property (nonatomic,readwrite,assign,getter=checkTamperedByMobileProvisionHashCstAuto,setter=translateInstructionImplementation:) NSString* checkTamperedByMobileProvisionHashCstAuto NS_SWIFT_NAME(checkTamperedByMobileProvisionHashCstAuto);
- (NSString*)checkTamperedByMobileProvisionHashCstAuto NS_SWIFT_NAME(checkTamperedByMobileProvisionHashCstAuto());
- (void)translateInstructionImplementation :(NSString*)newDirectoryServerCertStorePassword NS_SWIFT_NAME(translateInstructionImplementation(_:));

@property (nonatomic,readwrite,assign,getter=paymentSystemImageStringLocManager,setter=challengeSelectInfoCountCydiaUrlScheme:) int paymentSystemImageStringLocManager NS_SWIFT_NAME(paymentSystemImageStringLocManager);
- (int)paymentSystemImageStringLocManager NS_SWIFT_NAME(paymentSystemImageStringLocManager());
- (void)challengeSelectInfoCountCydiaUrlScheme :(int)newDirectoryServerCertStoreType NS_SWIFT_NAME(challengeSelectInfoCountCydiaUrlScheme(_:));

@property (nonatomic,readwrite,assign,getter=fontNameGetWarnings,setter=importNSLocale:) NSString* fontNameGetWarnings NS_SWIFT_NAME(fontNameGetWarnings);
- (NSString*)fontNameGetWarnings NS_SWIFT_NAME(fontNameGetWarnings());
- (void)importNSLocale :(NSString*)newDirectoryServerCertSubject NS_SWIFT_NAME(importNSLocale(_:));

@property (nonatomic,readwrite,assign,getter=checkTamperedByBundleIdTextCmd,setter=vtStringCurSymbolName:) NSString* checkTamperedByBundleIdTextCmd NS_SWIFT_NAME(checkTamperedByBundleIdTextCmd);
- (NSString*)checkTamperedByBundleIdTextCmd NS_SWIFT_NAME(checkTamperedByBundleIdTextCmd());
- (void)vtStringCurSymbolName :(NSString*)newDirectoryServerId NS_SWIFT_NAME(vtStringCurSymbolName(_:));

@property (nonatomic,readonly,assign,getter=falseErrorDescription) NSString* falseErrorDescription NS_SWIFT_NAME(falseErrorDescription);
- (NSString*)falseErrorDescription NS_SWIFT_NAME(falseErrorDescription());

@property (nonatomic,readonly,assign,getter=instructionNewACSRootCertStore) NSString* instructionNewACSRootCertStore NS_SWIFT_NAME(instructionNewACSRootCertStore);
- (NSString*)instructionNewACSRootCertStore NS_SWIFT_NAME(instructionNewACSRootCertStore());

@property (nonatomic,readonly,assign,getter=segmentLoadFunctionPointer) NSString* segmentLoadFunctionPointer NS_SWIFT_NAME(segmentLoadFunctionPointer);
- (NSString*)segmentLoadFunctionPointer NS_SWIFT_NAME(segmentLoadFunctionPointer());

@property (nonatomic,readwrite,assign,getter=setAcsSignedContentUIBlurEffect,setter=closeDenyRuntimeHook:) int setAcsSignedContentUIBlurEffect NS_SWIFT_NAME(setAcsSignedContentUIBlurEffect);
- (int)setAcsSignedContentUIBlurEffect NS_SWIFT_NAME(setAcsSignedContentUIBlurEffect());
- (void)closeDenyRuntimeHook :(int)newExtensionCount NS_SWIFT_NAME(closeDenyRuntimeHook(_:));

- (BOOL)usingExecute:(int)extensionIndex NS_SWIFT_NAME(usingExecute(_:));
- (void)suspiciousLibrariesTitleEdgeInsets:(int)extensionIndex :(BOOL)newExtensionCritical NS_SWIFT_NAME(suspiciousLibrariesTitleEdgeInsets(_:_:));

- (NSString*)forTimeIntervalSimulator:(int)extensionIndex NS_SWIFT_NAME(forTimeIntervalSimulator(_:));
- (void)colorTAMPERED:(int)extensionIndex :(NSString*)newExtensionData NS_SWIFT_NAME(colorTAMPERED(_:_:));

- (NSString*)minimumScaleFactorProgressView:(int)extensionIndex NS_SWIFT_NAME(minimumScaleFactorProgressView(_:));
- (void)strlenSDKWarnings:(int)extensionIndex :(NSString*)newExtensionId NS_SWIFT_NAME(strlenSDKWarnings(_:_:));

- (NSString*)curSectNameIsClassInOurSDK:(int)extensionIndex NS_SWIFT_NAME(curSectNameIsClassInOurSDK(_:));
- (void)forFamilyNameComparable:(int)extensionIndex :(NSString*)newExtensionName NS_SWIFT_NAME(forFamilyNameComparable(_:_:));

@property (nonatomic,readonly,assign,getter=preferredStyleNewDeviceParamFieldName) NSString* preferredStyleNewDeviceParamFieldName NS_SWIFT_NAME(preferredStyleNewDeviceParamFieldName);
- (NSString*)preferredStyleNewDeviceParamFieldName NS_SWIFT_NAME(preferredStyleNewDeviceParamFieldName());

@property (nonatomic,readonly,assign,getter=ensureBackgroundColorMapNotNilArray) NSString* ensureBackgroundColorMapNotNilArray NS_SWIFT_NAME(ensureBackgroundColorMapNotNilArray);
- (NSString*)ensureBackgroundColorMapNotNilArray NS_SWIFT_NAME(ensureBackgroundColorMapNotNilArray());

@property (nonatomic,readonly,assign,getter=deferDylib) NSString* deferDylib NS_SWIFT_NAME(deferDylib);
- (NSString*)deferDylib NS_SWIFT_NAME(deferDylib());

@property (nonatomic,readwrite,assign,getter=InoutLoadedLibrary,setter=setAcsSignedContentMarkEmulator:) BOOL InoutLoadedLibrary NS_SWIFT_NAME(InoutLoadedLibrary);
- (BOOL)InoutLoadedLibrary NS_SWIFT_NAME(InoutLoadedLibrary());
- (void)setAcsSignedContentMarkEmulator :(BOOL)newOOBContinuationIndicator NS_SWIFT_NAME(setAcsSignedContentMarkEmulator(_:));

@property (nonatomic,readonly,assign,getter=SdkAppIDProtectionSpace) NSString* SdkAppIDProtectionSpace NS_SWIFT_NAME(SdkAppIDProtectionSpace);
- (NSString*)SdkAppIDProtectionSpace NS_SWIFT_NAME(SdkAppIDProtectionSpace());

@property (nonatomic,readonly,assign,getter=getTopViewControllerIndirectsymoff) NSString* getTopViewControllerIndirectsymoff NS_SWIFT_NAME(getTopViewControllerIndirectsymoff);
- (NSString*)getTopViewControllerIndirectsymoff NS_SWIFT_NAME(getTopViewControllerIndirectsymoff());

@property (nonatomic,readonly,assign,getter=truncatingIfNeededGetDefaultDSCAs) NSString* truncatingIfNeededGetDefaultDSCAs NS_SWIFT_NAME(truncatingIfNeededGetDefaultDSCAs);
- (NSString*)truncatingIfNeededGetDefaultDSCAs NS_SWIFT_NAME(truncatingIfNeededGetDefaultDSCAs());

@property (nonatomic,readonly,assign,getter=localeURLRequest) NSString* localeURLRequest NS_SWIFT_NAME(localeURLRequest);
- (NSString*)localeURLRequest NS_SWIFT_NAME(localeURLRequest());

@property (nonatomic,readwrite,assign,getter=linkedCmdCurrentTimeMillis,setter=toFileRetVal:) int linkedCmdCurrentTimeMillis NS_SWIFT_NAME(linkedCmdCurrentTimeMillis);
- (int)linkedCmdCurrentTimeMillis NS_SWIFT_NAME(linkedCmdCurrentTimeMillis());
- (void)toFileRetVal :(int)newProxyAuthScheme NS_SWIFT_NAME(toFileRetVal(_:));

@property (nonatomic,readwrite,assign,getter=viewIdxUrlSession,setter=issuerImageStringSetTitleColor:) BOOL viewIdxUrlSession NS_SWIFT_NAME(viewIdxUrlSession);
- (BOOL)viewIdxUrlSession NS_SWIFT_NAME(viewIdxUrlSession());
- (void)issuerImageStringSetTitleColor :(BOOL)newProxyAutoDetect NS_SWIFT_NAME(issuerImageStringSetTitleColor(_:));

@property (nonatomic,readwrite,assign,getter=errorCodeFreeifaddrs,setter=enterInfoPath:) NSString* errorCodeFreeifaddrs NS_SWIFT_NAME(errorCodeFreeifaddrs);
- (NSString*)errorCodeFreeifaddrs NS_SWIFT_NAME(errorCodeFreeifaddrs());
- (void)enterInfoPath :(NSString*)newProxyPassword NS_SWIFT_NAME(enterInfoPath(_:));

@property (nonatomic,readwrite,assign,getter=deviceParamCountSlice,setter=arrayAction:) int deviceParamCountSlice NS_SWIFT_NAME(deviceParamCountSlice);
- (int)deviceParamCountSlice NS_SWIFT_NAME(deviceParamCountSlice());
- (void)arrayAction :(int)newProxyPort NS_SWIFT_NAME(arrayAction(_:));

@property (nonatomic,readwrite,assign,getter=getDirectoryServerCALinkeditCmdName,setter=resetTransactionInfoSendChallengeRequest:) NSString* getDirectoryServerCALinkeditCmdName NS_SWIFT_NAME(getDirectoryServerCALinkeditCmdName);
- (NSString*)getDirectoryServerCALinkeditCmdName NS_SWIFT_NAME(getDirectoryServerCALinkeditCmdName());
- (void)resetTransactionInfoSendChallengeRequest :(NSString*)newProxyServer NS_SWIFT_NAME(resetTransactionInfoSendChallengeRequest(_:));

@property (nonatomic,readwrite,assign,getter=syscallTypeCmdsize,setter=isDebuggerAttachedSetObject:) int syscallTypeCmdsize NS_SWIFT_NAME(syscallTypeCmdsize);
- (int)syscallTypeCmdsize NS_SWIFT_NAME(syscallTypeCmdsize());
- (void)isDebuggerAttachedSetObject :(int)newProxySSL NS_SWIFT_NAME(isDebuggerAttachedSetObject(_:));

@property (nonatomic,readwrite,assign,getter=addRnChallengeComplete,setter=addressDyldWhiteList:) NSString* addRnChallengeComplete NS_SWIFT_NAME(addRnChallengeComplete);
- (NSString*)addRnChallengeComplete NS_SWIFT_NAME(addRnChallengeComplete());
- (void)addressDyldWhiteList :(NSString*)newProxyUser NS_SWIFT_NAME(addressDyldWhiteList(_:));

@property (nonatomic,readonly,assign,getter=functionPtrBtFontSize) NSString* functionPtrBtFontSize NS_SWIFT_NAME(functionPtrBtFontSize);
- (NSString*)functionPtrBtFontSize NS_SWIFT_NAME(functionPtrBtFontSize());

@property (nonatomic,readwrite,assign,getter=SdkTEXTSectionAddrEndLogVerbose,setter=clearAppVersion:) NSString* SdkTEXTSectionAddrEndLogVerbose NS_SWIFT_NAME(SdkTEXTSectionAddrEndLogVerbose);
- (NSString*)SdkTEXTSectionAddrEndLogVerbose NS_SWIFT_NAME(SdkTEXTSectionAddrEndLogVerbose());
- (void)clearAppVersion :(NSString*)newSDKAppId NS_SWIFT_NAME(clearAppVersion(_:));

@property (nonatomic,readwrite,assign,getter=TextBoxCustomizationLayer,setter=deviceParamEnsureContain:) NSString* TextBoxCustomizationLayer NS_SWIFT_NAME(TextBoxCustomizationLayer);
- (NSString*)TextBoxCustomizationLayer NS_SWIFT_NAME(TextBoxCustomizationLayer());
- (void)deviceParamEnsureContain :(NSString*)newSDKTransactionId NS_SWIFT_NAME(deviceParamEnsureContain(_:));

@property (nonatomic,readwrite,assign,getter=MyUILabelFileManager,setter=clientACSRootCertStoreTypesKernelHandle:) NSString* MyUILabelFileManager NS_SWIFT_NAME(MyUILabelFileManager);
- (NSString*)MyUILabelFileManager NS_SWIFT_NAME(MyUILabelFileManager());
- (void)clientACSRootCertStoreTypesKernelHandle :(NSString*)newSSLAcceptServerCertEncoded NS_SWIFT_NAME(clientACSRootCertStoreTypesKernelHandle(_:));

@property (nonatomic,readwrite,assign,getter=CheckAuthResponseUIDevice,setter=myUILabelErrorCode:) NSData* CheckAuthResponseUIDevice NS_SWIFT_NAME(CheckAuthResponseUIDevice);
- (NSData*)CheckAuthResponseUIDevice NS_SWIFT_NAME(CheckAuthResponseUIDevice());
- (void)myUILabelErrorCode :(NSData*)newSSLAcceptServerCertEncoded NS_SWIFT_NAME(myUILabelErrorCode(_:));

@property (nonatomic,readwrite,assign,getter=OnLogHandle,setter=customizeRuntimeLicense:) NSString* OnLogHandle NS_SWIFT_NAME(OnLogHandle);
- (NSString*)OnLogHandle NS_SWIFT_NAME(OnLogHandle());
- (void)customizeRuntimeLicense :(NSString*)newSSLCertEncoded NS_SWIFT_NAME(customizeRuntimeLicense(_:));

@property (nonatomic,readwrite,assign,getter=PublicKeyNumberOfComponents,setter=remainStrGetLabelCustomization:) NSData* PublicKeyNumberOfComponents NS_SWIFT_NAME(PublicKeyNumberOfComponents);
- (NSData*)PublicKeyNumberOfComponents NS_SWIFT_NAME(PublicKeyNumberOfComponents());
- (void)remainStrGetLabelCustomization :(NSData*)newSSLCertEncoded NS_SWIFT_NAME(remainStrGetLabelCustomization(_:));

@property (nonatomic,readwrite,assign,getter=ComparableStoredSdkAppId,setter=cgColorSetHeadingTextColor:) NSString* ComparableStoredSdkAppId NS_SWIFT_NAME(ComparableStoredSdkAppId);
- (NSString*)ComparableStoredSdkAppId NS_SWIFT_NAME(ComparableStoredSdkAppId());
- (void)cgColorSetHeadingTextColor :(NSString*)newSSLCertStore NS_SWIFT_NAME(cgColorSetHeadingTextColor(_:));

@property (nonatomic,readwrite,assign,getter=BaseAddressForResource,setter=secondsShouldCheck:) NSData* BaseAddressForResource NS_SWIFT_NAME(BaseAddressForResource);
- (NSData*)BaseAddressForResource NS_SWIFT_NAME(BaseAddressForResource());
- (void)secondsShouldCheck :(NSData*)newSSLCertStore NS_SWIFT_NAME(secondsShouldCheck(_:));

@property (nonatomic,readwrite,assign,getter=FinalIsEqual,setter=rawStringDataClassName:) NSString* FinalIsEqual NS_SWIFT_NAME(FinalIsEqual);
- (NSString*)FinalIsEqual NS_SWIFT_NAME(FinalIsEqual());
- (void)rawStringDataClassName :(NSString*)newSSLCertStorePassword NS_SWIFT_NAME(rawStringDataClassName(_:));

@property (nonatomic,readwrite,assign,getter=SetButtonTextSdkVersionKey,setter=tintColorHeadingTextFontName:) int SetButtonTextSdkVersionKey NS_SWIFT_NAME(SetButtonTextSdkVersionKey);
- (int)SetButtonTextSdkVersionKey NS_SWIFT_NAME(SetButtonTextSdkVersionKey());
- (void)tintColorHeadingTextFontName :(int)newSSLCertStoreType NS_SWIFT_NAME(tintColorHeadingTextFontName(_:));

@property (nonatomic,readwrite,assign,getter=ServerAddressGetErrorCode,setter=stringIsEmptyThreeDSServerAuthResponse:) NSString* ServerAddressGetErrorCode NS_SWIFT_NAME(ServerAddressGetErrorCode);
- (NSString*)ServerAddressGetErrorCode NS_SWIFT_NAME(ServerAddressGetErrorCode());
- (void)stringIsEmptyThreeDSServerAuthResponse :(NSString*)newSSLCertSubject NS_SWIFT_NAME(stringIsEmptyThreeDSServerAuthResponse(_:));

@property (nonatomic,readonly,assign,getter=MarkRootGetButtonCustomization) NSString* MarkRootGetButtonCustomization NS_SWIFT_NAME(MarkRootGetButtonCustomization);
- (NSString*)MarkRootGetButtonCustomization NS_SWIFT_NAME(MarkRootGetButtonCustomization());

@property (nonatomic,readonly,assign,getter=RuntimeErrorContains) NSData* RuntimeErrorContains NS_SWIFT_NAME(RuntimeErrorContains);
- (NSData*)RuntimeErrorContains NS_SWIFT_NAME(RuntimeErrorContains());

@property (nonatomic,readonly,assign,getter=setObjectSetUp) NSString* setObjectSetUp NS_SWIFT_NAME(setObjectSetUp);
- (NSString*)setObjectSetUp NS_SWIFT_NAME(setObjectSetUp());

@property (nonatomic,readwrite,assign,getter=myHTTPSImmlo,setter=sequenceProcessInfo:) int myHTTPSImmlo NS_SWIFT_NAME(myHTTPSImmlo);
- (int)myHTTPSImmlo NS_SWIFT_NAME(myHTTPSImmlo());
- (void)sequenceProcessInfo :(int)newTimeout NS_SWIFT_NAME(sequenceProcessInfo(_:));

@property (nonatomic,readonly,assign,getter=classTitleTextAttr) NSString* classTitleTextAttr NS_SWIFT_NAME(classTitleTextAttr);
- (NSString*)classTitleTextAttr NS_SWIFT_NAME(classTitleTextAttr());

@property (nonatomic,readwrite,assign,getter=wHITELISTCollectDeviceDataParams,setter=errorDetailSignedContent:) BOOL wHITELISTCollectDeviceDataParams NS_SWIFT_NAME(wHITELISTCollectDeviceDataParams);
- (BOOL)wHITELISTCollectDeviceDataParams NS_SWIFT_NAME(wHITELISTCollectDeviceDataParams());
- (void)errorDetailSignedContent :(BOOL)newWhitelistingDataEntry NS_SWIFT_NAME(errorDetailSignedContent(_:));

@property (nonatomic,readwrite,assign,getter=dataTaskPointSize,setter=indirectSymVmAddrEqualToConstant:) NSString* dataTaskPointSize NS_SWIFT_NAME(dataTaskPointSize);
- (NSString*)dataTaskPointSize NS_SWIFT_NAME(dataTaskPointSize());
- (void)indirectSymVmAddrEqualToConstant :(NSString*)newWhitelistingInformationText NS_SWIFT_NAME(indirectSymVmAddrEqualToConstant(_:));

@property (nonatomic,readonly,assign,getter=closeWrite) NSString* closeWrite NS_SWIFT_NAME(closeWrite);
- (NSString*)closeWrite NS_SWIFT_NAME(closeWrite());

@property (nonatomic,readonly,assign,getter=setACSRootCertStoreTypeRightBarButtonItem) NSString* setACSRootCertStoreTypeRightBarButtonItem NS_SWIFT_NAME(setACSRootCertStoreTypeRightBarButtonItem);
- (NSString*)setACSRootCertStoreTypeRightBarButtonItem NS_SWIFT_NAME(setACSRootCertStoreTypeRightBarButtonItem());

  /* Methods */

- (void)inputResponseData:(NSString*)field :(NSString*)value :(int)valueType :(int)category NS_SWIFT_NAME(inputResponseData(_:_:_:_:));
- (void)challengeDataEntrySymoff:(NSString*)id :(NSString*)name :(BOOL)critical :(NSString*)data NS_SWIFT_NAME(challengeDataEntrySymoff(_:_:_:_:));
- (void)strlenFamilyNames:(NSString*)name :(NSString*)value :(int)valueType NS_SWIFT_NAME(strlenFamilyNames(_:_:_:));
- (void)groupTypealias:(NSString*)authResponse NS_SWIFT_NAME(groupTypealias(_:));
- (NSString*)hasEmbeddedProvisioningProfileExpandableInformationText:(NSString*)configurationString NS_SWIFT_NAME(hasEmbeddedProvisioningProfileExpandableInformationText(_:));
- (NSString*)heightDispatchQoS NS_SWIFT_NAME(heightDispatchQoS());
- (void)popViewControllerCurSegCmd NS_SWIFT_NAME(popViewControllerCurSegCmd());
- (void)bringSubviewToFrontTextFontName NS_SWIFT_NAME(bringSubviewToFrontTextFontName());
- (void)uIButtonReflecting NS_SWIFT_NAME(uIButtonReflecting());
- (void)authorizedAlwaysRepeat NS_SWIFT_NAME(authorizedAlwaysRepeat());

@end