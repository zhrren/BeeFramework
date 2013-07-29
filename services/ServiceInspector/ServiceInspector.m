//
//	 ______    ______    ______
//	/\  __ \  /\  ___\  /\  ___\
//	\ \  __<  \ \  __\_ \ \  __\_
//	 \ \_____\ \ \_____\ \ \_____\
//	  \/_____/  \/_____/  \/_____/
//
//
//	Copyright (c) 2013-2014, {Bee} open source community
//	http://www.bee-framework.com
//
//
//	Permission is hereby granted, free of charge, to any person obtaining a
//	copy of this software and associated documentation files (the "Software"),
//	to deal in the Software without restriction, including without limitation
//	the rights to use, copy, modify, merge, publish, distribute, sublicense,
//	and/or sell copies of the Software, and to permit persons to whom the
//	Software is furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//	FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
//	IN THE SOFTWARE.
//

#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)

#import "ServiceInspector.h"
#import "ServiceInspector_WindowHook.h"

#if (__ON__ == __BEE_DEVELOPMENT__)

#pragma mark -

@interface ServiceInspector()
{
	BOOL	_inspecting;
}
@end

#pragma mark -

@implementation ServiceInspector

SERVICE_AUTO_LOADING( YES )
SERVICE_AUTO_POWERON( NO )

- (void)load
{
	[super load];

	[self observeNotification:BeeSkeleton.LAUNCHED];
	[self observeNotification:BeeSkeleton.TERMINATED];

	[self observeNotification:UIWindow.TOUCH_BEGAN];
	[self observeNotification:UIWindow.TOUCH_MOVED];
	[self observeNotification:UIWindow.TOUCH_ENDED];
}

- (void)unload
{
	[self unobserveAllNotifications];
	
	[super unload];
}

- (void)powerOn
{
	[UIWindow hook];
}

- (void)powerOff
{
}

#pragma mark -

- (void)handleNotification:(NSNotification *)notification
{
	if ( [notification is:BeeSkeleton.LAUNCHED] )
	{
		[self powerOn];
	}
	else if ( [notification is:BeeSkeleton.TERMINATED] )
	{
		[self powerOff];
	}
}

@end

#endif	// #if (__ON__ == __BEE_DEVELOPMENT__)

#endif	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
