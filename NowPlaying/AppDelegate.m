//
//  AppDelegate.m
//  NowPlaying
//
//  Created by 김승호 on 2016. 2. 1..
//  Copyright © 2016년 Seungho Kim. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (weak) iTunesApplication *iTunes;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application
	[_button sendActionOn:NSLeftMouseDownMask];
	[_button setImage:[NSImage imageNamed:NSImageNameShareTemplate]];
	[self update];
	[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(update) userInfo:nil repeats:YES];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
	// Insert code here to tear down your application
}

- (IBAction)share:(id)sender {
	iTunesApplication *iTunes = (iTunesApplication *)[[SBApplication alloc] initWithBundleIdentifier:@"com.apple.iTunes"];
	iTunesTrack *track = iTunes.currentTrack;
	NSImage *image = track.artworks[0].data;
	NSMutableArray *array = [NSMutableArray arrayWithObject:[NSString stringWithFormat:@"#NowPlaying %@ - %@ - %@", track.artist, track.album, track.name]];
	if (image) [array addObject:image];
	NSSharingServicePicker *picker = [[NSSharingServicePicker alloc] initWithItems:array];
	picker.delegate = self;
	[picker showRelativeToRect:[sender bounds] ofView:sender preferredEdge:NSMinYEdge];
}

- (void)update {
	iTunesApplication *iTunes = (iTunesApplication *)[[SBApplication alloc] initWithBundleIdentifier:@"com.apple.iTunes"];
	iTunesTrack *track = iTunes.currentTrack;
	_imageView.image = track.artworks[0].data;
	[_nowplayingText setTitle:[NSString stringWithFormat:@"%@ - %@ - %@", track.artist, track.album, track.name]];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
	return YES;
}

- (id <NSSharingServiceDelegate>)sharingServicePicker:(NSSharingServicePicker *)sharingServicePicker delegateForSharingService:(NSSharingService *)sharingService {
	return self;
}

- (NSWindow *)sharingService:(NSSharingService *)sharingService sourceWindowForShareItems:(NSArray *)items sharingContentScope:(NSSharingContentScope *)sharingContentScope {
	return self.window;
}

@end
