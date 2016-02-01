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

@property (nonatomic, copy) NSString *album;
@property (nonatomic, copy) NSString *artist;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, retain) NSImage *albumart;

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
	NSMutableArray *array = [NSMutableArray arrayWithObject:[NSString stringWithFormat:@"#NowPlaying %@ - %@ - %@", self.artist, self.album, self.title]];
	
	if (self.albumart) [array addObject:self.albumart];
	
	NSSharingServicePicker *picker = [[NSSharingServicePicker alloc] initWithItems:array];
	picker.delegate = self;
	
	[picker showRelativeToRect:[sender bounds] ofView:sender preferredEdge:NSMinYEdge];
}

- (void)update {
	iTunesApplication *iTunes = (iTunesApplication *)[[SBApplication alloc] initWithBundleIdentifier:@"com.apple.iTunes"];
	iTunesTrack *track = iTunes.currentTrack;
	
	self.album = track.album;
	self.artist = track.artist;
	self.title = track.name;
	self.albumart = track.artworks[0].data;
	
	@try {
		self.imageView.image = self.albumart;
	}
	@catch (NSException *exception) {
		self.albumart = nil;
	}
	
	[_nowplayingText setTitle:[NSString stringWithFormat:@"%@ - %@ - %@", self.artist, self.album, self.title]];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
	return YES;
}

# pragma mark Delegate Methods

- (id <NSSharingServiceDelegate>)sharingServicePicker:(NSSharingServicePicker *)sharingServicePicker delegateForSharingService:(NSSharingService *)sharingService {
	return self;
}

- (NSWindow *)sharingService:(NSSharingService *)sharingService sourceWindowForShareItems:(NSArray *)items sharingContentScope:(NSSharingContentScope *)sharingContentScope {
	return self.window;
}

@end
