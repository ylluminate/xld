//
//  XLDAiffOutput.m
//  XLD
//
//  Created by tmkk on 10/11/03.
//  Copyright 2010 tmkk. All rights reserved.
//

#import "XLDAiffOutput.h"
#import "XLDDefaultOutputTask.h"

@implementation XLDAiffOutput

+ (NSString *)pluginName
{
	return @"AIFF";
}

- (void)savePrefs
{
	NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
	[pref setInteger:[o_bitDepth indexOfSelectedItem] forKey:@"XLDAiffOutput_BitDepth"];
	[pref setInteger:[o_isFloat state] forKey:@"XLDAiffOutput_IsFloat"];
	[pref setInteger:[[o_samplerate selectedItem] tag] forKey:@"XLDAiffOutput_Samplerate"];
	[pref setInteger:[[o_srcAlgorithm selectedItem] tag] forKey:@"XLDAiffOutput_SRCAlgorithm"];
	[pref synchronize];
}

- (void)loadPrefs
{
	NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
	[self loadConfigurations:pref];
}

- (NSMutableDictionary *)configurations
{
	NSMutableDictionary *cfg = [super configurations];
	/* for GUI */
	[cfg setObject:[NSNumber numberWithInt:[o_bitDepth indexOfSelectedItem]] forKey:@"XLDAiffOutput_BitDepth"];
	[cfg setObject:[NSNumber numberWithInt:[o_isFloat state]] forKey:@"XLDAiffOutput_IsFloat"];
	[cfg setObject:[NSNumber numberWithInt:[[o_samplerate selectedItem] tag]] forKey:@"XLDAiffOutput_Samplerate"];
	[cfg setObject:[NSNumber numberWithInt:[[o_srcAlgorithm selectedItem] tag]] forKey:@"XLDAiffOutput_SRCAlgorithm"];
	/* for task */
	[cfg setObject:[NSNumber numberWithUnsignedInt:SF_FORMAT_AIFF] forKey:@"SFFormat"];
	return cfg;
}

- (void)loadConfigurations:(id)cfg
{
	id obj;
	if(obj=[cfg objectForKey:@"XLDAiffOutput_BitDepth"]) {
		[o_bitDepth selectItemAtIndex:[obj intValue]];
	}
	if(obj=[cfg objectForKey:@"XLDAiffOutput_IsFloat"]) {
		[o_isFloat setState:[obj intValue]];
	}
	if(obj=[cfg objectForKey:@"XLDAiffOutput_Samplerate"]) {
		[o_samplerate selectItemWithTag:[obj intValue]];
	}
	if(obj=[cfg objectForKey:@"XLDAiffOutput_SRCAlgorithm"]) {
		[o_srcAlgorithm selectItemWithTag:[obj intValue]];
	}
	[self statusChanged:nil];
}

@end
