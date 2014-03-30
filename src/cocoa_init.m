//========================================================================
// GLFW 3.1 OS X - www.glfw.org
//------------------------------------------------------------------------
// Copyright (c) 2009-2010 Camilla Berglund <elmindreda@elmindreda.org>
//
// This software is provided 'as-is', without any express or implied
// warranty. In no event will the authors be held liable for any damages
// arising from the use of this software.
//
// Permission is granted to anyone to use this software for any purpose,
// including commercial applications, and to alter it and redistribute it
// freely, subject to the following restrictions:
//
// 1. The origin of this software must not be misrepresented; you must not
//    claim that you wrote the original software. If you use this software
//    in a product, an acknowledgment in the product documentation would
//    be appreciated but is not required.
//
// 2. Altered source versions must be plainly marked as such, and must not
//    be misrepresented as being the original software.
//
// 3. This notice may not be removed or altered from any source
//    distribution.
//
//========================================================================

#include "internal.h"
#include <sys/param.h> // For MAXPATHLEN


#if defined(_GLFW_USE_CHDIR)

// Change to our application bundle's resources directory, if present
//
static void changeToResourcesDirectory(void)
{
    char resourcesPath[MAXPATHLEN];

    CFBundleRef bundle = CFBundleGetMainBundle();
    if (!bundle)
        return;

    CFURLRef resourcesURL = CFBundleCopyResourcesDirectoryURL(bundle);

    CFStringRef last = CFURLCopyLastPathComponent(resourcesURL);
    if (CFStringCompare(CFSTR("Resources"), last, 0) != kCFCompareEqualTo)
    {
        CFRelease(last);
        CFRelease(resourcesURL);
        return;
    }

    CFRelease(last);

    if (!CFURLGetFileSystemRepresentation(resourcesURL,
                                          true,
                                          (UInt8*) resourcesPath,
                                          MAXPATHLEN))
    {
        CFRelease(resourcesURL);
        return;
    }

    CFRelease(resourcesURL);

    chdir(resourcesPath);
}

#endif /* _GLFW_USE_CHDIR */

