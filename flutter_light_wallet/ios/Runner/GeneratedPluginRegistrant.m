//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<agent_dart/AgentDartPlugin.h>)
#import <agent_dart/AgentDartPlugin.h>
#else
@import agent_dart;
#endif

#if __has_include(<file_picker/FilePickerPlugin.h>)
#import <file_picker/FilePickerPlugin.h>
#else
@import file_picker;
#endif

#if __has_include(<flutter_image_compress/ImageCompressPlugin.h>)
#import <flutter_image_compress/ImageCompressPlugin.h>
#else
@import flutter_image_compress;
#endif

#if __has_include(<image_gallery_saver/ImageGallerySaverPlugin.h>)
#import <image_gallery_saver/ImageGallerySaverPlugin.h>
#else
@import image_gallery_saver;
#endif

#if __has_include(<local_auth_darwin/FLALocalAuthPlugin.h>)
#import <local_auth_darwin/FLALocalAuthPlugin.h>
#else
@import local_auth_darwin;
#endif

#if __has_include(<package_info/FLTPackageInfoPlugin.h>)
#import <package_info/FLTPackageInfoPlugin.h>
#else
@import package_info;
#endif

#if __has_include(<path_provider_foundation/PathProviderPlugin.h>)
#import <path_provider_foundation/PathProviderPlugin.h>
#else
@import path_provider_foundation;
#endif

#if __has_include(<photo_manager/ImageScannerPlugin.h>)
#import <photo_manager/ImageScannerPlugin.h>
#else
@import photo_manager;
#endif

#if __has_include(<scan/ScanPlugin.h>)
#import <scan/ScanPlugin.h>
#else
@import scan;
#endif

#if __has_include(<shared_preferences/FLTSharedPreferencesPlugin.h>)
#import <shared_preferences/FLTSharedPreferencesPlugin.h>
#else
@import shared_preferences;
#endif

#if __has_include(<video_player_avfoundation/FVPVideoPlayerPlugin.h>)
#import <video_player_avfoundation/FVPVideoPlayerPlugin.h>
#else
@import video_player_avfoundation;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [AgentDartPlugin registerWithRegistrar:[registry registrarForPlugin:@"AgentDartPlugin"]];
  [FilePickerPlugin registerWithRegistrar:[registry registrarForPlugin:@"FilePickerPlugin"]];
  [ImageCompressPlugin registerWithRegistrar:[registry registrarForPlugin:@"ImageCompressPlugin"]];
  [ImageGallerySaverPlugin registerWithRegistrar:[registry registrarForPlugin:@"ImageGallerySaverPlugin"]];
  [FLALocalAuthPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLALocalAuthPlugin"]];
  [FLTPackageInfoPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTPackageInfoPlugin"]];
  [PathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"PathProviderPlugin"]];
  [ImageScannerPlugin registerWithRegistrar:[registry registrarForPlugin:@"ImageScannerPlugin"]];
  [ScanPlugin registerWithRegistrar:[registry registrarForPlugin:@"ScanPlugin"]];
  [FLTSharedPreferencesPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTSharedPreferencesPlugin"]];
  [FVPVideoPlayerPlugin registerWithRegistrar:[registry registrarForPlugin:@"FVPVideoPlayerPlugin"]];
}

@end
