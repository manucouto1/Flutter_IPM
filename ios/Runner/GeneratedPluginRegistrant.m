//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"

#if __has_include(<flutter_youtube/FlutterYoutubePlugin.h>)
#import <flutter_youtube/FlutterYoutubePlugin.h>
#else
@import flutter_youtube;
#endif

#if __has_include(<share/FLTSharePlugin.h>)
#import <share/FLTSharePlugin.h>
#else
@import share;
#endif

#if __has_include(<youtube_player/YoutubePlayerPlugin.h>)
#import <youtube_player/YoutubePlayerPlugin.h>
#else
@import youtube_player;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FlutterYoutubePlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterYoutubePlugin"]];
  [FLTSharePlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTSharePlugin"]];
  [YoutubePlayerPlugin registerWithRegistrar:[registry registrarForPlugin:@"YoutubePlayerPlugin"]];
}

@end