// Create key code translation tables
//
static void createKeyTables(void)
{
    int i;

    memset(_glfw.ns.publicKeys, -1, sizeof(_glfw.ns.publicKeys));
    memset(_glfw.ns.nativeKeys, -1, sizeof(_glfw.ns.nativeKeys));

    _glfw.ns.nativeKeys[GLFW_KEY_0] = 0x1d;
    _glfw.ns.nativeKeys[GLFW_KEY_1] = 0x12;
    _glfw.ns.nativeKeys[GLFW_KEY_2] = 0x13;
    _glfw.ns.nativeKeys[GLFW_KEY_3] = 0x14;
    _glfw.ns.nativeKeys[GLFW_KEY_4] = 0x15;
    _glfw.ns.nativeKeys[GLFW_KEY_5] = 0x17;
    _glfw.ns.nativeKeys[GLFW_KEY_6] = 0x16;
    _glfw.ns.nativeKeys[GLFW_KEY_7] = 0x1a;
    _glfw.ns.nativeKeys[GLFW_KEY_8] = 0x1c;
    _glfw.ns.nativeKeys[GLFW_KEY_9] = 0x19;
    _glfw.ns.nativeKeys[GLFW_KEY_A] = 0x00;
    _glfw.ns.nativeKeys[GLFW_KEY_B] = 0x0b;
    _glfw.ns.nativeKeys[GLFW_KEY_C] = 0x08;
    _glfw.ns.nativeKeys[GLFW_KEY_D] = 0x02;
    _glfw.ns.nativeKeys[GLFW_KEY_E] = 0x0e;
    _glfw.ns.nativeKeys[GLFW_KEY_F] = 0x03;
    _glfw.ns.nativeKeys[GLFW_KEY_G] = 0x05;
    _glfw.ns.nativeKeys[GLFW_KEY_H] = 0x04;
    _glfw.ns.nativeKeys[GLFW_KEY_I] = 0x22;
    _glfw.ns.nativeKeys[GLFW_KEY_J] = 0x26;
    _glfw.ns.nativeKeys[GLFW_KEY_K] = 0x28;
    _glfw.ns.nativeKeys[GLFW_KEY_L] = 0x25;
    _glfw.ns.nativeKeys[GLFW_KEY_M] = 0x2e;
    _glfw.ns.nativeKeys[GLFW_KEY_N] = 0x2d;
    _glfw.ns.nativeKeys[GLFW_KEY_O] = 0x1f;
    _glfw.ns.nativeKeys[GLFW_KEY_P] = 0x23;
    _glfw.ns.nativeKeys[GLFW_KEY_Q] = 0x0c;
    _glfw.ns.nativeKeys[GLFW_KEY_R] = 0x0f;
    _glfw.ns.nativeKeys[GLFW_KEY_S] = 0x01;
    _glfw.ns.nativeKeys[GLFW_KEY_T] = 0x11;
    _glfw.ns.nativeKeys[GLFW_KEY_U] = 0x20;
    _glfw.ns.nativeKeys[GLFW_KEY_V] = 0x09;
    _glfw.ns.nativeKeys[GLFW_KEY_W] = 0x0d;
    _glfw.ns.nativeKeys[GLFW_KEY_X] = 0x07;
    _glfw.ns.nativeKeys[GLFW_KEY_Y] = 0x10;
    _glfw.ns.nativeKeys[GLFW_KEY_Z] = 0x06;

    _glfw.ns.nativeKeys[GLFW_KEY_APOSTROPHE]    = 0x27;
    _glfw.ns.nativeKeys[GLFW_KEY_BACKSLASH]     = 0x2a;
    _glfw.ns.nativeKeys[GLFW_KEY_COMMA]         = 0x2b;
    _glfw.ns.nativeKeys[GLFW_KEY_EQUAL]         = 0x18;
    _glfw.ns.nativeKeys[GLFW_KEY_GRAVE_ACCENT]  = 0x32;
    _glfw.ns.nativeKeys[GLFW_KEY_LEFT_BRACKET]  = 0x21;
    _glfw.ns.nativeKeys[GLFW_KEY_MINUS]         = 0x1b;
    _glfw.ns.nativeKeys[GLFW_KEY_PERIOD]        = 0x2f;
    _glfw.ns.nativeKeys[GLFW_KEY_RIGHT_BRACKET] = 0x1e;
    _glfw.ns.nativeKeys[GLFW_KEY_SEMICOLON]     = 0x29;
    _glfw.ns.nativeKeys[GLFW_KEY_SLASH]         = 0x2c;
    _glfw.ns.nativeKeys[GLFW_KEY_WORLD_1]       = 0x0a;

    _glfw.ns.nativeKeys[GLFW_KEY_BACKSPACE]     = 0x33;
    _glfw.ns.nativeKeys[GLFW_KEY_CAPS_LOCK]     = 0x39;
    _glfw.ns.nativeKeys[GLFW_KEY_DELETE]        = 0x75;
    _glfw.ns.nativeKeys[GLFW_KEY_DOWN]          = 0x7d;
    _glfw.ns.nativeKeys[GLFW_KEY_END]           = 0x77;
    _glfw.ns.nativeKeys[GLFW_KEY_ENTER]         = 0x24;
    _glfw.ns.nativeKeys[GLFW_KEY_ESCAPE]        = 0x35;
    _glfw.ns.nativeKeys[GLFW_KEY_F1]            = 0x7a;
    _glfw.ns.nativeKeys[GLFW_KEY_F2]            = 0x78;
    _glfw.ns.nativeKeys[GLFW_KEY_F3]            = 0x63;
    _glfw.ns.nativeKeys[GLFW_KEY_F4]            = 0x76;
    _glfw.ns.nativeKeys[GLFW_KEY_F5]            = 0x60;
    _glfw.ns.nativeKeys[GLFW_KEY_F6]            = 0x61;
    _glfw.ns.nativeKeys[GLFW_KEY_F7]            = 0x62;
    _glfw.ns.nativeKeys[GLFW_KEY_F8]            = 0x64;
    _glfw.ns.nativeKeys[GLFW_KEY_F9]            = 0x65;
    _glfw.ns.nativeKeys[GLFW_KEY_F10]           = 0x6d;
    _glfw.ns.nativeKeys[GLFW_KEY_F11]           = 0x67;
    _glfw.ns.nativeKeys[GLFW_KEY_F12]           = 0x6f;
    _glfw.ns.nativeKeys[GLFW_KEY_F13]           = 0x69;
    _glfw.ns.nativeKeys[GLFW_KEY_F14]           = 0x6b;
    _glfw.ns.nativeKeys[GLFW_KEY_F15]           = 0x71;
    _glfw.ns.nativeKeys[GLFW_KEY_F16]           = 0x6a;
    _glfw.ns.nativeKeys[GLFW_KEY_F17]           = 0x40;
    _glfw.ns.nativeKeys[GLFW_KEY_F18]           = 0x4f;
    _glfw.ns.nativeKeys[GLFW_KEY_F19]           = 0x50;
    _glfw.ns.nativeKeys[GLFW_KEY_F20]           = 0x5a;
    _glfw.ns.nativeKeys[GLFW_KEY_HOME]          = 0x73;
    _glfw.ns.nativeKeys[GLFW_KEY_INSERT]        = 0x72;
    _glfw.ns.nativeKeys[GLFW_KEY_LEFT]          = 0x7b;
    _glfw.ns.nativeKeys[GLFW_KEY_LEFT_ALT]      = 0x3a;
    _glfw.ns.nativeKeys[GLFW_KEY_LEFT_CONTROL]  = 0x3b;
    _glfw.ns.nativeKeys[GLFW_KEY_LEFT_SHIFT]    = 0x38;
    _glfw.ns.nativeKeys[GLFW_KEY_LEFT_SUPER]    = 0x37;
    _glfw.ns.nativeKeys[GLFW_KEY_MENU]          = 0x6e;
    _glfw.ns.nativeKeys[GLFW_KEY_NUM_LOCK]      = 0x47;
    _glfw.ns.nativeKeys[GLFW_KEY_PAGE_DOWN]     = 0x79;
    _glfw.ns.nativeKeys[GLFW_KEY_PAGE_UP]       = 0x74;
    _glfw.ns.nativeKeys[GLFW_KEY_RIGHT]         = 0x7c;
    _glfw.ns.nativeKeys[GLFW_KEY_RIGHT_ALT]     = 0x3d;
    _glfw.ns.nativeKeys[GLFW_KEY_RIGHT_CONTROL] = 0x3e;
    _glfw.ns.nativeKeys[GLFW_KEY_RIGHT_SHIFT]   = 0x3c;
    _glfw.ns.nativeKeys[GLFW_KEY_RIGHT_SUPER]   = 0x36;
    _glfw.ns.nativeKeys[GLFW_KEY_SPACE]         = 0x31;
    _glfw.ns.nativeKeys[GLFW_KEY_TAB]           = 0x30;
    _glfw.ns.nativeKeys[GLFW_KEY_UP]            = 0x7e;

    _glfw.ns.nativeKeys[GLFW_KEY_KP_0]          = 0x52;
    _glfw.ns.nativeKeys[GLFW_KEY_KP_1]          = 0x53;
    _glfw.ns.nativeKeys[GLFW_KEY_KP_2]          = 0x54;
    _glfw.ns.nativeKeys[GLFW_KEY_KP_3]          = 0x55;
    _glfw.ns.nativeKeys[GLFW_KEY_KP_4]          = 0x56;
    _glfw.ns.nativeKeys[GLFW_KEY_KP_5]          = 0x57;
    _glfw.ns.nativeKeys[GLFW_KEY_KP_6]          = 0x58;
    _glfw.ns.nativeKeys[GLFW_KEY_KP_7]          = 0x59;
    _glfw.ns.nativeKeys[GLFW_KEY_KP_8]          = 0x5b;
    _glfw.ns.nativeKeys[GLFW_KEY_KP_9]          = 0x5c;
    _glfw.ns.nativeKeys[GLFW_KEY_KP_ADD]        = 0x45;
    _glfw.ns.nativeKeys[GLFW_KEY_KP_DECIMAL]    = 0x41;
    _glfw.ns.nativeKeys[GLFW_KEY_KP_DIVIDE]     = 0x4b;
    _glfw.ns.nativeKeys[GLFW_KEY_KP_ENTER]      = 0x4c;
    _glfw.ns.nativeKeys[GLFW_KEY_KP_EQUAL]      = 0x51;
    _glfw.ns.nativeKeys[GLFW_KEY_KP_MULTIPLY]   = 0x43;
    _glfw.ns.nativeKeys[GLFW_KEY_KP_SUBTRACT]   = 0x4e;

    for (i = 0;  i <= GLFW_KEY_LAST;  i++)
    {
        if (_glfw.ns.nativeKeys[i] != -1)
            _glfw.ns.publicKeys[_glfw.ns.nativeKeys[i]] = i;
    }
}


