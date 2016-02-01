//
//  AppDelegate.h
//  NowPlaying
//
//  Created by 김승호 on 2016. 2. 1..
//  Copyright © 2016년 Seungho Kim. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <ScriptingBridge/ScriptingBridge.h>
#import "iTunes.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, NSSharingServiceDelegate, NSSharingServicePickerDelegate>

@property (weak) IBOutlet NSTextFieldCell *nowplayingText;
@property (weak) IBOutlet NSImageView *imageView;
@property (weak) IBOutlet NSButton *button;

- (IBAction)share:(id)sender;

@end