//////////////////////////////////////////////////////////////////////////
//////                       GLFW platform API                      //////
//////////////////////////////////////////////////////////////////////////

int _glfwPlatformInit(void)
{
    _glfw.ns.autoreleasePool = [[NSAutoreleasePool alloc] init];

#if defined(_GLFW_USE_CHDIR)
    changeToResourcesDirectory();
#endif

    createKeyTables();

    _glfw.ns.eventSource = CGEventSourceCreate(kCGEventSourceStateHIDSystemState);
    if (!_glfw.ns.eventSource)
        return GL_FALSE;

    CGEventSourceSetLocalEventsSuppressionInterval(_glfw.ns.eventSource, 0.0);

    if (!_glfwInitContextAPI())
        return GL_FALSE;

    _glfwInitTimer();
    _glfwInitJoysticks();

    return GL_TRUE;
}

void _glfwPlatformTerminate(void)
{
    if (_glfw.ns.eventSource)
    {
        CFRelease(_glfw.ns.eventSource);
        _glfw.ns.eventSource = NULL;
    }

    [NSApp setDelegate:nil];
    [_glfw.ns.delegate release];
    _glfw.ns.delegate = nil;

    [_glfw.ns.autoreleasePool release];
    _glfw.ns.autoreleasePool = nil;

    [_glfw.ns.cursor release];
    _glfw.ns.cursor = nil;

    free(_glfw.ns.clipboardString);
    free(_glfw.ns.keyName);

    _glfwTerminateJoysticks();
    _glfwTerminateContextAPI();
}

const char* _glfwPlatformGetVersionString(void)
{
    const char* version = _GLFW_VERSION_NUMBER " Cocoa"
#if defined(_GLFW_NSGL)
        " NSGL"
#endif
#if defined(_GLFW_USE_CHDIR)
        " chdir"
#endif
#if defined(_GLFW_USE_MENUBAR)
        " menubar"
#endif
#if defined(_GLFW_USE_RETINA)
        " retina"
#endif
#if defined(_GLFW_BUILD_DLL)
        " dynamic"
#endif
        ;

    return version;
}

