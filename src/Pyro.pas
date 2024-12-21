{===============================================================================
  ___              
 | _ \_  _ _ _ ___ 
 |  _/ || | '_/ _ \
 |_|  \_, |_| \___/
      |__/         
   Game Library™

 Copyright © 2024-present tinyBigGAMES™ LLC
 All Rights Reserved.

 https://github.com/tinyBigGAMES/Pyro

 BSD 3-Clause License

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:

 1. Redistributions of source code must retain the above copyright notice,
    this list of conditions and the following disclaimer.

 2. Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation
    and/or other materials provided with the distribution.

 3. Neither the name of the copyright holder nor the names of its
    contributors may be used to endorse or promote products derived from
    this software without specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
 LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
===============================================================================}

unit Pyro;

{$IF CompilerVersion >= 36.0}
  // Code specific to Delphi Athens (12.2) and above
{$ELSE}
  {$MESSAGE ERROR 'This code requires  Delphi Athens (12.2) or later'}
{$IFEND}

{$IFNDEF WIN64}
  // Generates a compile-time error if the target platform is not Win64
  {$MESSAGE Error 'Unsupported platform'}
{$ENDIF}

{$Z4}  // Sets the enumeration size to 4 bytes
{$A8}  // Sets the alignment for record fields to 8 bytes

{$WARN SYMBOL_DEPRECATED OFF}
{$WARN SYMBOL_PLATFORM OFF}

{$WARN UNIT_PLATFORM OFF}
{$WARN UNIT_DEPRECATED OFF}

interface

{$REGION ' Uses '}
uses
  WinApi.Windows,
  WinApi.Messages,
  System.Types,
  System.SysUtils,
  System.Classes,
  System.IOUtils,
  System.Math,
  System.SyncObjs,
  System.Rtti,
  System.TypInfo,
  System.AnsiStrings,
  System.Generics.Collections;
{$ENDREGION}

{$REGION ' Pyro.Deps '}
const
  CSFML_VERSION_MAJOR = 3;
  CSFML_VERSION_MINOR = 0;
  CSFML_VERSION_PATCH = 0;
  Z_ERRNO = -1;
  Z_OK = 0;
  Z_DEFLATED = 8;
  Z_DEFAULT_STRATEGY = 0;
  ZIP_OK = (0);
  ZIP_EOF = (0);
  ZIP_ERRNO = (Z_ERRNO);
  ZIP_PARAMERROR = (-102);
  ZIP_BADZIPFILE = (-103);
  ZIP_INTERNALERROR = (-104);
  UNZ_OK = (0);
  UNZ_END_OF_LIST_OF_FILE = (-100);
  UNZ_ERRNO = (Z_ERRNO);
  UNZ_EOF = (0);
  UNZ_PARAMERROR = (-102);
  UNZ_BADZIPFILE = (-103);
  UNZ_INTERNALERROR = (-104);
  UNZ_CRCERROR = (-105);
  APPEND_STATUS_CREATE = (0);
  APPEND_STATUS_CREATEAFTER = (1);
  APPEND_STATUS_ADDINZIP = (2);
  PLM_PACKET_INVALID_TS = -1;
  PLM_AUDIO_SAMPLES_PER_FRAME = 1152;
  PLM_BUFFER_DEFAULT_SIZE = (128*1024);
  WINVER = $0501;
  LUA_LDIR = '!\lua\';
  LUA_CDIR = '!\';
  LUA_PATH_DEFAULT = '.\?.lua;' + LUA_LDIR + '?.lua;' + LUA_LDIR + '?\init.lua;';
  LUA_CPATH_DEFAULT = '.\?.dll;' + LUA_CDIR + '?.dll;' + LUA_CDIR + 'loadall.dll';
  LUA_PATH = 'LUA_PATH';
  LUA_CPATH = 'LUA_CPATH';
  LUA_INIT = 'LUA_INIT';
  LUA_DIRSEP = '\';
  LUA_PATHSEP = ';';
  LUA_PATH_MARK = '?';
  LUA_EXECDIR = '!';
  LUA_IGMARK = '-';
  LUA_PATH_CONFIG = LUA_DIRSEP + #10 + LUA_PATHSEP + #10 + LUA_PATH_MARK + #10 + LUA_EXECDIR + #10 + LUA_IGMARK + #10;
  LUAI_MAXSTACK = 65500;
  LUAI_MAXCSTACK = 8000;
  LUAI_GCPAUSE = 200;
  LUAI_GCMUL = 200;
  LUA_MAXCAPTURES = 32;
  LUA_IDSIZE = 60;
  BUFSIZ = 512;
  LUA_NUMBER_SCAN = '%lf';
  LUA_NUMBER_FMT = '%.14g';
  LUAI_MAXNUMBER2STR = 32;
  LUA_INTFRMLEN = 'l';
  LUA_VERSION_ = 'Lua 5.1';
  LUA_RELEASE = 'Lua 5.1.4';
  LUA_VERSION_NUM = 501;
  LUA_COPYRIGHT = 'Copyright (C) 1994-2008 Lua.org, PUC-Rio';
  LUA_AUTHORS = 'R. Ierusalimschy, L. H. de Figueiredo & W. Celes';
  LUA_SIGNATURE = #27'Lua';
  LUA_MULTRET = (-1);
  LUA_REGISTRYINDEX = (-10000);
  LUA_ENVIRONINDEX = (-10001);
  LUA_GLOBALSINDEX = (-10002);
  LUA_OK = 0;
  LUA_YIELD_ = 1;
  LUA_ERRRUN = 2;
  LUA_ERRSYNTAX = 3;
  LUA_ERRMEM = 4;
  LUA_ERRERR = 5;
  LUA_TNONE = (-1);
  LUA_TNIL = 0;
  LUA_TBOOLEAN = 1;
  LUA_TLIGHTUSERDATA = 2;
  LUA_TNUMBER = 3;
  LUA_TSTRING = 4;
  LUA_TTABLE = 5;
  LUA_TFUNCTION = 6;
  LUA_TUSERDATA = 7;
  LUA_TTHREAD = 8;
  LUA_MINSTACK = 20;
  LUA_GCSTOP = 0;
  LUA_GCRESTART = 1;
  LUA_GCCOLLECT = 2;
  LUA_GCCOUNT = 3;
  LUA_GCCOUNTB = 4;
  LUA_GCSTEP = 5;
  LUA_GCSETPAUSE = 6;
  LUA_GCSETSTEPMUL = 7;
  LUA_GCISRUNNING = 9;
  LUA_HOOKCALL = 0;
  LUA_HOOKRET = 1;
  LUA_HOOKLINE = 2;
  LUA_HOOKCOUNT = 3;
  LUA_HOOKTAILRET = 4;
  LUA_MASKCALL = (1 shl LUA_HOOKCALL);
  LUA_MASKRET = (1 shl LUA_HOOKRET);
  LUA_MASKLINE = (1 shl LUA_HOOKLINE);
  LUA_MASKCOUNT = (1 shl LUA_HOOKCOUNT);
  LUA_FILEHANDLE = 'FILE*';
  LUA_COLIBNAME = 'coroutine';
  LUA_MATHLIBNAME = 'math';
  LUA_STRLIBNAME = 'string';
  LUA_TABLIBNAME = 'table';
  LUA_IOLIBNAME = 'io';
  LUA_OSLIBNAME = 'os';
  LUA_LOADLIBNAME = 'package';
  LUA_DBLIBNAME = 'debug';
  LUA_BITLIBNAME = 'bit';
  LUA_JITLIBNAME = 'jit';
  LUA_FFILIBNAME = 'ffi';
  LUA_ERRFILE = (LUA_ERRERR+1);
  LUA_NOREF = (-2);
  LUA_REFNIL = (-1);
  LUAJIT_VERSION = 'LuaJIT 2.1.1734355927';
  LUAJIT_VERSION_NUM = 20199;
  LUAJIT_COPYRIGHT = 'Copyright (C) 2005-2023 Mike Pall';
  LUAJIT_URL = 'https://luajit.org/';
  LUAJIT_MODE_MASK = $00ff;
  LUAJIT_MODE_OFF = $0000;
  LUAJIT_MODE_ON = $0100;
  LUAJIT_MODE_FLUSH = $0200;
  SP_SEQUENCE_MODE_HOLD = 0;
  SP_SEQUENCE_MODE_ONCE = 1;
  SP_SEQUENCE_MODE_LOOP = 2;
  SP_SEQUENCE_MODE_PINGPONG = 3;
  SP_SEQUENCE_MODE_ONCEREVERSE = 4;
  SP_SEQUENCE_MODE_LOOPREVERSE = 5;
  SP_SEQUENCE_MODE_PINGPONGREVERSE = 6;
  SP_MAX_PROPERTY_IDS = 3;
  SKIN_ENTRIES_HASH_TABLE_SIZE = 100;

type
  sfSoundChannel = Integer;
  PsfSoundChannel = ^sfSoundChannel;

const
  sfSoundChannelUnspecified = 0;
  sfSoundChannelMono = 1;
  sfSoundChannelFrontLeft = 2;
  sfSoundChannelFrontRight = 3;
  sfSoundChannelFrontCenter = 4;
  sfSoundChannelFrontLeftOfCenter = 5;
  sfSoundChannelFrontRightOfCenter = 6;
  sfSoundChannelLowFrequencyEffects = 7;
  sfSoundChannelBackLeft = 8;
  sfSoundChannelBackRight = 9;
  sfSoundChannelBackCenter = 10;
  sfSoundChannelSideLeft = 11;
  sfSoundChannelSideRight = 12;
  sfSoundChannelTopCenter = 13;
  sfSoundChannelTopFrontLeft = 14;
  sfSoundChannelTopFrontRight = 15;
  sfSoundChannelTopFrontCenter = 16;
  sfSoundChannelTopBackLeft = 17;
  sfSoundChannelTopBackRight = 18;
  sfSoundChannelTopBackCenter = 19;

type
  sfSoundStatus = Integer;
  PsfSoundStatus = ^sfSoundStatus;

const
  sfStopped = 0;
  sfPaused = 1;
  sfPlaying = 2;

type
  sfBlendFactor = Integer;
  PsfBlendFactor = ^sfBlendFactor;

const
  sfBlendFactorZero = 0;
  sfBlendFactorOne = 1;
  sfBlendFactorSrcColor = 2;
  sfBlendFactorOneMinusSrcColor = 3;
  sfBlendFactorDstColor = 4;
  sfBlendFactorOneMinusDstColor = 5;
  sfBlendFactorSrcAlpha = 6;
  sfBlendFactorOneMinusSrcAlpha = 7;
  sfBlendFactorDstAlpha = 8;
  sfBlendFactorOneMinusDstAlpha = 9;

type
  sfBlendEquation = Integer;
  PsfBlendEquation = ^sfBlendEquation;

const
  sfBlendEquationAdd = 0;
  sfBlendEquationSubtract = 1;
  sfBlendEquationReverseSubtract = 2;
  sfBlendEquationMin = 3;
  sfBlendEquationMax = 4;

type
  sfPrimitiveType = Integer;
  PsfPrimitiveType = ^sfPrimitiveType;

const
  sfPoints = 0;
  sfLines = 1;
  sfLineStrip = 2;
  sfTriangles = 3;
  sfTriangleStrip = 4;
  sfTriangleFan = 5;

type
  sfCoordinateType = Integer;
  PsfCoordinateType = ^sfCoordinateType;

const
  sfCoordinateTypeNormalized = 0;
  sfCoordinateTypePixels = 1;

type
  sfStencilComparison = Integer;
  PsfStencilComparison = ^sfStencilComparison;

const
  sfStencilComparisonNever = 0;
  sfStencilComparisonLess = 1;
  sfStencilComparisonLessEqual = 2;
  sfStencilComparisonGreater = 3;
  sfStencilComparisonGreaterEqual = 4;
  sfStencilComparisonEqual = 5;
  sfStencilComparisonNotEqual = 6;
  sfStencilComparisonAlways = 7;

type
  sfStencilUpdateOperation = Integer;
  PsfStencilUpdateOperation = ^sfStencilUpdateOperation;

const
  sfStencilUpdateOperationKeep = 0;
  sfStencilUpdateOperationZero = 1;
  sfStencilUpdateOperationReplace = 2;
  sfStencilUpdateOperationIncrement = 3;
  sfStencilUpdateOperationDecrement = 4;
  sfStencilUpdateOperationInvert = 5;

const
  sfJoystickCount = 8;
  sfJoystickButtonCount = 32;
  sfJoystickAxisCount = 8;

type
  sfJoystickAxis = Integer;
  PsfJoystickAxis = ^sfJoystickAxis;

const
  sfJoystickX = 0;
  sfJoystickY = 1;
  sfJoystickZ = 2;
  sfJoystickR = 3;
  sfJoystickU = 4;
  sfJoystickV = 5;
  sfJoystickPovX = 6;
  sfJoystickPovY = 7;

type
  sfKeyCode = Integer;
  PsfKeyCode = ^sfKeyCode;

const
  sfKeyUnknown = -1;
  sfKeyA = 0;
  sfKeyB = 1;
  sfKeyC = 2;
  sfKeyD = 3;
  sfKeyE = 4;
  sfKeyF = 5;
  sfKeyG = 6;
  sfKeyH = 7;
  sfKeyI = 8;
  sfKeyJ = 9;
  sfKeyK = 10;
  sfKeyL = 11;
  sfKeyM = 12;
  sfKeyN = 13;
  sfKeyO = 14;
  sfKeyP = 15;
  sfKeyQ = 16;
  sfKeyR = 17;
  sfKeyS = 18;
  sfKeyT = 19;
  sfKeyU = 20;
  sfKeyV = 21;
  sfKeyW = 22;
  sfKeyX = 23;
  sfKeyY = 24;
  sfKeyZ = 25;
  sfKeyNum0 = 26;
  sfKeyNum1 = 27;
  sfKeyNum2 = 28;
  sfKeyNum3 = 29;
  sfKeyNum4 = 30;
  sfKeyNum5 = 31;
  sfKeyNum6 = 32;
  sfKeyNum7 = 33;
  sfKeyNum8 = 34;
  sfKeyNum9 = 35;
  sfKeyEscape = 36;
  sfKeyLControl = 37;
  sfKeyLShift = 38;
  sfKeyLAlt = 39;
  sfKeyLSystem = 40;
  sfKeyRControl = 41;
  sfKeyRShift = 42;
  sfKeyRAlt = 43;
  sfKeyRSystem = 44;
  sfKeyMenu = 45;
  sfKeyLBracket = 46;
  sfKeyRBracket = 47;
  sfKeySemicolon = 48;
  sfKeyComma = 49;
  sfKeyPeriod = 50;
  sfKeyApostrophe = 51;
  sfKeySlash = 52;
  sfKeyBackslash = 53;
  sfKeyGrave = 54;
  sfKeyEqual = 55;
  sfKeyHyphen = 56;
  sfKeySpace = 57;
  sfKeyEnter = 58;
  sfKeyBackspace = 59;
  sfKeyTab = 60;
  sfKeyPageUp = 61;
  sfKeyPageDown = 62;
  sfKeyEnd = 63;
  sfKeyHome = 64;
  sfKeyInsert = 65;
  sfKeyDelete = 66;
  sfKeyAdd = 67;
  sfKeySubtract = 68;
  sfKeyMultiply = 69;
  sfKeyDivide = 70;
  sfKeyLeft = 71;
  sfKeyRight = 72;
  sfKeyUp = 73;
  sfKeyDown = 74;
  sfKeyNumpad0 = 75;
  sfKeyNumpad1 = 76;
  sfKeyNumpad2 = 77;
  sfKeyNumpad3 = 78;
  sfKeyNumpad4 = 79;
  sfKeyNumpad5 = 80;
  sfKeyNumpad6 = 81;
  sfKeyNumpad7 = 82;
  sfKeyNumpad8 = 83;
  sfKeyNumpad9 = 84;
  sfKeyF1 = 85;
  sfKeyF2 = 86;
  sfKeyF3 = 87;
  sfKeyF4 = 88;
  sfKeyF5 = 89;
  sfKeyF6 = 90;
  sfKeyF7 = 91;
  sfKeyF8 = 92;
  sfKeyF9 = 93;
  sfKeyF10 = 94;
  sfKeyF11 = 95;
  sfKeyF12 = 96;
  sfKeyF13 = 97;
  sfKeyF14 = 98;
  sfKeyF15 = 99;
  sfKeyPause = 100;

const
  sfKeyCount = 101;

type
  sfScancode = Integer;
  PsfScancode = ^sfScancode;

const
  sfScanUnknown = -1;
  sfScanA = 0;
  sfScanB = 1;
  sfScanC = 2;
  sfScanD = 3;
  sfScanE = 4;
  sfScanF = 5;
  sfScanG = 6;
  sfScanH = 7;
  sfScanI = 8;
  sfScanJ = 9;
  sfScanK = 10;
  sfScanL = 11;
  sfScanM = 12;
  sfScanN = 13;
  sfScanO = 14;
  sfScanP = 15;
  sfScanQ = 16;
  sfScanR = 17;
  sfScanS = 18;
  sfScanT = 19;
  sfScanU = 20;
  sfScanV = 21;
  sfScanW = 22;
  sfScanX = 23;
  sfScanY = 24;
  sfScanZ = 25;
  sfScanNum1 = 26;
  sfScanNum2 = 27;
  sfScanNum3 = 28;
  sfScanNum4 = 29;
  sfScanNum5 = 30;
  sfScanNum6 = 31;
  sfScanNum7 = 32;
  sfScanNum8 = 33;
  sfScanNum9 = 34;
  sfScanNum0 = 35;
  sfScanEnter = 36;
  sfScanEscape = 37;
  sfScanBackspace = 38;
  sfScanTab = 39;
  sfScanSpace = 40;
  sfScanHyphen = 41;
  sfScanEqual = 42;
  sfScanLBracket = 43;
  sfScanRBracket = 44;
  sfScanBackslash = 45;
  sfScanSemicolon = 46;
  sfScanApostrophe = 47;
  sfScanGrave = 48;
  sfScanComma = 49;
  sfScanPeriod = 50;
  sfScanSlash = 51;
  sfScanF1 = 52;
  sfScanF2 = 53;
  sfScanF3 = 54;
  sfScanF4 = 55;
  sfScanF5 = 56;
  sfScanF6 = 57;
  sfScanF7 = 58;
  sfScanF8 = 59;
  sfScanF9 = 60;
  sfScanF10 = 61;
  sfScanF11 = 62;
  sfScanF12 = 63;
  sfScanF13 = 64;
  sfScanF14 = 65;
  sfScanF15 = 66;
  sfScanF16 = 67;
  sfScanF17 = 68;
  sfScanF18 = 69;
  sfScanF19 = 70;
  sfScanF20 = 71;
  sfScanF21 = 72;
  sfScanF22 = 73;
  sfScanF23 = 74;
  sfScanF24 = 75;
  sfScanCapsLock = 76;
  sfScanPrintScreen = 77;
  sfScanScrollLock = 78;
  sfScanPause = 79;
  sfScanInsert = 80;
  sfScanHome = 81;
  sfScanPageUp = 82;
  sfScanDelete = 83;
  sfScanEnd = 84;
  sfScanPageDown = 85;
  sfScanRight = 86;
  sfScanLeft = 87;
  sfScanDown = 88;
  sfScanUp = 89;
  sfScanNumLock = 90;
  sfScanNumpadDivide = 91;
  sfScanNumpadMultiply = 92;
  sfScanNumpadMinus = 93;
  sfScanNumpadPlus = 94;
  sfScanNumpadEqual = 95;
  sfScanNumpadEnter = 96;
  sfScanNumpadDecimal = 97;
  sfScanNumpad1 = 98;
  sfScanNumpad2 = 99;
  sfScanNumpad3 = 100;
  sfScanNumpad4 = 101;
  sfScanNumpad5 = 102;
  sfScanNumpad6 = 103;
  sfScanNumpad7 = 104;
  sfScanNumpad8 = 105;
  sfScanNumpad9 = 106;
  sfScanNumpad0 = 107;
  sfScanNonUsBackslash = 108;
  sfScanApplication = 109;
  sfScanExecute = 110;
  sfScanModeChange = 111;
  sfScanHelp = 112;
  sfScanMenu = 113;
  sfScanSelect = 114;
  sfScanRedo = 115;
  sfScanUndo = 116;
  sfScanCut = 117;
  sfScanCopy = 118;
  sfScanPaste = 119;
  sfScanVolumeMute = 120;
  sfScanVolumeUp = 121;
  sfScanVolumeDown = 122;
  sfScanMediaPlayPause = 123;
  sfScanMediaStop = 124;
  sfScanMediaNextTrack = 125;
  sfScanMediaPreviousTrack = 126;
  sfScanLControl = 127;
  sfScanLShift = 128;
  sfScanLAlt = 129;
  sfScanLSystem = 130;
  sfScanRControl = 131;
  sfScanRShift = 132;
  sfScanRAlt = 133;
  sfScanRSystem = 134;
  sfScanBack = 135;
  sfScanForward = 136;
  sfScanRefresh = 137;
  sfScanStop = 138;
  sfScanSearch = 139;
  sfScanFavorites = 140;
  sfScanHomePage = 141;
  sfScanLaunchApplication1 = 142;
  sfScanLaunchApplication2 = 143;
  sfScanLaunchMail = 144;
  sfScanLaunchMediaSelect = 145;

const
  sfScancodeCount = 146;

type
  sfMouseButton = Integer;
  PsfMouseButton = ^sfMouseButton;

const
  sfMouseLeft = 0;
  sfMouseRight = 1;
  sfMouseMiddle = 2;
  sfMouseButtonExtra1 = 3;
  sfMouseButtonExtra2 = 4;

const
  sfMouseButtonCount = 5;

type
  sfMouseWheel = Integer;
  PsfMouseWheel = ^sfMouseWheel;

const
  sfMouseVerticalWheel = 0;
  sfMouseHorizontalWheel = 1;

type
  sfSensorType = Integer;
  PsfSensorType = ^sfSensorType;

const
  sfSensorAccelerometer = 0;
  sfSensorGyroscope = 1;
  sfSensorMagnetometer = 2;
  sfSensorGravity = 3;
  sfSensorUserAcceleration = 4;
  sfSensorOrientation = 5;

const
  sfSensorCount = 6;

type
  sfEventType = Integer;
  PsfEventType = ^sfEventType;

const
  sfEvtClosed = 0;
  sfEvtResized = 1;
  sfEvtFocusLost = 2;
  sfEvtFocusGained = 3;
  sfEvtTextEntered = 4;
  sfEvtKeyPressed = 5;
  sfEvtKeyReleased = 6;
  sfEvtMouseWheelScrolled = 7;
  sfEvtMouseButtonPressed = 8;
  sfEvtMouseButtonReleased = 9;
  sfEvtMouseMoved = 10;
  sfEvtMouseMovedRaw = 11;
  sfEvtMouseEntered = 12;
  sfEvtMouseLeft = 13;
  sfEvtJoystickButtonPressed = 14;
  sfEvtJoystickButtonReleased = 15;
  sfEvtJoystickMoved = 16;
  sfEvtJoystickConnected = 17;
  sfEvtJoystickDisconnected = 18;
  sfEvtTouchBegan = 19;
  sfEvtTouchMoved = 20;
  sfEvtTouchEnded = 21;
  sfEvtSensorChanged = 22;
  sfEvtCount = 23;

type
  sfWindowStyle = Integer;
  PsfWindowStyle = ^sfWindowStyle;

const
  sfNone = 0;
  sfTitlebar = 1;
  sfResize = 2;
  sfClose = 4;
  sfDefaultStyle = 7;

type
  sfWindowState = Integer;
  PsfWindowState = ^sfWindowState;

const
  sfWindowed = 0;
  sfFullscreen = 1;

type
  sfContextAttribute = Integer;
  PsfContextAttribute = ^sfContextAttribute;

const
  sfContextDefault = 0;
  sfContextCore = 1;
  sfContextDebug = 4;

type
  sfTextStyle = Integer;
  PsfTextStyle = ^sfTextStyle;

const
  sfTextRegular = 0;
  sfTextBold = 1;
  sfTextItalic = 2;
  sfTextUnderlined = 4;
  sfTextStrikeThrough = 8;

type
  sfVertexBufferUsage = Integer;
  PsfVertexBufferUsage = ^sfVertexBufferUsage;

const
  sfVertexBufferStream = 0;
  sfVertexBufferDynamic = 1;
  sfVertexBufferStatic = 2;

type
  sfCursorType = Integer;
  PsfCursorType = ^sfCursorType;

const
  sfCursorArrow = 0;
  sfCursorArrowWait = 1;
  sfCursorWait = 2;
  sfCursorText = 3;
  sfCursorHand = 4;
  sfCursorSizeHorizontal = 5;
  sfCursorSizeVertical = 6;
  sfCursorSizeTopLeftBottomRight = 7;
  sfCursorSizeBottomLeftTopRight = 8;
  sfCursorSizeLeft = 9;
  sfCursorSizeRight = 10;
  sfCursorSizeTop = 11;
  sfCursorSizeBottom = 12;
  sfCursorSizeTopLeft = 13;
  sfCursorSizeBottomRight = 14;
  sfCursorSizeBottomLeft = 15;
  sfCursorSizeTopRight = 16;
  sfCursorSizeAll = 17;
  sfCursorCross = 18;
  sfCursorHelp = 19;
  sfCursorNotAllowed = 20;

type
  sfFtpTransferMode = Integer;
  PsfFtpTransferMode = ^sfFtpTransferMode;

const
  sfFtpBinary = 0;
  sfFtpAscii = 1;
  sfFtpEbcdic = 2;

type
  sfFtpStatus = Integer;
  PsfFtpStatus = ^sfFtpStatus;

const
  sfFtpRestartMarkerReply = 110;
  sfFtpServiceReadySoon = 120;
  sfFtpDataConnectionAlreadyOpened = 125;
  sfFtpOpeningDataConnection = 150;
  sfFtpOk = 200;
  sfFtpPointlessCommand = 202;
  sfFtpSystemStatus = 211;
  sfFtpDirectoryStatus = 212;
  sfFtpFileStatus = 213;
  sfFtpHelpMessage = 214;
  sfFtpSystemType = 215;
  sfFtpServiceReady = 220;
  sfFtpClosingConnection = 221;
  sfFtpDataConnectionOpened = 225;
  sfFtpClosingDataConnection = 226;
  sfFtpEnteringPassiveMode = 227;
  sfFtpLoggedIn = 230;
  sfFtpFileActionOk = 250;
  sfFtpDirectoryOk = 257;
  sfFtpNeedPassword = 331;
  sfFtpNeedAccountToLogIn = 332;
  sfFtpNeedInformation = 350;
  sfFtpServiceUnavailable = 421;
  sfFtpDataConnectionUnavailable = 425;
  sfFtpTransferAborted = 426;
  sfFtpFileActionAborted = 450;
  sfFtpLocalError = 451;
  sfFtpInsufficientStorageSpace = 452;
  sfFtpCommandUnknown = 500;
  sfFtpParametersUnknown = 501;
  sfFtpCommandNotImplemented = 502;
  sfFtpBadCommandSequence = 503;
  sfFtpParameterNotImplemented = 504;
  sfFtpNotLoggedIn = 530;
  sfFtpNeedAccountToStore = 532;
  sfFtpFileUnavailable = 550;
  sfFtpPageTypeUnknown = 551;
  sfFtpNotEnoughMemory = 552;
  sfFtpFilenameNotAllowed = 553;
  sfFtpInvalidResponse = 1000;
  sfFtpConnectionFailed = 1001;
  sfFtpConnectionClosed = 1002;
  sfFtpInvalidFile = 1003;

type
  sfHttpMethod = Integer;
  PsfHttpMethod = ^sfHttpMethod;

const
  sfHttpGet = 0;
  sfHttpPost = 1;
  sfHttpHead = 2;
  sfHttpPut = 3;
  sfHttpDelete = 4;

type
  sfHttpStatus = Integer;
  PsfHttpStatus = ^sfHttpStatus;

const
  sfHttpOk = 200;
  sfHttpCreated = 201;
  sfHttpAccepted = 202;
  sfHttpNoContent = 204;
  sfHttpResetContent = 205;
  sfHttpPartialContent = 206;
  sfHttpMultipleChoices = 300;
  sfHttpMovedPermanently = 301;
  sfHttpMovedTemporarily = 302;
  sfHttpNotModified = 304;
  sfHttpBadRequest = 400;
  sfHttpUnauthorized = 401;
  sfHttpForbidden = 403;
  sfHttpNotFound = 404;
  sfHttpRangeNotSatisfiable = 407;
  sfHttpInternalServerError = 500;
  sfHttpNotImplemented = 501;
  sfHttpBadGateway = 502;
  sfHttpServiceNotAvailable = 503;
  sfHttpGatewayTimeout = 504;
  sfHttpVersionNotSupported = 505;
  sfHttpInvalidResponse = 1000;
  sfHttpConnectionFailed = 1001;

type
  sfSocketStatus = Integer;
  PsfSocketStatus = ^sfSocketStatus;

const
  sfSocketDone = 0;
  sfSocketNotReady = 1;
  sfSocketPartial = 2;
  sfSocketDisconnected = 3;
  sfSocketError = 4;

const
  LUAJIT_MODE_ENGINE = 0;
  LUAJIT_MODE_DEBUG = 1;
  LUAJIT_MODE_FUNC = 2;
  LUAJIT_MODE_ALLFUNC = 3;
  LUAJIT_MODE_ALLSUBFUNC = 4;
  LUAJIT_MODE_TRACE = 5;
  LUAJIT_MODE_WRAPCFUNC = 16;
  LUAJIT_MODE_MAX = 17;

type
  spAttachmentType = Integer;
  PspAttachmentType = ^spAttachmentType;

const
  SP_ATTACHMENT_REGION = 0;
  SP_ATTACHMENT_BOUNDING_BOX = 1;
  SP_ATTACHMENT_MESH = 2;
  SP_ATTACHMENT_LINKED_MESH = 3;
  SP_ATTACHMENT_PATH = 4;
  SP_ATTACHMENT_POINT = 5;
  SP_ATTACHMENT_CLIPPING = 6;

type
  spInherit = Integer;
  PspInherit = ^spInherit;

const
  SP_INHERIT_NORMAL = 0;
  SP_INHERIT_ONLYTRANSLATION = 1;
  SP_INHERIT_NOROTATIONORREFLECTION = 2;
  SP_INHERIT_NOSCALE = 3;
  SP_INHERIT_NOSCALEORREFLECTION = 4;

type
  spPhysics = Integer;
  PspPhysics = ^spPhysics;

const
  SP_PHYSICS_NONE = 0;
  SP_PHYSICS_RESET = 1;
  SP_PHYSICS_UPDATE = 2;
  SP_PHYSICS_POSE = 3;

type
  spBlendMode = Integer;
  PspBlendMode = ^spBlendMode;

const
  SP_BLEND_MODE_NORMAL = 0;
  SP_BLEND_MODE_ADDITIVE = 1;
  SP_BLEND_MODE_MULTIPLY = 2;
  SP_BLEND_MODE_SCREEN = 3;

type
  spAtlasFormat = Integer;
  PspAtlasFormat = ^spAtlasFormat;

const
  SP_ATLAS_UNKNOWN_FORMAT = 0;
  SP_ATLAS_ALPHA = 1;
  SP_ATLAS_INTENSITY = 2;
  SP_ATLAS_LUMINANCE_ALPHA = 3;
  SP_ATLAS_RGB565 = 4;
  SP_ATLAS_RGBA4444 = 5;
  SP_ATLAS_RGB888 = 6;
  SP_ATLAS_RGBA8888 = 7;

type
  spAtlasFilter = Integer;
  PspAtlasFilter = ^spAtlasFilter;

const
  SP_ATLAS_UNKNOWN_FILTER = 0;
  SP_ATLAS_NEAREST = 1;
  SP_ATLAS_LINEAR = 2;
  SP_ATLAS_MIPMAP = 3;
  SP_ATLAS_MIPMAP_NEAREST_NEAREST = 4;
  SP_ATLAS_MIPMAP_LINEAR_NEAREST = 5;
  SP_ATLAS_MIPMAP_NEAREST_LINEAR = 6;
  SP_ATLAS_MIPMAP_LINEAR_LINEAR = 7;

type
  spAtlasWrap = Integer;
  PspAtlasWrap = ^spAtlasWrap;

const
  SP_ATLAS_MIRROREDREPEAT = 0;
  SP_ATLAS_CLAMPTOEDGE = 1;
  SP_ATLAS_REPEAT = 2;

type
  spMixBlend = Integer;
  PspMixBlend = ^spMixBlend;

const
  SP_MIX_BLEND_SETUP = 0;
  SP_MIX_BLEND_FIRST = 1;
  SP_MIX_BLEND_REPLACE = 2;
  SP_MIX_BLEND_ADD = 3;

type
  spMixDirection = Integer;
  PspMixDirection = ^spMixDirection;

const
  SP_MIX_DIRECTION_IN = 0;
  SP_MIX_DIRECTION_OUT = 1;

type
  spTimelineType = Integer;
  PspTimelineType = ^spTimelineType;

const
  SP_TIMELINE_ATTACHMENT = 0;
  SP_TIMELINE_ALPHA = 1;
  SP_TIMELINE_PATHCONSTRAINTPOSITION = 2;
  SP_TIMELINE_PATHCONSTRAINTSPACING = 3;
  SP_TIMELINE_ROTATE = 4;
  SP_TIMELINE_SCALEX = 5;
  SP_TIMELINE_SCALEY = 6;
  SP_TIMELINE_SHEARX = 7;
  SP_TIMELINE_SHEARY = 8;
  SP_TIMELINE_TRANSLATEX = 9;
  SP_TIMELINE_TRANSLATEY = 10;
  SP_TIMELINE_SCALE = 11;
  SP_TIMELINE_SHEAR = 12;
  SP_TIMELINE_TRANSLATE = 13;
  SP_TIMELINE_DEFORM = 14;
  SP_TIMELINE_SEQUENCE = 15;
  SP_TIMELINE_INHERIT = 16;
  SP_TIMELINE_IKCONSTRAINT = 17;
  SP_TIMELINE_PATHCONSTRAINTMIX = 18;
  SP_TIMELINE_PHYSICSCONSTRAINT_INERTIA = 19;
  SP_TIMELINE_PHYSICSCONSTRAINT_STRENGTH = 20;
  SP_TIMELINE_PHYSICSCONSTRAINT_DAMPING = 21;
  SP_TIMELINE_PHYSICSCONSTRAINT_MASS = 22;
  SP_TIMELINE_PHYSICSCONSTRAINT_WIND = 23;
  SP_TIMELINE_PHYSICSCONSTRAINT_GRAVITY = 24;
  SP_TIMELINE_PHYSICSCONSTRAINT_MIX = 25;
  SP_TIMELINE_PHYSICSCONSTRAINT_RESET = 26;
  SP_TIMELINE_RGB2 = 27;
  SP_TIMELINE_RGBA2 = 28;
  SP_TIMELINE_RGBA = 29;
  SP_TIMELINE_RGB = 30;
  SP_TIMELINE_TRANSFORMCONSTRAINT = 31;
  SP_TIMELINE_DRAWORDER = 32;
  SP_TIMELINE_EVENT = 33;

type
  spProperty = Integer;
  PspProperty = ^spProperty;

const
  SP_PROPERTY_ROTATE = 1;
  SP_PROPERTY_X = 2;
  SP_PROPERTY_Y = 4;
  SP_PROPERTY_SCALEX = 8;
  SP_PROPERTY_SCALEY = 16;
  SP_PROPERTY_SHEARX = 32;
  SP_PROPERTY_SHEARY = 64;
  SP_PROPERTY_INHERIT = 128;
  SP_PROPERTY_RGB = 256;
  SP_PROPERTY_ALPHA = 512;
  SP_PROPERTY_RGB2 = 1024;
  SP_PROPERTY_ATTACHMENT = 2048;
  SP_PROPERTY_DEFORM = 4096;
  SP_PROPERTY_EVENT = 8192;
  SP_PROPERTY_DRAWORDER = 16384;
  SP_PROPERTY_IKCONSTRAINT = 32768;
  SP_PROPERTY_TRANSFORMCONSTRAINT = 65536;
  SP_PROPERTY_PATHCONSTRAINT_POSITION = 131072;
  SP_PROPERTY_PATHCONSTRAINT_SPACING = 262144;
  SP_PROPERTY_PATHCONSTRAINT_MIX = 524288;
  SP_PROPERTY_PHYSICSCONSTRAINT_INERTIA = 1048576;
  SP_PROPERTY_PHYSICSCONSTRAINT_STRENGTH = 2097152;
  SP_PROPERTY_PHYSICSCONSTRAINT_DAMPING = 4194304;
  SP_PROPERTY_PHYSICSCONSTRAINT_MASS = 8388608;
  SP_PROPERTY_PHYSICSCONSTRAINT_WIND = 16777216;
  SP_PROPERTY_PHYSICSCONSTRAINT_GRAVITY = 33554432;
  SP_PROPERTY_PHYSICSCONSTRAINT_MIX = 67108864;
  SP_PROPERTY_PHYSICSCONSTRAINT_RESET = 134217728;
  SP_PROPERTY_SEQUENCE = 268435456;

type
  spPositionMode = Integer;
  PspPositionMode = ^spPositionMode;

const
  SP_POSITION_MODE_FIXED = 0;
  SP_POSITION_MODE_PERCENT = 1;

type
  spSpacingMode = Integer;
  PspSpacingMode = ^spSpacingMode;

const
  SP_SPACING_MODE_LENGTH = 0;
  SP_SPACING_MODE_FIXED = 1;
  SP_SPACING_MODE_PERCENT = 2;
  SP_SPACING_MODE_PROPORTIONAL = 3;

type
  spRotateMode = Integer;
  PspRotateMode = ^spRotateMode;

const
  SP_ROTATE_MODE_TANGENT = 0;
  SP_ROTATE_MODE_CHAIN = 1;
  SP_ROTATE_MODE_CHAIN_SCALE = 2;

type
  spEventType = Integer;
  PspEventType = ^spEventType;

const
  SP_ANIMATION_START = 0;
  SP_ANIMATION_INTERRUPT = 1;
  SP_ANIMATION_END = 2;
  SP_ANIMATION_COMPLETE = 3;
  SP_ANIMATION_DISPOSE = 4;
  SP_ANIMATION_EVENT = 5;

type
  // Forward declarations
  PPUTF8Char = ^PUTF8Char;
  PPInteger = ^PInteger;
  PPSingle = ^PSingle;
  PInt16 = ^Int16;
  PNativeUInt = ^NativeUInt;
  PUInt8 = ^UInt8;
  PPointer = ^Pointer;
  PVkInstance_T = Pointer;
  PPVkInstance_T = ^PVkInstance_T;
  PVkSurfaceKHR_T = Pointer;
  PPVkSurfaceKHR_T = ^PVkSurfaceKHR_T;
  PHWND__ = Pointer;
  PPHWND__ = ^PHWND__;
  PsfVector3f = ^sfVector3f;
  PsfListenerCone = ^sfListenerCone;
  PsfSoundSourceCone = ^sfSoundSourceCone;
  PsfInputStream = ^sfInputStream;
  PsfTime = ^sfTime;
  PsfTimeSpan = ^sfTimeSpan;
  PsfSoundStreamChunk = ^sfSoundStreamChunk;
  PsfVector2i = ^sfVector2i;
  PsfVector2u = ^sfVector2u;
  PsfVector2f = ^sfVector2f;
  PsfBlendMode = ^sfBlendMode;
  PsfColor = ^sfColor;
  PsfFloatRect = ^sfFloatRect;
  PsfIntRect = ^sfIntRect;
  PsfTransform = ^sfTransform;
  PsfFontInfo = ^sfFontInfo;
  PsfGlyph = ^sfGlyph;
  PsfStencilValue = ^sfStencilValue;
  PsfStencilMode = ^sfStencilMode;
  PsfRenderStates = ^sfRenderStates;
  PsfVertex = ^sfVertex;
  PsfJoystickIdentification = ^sfJoystickIdentification;
  PsfKeyEvent = ^sfKeyEvent;
  PsfTextEvent = ^sfTextEvent;
  PsfMouseMoveEvent = ^sfMouseMoveEvent;
  PsfMouseMoveRawEvent = ^sfMouseMoveRawEvent;
  PsfMouseButtonEvent = ^sfMouseButtonEvent;
  PsfMouseWheelScrollEvent = ^sfMouseWheelScrollEvent;
  PsfJoystickMoveEvent = ^sfJoystickMoveEvent;
  PsfJoystickButtonEvent = ^sfJoystickButtonEvent;
  PsfJoystickConnectEvent = ^sfJoystickConnectEvent;
  PsfSizeEvent = ^sfSizeEvent;
  PsfTouchEvent = ^sfTouchEvent;
  PsfSensorEvent = ^sfSensorEvent;
  PsfVideoMode = ^sfVideoMode;
  PsfContextSettings = ^sfContextSettings;
  PsfGlslBvec2 = ^sfGlslBvec2;
  PsfGlslIvec3 = ^sfGlslIvec3;
  PsfGlslBvec3 = ^sfGlslBvec3;
  PsfGlslVec4 = ^sfGlslVec4;
  PsfGlslIvec4 = ^sfGlslIvec4;
  PsfGlslBvec4 = ^sfGlslBvec4;
  PsfGlslMat3 = ^sfGlslMat3;
  PsfGlslMat4 = ^sfGlslMat4;
  PsfIpAddress = ^sfIpAddress;
  Ptm_zip_s = ^tm_zip_s;
  Pzip_fileinfo = ^zip_fileinfo;
  Ptm_unz_s = ^tm_unz_s;
  Punz_file_info64_s = ^unz_file_info64_s;
  Pplm_packet_t = ^plm_packet_t;
  Pplm_plane_t = ^plm_plane_t;
  Pplm_frame_t = ^plm_frame_t;
  Pplm_samples_t = ^plm_samples_t;
  Plua_Debug = ^lua_Debug;
  PluaL_Reg = ^luaL_Reg;
  PluaL_Buffer = ^luaL_Buffer;
  PspFloatArray = ^spFloatArray;
  PPspFloatArray = ^PspFloatArray;
  PspIntArray = ^spIntArray;
  PspShortArray = ^spShortArray;
  PPspShortArray = ^PspShortArray;
  PspUnsignedShortArray = ^spUnsignedShortArray;
  PspArrayFloatArray = ^spArrayFloatArray;
  PspArrayShortArray = ^spArrayShortArray;
  PspEventData = ^spEventData;
  PPspEventData = ^PspEventData;
  PspEvent = ^spEvent;
  PPspEvent = ^PspEvent;
  PspAttachment = ^spAttachment;
  PspColor = ^spColor;
  PspBoneData = ^spBoneData;
  PPspBoneData = ^PspBoneData;
  PspBone = ^spBone;
  PPspBone = ^PspBone;
  PspSlotData = ^spSlotData;
  PPspSlotData = ^PspSlotData;
  PspSlot = ^spSlot;
  PPspSlot = ^PspSlot;
  PspVertexAttachment = ^spVertexAttachment;
  PspTextureRegion = ^spTextureRegion;
  PPspTextureRegion = ^PspTextureRegion;
  PspAtlasPage = ^spAtlasPage;
  PspKeyValue = ^spKeyValue;
  PspKeyValueArray = ^spKeyValueArray;
  PspAtlasRegion = ^spAtlasRegion;
  PspAtlas = ^spAtlas;
  PspTextureRegionArray = ^spTextureRegionArray;
  PspSequence = ^spSequence;
  PspPropertyIdArray = ^spPropertyIdArray;
  PspTimelineArray = ^spTimelineArray;
  PspAnimation = ^spAnimation;
  PPspAnimation = ^PspAnimation;
  P_spTimelineVtable = ^_spTimelineVtable;
  PspTimeline = ^spTimeline;
  PPspTimeline = ^PspTimeline;
  PspCurveTimeline = ^spCurveTimeline;
  PspRotateTimeline = ^spRotateTimeline;
  PspTranslateTimeline = ^spTranslateTimeline;
  PspTranslateXTimeline = ^spTranslateXTimeline;
  PspTranslateYTimeline = ^spTranslateYTimeline;
  PspScaleTimeline = ^spScaleTimeline;
  PspScaleXTimeline = ^spScaleXTimeline;
  PspScaleYTimeline = ^spScaleYTimeline;
  PspShearTimeline = ^spShearTimeline;
  PspShearXTimeline = ^spShearXTimeline;
  PspShearYTimeline = ^spShearYTimeline;
  PspRGBATimeline = ^spRGBATimeline;
  PspRGBTimeline = ^spRGBTimeline;
  PspAlphaTimeline = ^spAlphaTimeline;
  PspRGBA2Timeline = ^spRGBA2Timeline;
  PspRGB2Timeline = ^spRGB2Timeline;
  PspAttachmentTimeline = ^spAttachmentTimeline;
  PspDeformTimeline = ^spDeformTimeline;
  PspSequenceTimeline = ^spSequenceTimeline;
  PspEventTimeline = ^spEventTimeline;
  PspDrawOrderTimeline = ^spDrawOrderTimeline;
  PspInheritTimeline = ^spInheritTimeline;
  PspIkConstraintTimeline = ^spIkConstraintTimeline;
  PspTransformConstraintTimeline = ^spTransformConstraintTimeline;
  PspPathConstraintPositionTimeline = ^spPathConstraintPositionTimeline;
  PspPathConstraintSpacingTimeline = ^spPathConstraintSpacingTimeline;
  PspPathConstraintMixTimeline = ^spPathConstraintMixTimeline;
  PspPhysicsConstraintTimeline = ^spPhysicsConstraintTimeline;
  PspPhysicsConstraintResetTimeline = ^spPhysicsConstraintResetTimeline;
  PspIkConstraintData = ^spIkConstraintData;
  PPspIkConstraintData = ^PspIkConstraintData;
  PspTransformConstraintData = ^spTransformConstraintData;
  PPspTransformConstraintData = ^PspTransformConstraintData;
  PspPathConstraintData = ^spPathConstraintData;
  PPspPathConstraintData = ^PspPathConstraintData;
  PspPhysicsConstraintData = ^spPhysicsConstraintData;
  PPspPhysicsConstraintData = ^PspPhysicsConstraintData;
  PspBoneDataArray = ^spBoneDataArray;
  PspIkConstraintDataArray = ^spIkConstraintDataArray;
  PspTransformConstraintDataArray = ^spTransformConstraintDataArray;
  PspPathConstraintDataArray = ^spPathConstraintDataArray;
  PspPhysicsConstraintDataArray = ^spPhysicsConstraintDataArray;
  PspSkin = ^spSkin;
  PPspSkin = ^PspSkin;
  P_Entry = ^_Entry;
  P_SkinHashTableEntry = ^_SkinHashTableEntry;
  P_spSkin = ^_spSkin;
  PspSkeletonData = ^spSkeletonData;
  PspAnimationStateData = ^spAnimationStateData;
  PspTrackEntryArray = ^spTrackEntryArray;
  PspTrackEntry = ^spTrackEntry;
  PPspTrackEntry = ^PspTrackEntry;
  PspAnimationState = ^spAnimationState;
  PspAttachmentLoader = ^spAttachmentLoader;
  PspAtlasAttachmentLoader = ^spAtlasAttachmentLoader;
  PspRegionAttachment = ^spRegionAttachment;
  PspMeshAttachment = ^spMeshAttachment;
  PspBoundingBoxAttachment = ^spBoundingBoxAttachment;
  PPspBoundingBoxAttachment = ^PspBoundingBoxAttachment;
  PspClippingAttachment = ^spClippingAttachment;
  PspPointAttachment = ^spPointAttachment;
  PspIkConstraint = ^spIkConstraint;
  PPspIkConstraint = ^PspIkConstraint;
  PspTransformConstraint = ^spTransformConstraint;
  PPspTransformConstraint = ^PspTransformConstraint;
  PspPathAttachment = ^spPathAttachment;
  PspPathConstraint = ^spPathConstraint;
  PPspPathConstraint = ^PspPathConstraint;
  PspPhysicsConstraint = ^spPhysicsConstraint;
  PPspPhysicsConstraint = ^PspPhysicsConstraint;
  PspSkeleton = ^spSkeleton;
  PspPolygon = ^spPolygon;
  PPspPolygon = ^PspPolygon;
  PspSkeletonBounds = ^spSkeletonBounds;
  PspSkeletonBinary = ^spSkeletonBinary;
  PspSkeletonJson = ^spSkeletonJson;
  PspTriangulator = ^spTriangulator;
  PspSkeletonClipping = ^spSkeletonClipping;
  PspSdlVertexArray = ^spSdlVertexArray;
  PspSkeletonDrawable = ^spSkeletonDrawable;

  sfChar32 = UInt32;
  PsfChar32 = ^sfChar32;

  sfVector3f = record
    x: Single;
    y: Single;
    z: Single;
  end;

  sfListenerCone = record
    innerAngle: Single;
    outerAngle: Single;
    outerGain: Single;
  end;

  sfEffectProcessor = procedure(const inputFrames: PSingle; inputFrameCount: PCardinal; outputFrames: PSingle; outputFrameCount: PCardinal; frameChannelCount: Cardinal); cdecl;

  sfSoundSourceCone = record
    innerAngle: Single;
    outerAngle: Single;
    outerGain: Single;
  end;

  PsfMusic = Pointer;
  PPsfMusic = ^PsfMusic;
  PsfSound = Pointer;
  PPsfSound = ^PsfSound;
  PsfSoundBuffer = Pointer;
  PPsfSoundBuffer = ^PsfSoundBuffer;
  PsfSoundBufferRecorder = Pointer;
  PPsfSoundBufferRecorder = ^PsfSoundBufferRecorder;
  PsfSoundRecorder = Pointer;
  PPsfSoundRecorder = ^PsfSoundRecorder;
  PsfSoundStream = Pointer;
  PPsfSoundStream = ^PsfSoundStream;

  sfInputStreamReadFunc = function(data: Pointer; size: NativeUInt; userData: Pointer): Int64; cdecl;
  sfInputStreamSeekFunc = function(position: NativeUInt; userData: Pointer): Int64; cdecl;
  sfInputStreamTellFunc = function(userData: Pointer): Int64; cdecl;
  sfInputStreamGetSizeFunc = function(userData: Pointer): Int64; cdecl;

  sfInputStream = record
    read: sfInputStreamReadFunc;
    seek: sfInputStreamSeekFunc;
    tell: sfInputStreamTellFunc;
    getSize: sfInputStreamGetSizeFunc;
    userData: Pointer;
  end;

  sfTime = record
    microseconds: Int64;
  end;

  sfTimeSpan = record
    offset: sfTime;
    length: sfTime;
  end;

  sfSoundRecorderStartCallback = function(p1: Pointer): Boolean; cdecl;
  sfSoundRecorderProcessCallback = function(const p1: PInt16; p2: NativeUInt; p3: Pointer): Boolean; cdecl;
  sfSoundRecorderStopCallback = procedure(p1: Pointer); cdecl;

  sfSoundStreamChunk = record
    samples: PInt16;
    sampleCount: Cardinal;
  end;

  sfSoundStreamGetDataCallback = function(p1: PsfSoundStreamChunk; p2: Pointer): Boolean; cdecl;
  sfSoundStreamSeekCallback = procedure(p1: sfTime; p2: Pointer); cdecl;
  PsfBuffer = Pointer;
  PPsfBuffer = ^PsfBuffer;
  PsfClock = Pointer;
  PPsfClock = ^PsfClock;

  sfVector2i = record
    x: Integer;
    y: Integer;
  end;

  sfVector2u = record
    x: Cardinal;
    y: Cardinal;
  end;

  sfVector2f = record
    x: Single;
    y: Single;
  end;

  sfBlendMode = record
    colorSrcFactor: sfBlendFactor;
    colorDstFactor: sfBlendFactor;
    colorEquation: sfBlendEquation;
    alphaSrcFactor: sfBlendFactor;
    alphaDstFactor: sfBlendFactor;
    alphaEquation: sfBlendEquation;
  end;

  sfColor = record
    r: UInt8;
    g: UInt8;
    b: UInt8;
    a: UInt8;
  end;

  sfFloatRect = record
    position: sfVector2f;
    size: sfVector2f;
  end;

  sfIntRect = record
    position: sfVector2i;
    size: sfVector2i;
  end;

  PsfCircleShape = Pointer;
  PPsfCircleShape = ^PsfCircleShape;
  PsfConvexShape = Pointer;
  PPsfConvexShape = ^PsfConvexShape;
  PsfFont = Pointer;
  PPsfFont = ^PsfFont;
  PsfImage = Pointer;
  PPsfImage = ^PsfImage;
  PsfShader = Pointer;
  PPsfShader = ^PsfShader;
  PsfRectangleShape = Pointer;
  PPsfRectangleShape = ^PsfRectangleShape;
  PsfRenderTexture = Pointer;
  PPsfRenderTexture = ^PsfRenderTexture;
  PsfRenderWindow = Pointer;
  PPsfRenderWindow = ^PsfRenderWindow;
  PsfShape = Pointer;
  PPsfShape = ^PsfShape;
  PsfSprite = Pointer;
  PPsfSprite = ^PsfSprite;
  PsfText = Pointer;
  PPsfText = ^PsfText;
  PsfTexture = Pointer;
  PPsfTexture = ^PsfTexture;
  PsfTransformable = Pointer;
  PPsfTransformable = ^PsfTransformable;
  PsfVertexArray = Pointer;
  PPsfVertexArray = ^PsfVertexArray;
  PsfVertexBuffer = Pointer;
  PPsfVertexBuffer = ^PsfVertexBuffer;
  PsfView = Pointer;
  PPsfView = ^PsfView;

  sfTransform = record
    matrix: array [0..8] of Single;
  end;

  sfFontInfo = record
    family: PUTF8Char;
  end;

  sfGlyph = record
    advance: Single;
    bounds: sfFloatRect;
    textureRect: sfIntRect;
  end;

  sfStencilValue = record
    value: Cardinal;
  end;

  sfStencilMode = record
    stencilComparison: sfStencilComparison;
    stencilUpdateOperation: sfStencilUpdateOperation;
    stencilReference: sfStencilValue;
    stencilMask: sfStencilValue;
    stencilOnly: Boolean;
  end;

  sfRenderStates = record
    blendMode: sfBlendMode;
    stencilMode: sfStencilMode;
    transform: sfTransform;
    coordinateType: sfCoordinateType;
    texture: PsfTexture;
    shader: PsfShader;
  end;

  sfVertex = record
    position: sfVector2f;
    color: sfColor;
    texCoords: sfVector2f;
  end;

  sfJoystickIdentification = record
    name: PUTF8Char;
    vendorId: Cardinal;
    productId: Cardinal;
  end;

  PsfContext = Pointer;
  PPsfContext = ^PsfContext;
  PsfCursor = Pointer;
  PPsfCursor = ^PsfCursor;
  PsfWindow = Pointer;
  PPsfWindow = ^PsfWindow;
  PsfWindowBase = Pointer;
  PPsfWindowBase = ^PsfWindowBase;

  sfKeyEvent = record
    &type: sfEventType;
    code: sfKeyCode;
    scancode: sfScancode;
    alt: Boolean;
    control: Boolean;
    shift: Boolean;
    system: Boolean;
  end;

  sfTextEvent = record
    &type: sfEventType;
    unicode: UInt32;
  end;

  sfMouseMoveEvent = record
    &type: sfEventType;
    position: sfVector2i;
  end;

  sfMouseMoveRawEvent = record
    &type: sfEventType;
    delta: sfVector2i;
  end;

  sfMouseButtonEvent = record
    &type: sfEventType;
    button: sfMouseButton;
    position: sfVector2i;
  end;

  sfMouseWheelScrollEvent = record
    &type: sfEventType;
    wheel: sfMouseWheel;
    delta: Single;
    position: sfVector2i;
  end;

  sfJoystickMoveEvent = record
    &type: sfEventType;
    joystickId: Cardinal;
    axis: sfJoystickAxis;
    position: Single;
  end;

  sfJoystickButtonEvent = record
    &type: sfEventType;
    joystickId: Cardinal;
    button: Cardinal;
  end;

  sfJoystickConnectEvent = record
    &type: sfEventType;
    joystickId: Cardinal;
  end;

  sfSizeEvent = record
    &type: sfEventType;
    size: sfVector2u;
  end;

  sfTouchEvent = record
    &type: sfEventType;
    finger: Cardinal;
    position: sfVector2i;
  end;

  sfSensorEvent = record
    &type: sfEventType;
    sensorType: sfSensorType;
    value: sfVector3f;
  end;

  PsfEvent = ^sfEvent;
  sfEvent = record
    case Integer of
      0: (&type: sfEventType);
      1: (size: sfSizeEvent);
      2: (key: sfKeyEvent);
      3: (text: sfTextEvent);
      4: (mouseMove: sfMouseMoveEvent);
      5: (mouseMoveRaw: sfMouseMoveRawEvent);
      6: (mouseButton: sfMouseButtonEvent);
      7: (mouseWheelScroll: sfMouseWheelScrollEvent);
      8: (joystickMove: sfJoystickMoveEvent);
      9: (joystickButton: sfJoystickButtonEvent);
      10: (joystickConnect: sfJoystickConnectEvent);
      11: (touch: sfTouchEvent);
      12: (sensor: sfSensorEvent);
  end;

  sfVideoMode = record
    size: sfVector2u;
    bitsPerPixel: Cardinal;
  end;

  VkInstance = Pointer;
  PVkInstance = ^VkInstance;
  VkSurfaceKHR = Pointer;
  PVkSurfaceKHR = ^VkSurfaceKHR;
  PVkAllocationCallbacks = Pointer;
  PPVkAllocationCallbacks = ^PVkAllocationCallbacks;

  sfVulkanFunctionPointer = procedure(); cdecl;
  sfWindowHandle = Pointer;
  PsfWindowHandle = ^sfWindowHandle;

  sfContextSettings = record
    depthBits: Cardinal;
    stencilBits: Cardinal;
    antiAliasingLevel: Cardinal;
    majorVersion: Cardinal;
    minorVersion: Cardinal;
    attributeFlags: UInt32;
    sRgbCapable: Boolean;
  end;

  sfGlslVec2 = sfVector2f;
  PsfGlslVec2 = ^sfGlslVec2;
  sfGlslIvec2 = sfVector2i;

  sfGlslBvec2 = record
    x: Boolean;
    y: Boolean;
  end;

  sfGlslVec3 = sfVector3f;
  PsfGlslVec3 = ^sfGlslVec3;

  sfGlslIvec3 = record
    x: Integer;
    y: Integer;
    z: Integer;
  end;

  sfGlslBvec3 = record
    x: Boolean;
    y: Boolean;
    z: Boolean;
  end;

  sfGlslVec4 = record
    x: Single;
    y: Single;
    z: Single;
    w: Single;
  end;

  sfGlslIvec4 = record
    x: Integer;
    y: Integer;
    z: Integer;
    w: Integer;
  end;

  sfGlslBvec4 = record
    x: Boolean;
    y: Boolean;
    z: Boolean;
    w: Boolean;
  end;

  sfGlslMat3 = record
    &array: array [0..8] of Single;
  end;

  sfGlslMat4 = record
    &array: array [0..15] of Single;
  end;

  sfShapeGetPointCountCallback = function(p1: Pointer): NativeUInt; cdecl;
  sfShapeGetPointCallback = function(p1: NativeUInt; p2: Pointer): sfVector2f; cdecl;
  sfGlFunctionPointer = procedure(); cdecl;

  sfIpAddress = record
    address: array [0..15] of UTF8Char;
  end;

  PsfFtpDirectoryResponse = Pointer;
  PPsfFtpDirectoryResponse = ^PsfFtpDirectoryResponse;
  PsfFtpListingResponse = Pointer;
  PPsfFtpListingResponse = ^PsfFtpListingResponse;
  PsfFtpResponse = Pointer;
  PPsfFtpResponse = ^PsfFtpResponse;
  PsfFtp = Pointer;
  PPsfFtp = ^PsfFtp;
  PsfHttpRequest = Pointer;
  PPsfHttpRequest = ^PsfHttpRequest;
  PsfHttpResponse = Pointer;
  PPsfHttpResponse = ^PsfHttpResponse;
  PsfHttp = Pointer;
  PPsfHttp = ^PsfHttp;
  PsfPacket = Pointer;
  PPsfPacket = ^PsfPacket;
  PsfSocketSelector = Pointer;
  PPsfSocketSelector = ^PsfSocketSelector;
  PsfTcpListener = Pointer;
  PPsfTcpListener = ^PsfTcpListener;
  PsfTcpSocket = Pointer;
  PPsfTcpSocket = ^PsfTcpSocket;
  PsfUdpSocket = Pointer;
  PPsfUdpSocket = ^PsfUdpSocket;
  voidp = Pointer;
  unzFile = voidp;
  zipFile = voidp;
  uInt = Cardinal;
  uLong = Longword;
  Bytef = &Byte;
  PBytef = ^Bytef;

  tm_zip_s = record
    tm_sec: Integer;
    tm_min: Integer;
    tm_hour: Integer;
    tm_mday: Integer;
    tm_mon: Integer;
    tm_year: Integer;
  end;

  tm_zip = tm_zip_s;

  zip_fileinfo = record
    tmz_date: tm_zip;
    dosDate: uLong;
    internal_fa: uLong;
    external_fa: uLong;
  end;

  tm_unz_s = record
    tm_sec: Integer;
    tm_min: Integer;
    tm_hour: Integer;
    tm_mday: Integer;
    tm_mon: Integer;
    tm_year: Integer;
  end;

  tm_unz = tm_unz_s;

  unz_file_info64_s = record
    version: uLong;
    version_needed: uLong;
    flag: uLong;
    compression_method: uLong;
    dosDate: uLong;
    crc: uLong;
    compressed_size: UInt64;
    uncompressed_size: UInt64;
    size_filename: uLong;
    size_file_extra: uLong;
    size_file_comment: uLong;
    disk_num_start: uLong;
    internal_fa: uLong;
    external_fa: uLong;
    tmu_date: tm_unz;
  end;

  unz_file_info64 = unz_file_info64_s;
  Punz_file_info64 = ^unz_file_info64;
  Pplm_t = Pointer;
  PPplm_t = ^Pplm_t;
  Pplm_buffer_t = Pointer;
  PPplm_buffer_t = ^Pplm_buffer_t;
  Pplm_demux_t = Pointer;
  PPplm_demux_t = ^Pplm_demux_t;
  Pplm_video_t = Pointer;
  PPplm_video_t = ^Pplm_video_t;
  Pplm_audio_t = Pointer;
  PPplm_audio_t = ^Pplm_audio_t;

  plm_packet_t = record
    &type: Integer;
    pts: Double;
    length: NativeUInt;
    data: PUInt8;
  end;

  plm_plane_t = record
    width: Cardinal;
    height: Cardinal;
    data: PUInt8;
  end;

  plm_frame_t = record
    time: Double;
    width: Cardinal;
    height: Cardinal;
    y: plm_plane_t;
    cr: plm_plane_t;
    cb: plm_plane_t;
  end;

  plm_video_decode_callback = procedure(self: Pplm_t; frame: Pplm_frame_t; user: Pointer); cdecl;

  plm_samples_t = record
    time: Double;
    count: Cardinal;
    interleaved: array [0..2303] of Single;
  end;

  plm_audio_decode_callback = procedure(self: Pplm_t; samples: Pplm_samples_t; user: Pointer); cdecl;
  plm_buffer_load_callback = procedure(self: Pplm_buffer_t; user: Pointer); cdecl;
  Plua_State = Pointer;
  PPlua_State = ^Plua_State;

  lua_CFunction = function(L: Plua_State): Integer; cdecl;
  lua_Reader = function(L: Plua_State; ud: Pointer; sz: PNativeUInt): PUTF8Char; cdecl;
  lua_Writer = function(L: Plua_State; const p: Pointer; sz: NativeUInt; ud: Pointer): Integer; cdecl;
  lua_Alloc = function(ud: Pointer; ptr: Pointer; osize: NativeUInt; nsize: NativeUInt): Pointer; cdecl;
  lua_Number = Double;
  Plua_Number = ^lua_Number;
  lua_Integer = NativeInt;

  lua_Hook = procedure(L: Plua_State; ar: Plua_Debug); cdecl;

  lua_Debug = record
    event: Integer;
    name: PUTF8Char;
    namewhat: PUTF8Char;
    what: PUTF8Char;
    source: PUTF8Char;
    currentline: Integer;
    nups: Integer;
    linedefined: Integer;
    lastlinedefined: Integer;
    short_src: array [0..59] of UTF8Char;
    i_ci: Integer;
  end;

  luaL_Reg = record
    name: PUTF8Char;
    func: lua_CFunction;
  end;

  luaL_Buffer = record
    p: PUTF8Char;
    lvl: Integer;
    L: Plua_State;
    buffer: array [0..511] of UTF8Char;
  end;

  luaJIT_profile_callback = procedure(data: Pointer; L: Plua_State; samples: Integer; vmstate: Integer); cdecl;

  spFloatArray = record
    size: Integer;
    capacity: Integer;
    items: PSingle;
  end;

  spIntArray = record
    size: Integer;
    capacity: Integer;
    items: PInteger;
  end;

  spShortArray = record
    size: Integer;
    capacity: Integer;
    items: PSmallint;
  end;

  spUnsignedShortArray = record
    size: Integer;
    capacity: Integer;
    items: PWord;
  end;

  spArrayFloatArray = record
    size: Integer;
    capacity: Integer;
    items: PPspFloatArray;
  end;

  spArrayShortArray = record
    size: Integer;
    capacity: Integer;
    items: PPspShortArray;
  end;

  spEventData = record
    name: PUTF8Char;
    intValue: Integer;
    floatValue: Single;
    stringValue: PUTF8Char;
    audioPath: PUTF8Char;
    volume: Single;
    balance: Single;
  end;

  spEvent = record
    data: PspEventData;
    time: Single;
    intValue: Integer;
    floatValue: Single;
    stringValue: PUTF8Char;
    volume: Single;
    balance: Single;
  end;

  spAttachment = record
    name: PUTF8Char;
    &type: spAttachmentType;
    vtable: Pointer;
    refCount: Integer;
    attachmentLoader: PspAttachmentLoader;
  end;

  spColor = record
    r: Single;
    g: Single;
    b: Single;
    a: Single;
  end;

  spBoneData = record
    index: Integer;
    name: PUTF8Char;
    parent: PspBoneData;
    length: Single;
    x: Single;
    y: Single;
    rotation: Single;
    scaleX: Single;
    scaleY: Single;
    shearX: Single;
    shearY: Single;
    inherit: spInherit;
    skinRequired: Integer;
    color: spColor;
    icon: PUTF8Char;
    visible: Integer;
  end;

  spBone = record
    data: PspBoneData;
    skeleton: PspSkeleton;
    parent: PspBone;
    childrenCount: Integer;
    children: PPspBone;
    x: Single;
    y: Single;
    rotation: Single;
    scaleX: Single;
    scaleY: Single;
    shearX: Single;
    shearY: Single;
    ax: Single;
    ay: Single;
    arotation: Single;
    ascaleX: Single;
    ascaleY: Single;
    ashearX: Single;
    ashearY: Single;
    a: Single;
    b: Single;
    worldX: Single;
    c: Single;
    d: Single;
    worldY: Single;
    sorted: Integer;
    active: Integer;
    inherit: spInherit;
  end;

  spSlotData = record
    index: Integer;
    name: PUTF8Char;
    boneData: PspBoneData;
    attachmentName: PUTF8Char;
    color: spColor;
    darkColor: PspColor;
    blendMode: spBlendMode;
    visible: Integer;
  end;

  spSlot = record
    data: PspSlotData;
    bone: PspBone;
    color: spColor;
    darkColor: PspColor;
    attachment: PspAttachment;
    attachmentState: Integer;
    deformCapacity: Integer;
    deformCount: Integer;
    deform: PSingle;
    sequenceIndex: Integer;
  end;

  spVertexAttachment = record
    super: spAttachment;
    bonesCount: Integer;
    bones: PInteger;
    verticesCount: Integer;
    vertices: PSingle;
    worldVerticesLength: Integer;
    timelineAttachment: PspAttachment;
    id: Integer;
  end;

  spTextureRegion = record
    rendererObject: Pointer;
    u: Single;
    v: Single;
    u2: Single;
    v2: Single;
    degrees: Integer;
    offsetX: Single;
    offsetY: Single;
    width: Integer;
    height: Integer;
    originalWidth: Integer;
    originalHeight: Integer;
  end;

  spAtlasPage = record
    atlas: PspAtlas;
    name: PUTF8Char;
    format: spAtlasFormat;
    minFilter: spAtlasFilter;
    magFilter: spAtlasFilter;
    uWrap: spAtlasWrap;
    vWrap: spAtlasWrap;
    rendererObject: Pointer;
    width: Integer;
    height: Integer;
    pma: Integer;
    next: PspAtlasPage;
  end;

  spKeyValue = record
    name: PUTF8Char;
    values: array [0..4] of Single;
  end;

  spKeyValueArray = record
    size: Integer;
    capacity: Integer;
    items: PspKeyValue;
  end;

  spAtlasRegion = record
    super: spTextureRegion;
    name: PUTF8Char;
    x: Integer;
    y: Integer;
    index: Integer;
    splits: PInteger;
    pads: PInteger;
    keyValues: PspKeyValueArray;
    page: PspAtlasPage;
    next: PspAtlasRegion;
  end;

  spAtlas = record
    pages: PspAtlasPage;
    regions: PspAtlasRegion;
    rendererObject: Pointer;
  end;

  spTextureRegionArray = record
    size: Integer;
    capacity: Integer;
    items: PPspTextureRegion;
  end;

  spSequence = record
    id: Integer;
    start: Integer;
    digits: Integer;
    setupIndex: Integer;
    regions: PspTextureRegionArray;
  end;

  spPropertyId = UInt64;
  PspPropertyId = ^spPropertyId;

  spPropertyIdArray = record
    size: Integer;
    capacity: Integer;
    items: PspPropertyId;
  end;

  spTimelineArray = record
    size: Integer;
    capacity: Integer;
    items: PPspTimeline;
  end;

  spAnimation = record
    name: PUTF8Char;
    duration: Single;
    timelines: PspTimelineArray;
    timelineIds: PspPropertyIdArray;
  end;

  _spTimelineVtable = record
    apply: procedure(self: PspTimeline; skeleton: PspSkeleton; lastTime: Single; time: Single; firedEvents: PPspEvent; eventsCount: PInteger; alpha: Single; blend: spMixBlend; direction: spMixDirection); cdecl;
    dispose: procedure(self: PspTimeline); cdecl;
    setBezier: procedure(self: PspTimeline; bezier: Integer; frame: Integer; value: Single; time1: Single; value1: Single; cx1: Single; cy1: Single; cx2: Single; cy2: Single; time2: Single; value2: Single); cdecl;
  end;

  spTimeline = record
    vtable: _spTimelineVtable;
    propertyIds: array [0..2] of spPropertyId;
    propertyIdsCount: Integer;
    frames: PspFloatArray;
    frameCount: Integer;
    frameEntries: Integer;
    &type: spTimelineType;
  end;

  spCurveTimeline = record
    super: spTimeline;
    curves: PspFloatArray;
  end;

  spCurveTimeline1 = spCurveTimeline;
  PspCurveTimeline1 = ^spCurveTimeline1;
  spCurveTimeline2 = spCurveTimeline;

  spRotateTimeline = record
    super: spCurveTimeline1;
    boneIndex: Integer;
  end;

  spTranslateTimeline = record
    super: spCurveTimeline2;
    boneIndex: Integer;
  end;

  spTranslateXTimeline = record
    super: spCurveTimeline1;
    boneIndex: Integer;
  end;

  spTranslateYTimeline = record
    super: spCurveTimeline1;
    boneIndex: Integer;
  end;

  spScaleTimeline = record
    super: spCurveTimeline2;
    boneIndex: Integer;
  end;

  spScaleXTimeline = record
    super: spCurveTimeline1;
    boneIndex: Integer;
  end;

  spScaleYTimeline = record
    super: spCurveTimeline1;
    boneIndex: Integer;
  end;

  spShearTimeline = record
    super: spCurveTimeline2;
    boneIndex: Integer;
  end;

  spShearXTimeline = record
    super: spCurveTimeline1;
    boneIndex: Integer;
  end;

  spShearYTimeline = record
    super: spCurveTimeline1;
    boneIndex: Integer;
  end;

  spRGBATimeline = record
    super: spCurveTimeline2;
    slotIndex: Integer;
  end;

  spRGBTimeline = record
    super: spCurveTimeline2;
    slotIndex: Integer;
  end;

  spAlphaTimeline = record
    super: spCurveTimeline1;
    slotIndex: Integer;
  end;

  spRGBA2Timeline = record
    super: spCurveTimeline;
    slotIndex: Integer;
  end;

  spRGB2Timeline = record
    super: spCurveTimeline;
    slotIndex: Integer;
  end;

  spAttachmentTimeline = record
    super: spTimeline;
    slotIndex: Integer;
    attachmentNames: PPUTF8Char;
  end;

  spDeformTimeline = record
    super: spCurveTimeline;
    frameVerticesCount: Integer;
    frameVertices: PPSingle;
    slotIndex: Integer;
    attachment: PspAttachment;
  end;

  spSequenceTimeline = record
    super: spTimeline;
    slotIndex: Integer;
    attachment: PspAttachment;
  end;

  spEventTimeline = record
    super: spTimeline;
    events: PPspEvent;
  end;

  spDrawOrderTimeline = record
    super: spTimeline;
    drawOrders: PPInteger;
    slotsCount: Integer;
  end;

  spInheritTimeline = record
    super: spTimeline;
    boneIndex: Integer;
  end;

  spIkConstraintTimeline = record
    super: spCurveTimeline;
    ikConstraintIndex: Integer;
  end;

  spTransformConstraintTimeline = record
    super: spCurveTimeline;
    transformConstraintIndex: Integer;
  end;

  spPathConstraintPositionTimeline = record
    super: spCurveTimeline;
    pathConstraintIndex: Integer;
  end;

  spPathConstraintSpacingTimeline = record
    super: spCurveTimeline;
    pathConstraintIndex: Integer;
  end;

  spPathConstraintMixTimeline = record
    super: spCurveTimeline;
    pathConstraintIndex: Integer;
  end;

  spPhysicsConstraintTimeline = record
    super: spCurveTimeline;
    physicsConstraintIndex: Integer;
  end;

  spPhysicsConstraintResetTimeline = record
    super: spTimeline;
    physicsConstraintIndex: Integer;
  end;

  spIkConstraintData = record
    name: PUTF8Char;
    order: Integer;
    skinRequired: Integer;
    bonesCount: Integer;
    bones: PPspBoneData;
    target: PspBoneData;
    bendDirection: Integer;
    compress: Integer;
    stretch: Integer;
    uniform: Integer;
    mix: Single;
    softness: Single;
  end;

  spTransformConstraintData = record
    name: PUTF8Char;
    order: Integer;
    skinRequired: Integer;
    bonesCount: Integer;
    bones: PPspBoneData;
    target: PspBoneData;
    mixRotate: Single;
    mixX: Single;
    mixY: Single;
    mixScaleX: Single;
    mixScaleY: Single;
    mixShearY: Single;
    offsetRotation: Single;
    offsetX: Single;
    offsetY: Single;
    offsetScaleX: Single;
    offsetScaleY: Single;
    offsetShearY: Single;
    relative: Integer;
    local: Integer;
  end;

  spPathConstraintData = record
    name: PUTF8Char;
    order: Integer;
    skinRequired: Integer;
    bonesCount: Integer;
    bones: PPspBoneData;
    target: PspSlotData;
    positionMode: spPositionMode;
    spacingMode: spSpacingMode;
    rotateMode: spRotateMode;
    offsetRotation: Single;
    position: Single;
    spacing: Single;
    mixRotate: Single;
    mixX: Single;
    mixY: Single;
  end;

  spPhysicsConstraintData = record
    name: PUTF8Char;
    order: Integer;
    skinRequired: Integer;
    bone: PspBoneData;
    x: Single;
    y: Single;
    rotate: Single;
    scaleX: Single;
    shearX: Single;
    limit: Single;
    step: Single;
    inertia: Single;
    strength: Single;
    damping: Single;
    massInverse: Single;
    wind: Single;
    gravity: Single;
    mix: Single;
    inertiaGlobal: Integer;
    strengthGlobal: Integer;
    dampingGlobal: Integer;
    massGlobal: Integer;
    windGlobal: Integer;
    gravityGlobal: Integer;
    mixGlobal: Integer;
  end;

  spBoneDataArray = record
    size: Integer;
    capacity: Integer;
    items: PPspBoneData;
  end;

  spIkConstraintDataArray = record
    size: Integer;
    capacity: Integer;
    items: PPspIkConstraintData;
  end;

  spTransformConstraintDataArray = record
    size: Integer;
    capacity: Integer;
    items: PPspTransformConstraintData;
  end;

  spPathConstraintDataArray = record
    size: Integer;
    capacity: Integer;
    items: PPspPathConstraintData;
  end;

  spPhysicsConstraintDataArray = record
    size: Integer;
    capacity: Integer;
    items: PPspPhysicsConstraintData;
  end;

  spSkin = record
    name: PUTF8Char;
    bones: PspBoneDataArray;
    ikConstraints: PspIkConstraintDataArray;
    transformConstraints: PspTransformConstraintDataArray;
    pathConstraints: PspPathConstraintDataArray;
    physicsConstraints: PspPhysicsConstraintDataArray;
    color: spColor;
  end;

  _Entry = record
    slotIndex: Integer;
    name: PUTF8Char;
    attachment: PspAttachment;
    next: P_Entry;
  end;

  spSkinEntry = _Entry;
  PspSkinEntry = ^spSkinEntry;

  _SkinHashTableEntry = record
    entry: P_Entry;
    next: P_SkinHashTableEntry;
  end;

  _spSkin = record
    super: spSkin;
    entries: P_Entry;
    entriesHashTable: array [0..99] of P_SkinHashTableEntry;
  end;

  spSkeletonData = record
    version: PUTF8Char;
    hash: PUTF8Char;
    x: Single;
    y: Single;
    width: Single;
    height: Single;
    referenceScale: Single;
    fps: Single;
    imagesPath: PUTF8Char;
    audioPath: PUTF8Char;
    stringsCount: Integer;
    strings: PPUTF8Char;
    bonesCount: Integer;
    bones: PPspBoneData;
    slotsCount: Integer;
    slots: PPspSlotData;
    skinsCount: Integer;
    skins: PPspSkin;
    defaultSkin: PspSkin;
    eventsCount: Integer;
    events: PPspEventData;
    animationsCount: Integer;
    animations: PPspAnimation;
    ikConstraintsCount: Integer;
    ikConstraints: PPspIkConstraintData;
    transformConstraintsCount: Integer;
    transformConstraints: PPspTransformConstraintData;
    pathConstraintsCount: Integer;
    pathConstraints: PPspPathConstraintData;
    physicsConstraintsCount: Integer;
    physicsConstraints: PPspPhysicsConstraintData;
  end;

  spAnimationStateData = record
    skeletonData: PspSkeletonData;
    defaultMix: Single;
    entries: Pointer;
  end;

  spAnimationStateListener = procedure(state: PspAnimationState; &type: spEventType; entry: PspTrackEntry; event: PspEvent); cdecl;

  spTrackEntryArray = record
    size: Integer;
    capacity: Integer;
    items: PPspTrackEntry;
  end;

  spTrackEntry = record
    animation: PspAnimation;
    previous: PspTrackEntry;
    next: PspTrackEntry;
    mixingFrom: PspTrackEntry;
    mixingTo: PspTrackEntry;
    listener: spAnimationStateListener;
    trackIndex: Integer;
    loop: Integer;
    holdPrevious: Integer;
    reverse: Integer;
    shortestRotation: Integer;
    eventThreshold: Single;
    mixAttachmentThreshold: Single;
    alphaAttachmentThreshold: Single;
    mixDrawOrderThreshold: Single;
    animationStart: Single;
    animationEnd: Single;
    animationLast: Single;
    nextAnimationLast: Single;
    delay: Single;
    trackTime: Single;
    trackLast: Single;
    nextTrackLast: Single;
    trackEnd: Single;
    timeScale: Single;
    alpha: Single;
    mixTime: Single;
    mixDuration: Single;
    interruptAlpha: Single;
    totalAlpha: Single;
    mixBlend: spMixBlend;
    timelineMode: PspIntArray;
    timelineHoldMix: PspTrackEntryArray;
    timelinesRotation: PSingle;
    timelinesRotationCount: Integer;
    rendererObject: Pointer;
    userData: Pointer;
  end;

  spAnimationState = record
    data: PspAnimationStateData;
    tracksCount: Integer;
    tracks: PPspTrackEntry;
    listener: spAnimationStateListener;
    timeScale: Single;
    rendererObject: Pointer;
    userData: Pointer;
    unkeyedState: Integer;
  end;

  spAttachmentLoader = record
    error1: PUTF8Char;
    error2: PUTF8Char;
    vtable: Pointer;
  end;

  spAtlasAttachmentLoader = record
    super: spAttachmentLoader;
    atlas: PspAtlas;
  end;

  spRegionAttachment = record
    super: spAttachment;
    path: PUTF8Char;
    x: Single;
    y: Single;
    scaleX: Single;
    scaleY: Single;
    rotation: Single;
    width: Single;
    height: Single;
    color: spColor;
    rendererObject: Pointer;
    region: PspTextureRegion;
    sequence: PspSequence;
    offset: array [0..7] of Single;
    uvs: array [0..7] of Single;
  end;

  spMeshAttachment = record
    super: spVertexAttachment;
    rendererObject: Pointer;
    region: PspTextureRegion;
    sequence: PspSequence;
    path: PUTF8Char;
    regionUVs: PSingle;
    uvs: PSingle;
    trianglesCount: Integer;
    triangles: PWord;
    color: spColor;
    hullLength: Integer;
    parentMesh: PspMeshAttachment;
    edgesCount: Integer;
    edges: PWord;
    width: Single;
    height: Single;
  end;

  spBoundingBoxAttachment = record
    super: spVertexAttachment;
    color: spColor;
  end;

  spClippingAttachment = record
    super: spVertexAttachment;
    endSlot: PspSlotData;
    color: spColor;
  end;

  spPointAttachment = record
    super: spAttachment;
    x: Single;
    y: Single;
    rotation: Single;
    color: spColor;
  end;

  spIkConstraint = record
    data: PspIkConstraintData;
    bonesCount: Integer;
    bones: PPspBone;
    target: PspBone;
    bendDirection: Integer;
    compress: Integer;
    stretch: Integer;
    mix: Single;
    softness: Single;
    active: Integer;
  end;

  spTransformConstraint = record
    data: PspTransformConstraintData;
    bonesCount: Integer;
    bones: PPspBone;
    target: PspBone;
    mixRotate: Single;
    mixX: Single;
    mixY: Single;
    mixScaleX: Single;
    mixScaleY: Single;
    mixShearY: Single;
    active: Integer;
  end;

  spPathAttachment = record
    super: spVertexAttachment;
    lengthsLength: Integer;
    lengths: PSingle;
    closed: Integer;
    constantSpeed: Integer;
    color: spColor;
  end;

  spPathConstraint = record
    data: PspPathConstraintData;
    bonesCount: Integer;
    bones: PPspBone;
    target: PspSlot;
    position: Single;
    spacing: Single;
    mixRotate: Single;
    mixX: Single;
    mixY: Single;
    spacesCount: Integer;
    spaces: PSingle;
    positionsCount: Integer;
    positions: PSingle;
    worldCount: Integer;
    world: PSingle;
    curvesCount: Integer;
    curves: PSingle;
    lengthsCount: Integer;
    lengths: PSingle;
    segments: array [0..9] of Single;
    active: Integer;
  end;

  spPhysicsConstraint = record
    data: PspPhysicsConstraintData;
    bone: PspBone;
    inertia: Single;
    strength: Single;
    damping: Single;
    massInverse: Single;
    wind: Single;
    gravity: Single;
    mix: Single;
    reset: Integer;
    ux: Single;
    uy: Single;
    cx: Single;
    cy: Single;
    tx: Single;
    ty: Single;
    xOffset: Single;
    xVelocity: Single;
    yOffset: Single;
    yVelocity: Single;
    rotateOffset: Single;
    rotateVelocity: Single;
    scaleOffset: Single;
    scaleVelocity: Single;
    active: Integer;
    skeleton: PspSkeleton;
    remaining: Single;
    lastTime: Single;
  end;

  spSkeleton = record
    data: PspSkeletonData;
    bonesCount: Integer;
    bones: PPspBone;
    root: PspBone;
    slotsCount: Integer;
    slots: PPspSlot;
    drawOrder: PPspSlot;
    ikConstraintsCount: Integer;
    ikConstraints: PPspIkConstraint;
    transformConstraintsCount: Integer;
    transformConstraints: PPspTransformConstraint;
    pathConstraintsCount: Integer;
    pathConstraints: PPspPathConstraint;
    physicsConstraintsCount: Integer;
    physicsConstraints: PPspPhysicsConstraint;
    skin: PspSkin;
    color: spColor;
    scaleX: Single;
    scaleY: Single;
    x: Single;
    y: Single;
    time: Single;
  end;

  spPolygon = record
    vertices: PSingle;
    count: Integer;
    capacity: Integer;
  end;

  spSkeletonBounds = record
    count: Integer;
    boundingBoxes: PPspBoundingBoxAttachment;
    polygons: PPspPolygon;
    minX: Single;
    minY: Single;
    maxX: Single;
    maxY: Single;
  end;

  spSkeletonBinary = record
    scale: Single;
    attachmentLoader: PspAttachmentLoader;
    error: PUTF8Char;
  end;

  spSkeletonJson = record
    scale: Single;
    attachmentLoader: PspAttachmentLoader;
    error: PUTF8Char;
  end;

  spTriangulator = record
    convexPolygons: PspArrayFloatArray;
    convexPolygonsIndices: PspArrayShortArray;
    indicesArray: PspShortArray;
    isConcaveArray: PspIntArray;
    triangles: PspShortArray;
    polygonPool: PspArrayFloatArray;
    polygonIndicesPool: PspArrayShortArray;
  end;

  spSkeletonClipping = record
    triangulator: PspTriangulator;
    clippingPolygon: PspFloatArray;
    clipOutput: PspFloatArray;
    clippedVertices: PspFloatArray;
    clippedUVs: PspFloatArray;
    clippedTriangles: PspUnsignedShortArray;
    scratch: PspFloatArray;
    clipAttachment: PspClippingAttachment;
    clippingPolygons: PspArrayFloatArray;
  end;

  spSdlVertexArray = record
    size: Integer;
    capacity: Integer;
    items: PsfVertex;
  end;

  spSkeletonDrawable = record
    skeleton: PspSkeleton;
    animationState: PspAnimationState;
    usePremultipliedAlpha: Integer;
    clipper: PspSkeletonClipping;
    worldVertices: PspFloatArray;
    sdlVertices: PspSdlVertexArray;
    sdlIndices: PspIntArray;
  end;

  spAtlasPage_createTexture_cb = function(const path: PUTF8Char; userData: Pointer): PsfTexture; cdecl;
  spAtlasPage_disposeTexture_cb = procedure(texture: PsfTexture; userData: Pointer); cdecl;

const
  PLM_DEMUX_PACKET_PRIVATE: Integer = $BD;
  PLM_DEMUX_PACKET_AUDIO_1: Integer = $C0;
  PLM_DEMUX_PACKET_AUDIO_2: Integer = $C1;
  PLM_DEMUX_PACKET_AUDIO_3: Integer = $C2;
  PLM_DEMUX_PACKET_AUDIO_4: Integer = $C3;
  PLM_DEMUX_PACKET_VIDEO_1: Integer = $E0;

var
  sfListener_setGlobalVolume: procedure(volume: Single); cdecl;
  sfListener_getGlobalVolume: function(): Single; cdecl;
  sfListener_setPosition: procedure(position: sfVector3f); cdecl;
  sfListener_getPosition: function(): sfVector3f; cdecl;
  sfListener_setDirection: procedure(direction: sfVector3f); cdecl;
  sfListener_getDirection: function(): sfVector3f; cdecl;
  sfListener_setVelocity: procedure(velocity: sfVector3f); cdecl;
  sfListener_getVelocity: function(): sfVector3f; cdecl;
  sfListener_setCone: procedure(cone: sfListenerCone); cdecl;
  sfListener_getCone: function(): sfListenerCone; cdecl;
  sfListener_setUpVector: procedure(upVector: sfVector3f); cdecl;
  sfListener_getUpVector: function(): sfVector3f; cdecl;
  sfTime_asSeconds: function(time: sfTime): Single; cdecl;
  sfTime_asMilliseconds: function(time: sfTime): Int32; cdecl;
  sfTime_asMicroseconds: function(time: sfTime): Int64; cdecl;
  sfSeconds: function(amount: Single): sfTime; cdecl;
  sfMilliseconds: function(amount: Int32): sfTime; cdecl;
  sfMicroseconds: function(amount: Int64): sfTime; cdecl;
  sfMusic_createFromFile: function(const filename: PUTF8Char): PsfMusic; cdecl;
  sfMusic_createFromMemory: function(const data: Pointer; sizeInBytes: NativeUInt): PsfMusic; cdecl;
  sfMusic_createFromStream: function(stream: PsfInputStream): PsfMusic; cdecl;
  sfMusic_destroy: procedure(const music: PsfMusic); cdecl;
  sfMusic_setLooping: procedure(music: PsfMusic; loop: Boolean); cdecl;
  sfMusic_isLooping: function(const music: PsfMusic): Boolean; cdecl;
  sfMusic_setEffectProcessor: procedure(music: PsfMusic; effectProcessor: sfEffectProcessor); cdecl;
  sfMusic_getDuration: function(const music: PsfMusic): sfTime; cdecl;
  sfMusic_getLoopPoints: function(const music: PsfMusic): sfTimeSpan; cdecl;
  sfMusic_setLoopPoints: procedure(music: PsfMusic; timePoints: sfTimeSpan); cdecl;
  sfMusic_play: procedure(music: PsfMusic); cdecl;
  sfMusic_pause: procedure(music: PsfMusic); cdecl;
  sfMusic_stop: procedure(music: PsfMusic); cdecl;
  sfMusic_getChannelCount: function(const music: PsfMusic): Cardinal; cdecl;
  sfMusic_getSampleRate: function(const music: PsfMusic): Cardinal; cdecl;
  sfMusic_getChannelMap: function(const music: PsfMusic; count: PNativeUInt): PsfSoundChannel; cdecl;
  sfMusic_getStatus: function(const music: PsfMusic): sfSoundStatus; cdecl;
  sfMusic_getPlayingOffset: function(const music: PsfMusic): sfTime; cdecl;
  sfMusic_setPitch: procedure(music: PsfMusic; pitch: Single); cdecl;
  sfMusic_setPan: procedure(music: PsfMusic; pan: Single); cdecl;
  sfMusic_setVolume: procedure(music: PsfMusic; volume: Single); cdecl;
  sfMusic_setSpatializationEnabled: procedure(music: PsfMusic; enabled: Boolean); cdecl;
  sfMusic_setPosition: procedure(music: PsfMusic; position: sfVector3f); cdecl;
  sfMusic_setDirection: procedure(music: PsfMusic; direction: sfVector3f); cdecl;
  sfMusic_setCone: procedure(music: PsfMusic; cone: sfSoundSourceCone); cdecl;
  sfMusic_setVelocity: procedure(music: PsfMusic; velocity: sfVector3f); cdecl;
  sfMusic_setDopplerFactor: procedure(music: PsfMusic; factor: Single); cdecl;
  sfMusic_setDirectionalAttenuationFactor: procedure(music: PsfMusic; factor: Single); cdecl;
  sfMusic_setRelativeToListener: procedure(music: PsfMusic; relative: Boolean); cdecl;
  sfMusic_setMinDistance: procedure(music: PsfMusic; distance: Single); cdecl;
  sfMusic_setMaxDistance: procedure(music: PsfMusic; distance: Single); cdecl;
  sfMusic_setMinGain: procedure(music: PsfMusic; gain: Single); cdecl;
  sfMusic_setMaxGain: procedure(music: PsfMusic; gain: Single); cdecl;
  sfMusic_setAttenuation: procedure(music: PsfMusic; attenuation: Single); cdecl;
  sfMusic_setPlayingOffset: procedure(music: PsfMusic; timeOffset: sfTime); cdecl;
  sfMusic_getPitch: function(const music: PsfMusic): Single; cdecl;
  sfMusic_getPan: function(const music: PsfMusic): Single; cdecl;
  sfMusic_isSpatializationEnabled: function(const music: PsfMusic): Boolean; cdecl;
  sfMusic_getVolume: function(const music: PsfMusic): Single; cdecl;
  sfMusic_getPosition: function(const music: PsfMusic): sfVector3f; cdecl;
  sfMusic_getDirection: function(const music: PsfMusic): sfVector3f; cdecl;
  sfMusic_getCone: function(const music: PsfMusic): sfSoundSourceCone; cdecl;
  sfMusic_getVelocity: function(const music: PsfMusic): sfVector3f; cdecl;
  sfMusic_getDopplerFactor: function(const music: PsfMusic): Single; cdecl;
  sfMusic_getDirectionalAttenuationFactor: function(const music: PsfMusic): Single; cdecl;
  sfMusic_isRelativeToListener: function(const music: PsfMusic): Boolean; cdecl;
  sfMusic_getMinDistance: function(const music: PsfMusic): Single; cdecl;
  sfMusic_getMaxDistance: function(const music: PsfMusic): Single; cdecl;
  sfMusic_getMinGain: function(const music: PsfMusic): Single; cdecl;
  sfMusic_getMaxGain: function(const music: PsfMusic): Single; cdecl;
  sfMusic_getAttenuation: function(const music: PsfMusic): Single; cdecl;
  sfSound_create: function(const buffer: PsfSoundBuffer): PsfSound; cdecl;
  sfSound_copy: function(const sound: PsfSound): PsfSound; cdecl;
  sfSound_destroy: procedure(const sound: PsfSound); cdecl;
  sfSound_play: procedure(sound: PsfSound); cdecl;
  sfSound_pause: procedure(sound: PsfSound); cdecl;
  sfSound_stop: procedure(sound: PsfSound); cdecl;
  sfSound_setBuffer: procedure(sound: PsfSound; const buffer: PsfSoundBuffer); cdecl;
  sfSound_getBuffer: function(const sound: PsfSound): PsfSoundBuffer; cdecl;
  sfSound_setLooping: procedure(sound: PsfSound; loop: Boolean); cdecl;
  sfSound_isLooping: function(const sound: PsfSound): Boolean; cdecl;
  sfSound_getStatus: function(const sound: PsfSound): sfSoundStatus; cdecl;
  sfSound_setPitch: procedure(sound: PsfSound; pitch: Single); cdecl;
  sfSound_setPan: procedure(sound: PsfSound; pan: Single); cdecl;
  sfSound_setVolume: procedure(sound: PsfSound; volume: Single); cdecl;
  sfSound_setSpatializationEnabled: procedure(sound: PsfSound; enabled: Boolean); cdecl;
  sfSound_setPosition: procedure(sound: PsfSound; position: sfVector3f); cdecl;
  sfSound_setDirection: procedure(sound: PsfSound; direction: sfVector3f); cdecl;
  sfSound_setCone: procedure(sound: PsfSound; cone: sfSoundSourceCone); cdecl;
  sfSound_setVelocity: procedure(sound: PsfSound; velocity: sfVector3f); cdecl;
  sfSound_setDopplerFactor: procedure(sound: PsfSound; factor: Single); cdecl;
  sfSound_setDirectionalAttenuationFactor: procedure(sound: PsfSound; factor: Single); cdecl;
  sfSound_setRelativeToListener: procedure(sound: PsfSound; relative: Boolean); cdecl;
  sfSound_setMinDistance: procedure(sound: PsfSound; distance: Single); cdecl;
  sfSound_setMaxDistance: procedure(sound: PsfSound; distance: Single); cdecl;
  sfSound_setMinGain: procedure(sound: PsfSound; gain: Single); cdecl;
  sfSound_setMaxGain: procedure(sound: PsfSound; gain: Single); cdecl;
  sfSound_setAttenuation: procedure(sound: PsfSound; attenuation: Single); cdecl;
  sfSound_setPlayingOffset: procedure(sound: PsfSound; timeOffset: sfTime); cdecl;
  sfSound_setEffectProcessor: procedure(sound: PsfSound; effectProcessor: sfEffectProcessor); cdecl;
  sfSound_getPitch: function(const sound: PsfSound): Single; cdecl;
  sfSound_getPan: function(const sound: PsfSound): Single; cdecl;
  sfSound_getVolume: function(const sound: PsfSound): Single; cdecl;
  sfSound_isSpatializationEnabled: function(const sound: PsfSound): Boolean; cdecl;
  sfSound_getPosition: function(const sound: PsfSound): sfVector3f; cdecl;
  sfSound_getDirection: function(const sound: PsfSound): sfVector3f; cdecl;
  sfSound_getCone: function(const sound: PsfSound): sfSoundSourceCone; cdecl;
  sfSound_getVelocity: function(const sound: PsfSound): sfVector3f; cdecl;
  sfSound_getDopplerFactor: function(const sound: PsfSound): Single; cdecl;
  sfSound_getDirectionalAttenuationFactor: function(const sound: PsfSound): Single; cdecl;
  sfSound_isRelativeToListener: function(const sound: PsfSound): Boolean; cdecl;
  sfSound_getMinDistance: function(const sound: PsfSound): Single; cdecl;
  sfSound_getMaxDistance: function(const sound: PsfSound): Single; cdecl;
  sfSound_getMinGain: function(const sound: PsfSound): Single; cdecl;
  sfSound_getMaxGain: function(const sound: PsfSound): Single; cdecl;
  sfSound_getAttenuation: function(const sound: PsfSound): Single; cdecl;
  sfSound_getPlayingOffset: function(const sound: PsfSound): sfTime; cdecl;
  sfSoundBuffer_createFromFile: function(const filename: PUTF8Char): PsfSoundBuffer; cdecl;
  sfSoundBuffer_createFromMemory: function(const data: Pointer; sizeInBytes: NativeUInt): PsfSoundBuffer; cdecl;
  sfSoundBuffer_createFromStream: function(stream: PsfInputStream): PsfSoundBuffer; cdecl;
  sfSoundBuffer_createFromSamples: function(const samples: PInt16; sampleCount: UInt64; channelCount: Cardinal; sampleRate: Cardinal; channelMapData: PsfSoundChannel; channelMapSize: NativeUInt): PsfSoundBuffer; cdecl;
  sfSoundBuffer_copy: function(const soundBuffer: PsfSoundBuffer): PsfSoundBuffer; cdecl;
  sfSoundBuffer_destroy: procedure(const soundBuffer: PsfSoundBuffer); cdecl;
  sfSoundBuffer_saveToFile: function(const soundBuffer: PsfSoundBuffer; const filename: PUTF8Char): Boolean; cdecl;
  sfSoundBuffer_getSamples: function(const soundBuffer: PsfSoundBuffer): PInt16; cdecl;
  sfSoundBuffer_getSampleCount: function(const soundBuffer: PsfSoundBuffer): UInt64; cdecl;
  sfSoundBuffer_getSampleRate: function(const soundBuffer: PsfSoundBuffer): Cardinal; cdecl;
  sfSoundBuffer_getChannelCount: function(const soundBuffer: PsfSoundBuffer): Cardinal; cdecl;
  sfSoundBuffer_getChannelMap: function(const soundBuffer: PsfSoundBuffer; count: PNativeUInt): PsfSoundChannel; cdecl;
  sfSoundBuffer_getDuration: function(const soundBuffer: PsfSoundBuffer): sfTime; cdecl;
  sfSoundBufferRecorder_create: function(): PsfSoundBufferRecorder; cdecl;
  sfSoundBufferRecorder_destroy: procedure(const soundBufferRecorder: PsfSoundBufferRecorder); cdecl;
  sfSoundBufferRecorder_start: function(soundBufferRecorder: PsfSoundBufferRecorder; sampleRate: Cardinal): Boolean; cdecl;
  sfSoundBufferRecorder_stop: procedure(soundBufferRecorder: PsfSoundBufferRecorder); cdecl;
  sfSoundBufferRecorder_getSampleRate: function(const soundBufferRecorder: PsfSoundBufferRecorder): Cardinal; cdecl;
  sfSoundBufferRecorder_getBuffer: function(const soundBufferRecorder: PsfSoundBufferRecorder): PsfSoundBuffer; cdecl;
  sfSoundBufferRecorder_setDevice: function(soundBufferRecorder: PsfSoundBufferRecorder; const name: PUTF8Char): Boolean; cdecl;
  sfSoundBufferRecorder_getDevice: function(soundBufferRecorder: PsfSoundBufferRecorder): PUTF8Char; cdecl;
  sfSoundBufferRecorder_setChannelCount: procedure(soundBufferRecorder: PsfSoundBufferRecorder; channelCount: Cardinal); cdecl;
  sfSoundBufferRecorder_getChannelCount: function(const soundBufferRecorder: PsfSoundBufferRecorder): Cardinal; cdecl;
  sfSoundRecorder_create: function(onStart: sfSoundRecorderStartCallback; onProcess: sfSoundRecorderProcessCallback; onStop: sfSoundRecorderStopCallback; userData: Pointer): PsfSoundRecorder; cdecl;
  sfSoundRecorder_destroy: procedure(const soundRecorder: PsfSoundRecorder); cdecl;
  sfSoundRecorder_start: function(soundRecorder: PsfSoundRecorder; sampleRate: Cardinal): Boolean; cdecl;
  sfSoundRecorder_stop: procedure(soundRecorder: PsfSoundRecorder); cdecl;
  sfSoundRecorder_getSampleRate: function(const soundRecorder: PsfSoundRecorder): Cardinal; cdecl;
  sfSoundRecorder_isAvailable: function(): Boolean; cdecl;
  sfSoundRecorder_getAvailableDevices: function(count: PNativeUInt): PPUTF8Char; cdecl;
  sfSoundRecorder_getDefaultDevice: function(): PUTF8Char; cdecl;
  sfSoundRecorder_setDevice: function(soundRecorder: PsfSoundRecorder; const name: PUTF8Char): Boolean; cdecl;
  sfSoundRecorder_getDevice: function(soundRecorder: PsfSoundRecorder): PUTF8Char; cdecl;
  sfSoundRecorder_setChannelCount: procedure(soundRecorder: PsfSoundRecorder; channelCount: Cardinal); cdecl;
  sfSoundRecorder_getChannelCount: function(const soundRecorder: PsfSoundRecorder): Cardinal; cdecl;
  sfSoundRecorder_getChannelMap: function(const soundRecorder: PsfSoundRecorder; count: PNativeUInt): PsfSoundChannel; cdecl;
  sfSoundStream_create: function(onGetData: sfSoundStreamGetDataCallback; onSeek: sfSoundStreamSeekCallback; channelCount: Cardinal; sampleRate: Cardinal; channelMapData: PsfSoundChannel; channelMapSize: NativeUInt; userData: Pointer): PsfSoundStream; cdecl;
  sfSoundStream_destroy: procedure(const soundStream: PsfSoundStream); cdecl;
  sfSoundStream_play: procedure(soundStream: PsfSoundStream); cdecl;
  sfSoundStream_pause: procedure(soundStream: PsfSoundStream); cdecl;
  sfSoundStream_stop: procedure(soundStream: PsfSoundStream); cdecl;
  sfSoundStream_getStatus: function(const soundStream: PsfSoundStream): sfSoundStatus; cdecl;
  sfSoundStream_getChannelCount: function(const soundStream: PsfSoundStream): Cardinal; cdecl;
  sfSoundStream_getSampleRate: function(const soundStream: PsfSoundStream): Cardinal; cdecl;
  sfSoundStream_getChannelMap: function(const soundStream: PsfSoundStream; count: PNativeUInt): PsfSoundChannel; cdecl;
  sfSoundStream_setPitch: procedure(soundStream: PsfSoundStream; pitch: Single); cdecl;
  sfSoundStream_setPan: procedure(soundStream: PsfSoundStream; pan: Single); cdecl;
  sfSoundStream_setVolume: procedure(soundStream: PsfSoundStream; volume: Single); cdecl;
  sfSoundStream_setSpatializationEnabled: procedure(soundStream: PsfSoundStream; enabled: Boolean); cdecl;
  sfSoundStream_setPosition: procedure(soundStream: PsfSoundStream; position: sfVector3f); cdecl;
  sfSoundStream_setDirection: procedure(soundStream: PsfSoundStream; direction: sfVector3f); cdecl;
  sfSoundStream_setCone: procedure(soundStream: PsfSoundStream; cone: sfSoundSourceCone); cdecl;
  sfSoundStream_setVelocity: procedure(soundStream: PsfSoundStream; velocity: sfVector3f); cdecl;
  sfSoundStream_setDopplerFactor: procedure(soundStream: PsfSoundStream; factor: Single); cdecl;
  sfSoundStream_setDirectionalAttenuationFactor: procedure(soundStream: PsfSoundStream; factor: Single); cdecl;
  sfSoundStream_setRelativeToListener: procedure(soundStream: PsfSoundStream; relative: Boolean); cdecl;
  sfSoundStream_setMinDistance: procedure(soundStream: PsfSoundStream; distance: Single); cdecl;
  sfSoundStream_setMaxDistance: procedure(soundStream: PsfSoundStream; distance: Single); cdecl;
  sfSoundStream_setMinGain: procedure(soundStream: PsfSoundStream; gain: Single); cdecl;
  sfSoundStream_setMaxGain: procedure(soundStream: PsfSoundStream; gain: Single); cdecl;
  sfSoundStream_setAttenuation: procedure(soundStream: PsfSoundStream; attenuation: Single); cdecl;
  sfSoundStream_setPlayingOffset: procedure(soundStream: PsfSoundStream; timeOffset: sfTime); cdecl;
  sfSoundStream_setLooping: procedure(soundStream: PsfSoundStream; loop: Boolean); cdecl;
  sfSoundStream_getPitch: function(const soundStream: PsfSoundStream): Single; cdecl;
  sfSoundStream_getPan: function(const soundStream: PsfSoundStream): Single; cdecl;
  sfSoundStream_getVolume: function(const soundStream: PsfSoundStream): Single; cdecl;
  sfSoundStream_isSpatializationEnabled: function(const soundStream: PsfSoundStream): Boolean; cdecl;
  sfSoundStream_getPosition: function(const soundStream: PsfSoundStream): sfVector3f; cdecl;
  sfSoundStream_getDirection: function(const soundStream: PsfSoundStream): sfVector3f; cdecl;
  sfSoundStream_getCone: function(const soundStream: PsfSoundStream): sfSoundSourceCone; cdecl;
  sfSoundStream_getVelocity: function(const soundStream: PsfSoundStream): sfVector3f; cdecl;
  sfSoundStream_getDopplerFactor: function(const soundStream: PsfSoundStream): Single; cdecl;
  sfSoundStream_getDirectionalAttenuationFactor: function(const soundStream: PsfSoundStream): Single; cdecl;
  sfSoundStream_isRelativeToListener: function(const soundStream: PsfSoundStream): Boolean; cdecl;
  sfSoundStream_getMinDistance: function(const soundStream: PsfSoundStream): Single; cdecl;
  sfSoundStream_getMaxDistance: function(const soundStream: PsfSoundStream): Single; cdecl;
  sfSoundStream_getMinGain: function(const soundStream: PsfSoundStream): Single; cdecl;
  sfSoundStream_getMaxGain: function(const soundStream: PsfSoundStream): Single; cdecl;
  sfSoundStream_getAttenuation: function(const soundStream: PsfSoundStream): Single; cdecl;
  sfSoundStream_isLooping: function(const soundStream: PsfSoundStream): Boolean; cdecl;
  sfSoundStream_setEffectProcessor: procedure(soundStream: PsfSoundStream; effectProcessor: sfEffectProcessor); cdecl;
  sfSoundStream_getPlayingOffset: function(const soundStream: PsfSoundStream): sfTime; cdecl;
  sfBuffer_create: function(): PsfBuffer; cdecl;
  sfBuffer_destroy: procedure(const buffer: PsfBuffer); cdecl;
  sfBuffer_getSize: function(const buffer: PsfBuffer): NativeUInt; cdecl;
  sfBuffer_getData: function(const buffer: PsfBuffer): PUInt8; cdecl;
  sfClock_create: function(): PsfClock; cdecl;
  sfClock_copy: function(const clock: PsfClock): PsfClock; cdecl;
  sfClock_destroy: procedure(const clock: PsfClock); cdecl;
  sfClock_getElapsedTime: function(const clock: PsfClock): sfTime; cdecl;
  sfClock_isRunning: function(const clock: PsfClock): Boolean; cdecl;
  sfClock_start: procedure(clock: PsfClock); cdecl;
  sfClock_stop: procedure(clock: PsfClock); cdecl;
  sfClock_restart: function(clock: PsfClock): sfTime; cdecl;
  sfClock_reset: function(clock: PsfClock): sfTime; cdecl;
  sfSleep: procedure(duration: sfTime); cdecl;
  sfColor_fromRGB: function(red: UInt8; green: UInt8; blue: UInt8): sfColor; cdecl;
  sfColor_fromRGBA: function(red: UInt8; green: UInt8; blue: UInt8; alpha: UInt8): sfColor; cdecl;
  sfColor_fromInteger: function(color: UInt32): sfColor; cdecl;
  sfColor_toInteger: function(color: sfColor): UInt32; cdecl;
  sfColor_add: function(color1: sfColor; color2: sfColor): sfColor; cdecl;
  sfColor_subtract: function(color1: sfColor; color2: sfColor): sfColor; cdecl;
  sfColor_modulate: function(color1: sfColor; color2: sfColor): sfColor; cdecl;
  sfFloatRect_contains: function(const rect: PsfFloatRect; point: sfVector2f): Boolean; cdecl;
  sfIntRect_contains: function(const rect: PsfIntRect; point: sfVector2i): Boolean; cdecl;
  sfFloatRect_intersects: function(const rect1: PsfFloatRect; const rect2: PsfFloatRect; intersection: PsfFloatRect): Boolean; cdecl;
  sfIntRect_intersects: function(const rect1: PsfIntRect; const rect2: PsfIntRect; intersection: PsfIntRect): Boolean; cdecl;
  sfTransform_fromMatrix: function(a00: Single; a01: Single; a02: Single; a10: Single; a11: Single; a12: Single; a20: Single; a21: Single; a22: Single): sfTransform; cdecl;
  sfTransform_getMatrix: procedure(const transform: PsfTransform; matrix: PSingle); cdecl;
  sfTransform_getInverse: function(const transform: PsfTransform): sfTransform; cdecl;
  sfTransform_transformPoint: function(const transform: PsfTransform; point: sfVector2f): sfVector2f; cdecl;
  sfTransform_transformRect: function(const transform: PsfTransform; rectangle: sfFloatRect): sfFloatRect; cdecl;
  sfTransform_combine: procedure(transform: PsfTransform; const other: PsfTransform); cdecl;
  sfTransform_translate: procedure(transform: PsfTransform; offset: sfVector2f); cdecl;
  sfTransform_rotate: procedure(transform: PsfTransform; angle: Single); cdecl;
  sfTransform_rotateWithCenter: procedure(transform: PsfTransform; angle: Single; center: sfVector2f); cdecl;
  sfTransform_scale: procedure(transform: PsfTransform; scale: sfVector2f); cdecl;
  sfTransform_scaleWithCenter: procedure(transform: PsfTransform; scale: sfVector2f; center: sfVector2f); cdecl;
  sfTransform_equal: function(left: PsfTransform; right: PsfTransform): Boolean; cdecl;
  sfCircleShape_create: function(): PsfCircleShape; cdecl;
  sfCircleShape_copy: function(const shape: PsfCircleShape): PsfCircleShape; cdecl;
  sfCircleShape_destroy: procedure(const shape: PsfCircleShape); cdecl;
  sfCircleShape_setPosition: procedure(shape: PsfCircleShape; position: sfVector2f); cdecl;
  sfCircleShape_setRotation: procedure(shape: PsfCircleShape; angle: Single); cdecl;
  sfCircleShape_setScale: procedure(shape: PsfCircleShape; scale: sfVector2f); cdecl;
  sfCircleShape_setOrigin: procedure(shape: PsfCircleShape; origin: sfVector2f); cdecl;
  sfCircleShape_getPosition: function(const shape: PsfCircleShape): sfVector2f; cdecl;
  sfCircleShape_getRotation: function(const shape: PsfCircleShape): Single; cdecl;
  sfCircleShape_getScale: function(const shape: PsfCircleShape): sfVector2f; cdecl;
  sfCircleShape_getOrigin: function(const shape: PsfCircleShape): sfVector2f; cdecl;
  sfCircleShape_move: procedure(shape: PsfCircleShape; offset: sfVector2f); cdecl;
  sfCircleShape_rotate: procedure(shape: PsfCircleShape; angle: Single); cdecl;
  sfCircleShape_scale: procedure(shape: PsfCircleShape; factors: sfVector2f); cdecl;
  sfCircleShape_getTransform: function(const shape: PsfCircleShape): sfTransform; cdecl;
  sfCircleShape_getInverseTransform: function(const shape: PsfCircleShape): sfTransform; cdecl;
  sfCircleShape_setTexture: procedure(shape: PsfCircleShape; const texture: PsfTexture; resetRect: Boolean); cdecl;
  sfCircleShape_setTextureRect: procedure(shape: PsfCircleShape; rect: sfIntRect); cdecl;
  sfCircleShape_setFillColor: procedure(shape: PsfCircleShape; color: sfColor); cdecl;
  sfCircleShape_setOutlineColor: procedure(shape: PsfCircleShape; color: sfColor); cdecl;
  sfCircleShape_setOutlineThickness: procedure(shape: PsfCircleShape; thickness: Single); cdecl;
  sfCircleShape_getTexture: function(const shape: PsfCircleShape): PsfTexture; cdecl;
  sfCircleShape_getTextureRect: function(const shape: PsfCircleShape): sfIntRect; cdecl;
  sfCircleShape_getFillColor: function(const shape: PsfCircleShape): sfColor; cdecl;
  sfCircleShape_getOutlineColor: function(const shape: PsfCircleShape): sfColor; cdecl;
  sfCircleShape_getOutlineThickness: function(const shape: PsfCircleShape): Single; cdecl;
  sfCircleShape_getPointCount: function(const shape: PsfCircleShape): NativeUInt; cdecl;
  sfCircleShape_getPoint: function(const shape: PsfCircleShape; index: NativeUInt): sfVector2f; cdecl;
  sfCircleShape_getGeometricCenter: function(const shape: PsfCircleShape): sfVector2f; cdecl;
  sfCircleShape_setRadius: procedure(shape: PsfCircleShape; radius: Single); cdecl;
  sfCircleShape_getRadius: function(const shape: PsfCircleShape): Single; cdecl;
  sfCircleShape_setPointCount: procedure(shape: PsfCircleShape; count: NativeUInt); cdecl;
  sfCircleShape_getLocalBounds: function(const shape: PsfCircleShape): sfFloatRect; cdecl;
  sfCircleShape_getGlobalBounds: function(const shape: PsfCircleShape): sfFloatRect; cdecl;
  sfConvexShape_create: function(): PsfConvexShape; cdecl;
  sfConvexShape_copy: function(const shape: PsfConvexShape): PsfConvexShape; cdecl;
  sfConvexShape_destroy: procedure(const shape: PsfConvexShape); cdecl;
  sfConvexShape_setPosition: procedure(shape: PsfConvexShape; position: sfVector2f); cdecl;
  sfConvexShape_setRotation: procedure(shape: PsfConvexShape; angle: Single); cdecl;
  sfConvexShape_setScale: procedure(shape: PsfConvexShape; scale: sfVector2f); cdecl;
  sfConvexShape_setOrigin: procedure(shape: PsfConvexShape; origin: sfVector2f); cdecl;
  sfConvexShape_getPosition: function(const shape: PsfConvexShape): sfVector2f; cdecl;
  sfConvexShape_getRotation: function(const shape: PsfConvexShape): Single; cdecl;
  sfConvexShape_getScale: function(const shape: PsfConvexShape): sfVector2f; cdecl;
  sfConvexShape_getOrigin: function(const shape: PsfConvexShape): sfVector2f; cdecl;
  sfConvexShape_move: procedure(shape: PsfConvexShape; offset: sfVector2f); cdecl;
  sfConvexShape_rotate: procedure(shape: PsfConvexShape; angle: Single); cdecl;
  sfConvexShape_scale: procedure(shape: PsfConvexShape; factors: sfVector2f); cdecl;
  sfConvexShape_getTransform: function(const shape: PsfConvexShape): sfTransform; cdecl;
  sfConvexShape_getInverseTransform: function(const shape: PsfConvexShape): sfTransform; cdecl;
  sfConvexShape_setTexture: procedure(shape: PsfConvexShape; const texture: PsfTexture; resetRect: Boolean); cdecl;
  sfConvexShape_setTextureRect: procedure(shape: PsfConvexShape; rect: sfIntRect); cdecl;
  sfConvexShape_setFillColor: procedure(shape: PsfConvexShape; color: sfColor); cdecl;
  sfConvexShape_setOutlineColor: procedure(shape: PsfConvexShape; color: sfColor); cdecl;
  sfConvexShape_setOutlineThickness: procedure(shape: PsfConvexShape; thickness: Single); cdecl;
  sfConvexShape_getTexture: function(const shape: PsfConvexShape): PsfTexture; cdecl;
  sfConvexShape_getTextureRect: function(const shape: PsfConvexShape): sfIntRect; cdecl;
  sfConvexShape_getFillColor: function(const shape: PsfConvexShape): sfColor; cdecl;
  sfConvexShape_getOutlineColor: function(const shape: PsfConvexShape): sfColor; cdecl;
  sfConvexShape_getOutlineThickness: function(const shape: PsfConvexShape): Single; cdecl;
  sfConvexShape_getPointCount: function(const shape: PsfConvexShape): NativeUInt; cdecl;
  sfConvexShape_getPoint: function(const shape: PsfConvexShape; index: NativeUInt): sfVector2f; cdecl;
  sfConvexShape_getGeometricCenter: function(const shape: PsfConvexShape): sfVector2f; cdecl;
  sfConvexShape_setPointCount: procedure(shape: PsfConvexShape; count: NativeUInt); cdecl;
  sfConvexShape_setPoint: procedure(shape: PsfConvexShape; index: NativeUInt; point: sfVector2f); cdecl;
  sfConvexShape_getLocalBounds: function(const shape: PsfConvexShape): sfFloatRect; cdecl;
  sfConvexShape_getGlobalBounds: function(const shape: PsfConvexShape): sfFloatRect; cdecl;
  sfFont_createFromFile: function(const filename: PUTF8Char): PsfFont; cdecl;
  sfFont_createFromMemory: function(const data: Pointer; sizeInBytes: NativeUInt): PsfFont; cdecl;
  sfFont_createFromStream: function(stream: PsfInputStream): PsfFont; cdecl;
  sfFont_copy: function(const font: PsfFont): PsfFont; cdecl;
  sfFont_destroy: procedure(const font: PsfFont); cdecl;
  sfFont_getGlyph: function(const font: PsfFont; codePoint: UInt32; characterSize: Cardinal; bold: Boolean; outlineThickness: Single): sfGlyph; cdecl;
  sfFont_hasGlyph: function(const font: PsfFont; codePoint: UInt32): Boolean; cdecl;
  sfFont_getKerning: function(const font: PsfFont; first: UInt32; second: UInt32; characterSize: Cardinal): Single; cdecl;
  sfFont_getBoldKerning: function(const font: PsfFont; first: UInt32; second: UInt32; characterSize: Cardinal): Single; cdecl;
  sfFont_getLineSpacing: function(const font: PsfFont; characterSize: Cardinal): Single; cdecl;
  sfFont_getUnderlinePosition: function(const font: PsfFont; characterSize: Cardinal): Single; cdecl;
  sfFont_getUnderlineThickness: function(const font: PsfFont; characterSize: Cardinal): Single; cdecl;
  sfFont_getTexture: function(font: PsfFont; characterSize: Cardinal): PsfTexture; cdecl;
  sfFont_setSmooth: procedure(font: PsfFont; smooth: Boolean); cdecl;
  sfFont_isSmooth: function(const font: PsfFont): Boolean; cdecl;
  sfFont_getInfo: function(const font: PsfFont): sfFontInfo; cdecl;
  sfImage_create: function(size: sfVector2u): PsfImage; cdecl;
  sfImage_createFromColor: function(size: sfVector2u; color: sfColor): PsfImage; cdecl;
  sfImage_createFromPixels: function(size: sfVector2u; const pixels: PUInt8): PsfImage; cdecl;
  sfImage_createFromFile: function(const filename: PUTF8Char): PsfImage; cdecl;
  sfImage_createFromMemory: function(const data: Pointer; size: NativeUInt): PsfImage; cdecl;
  sfImage_createFromStream: function(stream: PsfInputStream): PsfImage; cdecl;
  sfImage_copy: function(const image: PsfImage): PsfImage; cdecl;
  sfImage_destroy: procedure(const image: PsfImage); cdecl;
  sfImage_saveToFile: function(const image: PsfImage; const filename: PUTF8Char): Boolean; cdecl;
  sfImage_saveToMemory: function(const image: PsfImage; output: PsfBuffer; const format: PUTF8Char): Boolean; cdecl;
  sfImage_getSize: function(const image: PsfImage): sfVector2u; cdecl;
  sfImage_createMaskFromColor: procedure(image: PsfImage; color: sfColor; alpha: UInt8); cdecl;
  sfImage_copyImage: function(image: PsfImage; const source: PsfImage; dest: sfVector2u; sourceRect: sfIntRect; applyAlpha: Boolean): Boolean; cdecl;
  sfImage_setPixel: procedure(image: PsfImage; coords: sfVector2u; color: sfColor); cdecl;
  sfImage_getPixel: function(const image: PsfImage; coords: sfVector2u): sfColor; cdecl;
  sfImage_getPixelsPtr: function(const image: PsfImage): PUInt8; cdecl;
  sfImage_flipHorizontally: procedure(image: PsfImage); cdecl;
  sfImage_flipVertically: procedure(image: PsfImage); cdecl;
  sfRectangleShape_create: function(): PsfRectangleShape; cdecl;
  sfRectangleShape_copy: function(const shape: PsfRectangleShape): PsfRectangleShape; cdecl;
  sfRectangleShape_destroy: procedure(const shape: PsfRectangleShape); cdecl;
  sfRectangleShape_setPosition: procedure(shape: PsfRectangleShape; position: sfVector2f); cdecl;
  sfRectangleShape_setRotation: procedure(shape: PsfRectangleShape; angle: Single); cdecl;
  sfRectangleShape_setScale: procedure(shape: PsfRectangleShape; scale: sfVector2f); cdecl;
  sfRectangleShape_setOrigin: procedure(shape: PsfRectangleShape; origin: sfVector2f); cdecl;
  sfRectangleShape_getPosition: function(const shape: PsfRectangleShape): sfVector2f; cdecl;
  sfRectangleShape_getRotation: function(const shape: PsfRectangleShape): Single; cdecl;
  sfRectangleShape_getScale: function(const shape: PsfRectangleShape): sfVector2f; cdecl;
  sfRectangleShape_getOrigin: function(const shape: PsfRectangleShape): sfVector2f; cdecl;
  sfRectangleShape_move: procedure(shape: PsfRectangleShape; offset: sfVector2f); cdecl;
  sfRectangleShape_rotate: procedure(shape: PsfRectangleShape; angle: Single); cdecl;
  sfRectangleShape_scale: procedure(shape: PsfRectangleShape; factors: sfVector2f); cdecl;
  sfRectangleShape_getTransform: function(const shape: PsfRectangleShape): sfTransform; cdecl;
  sfRectangleShape_getInverseTransform: function(const shape: PsfRectangleShape): sfTransform; cdecl;
  sfRectangleShape_setTexture: procedure(shape: PsfRectangleShape; const texture: PsfTexture; resetRect: Boolean); cdecl;
  sfRectangleShape_setTextureRect: procedure(shape: PsfRectangleShape; rect: sfIntRect); cdecl;
  sfRectangleShape_setFillColor: procedure(shape: PsfRectangleShape; color: sfColor); cdecl;
  sfRectangleShape_setOutlineColor: procedure(shape: PsfRectangleShape; color: sfColor); cdecl;
  sfRectangleShape_setOutlineThickness: procedure(shape: PsfRectangleShape; thickness: Single); cdecl;
  sfRectangleShape_getTexture: function(const shape: PsfRectangleShape): PsfTexture; cdecl;
  sfRectangleShape_getTextureRect: function(const shape: PsfRectangleShape): sfIntRect; cdecl;
  sfRectangleShape_getFillColor: function(const shape: PsfRectangleShape): sfColor; cdecl;
  sfRectangleShape_getOutlineColor: function(const shape: PsfRectangleShape): sfColor; cdecl;
  sfRectangleShape_getOutlineThickness: function(const shape: PsfRectangleShape): Single; cdecl;
  sfRectangleShape_getPointCount: function(const shape: PsfRectangleShape): NativeUInt; cdecl;
  sfRectangleShape_getPoint: function(const shape: PsfRectangleShape; index: NativeUInt): sfVector2f; cdecl;
  sfRectangleShape_getGeometricCenter: function(const shape: PsfRectangleShape): sfVector2f; cdecl;
  sfRectangleShape_setSize: procedure(shape: PsfRectangleShape; size: sfVector2f); cdecl;
  sfRectangleShape_getSize: function(const shape: PsfRectangleShape): sfVector2f; cdecl;
  sfRectangleShape_getLocalBounds: function(const shape: PsfRectangleShape): sfFloatRect; cdecl;
  sfRectangleShape_getGlobalBounds: function(const shape: PsfRectangleShape): sfFloatRect; cdecl;
  sfJoystick_isConnected: function(joystick: Cardinal): Boolean; cdecl;
  sfJoystick_getButtonCount: function(joystick: Cardinal): Cardinal; cdecl;
  sfJoystick_hasAxis: function(joystick: Cardinal; axis: sfJoystickAxis): Boolean; cdecl;
  sfJoystick_isButtonPressed: function(joystick: Cardinal; button: Cardinal): Boolean; cdecl;
  sfJoystick_getAxisPosition: function(joystick: Cardinal; axis: sfJoystickAxis): Single; cdecl;
  sfJoystick_getIdentification: function(joystick: Cardinal): sfJoystickIdentification; cdecl;
  sfJoystick_update: procedure(); cdecl;
  sfKeyboard_isKeyPressed: function(key: sfKeyCode): Boolean; cdecl;
  sfKeyboard_isScancodePressed: function(code: sfScancode): Boolean; cdecl;
  sfKeyboard_localize: function(code: sfScancode): sfKeyCode; cdecl;
  sfKeyboard_delocalize: function(key: sfKeyCode): sfScancode; cdecl;
  sfKeyboard_getDescription: function(code: sfScancode): PUTF8Char; cdecl;
  sfKeyboard_setVirtualKeyboardVisible: procedure(visible: Boolean); cdecl;
  sfMouse_isButtonPressed: function(button: sfMouseButton): Boolean; cdecl;
  sfMouse_getPosition: function(const relativeTo: PsfWindow): sfVector2i; cdecl;
  sfMouse_setPosition: procedure(position: sfVector2i; const relativeTo: PsfWindow); cdecl;
  sfMouse_getPositionWindowBase: function(const relativeTo: PsfWindowBase): sfVector2i; cdecl;
  sfMouse_setPositionWindowBase: procedure(position: sfVector2i; const relativeTo: PsfWindowBase); cdecl;
  sfSensor_isAvailable: function(sensor: sfSensorType): Boolean; cdecl;
  sfSensor_setEnabled: procedure(sensor: sfSensorType; enabled: Boolean); cdecl;
  sfSensor_getValue: function(sensor: sfSensorType): sfVector3f; cdecl;
  sfVideoMode_getDesktopMode: function(): sfVideoMode; cdecl;
  sfVideoMode_getFullscreenModes: function(count: PNativeUInt): PsfVideoMode; cdecl;
  sfVideoMode_isValid: function(mode: sfVideoMode): Boolean; cdecl;
  sfVulkan_isAvailable: function(requireGraphics: Boolean): Boolean; cdecl;
  sfVulkan_getFunction: function(const name: PUTF8Char): sfVulkanFunctionPointer; cdecl;
  sfVulkan_getGraphicsRequiredInstanceExtensions: function(count: PNativeUInt): PPUTF8Char; cdecl;
  sfWindowBase_create: function(mode: sfVideoMode; const title: PUTF8Char; style: UInt32; state: sfWindowState): PsfWindowBase; cdecl;
  sfWindowBase_createUnicode: function(mode: sfVideoMode; const title: PsfChar32; style: UInt32; state: sfWindowState): PsfWindowBase; cdecl;
  sfWindowBase_createFromHandle: function(handle: sfWindowHandle): PsfWindowBase; cdecl;
  sfWindowBase_destroy: procedure(const windowBase: PsfWindowBase); cdecl;
  sfWindowBase_close: procedure(windowBase: PsfWindowBase); cdecl;
  sfWindowBase_isOpen: function(const windowBase: PsfWindowBase): Boolean; cdecl;
  sfWindowBase_pollEvent: function(windowBase: PsfWindowBase; event: PsfEvent): Boolean; cdecl;
  sfWindowBase_waitEvent: function(windowBase: PsfWindowBase; timeout: sfTime; event: PsfEvent): Boolean; cdecl;
  sfWindowBase_getPosition: function(const windowBase: PsfWindowBase): sfVector2i; cdecl;
  sfWindowBase_setPosition: procedure(windowBase: PsfWindowBase; position: sfVector2i); cdecl;
  sfWindowBase_getSize: function(const windowBase: PsfWindowBase): sfVector2u; cdecl;
  sfWindowBase_setSize: procedure(windowBase: PsfWindowBase; size: sfVector2u); cdecl;
  sfWindowBase_setTitle: procedure(windowBase: PsfWindowBase; const title: PUTF8Char); cdecl;
  sfWindowBase_setUnicodeTitle: procedure(windowBase: PsfWindowBase; const title: PsfChar32); cdecl;
  sfWindowBase_setIcon: procedure(windowBase: PsfWindowBase; size: sfVector2u; const pixels: PUInt8); cdecl;
  sfWindowBase_setVisible: procedure(windowBase: PsfWindowBase; visible: Boolean); cdecl;
  sfWindowBase_setMouseCursorVisible: procedure(windowBase: PsfWindowBase; visible: Boolean); cdecl;
  sfWindowBase_setMouseCursorGrabbed: procedure(windowBase: PsfWindowBase; grabbed: Boolean); cdecl;
  sfWindowBase_setMouseCursor: procedure(windowBase: PsfWindowBase; const cursor: PsfCursor); cdecl;
  sfWindowBase_setKeyRepeatEnabled: procedure(windowBase: PsfWindowBase; enabled: Boolean); cdecl;
  sfWindowBase_setJoystickThreshold: procedure(windowBase: PsfWindowBase; threshold: Single); cdecl;
  sfWindowBase_requestFocus: procedure(windowBase: PsfWindowBase); cdecl;
  sfWindowBase_hasFocus: function(const windowBase: PsfWindowBase): Boolean; cdecl;
  sfWindowBase_getNativeHandle: function(const windowBase: PsfWindowBase): sfWindowHandle; cdecl;
  sfWindowBase_createVulkanSurface: function(windowBase: PsfWindowBase; const instance: PVkInstance; surface: PVkSurfaceKHR; const allocator: PVkAllocationCallbacks): Boolean; cdecl;
  sfWindow_create: function(mode: sfVideoMode; const title: PUTF8Char; style: UInt32; state: sfWindowState; const settings: PsfContextSettings): PsfWindow; cdecl;
  sfWindow_createUnicode: function(mode: sfVideoMode; const title: PsfChar32; style: UInt32; state: sfWindowState; const settings: PsfContextSettings): PsfWindow; cdecl;
  sfWindow_createFromHandle: function(handle: sfWindowHandle; const settings: PsfContextSettings): PsfWindow; cdecl;
  sfWindow_destroy: procedure(const window: PsfWindow); cdecl;
  sfWindow_close: procedure(window: PsfWindow); cdecl;
  sfWindow_isOpen: function(const window: PsfWindow): Boolean; cdecl;
  sfWindow_getSettings: function(const window: PsfWindow): sfContextSettings; cdecl;
  sfWindow_pollEvent: function(window: PsfWindow; event: PsfEvent): Boolean; cdecl;
  sfWindow_waitEvent: function(window: PsfWindow; timeout: sfTime; event: PsfEvent): Boolean; cdecl;
  sfWindow_getPosition: function(const window: PsfWindow): sfVector2i; cdecl;
  sfWindow_setPosition: procedure(window: PsfWindow; position: sfVector2i); cdecl;
  sfWindow_getSize: function(const window: PsfWindow): sfVector2u; cdecl;
  sfWindow_setSize: procedure(window: PsfWindow; size: sfVector2u); cdecl;
  sfWindow_setTitle: procedure(window: PsfWindow; const title: PUTF8Char); cdecl;
  sfWindow_setUnicodeTitle: procedure(window: PsfWindow; const title: PsfChar32); cdecl;
  sfWindow_setIcon: procedure(window: PsfWindow; size: sfVector2u; const pixels: PUInt8); cdecl;
  sfWindow_setVisible: procedure(window: PsfWindow; visible: Boolean); cdecl;
  sfWindow_setVerticalSyncEnabled: procedure(window: PsfWindow; enabled: Boolean); cdecl;
  sfWindow_setMouseCursorVisible: procedure(window: PsfWindow; visible: Boolean); cdecl;
  sfWindow_setMouseCursorGrabbed: procedure(window: PsfWindow; grabbed: Boolean); cdecl;
  sfWindow_setMouseCursor: procedure(window: PsfWindow; const cursor: PsfCursor); cdecl;
  sfWindow_setKeyRepeatEnabled: procedure(window: PsfWindow; enabled: Boolean); cdecl;
  sfWindow_setFramerateLimit: procedure(window: PsfWindow; limit: Cardinal); cdecl;
  sfWindow_setJoystickThreshold: procedure(window: PsfWindow; threshold: Single); cdecl;
  sfWindow_setActive: function(window: PsfWindow; active: Boolean): Boolean; cdecl;
  sfWindow_requestFocus: procedure(window: PsfWindow); cdecl;
  sfWindow_hasFocus: function(const window: PsfWindow): Boolean; cdecl;
  sfWindow_display: procedure(window: PsfWindow); cdecl;
  sfWindow_getNativeHandle: function(const window: PsfWindow): sfWindowHandle; cdecl;
  sfWindow_createVulkanSurface: function(window: PsfWindow; const instance: PVkInstance; surface: PVkSurfaceKHR; const allocator: PVkAllocationCallbacks): Boolean; cdecl;
  sfRenderTexture_create: function(size: sfVector2u; const settings: PsfContextSettings): PsfRenderTexture; cdecl;
  sfRenderTexture_destroy: procedure(const renderTexture: PsfRenderTexture); cdecl;
  sfRenderTexture_getSize: function(const renderTexture: PsfRenderTexture): sfVector2u; cdecl;
  sfRenderTexture_isSrgb: function(const renderTexture: PsfRenderTexture): Boolean; cdecl;
  sfRenderTexture_setActive: function(renderTexture: PsfRenderTexture; active: Boolean): Boolean; cdecl;
  sfRenderTexture_display: procedure(renderTexture: PsfRenderTexture); cdecl;
  sfRenderTexture_clear: procedure(renderTexture: PsfRenderTexture; color: sfColor); cdecl;
  sfRenderTexture_clearStencil: procedure(renderTexture: PsfRenderTexture; stencilValue: sfStencilValue); cdecl;
  sfRenderTexture_clearColorAndStencil: procedure(renderTexture: PsfRenderTexture; color: sfColor; stencilValue: sfStencilValue); cdecl;
  sfRenderTexture_setView: procedure(renderTexture: PsfRenderTexture; const view: PsfView); cdecl;
  sfRenderTexture_getView: function(const renderTexture: PsfRenderTexture): PsfView; cdecl;
  sfRenderTexture_getDefaultView: function(const renderTexture: PsfRenderTexture): PsfView; cdecl;
  sfRenderTexture_getViewport: function(const renderTexture: PsfRenderTexture; const view: PsfView): sfIntRect; cdecl;
  sfRenderTexture_getScissor: function(const renderTexture: PsfRenderTexture; const view: PsfView): sfIntRect; cdecl;
  sfRenderTexture_mapPixelToCoords: function(const renderTexture: PsfRenderTexture; point: sfVector2i; const view: PsfView): sfVector2f; cdecl;
  sfRenderTexture_mapCoordsToPixel: function(const renderTexture: PsfRenderTexture; point: sfVector2f; const view: PsfView): sfVector2i; cdecl;
  sfRenderTexture_drawSprite: procedure(renderTexture: PsfRenderTexture; const &object: PsfSprite; const states: PsfRenderStates); cdecl;
  sfRenderTexture_drawText: procedure(renderTexture: PsfRenderTexture; const &object: PsfText; const states: PsfRenderStates); cdecl;
  sfRenderTexture_drawShape: procedure(renderTexture: PsfRenderTexture; const &object: PsfShape; const states: PsfRenderStates); cdecl;
  sfRenderTexture_drawCircleShape: procedure(renderTexture: PsfRenderTexture; const &object: PsfCircleShape; const states: PsfRenderStates); cdecl;
  sfRenderTexture_drawConvexShape: procedure(renderTexture: PsfRenderTexture; const &object: PsfConvexShape; const states: PsfRenderStates); cdecl;
  sfRenderTexture_drawRectangleShape: procedure(renderTexture: PsfRenderTexture; const &object: PsfRectangleShape; const states: PsfRenderStates); cdecl;
  sfRenderTexture_drawVertexArray: procedure(renderTexture: PsfRenderTexture; const &object: PsfVertexArray; const states: PsfRenderStates); cdecl;
  sfRenderTexture_drawVertexBuffer: procedure(renderTexture: PsfRenderTexture; const &object: PsfVertexBuffer; const states: PsfRenderStates); cdecl;
  sfRenderTexture_drawVertexBufferRange: procedure(renderTexture: PsfRenderTexture; const &object: PsfVertexBuffer; firstVertex: NativeUInt; vertexCount: NativeUInt; const states: PsfRenderStates); cdecl;
  sfRenderTexture_drawPrimitives: procedure(renderTexture: PsfRenderTexture; const vertices: PsfVertex; vertexCount: NativeUInt; &type: sfPrimitiveType; const states: PsfRenderStates); cdecl;
  sfRenderTexture_pushGLStates: procedure(renderTexture: PsfRenderTexture); cdecl;
  sfRenderTexture_popGLStates: procedure(renderTexture: PsfRenderTexture); cdecl;
  sfRenderTexture_resetGLStates: procedure(renderTexture: PsfRenderTexture); cdecl;
  sfRenderTexture_getTexture: function(const renderTexture: PsfRenderTexture): PsfTexture; cdecl;
  sfRenderTexture_getMaximumAntiAliasingLevel: function(): Cardinal; cdecl;
  sfRenderTexture_setSmooth: procedure(renderTexture: PsfRenderTexture; smooth: Boolean); cdecl;
  sfRenderTexture_isSmooth: function(const renderTexture: PsfRenderTexture): Boolean; cdecl;
  sfRenderTexture_setRepeated: procedure(renderTexture: PsfRenderTexture; repeated: Boolean); cdecl;
  sfRenderTexture_isRepeated: function(const renderTexture: PsfRenderTexture): Boolean; cdecl;
  sfRenderTexture_generateMipmap: function(renderTexture: PsfRenderTexture): Boolean; cdecl;
  sfRenderWindow_create: function(mode: sfVideoMode; const title: PUTF8Char; style: UInt32; state: sfWindowState; const settings: PsfContextSettings): PsfRenderWindow; cdecl;
  sfRenderWindow_createUnicode: function(mode: sfVideoMode; const title: PsfChar32; style: UInt32; state: sfWindowState; const settings: PsfContextSettings): PsfRenderWindow; cdecl;
  sfRenderWindow_createFromHandle: function(handle: sfWindowHandle; const settings: PsfContextSettings): PsfRenderWindow; cdecl;
  sfRenderWindow_destroy: procedure(const renderWindow: PsfRenderWindow); cdecl;
  sfRenderWindow_close: procedure(renderWindow: PsfRenderWindow); cdecl;
  sfRenderWindow_isOpen: function(const renderWindow: PsfRenderWindow): Boolean; cdecl;
  sfRenderWindow_getSettings: function(const renderWindow: PsfRenderWindow): sfContextSettings; cdecl;
  sfRenderWindow_pollEvent: function(renderWindow: PsfRenderWindow; event: PsfEvent): Boolean; cdecl;
  sfRenderWindow_waitEvent: function(renderWindow: PsfRenderWindow; timeout: sfTime; event: PsfEvent): Boolean; cdecl;
  sfRenderWindow_getPosition: function(const renderWindow: PsfRenderWindow): sfVector2i; cdecl;
  sfRenderWindow_setPosition: procedure(renderWindow: PsfRenderWindow; position: sfVector2i); cdecl;
  sfRenderWindow_getSize: function(const renderWindow: PsfRenderWindow): sfVector2u; cdecl;
  sfRenderWindow_isSrgb: function(const renderWindow: PsfRenderWindow): Boolean; cdecl;
  sfRenderWindow_setSize: procedure(renderWindow: PsfRenderWindow; size: sfVector2u); cdecl;
  sfRenderWindow_setTitle: procedure(renderWindow: PsfRenderWindow; const title: PUTF8Char); cdecl;
  sfRenderWindow_setUnicodeTitle: procedure(renderWindow: PsfRenderWindow; const title: PsfChar32); cdecl;
  sfRenderWindow_setIcon: procedure(renderWindow: PsfRenderWindow; size: sfVector2u; const pixels: PUInt8); cdecl;
  sfRenderWindow_setVisible: procedure(renderWindow: PsfRenderWindow; visible: Boolean); cdecl;
  sfRenderWindow_setVerticalSyncEnabled: procedure(renderWindow: PsfRenderWindow; enabled: Boolean); cdecl;
  sfRenderWindow_setMouseCursorVisible: procedure(renderWindow: PsfRenderWindow; show: Boolean); cdecl;
  sfRenderWindow_setMouseCursorGrabbed: procedure(renderWindow: PsfRenderWindow; grabbed: Boolean); cdecl;
  sfRenderWindow_setMouseCursor: procedure(renderWindow: PsfRenderWindow; const cursor: PsfCursor); cdecl;
  sfRenderWindow_setKeyRepeatEnabled: procedure(renderWindow: PsfRenderWindow; enabled: Boolean); cdecl;
  sfRenderWindow_setFramerateLimit: procedure(renderWindow: PsfRenderWindow; limit: Cardinal); cdecl;
  sfRenderWindow_setJoystickThreshold: procedure(renderWindow: PsfRenderWindow; threshold: Single); cdecl;
  sfRenderWindow_setActive: function(renderWindow: PsfRenderWindow; active: Boolean): Boolean; cdecl;
  sfRenderWindow_requestFocus: procedure(renderWindow: PsfRenderWindow); cdecl;
  sfRenderWindow_hasFocus: function(const renderWindow: PsfRenderWindow): Boolean; cdecl;
  sfRenderWindow_display: procedure(renderWindow: PsfRenderWindow); cdecl;
  sfRenderWindow_getNativeHandle: function(const renderWindow: PsfRenderWindow): sfWindowHandle; cdecl;
  sfRenderWindow_clear: procedure(renderWindow: PsfRenderWindow; color: sfColor); cdecl;
  sfRenderWindow_clearStencil: procedure(renderWindow: PsfRenderWindow; stencilValue: sfStencilValue); cdecl;
  sfRenderWindow_clearColorAndStencil: procedure(renderWindow: PsfRenderWindow; color: sfColor; stencilValue: sfStencilValue); cdecl;
  sfRenderWindow_setView: procedure(renderWindow: PsfRenderWindow; const view: PsfView); cdecl;
  sfRenderWindow_getView: function(const renderWindow: PsfRenderWindow): PsfView; cdecl;
  sfRenderWindow_getDefaultView: function(const renderWindow: PsfRenderWindow): PsfView; cdecl;
  sfRenderWindow_getViewport: function(const renderWindow: PsfRenderWindow; const view: PsfView): sfIntRect; cdecl;
  sfRenderWindow_getScissor: function(const renderWindow: PsfRenderWindow; const view: PsfView): sfIntRect; cdecl;
  sfRenderWindow_mapPixelToCoords: function(const renderWindow: PsfRenderWindow; point: sfVector2i; const view: PsfView): sfVector2f; cdecl;
  sfRenderWindow_mapCoordsToPixel: function(const renderWindow: PsfRenderWindow; point: sfVector2f; const view: PsfView): sfVector2i; cdecl;
  sfRenderWindow_drawSprite: procedure(renderWindow: PsfRenderWindow; const &object: PsfSprite; const states: PsfRenderStates); cdecl;
  sfRenderWindow_drawText: procedure(renderWindow: PsfRenderWindow; const &object: PsfText; const states: PsfRenderStates); cdecl;
  sfRenderWindow_drawShape: procedure(renderWindow: PsfRenderWindow; const &object: PsfShape; const states: PsfRenderStates); cdecl;
  sfRenderWindow_drawCircleShape: procedure(renderWindow: PsfRenderWindow; const &object: PsfCircleShape; const states: PsfRenderStates); cdecl;
  sfRenderWindow_drawConvexShape: procedure(renderWindow: PsfRenderWindow; const &object: PsfConvexShape; const states: PsfRenderStates); cdecl;
  sfRenderWindow_drawRectangleShape: procedure(renderWindow: PsfRenderWindow; const &object: PsfRectangleShape; const states: PsfRenderStates); cdecl;
  sfRenderWindow_drawVertexArray: procedure(renderWindow: PsfRenderWindow; const &object: PsfVertexArray; const states: PsfRenderStates); cdecl;
  sfRenderWindow_drawVertexBuffer: procedure(renderWindow: PsfRenderWindow; const &object: PsfVertexBuffer; const states: PsfRenderStates); cdecl;
  sfRenderWindow_drawVertexBufferRange: procedure(renderWindow: PsfRenderWindow; const &object: PsfVertexBuffer; firstVertex: NativeUInt; vertexCount: NativeUInt; const states: PsfRenderStates); cdecl;
  sfRenderWindow_drawPrimitives: procedure(renderWindow: PsfRenderWindow; const vertices: PsfVertex; vertexCount: NativeUInt; &type: sfPrimitiveType; const states: PsfRenderStates); cdecl;
  sfRenderWindow_pushGLStates: procedure(renderWindow: PsfRenderWindow); cdecl;
  sfRenderWindow_popGLStates: procedure(renderWindow: PsfRenderWindow); cdecl;
  sfRenderWindow_resetGLStates: procedure(renderWindow: PsfRenderWindow); cdecl;
  sfMouse_getPositionRenderWindow: function(const relativeTo: PsfRenderWindow): sfVector2i; cdecl;
  sfMouse_setPositionRenderWindow: procedure(position: sfVector2i; const relativeTo: PsfRenderWindow); cdecl;
  sfTouch_getPositionRenderWindow: function(finger: Cardinal; const relativeTo: PsfRenderWindow): sfVector2i; cdecl;
  sfRenderWindow_createVulkanSurface: function(renderWindow: PsfRenderWindow; const instance: PVkInstance; surface: PVkSurfaceKHR; const allocator: PVkAllocationCallbacks): Boolean; cdecl;
  sfShader_createFromFile: function(const vertexShaderFilename: PUTF8Char; const geometryShaderFilename: PUTF8Char; const fragmentShaderFilename: PUTF8Char): PsfShader; cdecl;
  sfShader_createFromMemory: function(const vertexShader: PUTF8Char; const geometryShader: PUTF8Char; const fragmentShader: PUTF8Char): PsfShader; cdecl;
  sfShader_createFromStream: function(vertexShaderStream: PsfInputStream; geometryShaderStream: PsfInputStream; fragmentShaderStream: PsfInputStream): PsfShader; cdecl;
  sfShader_destroy: procedure(const shader: PsfShader); cdecl;
  sfShader_setFloatUniform: procedure(shader: PsfShader; const name: PUTF8Char; x: Single); cdecl;
  sfShader_setVec2Uniform: procedure(shader: PsfShader; const name: PUTF8Char; vector: sfGlslVec2); cdecl;
  sfShader_setVec3Uniform: procedure(shader: PsfShader; const name: PUTF8Char; vector: sfGlslVec3); cdecl;
  sfShader_setVec4Uniform: procedure(shader: PsfShader; const name: PUTF8Char; vector: sfGlslVec4); cdecl;
  sfShader_setColorUniform: procedure(shader: PsfShader; const name: PUTF8Char; color: sfColor); cdecl;
  sfShader_setIntUniform: procedure(shader: PsfShader; const name: PUTF8Char; x: Integer); cdecl;
  sfShader_setIvec2Uniform: procedure(shader: PsfShader; const name: PUTF8Char; vector: sfGlslIvec2); cdecl;
  sfShader_setIvec3Uniform: procedure(shader: PsfShader; const name: PUTF8Char; vector: sfGlslIvec3); cdecl;
  sfShader_setIvec4Uniform: procedure(shader: PsfShader; const name: PUTF8Char; vector: sfGlslIvec4); cdecl;
  sfShader_setIntColorUniform: procedure(shader: PsfShader; const name: PUTF8Char; color: sfColor); cdecl;
  sfShader_setBoolUniform: procedure(shader: PsfShader; const name: PUTF8Char; x: Boolean); cdecl;
  sfShader_setBvec2Uniform: procedure(shader: PsfShader; const name: PUTF8Char; vector: sfGlslBvec2); cdecl;
  sfShader_setBvec3Uniform: procedure(shader: PsfShader; const name: PUTF8Char; vector: sfGlslBvec3); cdecl;
  sfShader_setBvec4Uniform: procedure(shader: PsfShader; const name: PUTF8Char; vector: sfGlslBvec4); cdecl;
  sfShader_setMat3Uniform: procedure(shader: PsfShader; const name: PUTF8Char; const matrix: PsfGlslMat3); cdecl;
  sfShader_setMat4Uniform: procedure(shader: PsfShader; const name: PUTF8Char; const matrix: PsfGlslMat4); cdecl;
  sfShader_setTextureUniform: procedure(shader: PsfShader; const name: PUTF8Char; const texture: PsfTexture); cdecl;
  sfShader_setCurrentTextureUniform: procedure(shader: PsfShader; const name: PUTF8Char); cdecl;
  sfShader_setFloatUniformArray: procedure(shader: PsfShader; const name: PUTF8Char; const scalarArray: PSingle; length: NativeUInt); cdecl;
  sfShader_setVec2UniformArray: procedure(shader: PsfShader; const name: PUTF8Char; const vectorArray: PsfGlslVec2; length: NativeUInt); cdecl;
  sfShader_setVec3UniformArray: procedure(shader: PsfShader; const name: PUTF8Char; const vectorArray: PsfGlslVec3; length: NativeUInt); cdecl;
  sfShader_setVec4UniformArray: procedure(shader: PsfShader; const name: PUTF8Char; const vectorArray: PsfGlslVec4; length: NativeUInt); cdecl;
  sfShader_setMat3UniformArray: procedure(shader: PsfShader; const name: PUTF8Char; const matrixArray: PsfGlslMat3; length: NativeUInt); cdecl;
  sfShader_setMat4UniformArray: procedure(shader: PsfShader; const name: PUTF8Char; const matrixArray: PsfGlslMat4; length: NativeUInt); cdecl;
  sfShader_getNativeHandle: function(const shader: PsfShader): Cardinal; cdecl;
  sfShader_bind: procedure(const shader: PsfShader); cdecl;
  sfShader_isAvailable: function(): Boolean; cdecl;
  sfShader_isGeometryAvailable: function(): Boolean; cdecl;
  sfShape_create: function(getPointCount: sfShapeGetPointCountCallback; getPoint: sfShapeGetPointCallback; userData: Pointer): PsfShape; cdecl;
  sfShape_destroy: procedure(const shape: PsfShape); cdecl;
  sfShape_setPosition: procedure(shape: PsfShape; position: sfVector2f); cdecl;
  sfShape_setRotation: procedure(shape: PsfShape; angle: Single); cdecl;
  sfShape_setScale: procedure(shape: PsfShape; scale: sfVector2f); cdecl;
  sfShape_setOrigin: procedure(shape: PsfShape; origin: sfVector2f); cdecl;
  sfShape_getPosition: function(const shape: PsfShape): sfVector2f; cdecl;
  sfShape_getRotation: function(const shape: PsfShape): Single; cdecl;
  sfShape_getScale: function(const shape: PsfShape): sfVector2f; cdecl;
  sfShape_getOrigin: function(const shape: PsfShape): sfVector2f; cdecl;
  sfShape_move: procedure(shape: PsfShape; offset: sfVector2f); cdecl;
  sfShape_rotate: procedure(shape: PsfShape; angle: Single); cdecl;
  sfShape_scale: procedure(shape: PsfShape; factors: sfVector2f); cdecl;
  sfShape_getTransform: function(const shape: PsfShape): sfTransform; cdecl;
  sfShape_getInverseTransform: function(const shape: PsfShape): sfTransform; cdecl;
  sfShape_setTexture: procedure(shape: PsfShape; const texture: PsfTexture; resetRect: Boolean); cdecl;
  sfShape_setTextureRect: procedure(shape: PsfShape; rect: sfIntRect); cdecl;
  sfShape_setFillColor: procedure(shape: PsfShape; color: sfColor); cdecl;
  sfShape_setOutlineColor: procedure(shape: PsfShape; color: sfColor); cdecl;
  sfShape_setOutlineThickness: procedure(shape: PsfShape; thickness: Single); cdecl;
  sfShape_getTexture: function(const shape: PsfShape): PsfTexture; cdecl;
  sfShape_getTextureRect: function(const shape: PsfShape): sfIntRect; cdecl;
  sfShape_getFillColor: function(const shape: PsfShape): sfColor; cdecl;
  sfShape_getOutlineColor: function(const shape: PsfShape): sfColor; cdecl;
  sfShape_getOutlineThickness: function(const shape: PsfShape): Single; cdecl;
  sfShape_getPointCount: function(const shape: PsfShape): NativeUInt; cdecl;
  sfShape_getPoint: function(const shape: PsfShape; index: NativeUInt): sfVector2f; cdecl;
  sfShape_getGeometricCenter: function(const shape: PsfShape): sfVector2f; cdecl;
  sfShape_getLocalBounds: function(const shape: PsfShape): sfFloatRect; cdecl;
  sfShape_getGlobalBounds: function(const shape: PsfShape): sfFloatRect; cdecl;
  sfShape_update: procedure(shape: PsfShape); cdecl;
  sfSprite_create: function(const texture: PsfTexture): PsfSprite; cdecl;
  sfSprite_copy: function(const sprite: PsfSprite): PsfSprite; cdecl;
  sfSprite_destroy: procedure(const sprite: PsfSprite); cdecl;
  sfSprite_setPosition: procedure(sprite: PsfSprite; position: sfVector2f); cdecl;
  sfSprite_setRotation: procedure(sprite: PsfSprite; angle: Single); cdecl;
  sfSprite_setScale: procedure(sprite: PsfSprite; scale: sfVector2f); cdecl;
  sfSprite_setOrigin: procedure(sprite: PsfSprite; origin: sfVector2f); cdecl;
  sfSprite_getPosition: function(const sprite: PsfSprite): sfVector2f; cdecl;
  sfSprite_getRotation: function(const sprite: PsfSprite): Single; cdecl;
  sfSprite_getScale: function(const sprite: PsfSprite): sfVector2f; cdecl;
  sfSprite_getOrigin: function(const sprite: PsfSprite): sfVector2f; cdecl;
  sfSprite_move: procedure(sprite: PsfSprite; offset: sfVector2f); cdecl;
  sfSprite_rotate: procedure(sprite: PsfSprite; angle: Single); cdecl;
  sfSprite_scale: procedure(sprite: PsfSprite; factors: sfVector2f); cdecl;
  sfSprite_getTransform: function(const sprite: PsfSprite): sfTransform; cdecl;
  sfSprite_getInverseTransform: function(const sprite: PsfSprite): sfTransform; cdecl;
  sfSprite_setTexture: procedure(sprite: PsfSprite; const texture: PsfTexture; resetRect: Boolean); cdecl;
  sfSprite_setTextureRect: procedure(sprite: PsfSprite; rectangle: sfIntRect); cdecl;
  sfSprite_setColor: procedure(sprite: PsfSprite; color: sfColor); cdecl;
  sfSprite_getTexture: function(const sprite: PsfSprite): PsfTexture; cdecl;
  sfSprite_getTextureRect: function(const sprite: PsfSprite): sfIntRect; cdecl;
  sfSprite_getColor: function(const sprite: PsfSprite): sfColor; cdecl;
  sfSprite_getLocalBounds: function(const sprite: PsfSprite): sfFloatRect; cdecl;
  sfSprite_getGlobalBounds: function(const sprite: PsfSprite): sfFloatRect; cdecl;
  sfText_create: function(const font: PsfFont): PsfText; cdecl;
  sfText_copy: function(const text: PsfText): PsfText; cdecl;
  sfText_destroy: procedure(const text: PsfText); cdecl;
  sfText_setPosition: procedure(text: PsfText; position: sfVector2f); cdecl;
  sfText_setRotation: procedure(text: PsfText; angle: Single); cdecl;
  sfText_setScale: procedure(text: PsfText; scale: sfVector2f); cdecl;
  sfText_setOrigin: procedure(text: PsfText; origin: sfVector2f); cdecl;
  sfText_getPosition: function(const text: PsfText): sfVector2f; cdecl;
  sfText_getRotation: function(const text: PsfText): Single; cdecl;
  sfText_getScale: function(const text: PsfText): sfVector2f; cdecl;
  sfText_getOrigin: function(const text: PsfText): sfVector2f; cdecl;
  sfText_move: procedure(text: PsfText; offset: sfVector2f); cdecl;
  sfText_rotate: procedure(text: PsfText; angle: Single); cdecl;
  sfText_scale: procedure(text: PsfText; factors: sfVector2f); cdecl;
  sfText_getTransform: function(const text: PsfText): sfTransform; cdecl;
  sfText_getInverseTransform: function(const text: PsfText): sfTransform; cdecl;
  sfText_setString: procedure(text: PsfText; const &string: PUTF8Char); cdecl;
  sfText_setUnicodeString: procedure(text: PsfText; const &string: PsfChar32); cdecl;
  sfText_setFont: procedure(text: PsfText; const font: PsfFont); cdecl;
  sfText_setCharacterSize: procedure(text: PsfText; size: Cardinal); cdecl;
  sfText_setLineSpacing: procedure(text: PsfText; spacingFactor: Single); cdecl;
  sfText_setLetterSpacing: procedure(text: PsfText; spacingFactor: Single); cdecl;
  sfText_setStyle: procedure(text: PsfText; style: UInt32); cdecl;
  sfText_setFillColor: procedure(text: PsfText; color: sfColor); cdecl;
  sfText_setOutlineColor: procedure(text: PsfText; color: sfColor); cdecl;
  sfText_setOutlineThickness: procedure(text: PsfText; thickness: Single); cdecl;
  sfText_getString: function(const text: PsfText): PUTF8Char; cdecl;
  sfText_getUnicodeString: function(const text: PsfText): PsfChar32; cdecl;
  sfText_getFont: function(const text: PsfText): PsfFont; cdecl;
  sfText_getCharacterSize: function(const text: PsfText): Cardinal; cdecl;
  sfText_getLetterSpacing: function(const text: PsfText): Single; cdecl;
  sfText_getLineSpacing: function(const text: PsfText): Single; cdecl;
  sfText_getStyle: function(const text: PsfText): UInt32; cdecl;
  sfText_getFillColor: function(const text: PsfText): sfColor; cdecl;
  sfText_getOutlineColor: function(const text: PsfText): sfColor; cdecl;
  sfText_getOutlineThickness: function(const text: PsfText): Single; cdecl;
  sfText_findCharacterPos: function(const text: PsfText; index: NativeUInt): sfVector2f; cdecl;
  sfText_getLocalBounds: function(const text: PsfText): sfFloatRect; cdecl;
  sfText_getGlobalBounds: function(const text: PsfText): sfFloatRect; cdecl;
  sfTexture_create: function(size: sfVector2u): PsfTexture; cdecl;
  sfTexture_createSrgb: function(size: sfVector2u): PsfTexture; cdecl;
  sfTexture_createFromFile: function(const filename: PUTF8Char; const area: PsfIntRect): PsfTexture; cdecl;
  sfTexture_createSrgbFromFile: function(const filename: PUTF8Char; const area: PsfIntRect): PsfTexture; cdecl;
  sfTexture_createFromMemory: function(const data: Pointer; sizeInBytes: NativeUInt; const area: PsfIntRect): PsfTexture; cdecl;
  sfTexture_createSrgbFromMemory: function(const data: Pointer; sizeInBytes: NativeUInt; const area: PsfIntRect): PsfTexture; cdecl;
  sfTexture_createFromStream: function(stream: PsfInputStream; const area: PsfIntRect): PsfTexture; cdecl;
  sfTexture_createSrgbFromStream: function(stream: PsfInputStream; const area: PsfIntRect): PsfTexture; cdecl;
  sfTexture_createFromImage: function(const image: PsfImage; const area: PsfIntRect): PsfTexture; cdecl;
  sfTexture_createSrgbFromImage: function(const image: PsfImage; const area: PsfIntRect): PsfTexture; cdecl;
  sfTexture_copy: function(const texture: PsfTexture): PsfTexture; cdecl;
  sfTexture_destroy: procedure(const texture: PsfTexture); cdecl;
  sfTexture_getSize: function(const texture: PsfTexture): sfVector2u; cdecl;
  sfTexture_copyToImage: function(const texture: PsfTexture): PsfImage; cdecl;
  sfTexture_updateFromPixels: procedure(texture: PsfTexture; const pixels: PUInt8; size: sfVector2u; offset: sfVector2u); cdecl;
  sfTexture_updateFromTexture: procedure(destination: PsfTexture; const source: PsfTexture; offset: sfVector2u); cdecl;
  sfTexture_updateFromImage: procedure(texture: PsfTexture; const image: PsfImage; offset: sfVector2u); cdecl;
  sfTexture_updateFromWindow: procedure(texture: PsfTexture; const window: PsfWindow; offset: sfVector2u); cdecl;
  sfTexture_updateFromRenderWindow: procedure(texture: PsfTexture; const renderWindow: PsfRenderWindow; offset: sfVector2u); cdecl;
  sfTexture_setSmooth: procedure(texture: PsfTexture; smooth: Boolean); cdecl;
  sfTexture_isSmooth: function(const texture: PsfTexture): Boolean; cdecl;
  sfTexture_isSrgb: function(const texture: PsfTexture): Boolean; cdecl;
  sfTexture_setRepeated: procedure(texture: PsfTexture; repeated: Boolean); cdecl;
  sfTexture_isRepeated: function(const texture: PsfTexture): Boolean; cdecl;
  sfTexture_generateMipmap: function(texture: PsfTexture): Boolean; cdecl;
  sfTexture_swap: procedure(left: PsfTexture; right: PsfTexture); cdecl;
  sfTexture_getNativeHandle: function(const texture: PsfTexture): Cardinal; cdecl;
  sfTexture_bind: procedure(const texture: PsfTexture; &type: sfCoordinateType); cdecl;
  sfTexture_getMaximumSize: function(): Cardinal; cdecl;
  sfTransformable_create: function(): PsfTransformable; cdecl;
  sfTransformable_copy: function(const transformable: PsfTransformable): PsfTransformable; cdecl;
  sfTransformable_destroy: procedure(const transformable: PsfTransformable); cdecl;
  sfTransformable_setPosition: procedure(transformable: PsfTransformable; position: sfVector2f); cdecl;
  sfTransformable_setRotation: procedure(transformable: PsfTransformable; angle: Single); cdecl;
  sfTransformable_setScale: procedure(transformable: PsfTransformable; scale: sfVector2f); cdecl;
  sfTransformable_setOrigin: procedure(transformable: PsfTransformable; origin: sfVector2f); cdecl;
  sfTransformable_getPosition: function(const transformable: PsfTransformable): sfVector2f; cdecl;
  sfTransformable_getRotation: function(const transformable: PsfTransformable): Single; cdecl;
  sfTransformable_getScale: function(const transformable: PsfTransformable): sfVector2f; cdecl;
  sfTransformable_getOrigin: function(const transformable: PsfTransformable): sfVector2f; cdecl;
  sfTransformable_move: procedure(transformable: PsfTransformable; offset: sfVector2f); cdecl;
  sfTransformable_rotate: procedure(transformable: PsfTransformable; angle: Single); cdecl;
  sfTransformable_scale: procedure(transformable: PsfTransformable; factors: sfVector2f); cdecl;
  sfTransformable_getTransform: function(const transformable: PsfTransformable): sfTransform; cdecl;
  sfTransformable_getInverseTransform: function(const transformable: PsfTransformable): sfTransform; cdecl;
  sfVertexArray_create: function(): PsfVertexArray; cdecl;
  sfVertexArray_copy: function(const vertexArray: PsfVertexArray): PsfVertexArray; cdecl;
  sfVertexArray_destroy: procedure(const vertexArray: PsfVertexArray); cdecl;
  sfVertexArray_getVertexCount: function(const vertexArray: PsfVertexArray): NativeUInt; cdecl;
  sfVertexArray_getVertex: function(vertexArray: PsfVertexArray; index: NativeUInt): PsfVertex; cdecl;
  sfVertexArray_clear: procedure(vertexArray: PsfVertexArray); cdecl;
  sfVertexArray_resize: procedure(vertexArray: PsfVertexArray; vertexCount: NativeUInt); cdecl;
  sfVertexArray_append: procedure(vertexArray: PsfVertexArray; vertex: sfVertex); cdecl;
  sfVertexArray_setPrimitiveType: procedure(vertexArray: PsfVertexArray; &type: sfPrimitiveType); cdecl;
  sfVertexArray_getPrimitiveType: function(vertexArray: PsfVertexArray): sfPrimitiveType; cdecl;
  sfVertexArray_getBounds: function(vertexArray: PsfVertexArray): sfFloatRect; cdecl;
  sfVertexBuffer_create: function(vertexCount: NativeUInt; &type: sfPrimitiveType; usage: sfVertexBufferUsage): PsfVertexBuffer; cdecl;
  sfVertexBuffer_copy: function(const vertexBuffer: PsfVertexBuffer): PsfVertexBuffer; cdecl;
  sfVertexBuffer_destroy: procedure(const vertexBuffer: PsfVertexBuffer); cdecl;
  sfVertexBuffer_getVertexCount: function(const vertexBuffer: PsfVertexBuffer): NativeUInt; cdecl;
  sfVertexBuffer_update: function(vertexBuffer: PsfVertexBuffer; const vertices: PsfVertex; vertexCount: Cardinal; offset: Cardinal): Boolean; cdecl;
  sfVertexBuffer_updateFromVertexBuffer: function(vertexBuffer: PsfVertexBuffer; const other: PsfVertexBuffer): Boolean; cdecl;
  sfVertexBuffer_swap: procedure(left: PsfVertexBuffer; right: PsfVertexBuffer); cdecl;
  sfVertexBuffer_getNativeHandle: function(vertexBuffer: PsfVertexBuffer): Cardinal; cdecl;
  sfVertexBuffer_setPrimitiveType: procedure(vertexBuffer: PsfVertexBuffer; &type: sfPrimitiveType); cdecl;
  sfVertexBuffer_getPrimitiveType: function(const vertexBuffer: PsfVertexBuffer): sfPrimitiveType; cdecl;
  sfVertexBuffer_setUsage: procedure(vertexBuffer: PsfVertexBuffer; usage: sfVertexBufferUsage); cdecl;
  sfVertexBuffer_getUsage: function(const vertexBuffer: PsfVertexBuffer): sfVertexBufferUsage; cdecl;
  sfVertexBuffer_bind: procedure(const vertexBuffer: PsfVertexBuffer); cdecl;
  sfVertexBuffer_isAvailable: function(): Boolean; cdecl;
  sfView_create: function(): PsfView; cdecl;
  sfView_createFromRect: function(rectangle: sfFloatRect): PsfView; cdecl;
  sfView_copy: function(const view: PsfView): PsfView; cdecl;
  sfView_destroy: procedure(const view: PsfView); cdecl;
  sfView_setCenter: procedure(view: PsfView; center: sfVector2f); cdecl;
  sfView_setSize: procedure(view: PsfView; size: sfVector2f); cdecl;
  sfView_setRotation: procedure(view: PsfView; angle: Single); cdecl;
  sfView_setViewport: procedure(view: PsfView; viewport: sfFloatRect); cdecl;
  sfView_setScissor: procedure(view: PsfView; scissor: sfFloatRect); cdecl;
  sfView_getCenter: function(const view: PsfView): sfVector2f; cdecl;
  sfView_getSize: function(const view: PsfView): sfVector2f; cdecl;
  sfView_getRotation: function(const view: PsfView): Single; cdecl;
  sfView_getViewport: function(const view: PsfView): sfFloatRect; cdecl;
  sfView_getScissor: function(const view: PsfView): sfFloatRect; cdecl;
  sfView_move: procedure(view: PsfView; offset: sfVector2f); cdecl;
  sfView_rotate: procedure(view: PsfView; angle: Single); cdecl;
  sfView_zoom: procedure(view: PsfView; factor: Single); cdecl;
  sfClipboard_getString: function(): PUTF8Char; cdecl;
  sfClipboard_getUnicodeString: function(): PsfChar32; cdecl;
  sfClipboard_setString: procedure(const text: PUTF8Char); cdecl;
  sfClipboard_setUnicodeString: procedure(const text: PsfChar32); cdecl;
  sfContext_create: function(): PsfContext; cdecl;
  sfContext_destroy: procedure(const context: PsfContext); cdecl;
  sfContext_isExtensionAvailable: function(const name: PUTF8Char): Boolean; cdecl;
  sfContext_setActive: function(context: PsfContext; active: Boolean): Boolean; cdecl;
  sfContext_getFunction: function(const name: PUTF8Char): sfGlFunctionPointer; cdecl;
  sfContext_getSettings: function(const context: PsfContext): sfContextSettings; cdecl;
  sfContext_getActiveContextId: function(): UInt64; cdecl;
  sfCursor_createFromPixels: function(const pixels: PUInt8; size: sfVector2u; hotspot: sfVector2u): PsfCursor; cdecl;
  sfCursor_createFromSystem: function(&type: sfCursorType): PsfCursor; cdecl;
  sfCursor_destroy: procedure(const cursor: PsfCursor); cdecl;
  sfTouch_isDown: function(finger: Cardinal): Boolean; cdecl;
  sfTouch_getPosition: function(finger: Cardinal; const relativeTo: PsfWindow): sfVector2i; cdecl;
  sfTouch_getPositionWindowBase: function(finger: Cardinal; const relativeTo: PsfWindowBase): sfVector2i; cdecl;
  sfIpAddress_fromString: function(const address: PUTF8Char): sfIpAddress; cdecl;
  sfIpAddress_fromBytes: function(byte0: UInt8; byte1: UInt8; byte2: UInt8; byte3: UInt8): sfIpAddress; cdecl;
  sfIpAddress_fromInteger: function(address: UInt32): sfIpAddress; cdecl;
  sfIpAddress_toString: procedure(address: sfIpAddress; &string: PUTF8Char); cdecl;
  sfIpAddress_toInteger: function(address: sfIpAddress): UInt32; cdecl;
  sfIpAddress_getLocalAddress: function(): sfIpAddress; cdecl;
  sfIpAddress_getPublicAddress: function(timeout: sfTime): sfIpAddress; cdecl;
  sfFtpListingResponse_destroy: procedure(const ftpListingResponse: PsfFtpListingResponse); cdecl;
  sfFtpListingResponse_isOk: function(const ftpListingResponse: PsfFtpListingResponse): Boolean; cdecl;
  sfFtpListingResponse_getStatus: function(const ftpListingResponse: PsfFtpListingResponse): sfFtpStatus; cdecl;
  sfFtpListingResponse_getMessage: function(const ftpListingResponse: PsfFtpListingResponse): PUTF8Char; cdecl;
  sfFtpListingResponse_getCount: function(const ftpListingResponse: PsfFtpListingResponse): NativeUInt; cdecl;
  sfFtpListingResponse_getName: function(const ftpListingResponse: PsfFtpListingResponse; index: NativeUInt): PUTF8Char; cdecl;
  sfFtpDirectoryResponse_destroy: procedure(const ftpDirectoryResponse: PsfFtpDirectoryResponse); cdecl;
  sfFtpDirectoryResponse_isOk: function(const ftpDirectoryResponse: PsfFtpDirectoryResponse): Boolean; cdecl;
  sfFtpDirectoryResponse_getStatus: function(const ftpDirectoryResponse: PsfFtpDirectoryResponse): sfFtpStatus; cdecl;
  sfFtpDirectoryResponse_getMessage: function(const ftpDirectoryResponse: PsfFtpDirectoryResponse): PUTF8Char; cdecl;
  sfFtpDirectoryResponse_getDirectory: function(const ftpDirectoryResponse: PsfFtpDirectoryResponse): PUTF8Char; cdecl;
  sfFtpDirectoryResponse_getDirectoryUnicode: function(const ftpDirectoryResponse: PsfFtpDirectoryResponse): PsfChar32; cdecl;
  sfFtpResponse_destroy: procedure(const ftpResponse: PsfFtpResponse); cdecl;
  sfFtpResponse_isOk: function(const ftpResponse: PsfFtpResponse): Boolean; cdecl;
  sfFtpResponse_getStatus: function(const ftpResponse: PsfFtpResponse): sfFtpStatus; cdecl;
  sfFtpResponse_getMessage: function(const ftpResponse: PsfFtpResponse): PUTF8Char; cdecl;
  sfFtp_create: function(): PsfFtp; cdecl;
  sfFtp_destroy: procedure(const ftp: PsfFtp); cdecl;
  sfFtp_connect: function(ftp: PsfFtp; server: sfIpAddress; port: Word; timeout: sfTime): PsfFtpResponse; cdecl;
  sfFtp_loginAnonymous: function(ftp: PsfFtp): PsfFtpResponse; cdecl;
  sfFtp_login: function(ftp: PsfFtp; const name: PUTF8Char; const password: PUTF8Char): PsfFtpResponse; cdecl;
  sfFtp_disconnect: function(ftp: PsfFtp): PsfFtpResponse; cdecl;
  sfFtp_keepAlive: function(ftp: PsfFtp): PsfFtpResponse; cdecl;
  sfFtp_getWorkingDirectory: function(ftp: PsfFtp): PsfFtpDirectoryResponse; cdecl;
  sfFtp_getDirectoryListing: function(ftp: PsfFtp; const directory: PUTF8Char): PsfFtpListingResponse; cdecl;
  sfFtp_changeDirectory: function(ftp: PsfFtp; const directory: PUTF8Char): PsfFtpResponse; cdecl;
  sfFtp_parentDirectory: function(ftp: PsfFtp): PsfFtpResponse; cdecl;
  sfFtp_createDirectory: function(ftp: PsfFtp; const name: PUTF8Char): PsfFtpResponse; cdecl;
  sfFtp_deleteDirectory: function(ftp: PsfFtp; const name: PUTF8Char): PsfFtpResponse; cdecl;
  sfFtp_renameFile: function(ftp: PsfFtp; const &file: PUTF8Char; const newName: PUTF8Char): PsfFtpResponse; cdecl;
  sfFtp_deleteFile: function(ftp: PsfFtp; const name: PUTF8Char): PsfFtpResponse; cdecl;
  sfFtp_download: function(ftp: PsfFtp; const remoteFile: PUTF8Char; const localPath: PUTF8Char; mode: sfFtpTransferMode): PsfFtpResponse; cdecl;
  sfFtp_upload: function(ftp: PsfFtp; const localFile: PUTF8Char; const remotePath: PUTF8Char; mode: sfFtpTransferMode; append: Boolean): PsfFtpResponse; cdecl;
  sfFtp_sendCommand: function(ftp: PsfFtp; const command: PUTF8Char; const parameter: PUTF8Char): PsfFtpResponse; cdecl;
  sfHttpRequest_create: function(): PsfHttpRequest; cdecl;
  sfHttpRequest_destroy: procedure(const httpRequest: PsfHttpRequest); cdecl;
  sfHttpRequest_setField: procedure(httpRequest: PsfHttpRequest; const field: PUTF8Char; const value: PUTF8Char); cdecl;
  sfHttpRequest_setMethod: procedure(httpRequest: PsfHttpRequest; method: sfHttpMethod); cdecl;
  sfHttpRequest_setUri: procedure(httpRequest: PsfHttpRequest; const uri: PUTF8Char); cdecl;
  sfHttpRequest_setHttpVersion: procedure(httpRequest: PsfHttpRequest; major: Cardinal; minor: Cardinal); cdecl;
  sfHttpRequest_setBody: procedure(httpRequest: PsfHttpRequest; const body: PUTF8Char); cdecl;
  sfHttpResponse_destroy: procedure(const httpResponse: PsfHttpResponse); cdecl;
  sfHttpResponse_getField: function(const httpResponse: PsfHttpResponse; const field: PUTF8Char): PUTF8Char; cdecl;
  sfHttpResponse_getStatus: function(const httpResponse: PsfHttpResponse): sfHttpStatus; cdecl;
  sfHttpResponse_getMajorVersion: function(const httpResponse: PsfHttpResponse): Cardinal; cdecl;
  sfHttpResponse_getMinorVersion: function(const httpResponse: PsfHttpResponse): Cardinal; cdecl;
  sfHttpResponse_getBody: function(const httpResponse: PsfHttpResponse): PUTF8Char; cdecl;
  sfHttp_create: function(): PsfHttp; cdecl;
  sfHttp_destroy: procedure(const http: PsfHttp); cdecl;
  sfHttp_setHost: procedure(http: PsfHttp; const host: PUTF8Char; port: Word); cdecl;
  sfHttp_sendRequest: function(http: PsfHttp; const request: PsfHttpRequest; timeout: sfTime): PsfHttpResponse; cdecl;
  sfPacket_create: function(): PsfPacket; cdecl;
  sfPacket_copy: function(const packet: PsfPacket): PsfPacket; cdecl;
  sfPacket_destroy: procedure(const packet: PsfPacket); cdecl;
  sfPacket_append: procedure(packet: PsfPacket; const data: Pointer; sizeInBytes: NativeUInt); cdecl;
  sfPacket_getReadPosition: function(const packet: PsfPacket): NativeUInt; cdecl;
  sfPacket_clear: procedure(packet: PsfPacket); cdecl;
  sfPacket_getData: function(const packet: PsfPacket): Pointer; cdecl;
  sfPacket_getDataSize: function(const packet: PsfPacket): NativeUInt; cdecl;
  sfPacket_endOfPacket: function(const packet: PsfPacket): Boolean; cdecl;
  sfPacket_canRead: function(const packet: PsfPacket): Boolean; cdecl;
  sfPacket_readBool: function(packet: PsfPacket): Boolean; cdecl;
  sfPacket_readInt8: function(packet: PsfPacket): Int8; cdecl;
  sfPacket_readUint8: function(packet: PsfPacket): UInt8; cdecl;
  sfPacket_readInt16: function(packet: PsfPacket): Int16; cdecl;
  sfPacket_readUint16: function(packet: PsfPacket): UInt16; cdecl;
  sfPacket_readInt32: function(packet: PsfPacket): Int32; cdecl;
  sfPacket_readUint32: function(packet: PsfPacket): UInt32; cdecl;
  sfPacket_readFloat: function(packet: PsfPacket): Single; cdecl;
  sfPacket_readDouble: function(packet: PsfPacket): Double; cdecl;
  sfPacket_readString: procedure(packet: PsfPacket; &string: PUTF8Char); cdecl;
  sfPacket_readWideString: procedure(packet: PsfPacket; &string: PWideChar); cdecl;
  sfPacket_writeBool: procedure(packet: PsfPacket; p2: Boolean); cdecl;
  sfPacket_writeInt8: procedure(packet: PsfPacket; p2: Int8); cdecl;
  sfPacket_writeUint8: procedure(packet: PsfPacket; p2: UInt8); cdecl;
  sfPacket_writeInt16: procedure(packet: PsfPacket; p2: Int16); cdecl;
  sfPacket_writeUint16: procedure(packet: PsfPacket; p2: UInt16); cdecl;
  sfPacket_writeInt32: procedure(packet: PsfPacket; p2: Int32); cdecl;
  sfPacket_writeUint32: procedure(packet: PsfPacket; p2: UInt32); cdecl;
  sfPacket_writeFloat: procedure(packet: PsfPacket; p2: Single); cdecl;
  sfPacket_writeDouble: procedure(packet: PsfPacket; p2: Double); cdecl;
  sfPacket_writeString: procedure(packet: PsfPacket; const &string: PUTF8Char); cdecl;
  sfPacket_writeWideString: procedure(packet: PsfPacket; const &string: PWideChar); cdecl;
  sfSocketSelector_create: function(): PsfSocketSelector; cdecl;
  sfSocketSelector_copy: function(const selector: PsfSocketSelector): PsfSocketSelector; cdecl;
  sfSocketSelector_destroy: procedure(const selector: PsfSocketSelector); cdecl;
  sfSocketSelector_addTcpListener: procedure(selector: PsfSocketSelector; socket: PsfTcpListener); cdecl;
  sfSocketSelector_addTcpSocket: procedure(selector: PsfSocketSelector; socket: PsfTcpSocket); cdecl;
  sfSocketSelector_addUdpSocket: procedure(selector: PsfSocketSelector; socket: PsfUdpSocket); cdecl;
  sfSocketSelector_removeTcpListener: procedure(selector: PsfSocketSelector; socket: PsfTcpListener); cdecl;
  sfSocketSelector_removeTcpSocket: procedure(selector: PsfSocketSelector; socket: PsfTcpSocket); cdecl;
  sfSocketSelector_removeUdpSocket: procedure(selector: PsfSocketSelector; socket: PsfUdpSocket); cdecl;
  sfSocketSelector_clear: procedure(selector: PsfSocketSelector); cdecl;
  sfSocketSelector_wait: function(selector: PsfSocketSelector; timeout: sfTime): Boolean; cdecl;
  sfSocketSelector_isTcpListenerReady: function(const selector: PsfSocketSelector; socket: PsfTcpListener): Boolean; cdecl;
  sfSocketSelector_isTcpSocketReady: function(const selector: PsfSocketSelector; socket: PsfTcpSocket): Boolean; cdecl;
  sfSocketSelector_isUdpSocketReady: function(const selector: PsfSocketSelector; socket: PsfUdpSocket): Boolean; cdecl;
  sfTcpListener_create: function(): PsfTcpListener; cdecl;
  sfTcpListener_destroy: procedure(const listener: PsfTcpListener); cdecl;
  sfTcpListener_setBlocking: procedure(listener: PsfTcpListener; blocking: Boolean); cdecl;
  sfTcpListener_isBlocking: function(const listener: PsfTcpListener): Boolean; cdecl;
  sfTcpListener_getLocalPort: function(const listener: PsfTcpListener): Word; cdecl;
  sfTcpListener_listen: function(listener: PsfTcpListener; port: Word; address: sfIpAddress): sfSocketStatus; cdecl;
  sfTcpListener_accept: function(listener: PsfTcpListener; connected: PPsfTcpSocket): sfSocketStatus; cdecl;
  sfTcpSocket_create: function(): PsfTcpSocket; cdecl;
  sfTcpSocket_destroy: procedure(const socket: PsfTcpSocket); cdecl;
  sfTcpSocket_setBlocking: procedure(socket: PsfTcpSocket; blocking: Boolean); cdecl;
  sfTcpSocket_isBlocking: function(const socket: PsfTcpSocket): Boolean; cdecl;
  sfTcpSocket_getLocalPort: function(const socket: PsfTcpSocket): Word; cdecl;
  sfTcpSocket_getRemoteAddress: function(const socket: PsfTcpSocket): sfIpAddress; cdecl;
  sfTcpSocket_getRemotePort: function(const socket: PsfTcpSocket): Word; cdecl;
  sfTcpSocket_connect: function(socket: PsfTcpSocket; remoteAddress: sfIpAddress; remotePort: Word; timeout: sfTime): sfSocketStatus; cdecl;
  sfTcpSocket_disconnect: procedure(socket: PsfTcpSocket); cdecl;
  sfTcpSocket_send: function(socket: PsfTcpSocket; const data: Pointer; size: NativeUInt): sfSocketStatus; cdecl;
  sfTcpSocket_sendPartial: function(socket: PsfTcpSocket; const data: Pointer; size: NativeUInt; sent: PNativeUInt): sfSocketStatus; cdecl;
  sfTcpSocket_receive: function(socket: PsfTcpSocket; data: Pointer; size: NativeUInt; received: PNativeUInt): sfSocketStatus; cdecl;
  sfTcpSocket_sendPacket: function(socket: PsfTcpSocket; packet: PsfPacket): sfSocketStatus; cdecl;
  sfTcpSocket_receivePacket: function(socket: PsfTcpSocket; packet: PsfPacket): sfSocketStatus; cdecl;
  sfUdpSocket_create: function(): PsfUdpSocket; cdecl;
  sfUdpSocket_destroy: procedure(const socket: PsfUdpSocket); cdecl;
  sfUdpSocket_setBlocking: procedure(socket: PsfUdpSocket; blocking: Boolean); cdecl;
  sfUdpSocket_isBlocking: function(const socket: PsfUdpSocket): Boolean; cdecl;
  sfUdpSocket_getLocalPort: function(const socket: PsfUdpSocket): Word; cdecl;
  sfUdpSocket_bind: function(socket: PsfUdpSocket; port: Word; address: sfIpAddress): sfSocketStatus; cdecl;
  sfUdpSocket_unbind: procedure(socket: PsfUdpSocket); cdecl;
  sfUdpSocket_send: function(socket: PsfUdpSocket; const data: Pointer; size: NativeUInt; remoteAddress: sfIpAddress; remotePort: Word): sfSocketStatus; cdecl;
  sfUdpSocket_receive: function(socket: PsfUdpSocket; data: Pointer; size: NativeUInt; received: PNativeUInt; remoteAddress: PsfIpAddress; remotePort: PWord): sfSocketStatus; cdecl;
  sfUdpSocket_sendPacket: function(socket: PsfUdpSocket; packet: PsfPacket; remoteAddress: sfIpAddress; remotePort: Word): sfSocketStatus; cdecl;
  sfUdpSocket_receivePacket: function(socket: PsfUdpSocket; packet: PsfPacket; remoteAddress: PsfIpAddress; remotePort: PWord): sfSocketStatus; cdecl;
  sfUdpSocket_maxDatagramSize: function(): Cardinal; cdecl;
  crc32: function(crc: uLong; const buf: PBytef; len: uInt): uLong; cdecl;
  unzOpen64: function(const path: Pointer): unzFile; cdecl;
  unzLocateFile: function(&file: unzFile; const szFileName: PUTF8Char; iCaseSensitivity: Integer): Integer; cdecl;
  unzClose: function(&file: unzFile): Integer; cdecl;
  unzOpenCurrentFilePassword: function(&file: unzFile; const password: PUTF8Char): Integer; cdecl;
  unzGetCurrentFileInfo64: function(&file: unzFile; pfile_info: Punz_file_info64; szFileName: PUTF8Char; fileNameBufferSize: uLong; extraField: Pointer; extraFieldBufferSize: uLong; szComment: PUTF8Char; commentBufferSize: uLong): Integer; cdecl;
  unzReadCurrentFile: function(&file: unzFile; buf: voidp; len: Cardinal): Integer; cdecl;
  unzCloseCurrentFile: function(&file: unzFile): Integer; cdecl;
  unztell64: function(&file: unzFile): UInt64; cdecl;
  zipOpen64: function(const pathname: Pointer; append: Integer): zipFile; cdecl;
  zipOpenNewFileInZip3_64: function(&file: zipFile; const filename: PUTF8Char; const zipfi: Pzip_fileinfo; const extrafield_local: Pointer; size_extrafield_local: uInt; const extrafield_global: Pointer; size_extrafield_global: uInt; const comment: PUTF8Char; method: Integer; level: Integer; raw: Integer; windowBits: Integer; memLevel: Integer; strategy: Integer; const password: PUTF8Char; crcForCrypting: uLong; zip64: Integer): Integer; cdecl;
  zipWriteInFileInZip: function(&file: zipFile; const buf: Pointer; len: Cardinal): Integer; cdecl;
  zipCloseFileInZip: function(&file: zipFile): Integer; cdecl;
  zipClose: function(&file: zipFile; const global_comment: PUTF8Char): Integer; cdecl;
  plm_create_with_filename: function(const filename: PUTF8Char): Pplm_t; cdecl;
  plm_create_with_file: function(fh: PPointer; close_when_done: Integer): Pplm_t; cdecl;
  plm_create_with_memory: function(bytes: PUInt8; length: NativeUInt; free_when_done: Integer): Pplm_t; cdecl;
  plm_create_with_buffer: function(buffer: Pplm_buffer_t; destroy_when_done: Integer): Pplm_t; cdecl;
  plm_destroy: procedure(self: Pplm_t); cdecl;
  plm_has_headers: function(self: Pplm_t): Integer; cdecl;
  plm_probe: function(self: Pplm_t; probesize: NativeUInt): Integer; cdecl;
  plm_get_video_enabled: function(self: Pplm_t): Integer; cdecl;
  plm_set_video_enabled: procedure(self: Pplm_t; enabled: Integer); cdecl;
  plm_get_num_video_streams: function(self: Pplm_t): Integer; cdecl;
  plm_get_width: function(self: Pplm_t): Integer; cdecl;
  plm_get_height: function(self: Pplm_t): Integer; cdecl;
  plm_get_pixel_aspect_ratio: function(self: Pplm_t): Double; cdecl;
  plm_get_framerate: function(self: Pplm_t): Double; cdecl;
  plm_get_audio_enabled: function(self: Pplm_t): Integer; cdecl;
  plm_set_audio_enabled: procedure(self: Pplm_t; enabled: Integer); cdecl;
  plm_get_num_audio_streams: function(self: Pplm_t): Integer; cdecl;
  plm_set_audio_stream: procedure(self: Pplm_t; stream_index: Integer); cdecl;
  plm_get_samplerate: function(self: Pplm_t): Integer; cdecl;
  plm_get_audio_lead_time: function(self: Pplm_t): Double; cdecl;
  plm_set_audio_lead_time: procedure(self: Pplm_t; lead_time: Double); cdecl;
  plm_get_time: function(self: Pplm_t): Double; cdecl;
  plm_get_duration: function(self: Pplm_t): Double; cdecl;
  plm_rewind: procedure(self: Pplm_t); cdecl;
  plm_get_loop: function(self: Pplm_t): Integer; cdecl;
  plm_set_loop: procedure(self: Pplm_t; loop: Integer); cdecl;
  plm_has_ended: function(self: Pplm_t): Integer; cdecl;
  plm_set_video_decode_callback: procedure(self: Pplm_t; fp: plm_video_decode_callback; user: Pointer); cdecl;
  plm_set_audio_decode_callback: procedure(self: Pplm_t; fp: plm_audio_decode_callback; user: Pointer); cdecl;
  plm_decode: procedure(self: Pplm_t; seconds: Double); cdecl;
  plm_decode_video: function(self: Pplm_t): Pplm_frame_t; cdecl;
  plm_decode_audio: function(self: Pplm_t): Pplm_samples_t; cdecl;
  plm_seek: function(self: Pplm_t; time: Double; seek_exact: Integer): Integer; cdecl;
  plm_seek_frame: function(self: Pplm_t; time: Double; seek_exact: Integer): Pplm_frame_t; cdecl;
  plm_buffer_create_with_filename: function(const filename: PUTF8Char): Pplm_buffer_t; cdecl;
  plm_buffer_create_with_file: function(fh: PPointer; close_when_done: Integer): Pplm_buffer_t; cdecl;
  plm_buffer_create_with_memory: function(bytes: PUInt8; length: NativeUInt; free_when_done: Integer): Pplm_buffer_t; cdecl;
  plm_buffer_create_with_capacity: function(capacity: NativeUInt): Pplm_buffer_t; cdecl;
  plm_buffer_create_for_appending: function(initial_capacity: NativeUInt): Pplm_buffer_t; cdecl;
  plm_buffer_destroy: procedure(self: Pplm_buffer_t); cdecl;
  plm_buffer_write: function(self: Pplm_buffer_t; bytes: PUInt8; length: NativeUInt): NativeUInt; cdecl;
  plm_buffer_signal_end: procedure(self: Pplm_buffer_t); cdecl;
  plm_buffer_set_load_callback: procedure(self: Pplm_buffer_t; fp: plm_buffer_load_callback; user: Pointer); cdecl;
  plm_buffer_rewind: procedure(self: Pplm_buffer_t); cdecl;
  plm_buffer_get_size: function(self: Pplm_buffer_t): NativeUInt; cdecl;
  plm_buffer_get_remaining: function(self: Pplm_buffer_t): NativeUInt; cdecl;
  plm_buffer_has_ended: function(self: Pplm_buffer_t): Integer; cdecl;
  plm_demux_create: function(buffer: Pplm_buffer_t; destroy_when_done: Integer): Pplm_demux_t; cdecl;
  plm_demux_destroy: procedure(self: Pplm_demux_t); cdecl;
  plm_demux_has_headers: function(self: Pplm_demux_t): Integer; cdecl;
  plm_demux_probe: function(self: Pplm_demux_t; probesize: NativeUInt): Integer; cdecl;
  plm_demux_get_num_video_streams: function(self: Pplm_demux_t): Integer; cdecl;
  plm_demux_get_num_audio_streams: function(self: Pplm_demux_t): Integer; cdecl;
  plm_demux_rewind: procedure(self: Pplm_demux_t); cdecl;
  plm_demux_has_ended: function(self: Pplm_demux_t): Integer; cdecl;
  plm_demux_seek: function(self: Pplm_demux_t; time: Double; &type: Integer; force_intra: Integer): Pplm_packet_t; cdecl;
  plm_demux_get_start_time: function(self: Pplm_demux_t; &type: Integer): Double; cdecl;
  plm_demux_get_duration: function(self: Pplm_demux_t; &type: Integer): Double; cdecl;
  plm_demux_decode: function(self: Pplm_demux_t): Pplm_packet_t; cdecl;
  plm_video_create_with_buffer: function(buffer: Pplm_buffer_t; destroy_when_done: Integer): Pplm_video_t; cdecl;
  plm_video_destroy: procedure(self: Pplm_video_t); cdecl;
  plm_video_has_header: function(self: Pplm_video_t): Integer; cdecl;
  plm_video_get_framerate: function(self: Pplm_video_t): Double; cdecl;
  plm_video_get_pixel_aspect_ratio: function(self: Pplm_video_t): Double; cdecl;
  plm_video_get_width: function(self: Pplm_video_t): Integer; cdecl;
  plm_video_get_height: function(self: Pplm_video_t): Integer; cdecl;
  plm_video_set_no_delay: procedure(self: Pplm_video_t; no_delay: Integer); cdecl;
  plm_video_get_time: function(self: Pplm_video_t): Double; cdecl;
  plm_video_set_time: procedure(self: Pplm_video_t; time: Double); cdecl;
  plm_video_rewind: procedure(self: Pplm_video_t); cdecl;
  plm_video_has_ended: function(self: Pplm_video_t): Integer; cdecl;
  plm_video_decode: function(self: Pplm_video_t): Pplm_frame_t; cdecl;
  plm_frame_to_rgb: procedure(frame: Pplm_frame_t; dest: PUInt8; stride: Integer); cdecl;
  plm_frame_to_bgr: procedure(frame: Pplm_frame_t; dest: PUInt8; stride: Integer); cdecl;
  plm_frame_to_rgba: procedure(frame: Pplm_frame_t; dest: PUInt8; stride: Integer); cdecl;
  plm_frame_to_bgra: procedure(frame: Pplm_frame_t; dest: PUInt8; stride: Integer); cdecl;
  plm_frame_to_argb: procedure(frame: Pplm_frame_t; dest: PUInt8; stride: Integer); cdecl;
  plm_frame_to_abgr: procedure(frame: Pplm_frame_t; dest: PUInt8; stride: Integer); cdecl;
  plm_audio_create_with_buffer: function(buffer: Pplm_buffer_t; destroy_when_done: Integer): Pplm_audio_t; cdecl;
  plm_audio_destroy: procedure(self: Pplm_audio_t); cdecl;
  plm_audio_has_header: function(self: Pplm_audio_t): Integer; cdecl;
  plm_audio_get_samplerate: function(self: Pplm_audio_t): Integer; cdecl;
  plm_audio_get_time: function(self: Pplm_audio_t): Double; cdecl;
  plm_audio_set_time: procedure(self: Pplm_audio_t; time: Double); cdecl;
  plm_audio_rewind: procedure(self: Pplm_audio_t); cdecl;
  plm_audio_has_ended: function(self: Pplm_audio_t): Integer; cdecl;
  plm_audio_decode: function(self: Pplm_audio_t): Pplm_samples_t; cdecl;
  lua_newstate: function(f: lua_Alloc; ud: Pointer): Plua_State; cdecl;
  lua_close: procedure(L: Plua_State); cdecl;
  lua_newthread: function(L: Plua_State): Plua_State; cdecl;
  lua_atpanic: function(L: Plua_State; panicf: lua_CFunction): lua_CFunction; cdecl;
  lua_gettop: function(L: Plua_State): Integer; cdecl;
  lua_settop: procedure(L: Plua_State; idx: Integer); cdecl;
  lua_pushvalue: procedure(L: Plua_State; idx: Integer); cdecl;
  lua_remove: procedure(L: Plua_State; idx: Integer); cdecl;
  lua_insert: procedure(L: Plua_State; idx: Integer); cdecl;
  lua_replace: procedure(L: Plua_State; idx: Integer); cdecl;
  lua_checkstack: function(L: Plua_State; sz: Integer): Integer; cdecl;
  lua_xmove: procedure(from: Plua_State; &to: Plua_State; n: Integer); cdecl;
  lua_isnumber: function(L: Plua_State; idx: Integer): Integer; cdecl;
  lua_isstring: function(L: Plua_State; idx: Integer): Integer; cdecl;
  lua_iscfunction: function(L: Plua_State; idx: Integer): Integer; cdecl;
  lua_isuserdata: function(L: Plua_State; idx: Integer): Integer; cdecl;
  lua_type: function(L: Plua_State; idx: Integer): Integer; cdecl;
  lua_typename: function(L: Plua_State; tp: Integer): PUTF8Char; cdecl;
  lua_equal: function(L: Plua_State; idx1: Integer; idx2: Integer): Integer; cdecl;
  lua_rawequal: function(L: Plua_State; idx1: Integer; idx2: Integer): Integer; cdecl;
  lua_lessthan: function(L: Plua_State; idx1: Integer; idx2: Integer): Integer; cdecl;
  lua_tonumber: function(L: Plua_State; idx: Integer): lua_Number; cdecl;
  lua_tointeger: function(L: Plua_State; idx: Integer): lua_Integer; cdecl;
  lua_toboolean: function(L: Plua_State; idx: Integer): Integer; cdecl;
  lua_tolstring: function(L: Plua_State; idx: Integer; len: PNativeUInt): PUTF8Char; cdecl;
  lua_objlen: function(L: Plua_State; idx: Integer): NativeUInt; cdecl;
  lua_tocfunction: function(L: Plua_State; idx: Integer): lua_CFunction; cdecl;
  lua_touserdata: function(L: Plua_State; idx: Integer): Pointer; cdecl;
  lua_tothread: function(L: Plua_State; idx: Integer): Plua_State; cdecl;
  lua_topointer: function(L: Plua_State; idx: Integer): Pointer; cdecl;
  lua_pushnil: procedure(L: Plua_State); cdecl;
  lua_pushnumber: procedure(L: Plua_State; n: lua_Number); cdecl;
  lua_pushinteger: procedure(L: Plua_State; n: lua_Integer); cdecl;
  lua_pushlstring: procedure(L: Plua_State; const s: PUTF8Char; l_: NativeUInt); cdecl;
  lua_pushstring: procedure(L: Plua_State; const s: PUTF8Char); cdecl;
  lua_pushvfstring: function(L: Plua_State; const fmt: PUTF8Char; argp: Pointer): PUTF8Char; cdecl;
  lua_pushfstring: function(L: Plua_State; const fmt: PUTF8Char): PUTF8Char varargs; cdecl;
  lua_pushcclosure: procedure(L: Plua_State; fn: lua_CFunction; n: Integer); cdecl;
  lua_pushboolean: procedure(L: Plua_State; b: Integer); cdecl;
  lua_pushlightuserdata: procedure(L: Plua_State; p: Pointer); cdecl;
  lua_pushthread: function(L: Plua_State): Integer; cdecl;
  lua_gettable: procedure(L: Plua_State; idx: Integer); cdecl;
  lua_getfield: procedure(L: Plua_State; idx: Integer; const k: PUTF8Char); cdecl;
  lua_rawget: procedure(L: Plua_State; idx: Integer); cdecl;
  lua_rawgeti: procedure(L: Plua_State; idx: Integer; n: Integer); cdecl;
  lua_createtable: procedure(L: Plua_State; narr: Integer; nrec: Integer); cdecl;
  lua_newuserdata: function(L: Plua_State; sz: NativeUInt): Pointer; cdecl;
  lua_getmetatable: function(L: Plua_State; objindex: Integer): Integer; cdecl;
  lua_getfenv: procedure(L: Plua_State; idx: Integer); cdecl;
  lua_settable: procedure(L: Plua_State; idx: Integer); cdecl;
  lua_setfield: procedure(L: Plua_State; idx: Integer; const k: PUTF8Char); cdecl;
  lua_rawset: procedure(L: Plua_State; idx: Integer); cdecl;
  lua_rawseti: procedure(L: Plua_State; idx: Integer; n: Integer); cdecl;
  lua_setmetatable: function(L: Plua_State; objindex: Integer): Integer; cdecl;
  lua_setfenv: function(L: Plua_State; idx: Integer): Integer; cdecl;
  lua_call: procedure(L: Plua_State; nargs: Integer; nresults: Integer); cdecl;
  lua_pcall: function(L: Plua_State; nargs: Integer; nresults: Integer; errfunc: Integer): Integer; cdecl;
  lua_cpcall: function(L: Plua_State; func: lua_CFunction; ud: Pointer): Integer; cdecl;
  lua_load: function(L: Plua_State; reader: lua_Reader; dt: Pointer; const chunkname: PUTF8Char): Integer; cdecl;
  lua_dump: function(L: Plua_State; writer: lua_Writer; data: Pointer): Integer; cdecl;
  lua_yield: function(L: Plua_State; nresults: Integer): Integer; cdecl;
  lua_resume: function(L: Plua_State; narg: Integer): Integer; cdecl;
  lua_status: function(L: Plua_State): Integer; cdecl;
  lua_gc: function(L: Plua_State; what: Integer; data: Integer): Integer; cdecl;
  lua_error: function(L: Plua_State): Integer; cdecl;
  lua_next: function(L: Plua_State; idx: Integer): Integer; cdecl;
  lua_concat: procedure(L: Plua_State; n: Integer); cdecl;
  lua_getallocf: function(L: Plua_State; ud: PPointer): lua_Alloc; cdecl;
  lua_setallocf: procedure(L: Plua_State; f: lua_Alloc; ud: Pointer); cdecl;
  lua_getstack: function(L: Plua_State; level: Integer; ar: Plua_Debug): Integer; cdecl;
  lua_getinfo: function(L: Plua_State; const what: PUTF8Char; ar: Plua_Debug): Integer; cdecl;
  lua_getlocal: function(L: Plua_State; const ar: Plua_Debug; n: Integer): PUTF8Char; cdecl;
  lua_setlocal: function(L: Plua_State; const ar: Plua_Debug; n: Integer): PUTF8Char; cdecl;
  lua_getupvalue: function(L: Plua_State; funcindex: Integer; n: Integer): PUTF8Char; cdecl;
  lua_setupvalue: function(L: Plua_State; funcindex: Integer; n: Integer): PUTF8Char; cdecl;
  lua_sethook: function(L: Plua_State; func: lua_Hook; mask: Integer; count: Integer): Integer; cdecl;
  lua_gethook: function(L: Plua_State): lua_Hook; cdecl;
  lua_gethookmask: function(L: Plua_State): Integer; cdecl;
  lua_gethookcount: function(L: Plua_State): Integer; cdecl;
  lua_upvalueid: function(L: Plua_State; idx: Integer; n: Integer): Pointer; cdecl;
  lua_upvaluejoin: procedure(L: Plua_State; idx1: Integer; n1: Integer; idx2: Integer; n2: Integer); cdecl;
  lua_loadx: function(L: Plua_State; reader: lua_Reader; dt: Pointer; const chunkname: PUTF8Char; const mode: PUTF8Char): Integer; cdecl;
  lua_version: function(L: Plua_State): Plua_Number; cdecl;
  lua_copy: procedure(L: Plua_State; fromidx: Integer; toidx: Integer); cdecl;
  lua_tonumberx: function(L: Plua_State; idx: Integer; isnum: PInteger): lua_Number; cdecl;
  lua_tointegerx: function(L: Plua_State; idx: Integer; isnum: PInteger): lua_Integer; cdecl;
  lua_isyieldable: function(L: Plua_State): Integer; cdecl;
  luaopen_base: function(L: Plua_State): Integer; cdecl;
  luaopen_math: function(L: Plua_State): Integer; cdecl;
  luaopen_string: function(L: Plua_State): Integer; cdecl;
  luaopen_table: function(L: Plua_State): Integer; cdecl;
  luaopen_io: function(L: Plua_State): Integer; cdecl;
  luaopen_os: function(L: Plua_State): Integer; cdecl;
  luaopen_package: function(L: Plua_State): Integer; cdecl;
  luaopen_debug: function(L: Plua_State): Integer; cdecl;
  luaopen_bit: function(L: Plua_State): Integer; cdecl;
  luaopen_jit: function(L: Plua_State): Integer; cdecl;
  luaopen_ffi: function(L: Plua_State): Integer; cdecl;
  luaopen_string_buffer: function(L: Plua_State): Integer; cdecl;
  luaL_openlibs: procedure(L: Plua_State); cdecl;
  luaL_openlib: procedure(L: Plua_State; const libname: PUTF8Char; const l_: PluaL_Reg; nup: Integer); cdecl;
  luaL_register: procedure(L: Plua_State; const libname: PUTF8Char; const l_: PluaL_Reg); cdecl;
  luaL_getmetafield: function(L: Plua_State; obj: Integer; const e: PUTF8Char): Integer; cdecl;
  luaL_callmeta: function(L: Plua_State; obj: Integer; const e: PUTF8Char): Integer; cdecl;
  luaL_typerror: function(L: Plua_State; narg: Integer; const tname: PUTF8Char): Integer; cdecl;
  luaL_argerror: function(L: Plua_State; numarg: Integer; const extramsg: PUTF8Char): Integer; cdecl;
  luaL_checklstring: function(L: Plua_State; numArg: Integer; l_: PNativeUInt): PUTF8Char; cdecl;
  luaL_optlstring: function(L: Plua_State; numArg: Integer; const def: PUTF8Char; l_: PNativeUInt): PUTF8Char; cdecl;
  luaL_checknumber: function(L: Plua_State; numArg: Integer): lua_Number; cdecl;
  luaL_optnumber: function(L: Plua_State; nArg: Integer; def: lua_Number): lua_Number; cdecl;
  luaL_checkinteger: function(L: Plua_State; numArg: Integer): lua_Integer; cdecl;
  luaL_optinteger: function(L: Plua_State; nArg: Integer; def: lua_Integer): lua_Integer; cdecl;
  luaL_checkstack: procedure(L: Plua_State; sz: Integer; const msg: PUTF8Char); cdecl;
  luaL_checktype: procedure(L: Plua_State; narg: Integer; t: Integer); cdecl;
  luaL_checkany: procedure(L: Plua_State; narg: Integer); cdecl;
  luaL_newmetatable: function(L: Plua_State; const tname: PUTF8Char): Integer; cdecl;
  luaL_checkudata: function(L: Plua_State; ud: Integer; const tname: PUTF8Char): Pointer; cdecl;
  luaL_where: procedure(L: Plua_State; lvl: Integer); cdecl;
  luaL_error: function(L: Plua_State; const fmt: PUTF8Char): Integer varargs; cdecl;
  luaL_checkoption: function(L: Plua_State; narg: Integer; const def: PUTF8Char; lst: PPUTF8Char): Integer; cdecl;
  luaL_ref: function(L: Plua_State; t: Integer): Integer; cdecl;
  luaL_unref: procedure(L: Plua_State; t: Integer; ref: Integer); cdecl;
  luaL_loadfile: function(L: Plua_State; const filename: PUTF8Char): Integer; cdecl;
  luaL_loadbuffer: function(L: Plua_State; const buff: PUTF8Char; sz: NativeUInt; const name: PUTF8Char): Integer; cdecl;
  luaL_loadstring: function(L: Plua_State; const s: PUTF8Char): Integer; cdecl;
  luaL_newstate: function(): Plua_State; cdecl;
  luaL_gsub: function(L: Plua_State; const s: PUTF8Char; const p: PUTF8Char; const r: PUTF8Char): PUTF8Char; cdecl;
  luaL_findtable: function(L: Plua_State; idx: Integer; const fname: PUTF8Char; szhint: Integer): PUTF8Char; cdecl;
  luaL_fileresult: function(L: Plua_State; stat: Integer; const fname: PUTF8Char): Integer; cdecl;
  luaL_execresult: function(L: Plua_State; stat: Integer): Integer; cdecl;
  luaL_loadfilex: function(L: Plua_State; const filename: PUTF8Char; const mode: PUTF8Char): Integer; cdecl;
  luaL_loadbufferx: function(L: Plua_State; const buff: PUTF8Char; sz: NativeUInt; const name: PUTF8Char; const mode: PUTF8Char): Integer; cdecl;
  luaL_traceback: procedure(L: Plua_State; L1: Plua_State; const msg: PUTF8Char; level: Integer); cdecl;
  luaL_setfuncs: procedure(L: Plua_State; const l_: PluaL_Reg; nup: Integer); cdecl;
  luaL_pushmodule: procedure(L: Plua_State; const modname: PUTF8Char; sizehint: Integer); cdecl;
  luaL_testudata: function(L: Plua_State; ud: Integer; const tname: PUTF8Char): Pointer; cdecl;
  luaL_setmetatable: procedure(L: Plua_State; const tname: PUTF8Char); cdecl;
  luaL_buffinit: procedure(L: Plua_State; B: PluaL_Buffer); cdecl;
  luaL_prepbuffer: function(B: PluaL_Buffer): PUTF8Char; cdecl;
  luaL_addlstring: procedure(B: PluaL_Buffer; const s: PUTF8Char; l: NativeUInt); cdecl;
  luaL_addstring: procedure(B: PluaL_Buffer; const s: PUTF8Char); cdecl;
  luaL_addvalue: procedure(B: PluaL_Buffer); cdecl;
  luaL_pushresult: procedure(B: PluaL_Buffer); cdecl;
  luaJIT_setmode: function(L: Plua_State; idx: Integer; mode: Integer): Integer; cdecl;
  luaJIT_profile_start: procedure(L: Plua_State; const mode: PUTF8Char; cb: luaJIT_profile_callback; data: Pointer); cdecl;
  luaJIT_profile_stop: procedure(L: Plua_State); cdecl;
  luaJIT_profile_dumpstack: function(L: Plua_State; const fmt: PUTF8Char; depth: Integer; len: PNativeUInt): PUTF8Char; cdecl;
  luaJIT_version_2_1_1734355927: procedure(); cdecl;
  spFloatArray_create: function(initialCapacity: Integer): PspFloatArray; cdecl;
  spFloatArray_dispose: procedure(self: PspFloatArray); cdecl;
  spFloatArray_clear: procedure(self: PspFloatArray); cdecl;
  spFloatArray_setSize: function(self: PspFloatArray; newSize: Integer): PspFloatArray; cdecl;
  spFloatArray_ensureCapacity: procedure(self: PspFloatArray; newCapacity: Integer); cdecl;
  spFloatArray_add: procedure(self: PspFloatArray; value: Single); cdecl;
  spFloatArray_addAll: procedure(self: PspFloatArray; other: PspFloatArray); cdecl;
  spFloatArray_addAllValues: procedure(self: PspFloatArray; values: PSingle; offset: Integer; count: Integer); cdecl;
  spFloatArray_removeAt: procedure(self: PspFloatArray; index: Integer); cdecl;
  spFloatArray_contains: function(self: PspFloatArray; value: Single): Integer; cdecl;
  spFloatArray_pop: function(self: PspFloatArray): Single; cdecl;
  spFloatArray_peek: function(self: PspFloatArray): Single; cdecl;
  spIntArray_create: function(initialCapacity: Integer): PspIntArray; cdecl;
  spIntArray_dispose: procedure(self: PspIntArray); cdecl;
  spIntArray_clear: procedure(self: PspIntArray); cdecl;
  spIntArray_setSize: function(self: PspIntArray; newSize: Integer): PspIntArray; cdecl;
  spIntArray_ensureCapacity: procedure(self: PspIntArray; newCapacity: Integer); cdecl;
  spIntArray_add: procedure(self: PspIntArray; value: Integer); cdecl;
  spIntArray_addAll: procedure(self: PspIntArray; other: PspIntArray); cdecl;
  spIntArray_addAllValues: procedure(self: PspIntArray; values: PInteger; offset: Integer; count: Integer); cdecl;
  spIntArray_removeAt: procedure(self: PspIntArray; index: Integer); cdecl;
  spIntArray_contains: function(self: PspIntArray; value: Integer): Integer; cdecl;
  spIntArray_pop: function(self: PspIntArray): Integer; cdecl;
  spIntArray_peek: function(self: PspIntArray): Integer; cdecl;
  spShortArray_create: function(initialCapacity: Integer): PspShortArray; cdecl;
  spShortArray_dispose: procedure(self: PspShortArray); cdecl;
  spShortArray_clear: procedure(self: PspShortArray); cdecl;
  spShortArray_setSize: function(self: PspShortArray; newSize: Integer): PspShortArray; cdecl;
  spShortArray_ensureCapacity: procedure(self: PspShortArray; newCapacity: Integer); cdecl;
  spShortArray_add: procedure(self: PspShortArray; value: Smallint); cdecl;
  spShortArray_addAll: procedure(self: PspShortArray; other: PspShortArray); cdecl;
  spShortArray_addAllValues: procedure(self: PspShortArray; values: PSmallint; offset: Integer; count: Integer); cdecl;
  spShortArray_removeAt: procedure(self: PspShortArray; index: Integer); cdecl;
  spShortArray_contains: function(self: PspShortArray; value: Smallint): Integer; cdecl;
  spShortArray_pop: function(self: PspShortArray): Smallint; cdecl;
  spShortArray_peek: function(self: PspShortArray): Smallint; cdecl;
  spUnsignedShortArray_create: function(initialCapacity: Integer): PspUnsignedShortArray; cdecl;
  spUnsignedShortArray_dispose: procedure(self: PspUnsignedShortArray); cdecl;
  spUnsignedShortArray_clear: procedure(self: PspUnsignedShortArray); cdecl;
  spUnsignedShortArray_setSize: function(self: PspUnsignedShortArray; newSize: Integer): PspUnsignedShortArray; cdecl;
  spUnsignedShortArray_ensureCapacity: procedure(self: PspUnsignedShortArray; newCapacity: Integer); cdecl;
  spUnsignedShortArray_add: procedure(self: PspUnsignedShortArray; value: Word); cdecl;
  spUnsignedShortArray_addAll: procedure(self: PspUnsignedShortArray; other: PspUnsignedShortArray); cdecl;
  spUnsignedShortArray_addAllValues: procedure(self: PspUnsignedShortArray; values: PWord; offset: Integer; count: Integer); cdecl;
  spUnsignedShortArray_removeAt: procedure(self: PspUnsignedShortArray; index: Integer); cdecl;
  spUnsignedShortArray_contains: function(self: PspUnsignedShortArray; value: Word): Integer; cdecl;
  spUnsignedShortArray_pop: function(self: PspUnsignedShortArray): Word; cdecl;
  spUnsignedShortArray_peek: function(self: PspUnsignedShortArray): Word; cdecl;
  spArrayFloatArray_create: function(initialCapacity: Integer): PspArrayFloatArray; cdecl;
  spArrayFloatArray_dispose: procedure(self: PspArrayFloatArray); cdecl;
  spArrayFloatArray_clear: procedure(self: PspArrayFloatArray); cdecl;
  spArrayFloatArray_setSize: function(self: PspArrayFloatArray; newSize: Integer): PspArrayFloatArray; cdecl;
  spArrayFloatArray_ensureCapacity: procedure(self: PspArrayFloatArray; newCapacity: Integer); cdecl;
  spArrayFloatArray_add: procedure(self: PspArrayFloatArray; value: PspFloatArray); cdecl;
  spArrayFloatArray_addAll: procedure(self: PspArrayFloatArray; other: PspArrayFloatArray); cdecl;
  spArrayFloatArray_addAllValues: procedure(self: PspArrayFloatArray; values: PPspFloatArray; offset: Integer; count: Integer); cdecl;
  spArrayFloatArray_removeAt: procedure(self: PspArrayFloatArray; index: Integer); cdecl;
  spArrayFloatArray_contains: function(self: PspArrayFloatArray; value: PspFloatArray): Integer; cdecl;
  spArrayFloatArray_pop: function(self: PspArrayFloatArray): PspFloatArray; cdecl;
  spArrayFloatArray_peek: function(self: PspArrayFloatArray): PspFloatArray; cdecl;
  spArrayShortArray_create: function(initialCapacity: Integer): PspArrayShortArray; cdecl;
  spArrayShortArray_dispose: procedure(self: PspArrayShortArray); cdecl;
  spArrayShortArray_clear: procedure(self: PspArrayShortArray); cdecl;
  spArrayShortArray_setSize: function(self: PspArrayShortArray; newSize: Integer): PspArrayShortArray; cdecl;
  spArrayShortArray_ensureCapacity: procedure(self: PspArrayShortArray; newCapacity: Integer); cdecl;
  spArrayShortArray_add: procedure(self: PspArrayShortArray; value: PspShortArray); cdecl;
  spArrayShortArray_addAll: procedure(self: PspArrayShortArray; other: PspArrayShortArray); cdecl;
  spArrayShortArray_addAllValues: procedure(self: PspArrayShortArray; values: PPspShortArray; offset: Integer; count: Integer); cdecl;
  spArrayShortArray_removeAt: procedure(self: PspArrayShortArray; index: Integer); cdecl;
  spArrayShortArray_contains: function(self: PspArrayShortArray; value: PspShortArray): Integer; cdecl;
  spArrayShortArray_pop: function(self: PspArrayShortArray): PspShortArray; cdecl;
  spArrayShortArray_peek: function(self: PspArrayShortArray): PspShortArray; cdecl;
  spEventData_create: function(const name: PUTF8Char): PspEventData; cdecl;
  spEventData_dispose: procedure(self: PspEventData); cdecl;
  spEvent_create: function(time: Single; data: PspEventData): PspEvent; cdecl;
  spEvent_dispose: procedure(self: PspEvent); cdecl;
  spAttachment_dispose: procedure(self: PspAttachment); cdecl;
  spAttachment_copy: function(self: PspAttachment): PspAttachment; cdecl;
  spColor_create: function(): PspColor; cdecl;
  spColor_dispose: procedure(self: PspColor); cdecl;
  spColor_setFromFloats: procedure(color: PspColor; r: Single; g: Single; b: Single; a: Single); cdecl;
  spColor_setFromFloats3: procedure(self: PspColor; r: Single; g: Single; b: Single); cdecl;
  spColor_setFromColor: procedure(color: PspColor; otherColor: PspColor); cdecl;
  spColor_setFromColor3: procedure(self: PspColor; otherColor: PspColor); cdecl;
  spColor_addFloats: procedure(color: PspColor; r: Single; g: Single; b: Single; a: Single); cdecl;
  spColor_addFloats3: procedure(color: PspColor; r: Single; g: Single; b: Single); cdecl;
  spColor_addColor: procedure(color: PspColor; otherColor: PspColor); cdecl;
  spColor_clamp: procedure(color: PspColor); cdecl;
  spBoneData_create: function(index: Integer; const name: PUTF8Char; parent: PspBoneData): PspBoneData; cdecl;
  spBoneData_dispose: procedure(self: PspBoneData); cdecl;
  spBone_setYDown: procedure(yDown: Integer); cdecl;
  spBone_isYDown: function(): Integer; cdecl;
  spBone_create: function(data: PspBoneData; skeleton: PspSkeleton; parent: PspBone): PspBone; cdecl;
  spBone_dispose: procedure(self: PspBone); cdecl;
  spBone_setToSetupPose: procedure(self: PspBone); cdecl;
  spBone_update: procedure(self: PspBone); cdecl;
  spBone_updateWorldTransform: procedure(self: PspBone); cdecl;
  spBone_updateWorldTransformWith: procedure(self: PspBone; x: Single; y: Single; rotation: Single; scaleX: Single; scaleY: Single; shearX: Single; shearY: Single); cdecl;
  spBone_getWorldRotationX: function(self: PspBone): Single; cdecl;
  spBone_getWorldRotationY: function(self: PspBone): Single; cdecl;
  spBone_getWorldScaleX: function(self: PspBone): Single; cdecl;
  spBone_getWorldScaleY: function(self: PspBone): Single; cdecl;
  spBone_updateAppliedTransform: procedure(self: PspBone); cdecl;
  spBone_worldToLocal: procedure(self: PspBone; worldX: Single; worldY: Single; localX: PSingle; localY: PSingle); cdecl;
  spBone_worldToParent: procedure(self: PspBone; worldX: Single; worldY: Single; parentX: PSingle; parentY: PSingle); cdecl;
  spBone_localToWorld: procedure(self: PspBone; localX: Single; localY: Single; worldX: PSingle; worldY: PSingle); cdecl;
  spBone_worldToLocalRotation: function(self: PspBone; worldRotation: Single): Single; cdecl;
  spBone_localToWorldRotation: function(self: PspBone; localRotation: Single): Single; cdecl;
  spBone_rotateWorld: procedure(self: PspBone; degrees: Single); cdecl;
  spSlotData_create: function(const index: Integer; const name: PUTF8Char; boneData: PspBoneData): PspSlotData; cdecl;
  spSlotData_dispose: procedure(self: PspSlotData); cdecl;
  spSlotData_setAttachmentName: procedure(self: PspSlotData; const attachmentName: PUTF8Char); cdecl;
  spSlot_create: function(data: PspSlotData; bone: PspBone): PspSlot; cdecl;
  spSlot_dispose: procedure(self: PspSlot); cdecl;
  spSlot_setAttachment: procedure(self: PspSlot; attachment: PspAttachment); cdecl;
  spSlot_setToSetupPose: procedure(self: PspSlot); cdecl;
  spVertexAttachment_computeWorldVertices: procedure(self: PspVertexAttachment; slot: PspSlot; start: Integer; count: Integer; worldVertices: PSingle; offset: Integer; stride: Integer); cdecl;
  spVertexAttachment_copyTo: procedure(self: PspVertexAttachment; other: PspVertexAttachment); cdecl;
  spAtlasPage_create: function(atlas: PspAtlas; const name: PUTF8Char): PspAtlasPage; cdecl;
  spAtlasPage_dispose: procedure(self: PspAtlasPage); cdecl;
  spKeyValueArray_create: function(initialCapacity: Integer): PspKeyValueArray; cdecl;
  spKeyValueArray_dispose: procedure(self: PspKeyValueArray); cdecl;
  spKeyValueArray_clear: procedure(self: PspKeyValueArray); cdecl;
  spKeyValueArray_setSize: function(self: PspKeyValueArray; newSize: Integer): PspKeyValueArray; cdecl;
  spKeyValueArray_ensureCapacity: procedure(self: PspKeyValueArray; newCapacity: Integer); cdecl;
  spKeyValueArray_add: procedure(self: PspKeyValueArray; value: spKeyValue); cdecl;
  spKeyValueArray_addAll: procedure(self: PspKeyValueArray; other: PspKeyValueArray); cdecl;
  spKeyValueArray_addAllValues: procedure(self: PspKeyValueArray; values: PspKeyValue; offset: Integer; count: Integer); cdecl;
  spKeyValueArray_contains: function(self: PspKeyValueArray; value: spKeyValue): Integer; cdecl;
  spKeyValueArray_pop: function(self: PspKeyValueArray): spKeyValue; cdecl;
  spKeyValueArray_peek: function(self: PspKeyValueArray): spKeyValue; cdecl;
  spAtlasRegion_create: function(): PspAtlasRegion; cdecl;
  spAtlasRegion_dispose: procedure(self: PspAtlasRegion); cdecl;
  spAtlas_create: function(const data: PUTF8Char; length: Integer; const dir: PUTF8Char; rendererObject: Pointer): PspAtlas; cdecl;
  spAtlas_createFromFile: function(const path: PUTF8Char; rendererObject: Pointer): PspAtlas; cdecl;
  spAtlas_dispose: procedure(atlas: PspAtlas); cdecl;
  spAtlas_findRegion: function(const self: PspAtlas; const name: PUTF8Char): PspAtlasRegion; cdecl;
  spTextureRegionArray_create: function(initialCapacity: Integer): PspTextureRegionArray; cdecl;
  spTextureRegionArray_dispose: procedure(self: PspTextureRegionArray); cdecl;
  spTextureRegionArray_clear: procedure(self: PspTextureRegionArray); cdecl;
  spTextureRegionArray_setSize: function(self: PspTextureRegionArray; newSize: Integer): PspTextureRegionArray; cdecl;
  spTextureRegionArray_ensureCapacity: procedure(self: PspTextureRegionArray; newCapacity: Integer); cdecl;
  spTextureRegionArray_add: procedure(self: PspTextureRegionArray; value: PspTextureRegion); cdecl;
  spTextureRegionArray_addAll: procedure(self: PspTextureRegionArray; other: PspTextureRegionArray); cdecl;
  spTextureRegionArray_addAllValues: procedure(self: PspTextureRegionArray; values: PPspTextureRegion; offset: Integer; count: Integer); cdecl;
  spTextureRegionArray_removeAt: procedure(self: PspTextureRegionArray; index: Integer); cdecl;
  spTextureRegionArray_contains: function(self: PspTextureRegionArray; value: PspTextureRegion): Integer; cdecl;
  spTextureRegionArray_pop: function(self: PspTextureRegionArray): PspTextureRegion; cdecl;
  spTextureRegionArray_peek: function(self: PspTextureRegionArray): PspTextureRegion; cdecl;
  spSequence_create: function(numRegions: Integer): PspSequence; cdecl;
  spSequence_dispose: procedure(self: PspSequence); cdecl;
  spSequence_copy: function(self: PspSequence): PspSequence; cdecl;
  spSequence_apply: procedure(self: PspSequence; slot: PspSlot; attachment: PspAttachment); cdecl;
  spSequence_getPath: procedure(self: PspSequence; const basePath: PUTF8Char; index: Integer; path: PUTF8Char); cdecl;
  spPropertyIdArray_create: function(initialCapacity: Integer): PspPropertyIdArray; cdecl;
  spPropertyIdArray_dispose: procedure(self: PspPropertyIdArray); cdecl;
  spPropertyIdArray_clear: procedure(self: PspPropertyIdArray); cdecl;
  spPropertyIdArray_setSize: function(self: PspPropertyIdArray; newSize: Integer): PspPropertyIdArray; cdecl;
  spPropertyIdArray_ensureCapacity: procedure(self: PspPropertyIdArray; newCapacity: Integer); cdecl;
  spPropertyIdArray_add: procedure(self: PspPropertyIdArray; value: spPropertyId); cdecl;
  spPropertyIdArray_addAll: procedure(self: PspPropertyIdArray; other: PspPropertyIdArray); cdecl;
  spPropertyIdArray_addAllValues: procedure(self: PspPropertyIdArray; values: PspPropertyId; offset: Integer; count: Integer); cdecl;
  spPropertyIdArray_removeAt: procedure(self: PspPropertyIdArray; index: Integer); cdecl;
  spPropertyIdArray_contains: function(self: PspPropertyIdArray; value: spPropertyId): Integer; cdecl;
  spPropertyIdArray_pop: function(self: PspPropertyIdArray): spPropertyId; cdecl;
  spPropertyIdArray_peek: function(self: PspPropertyIdArray): spPropertyId; cdecl;
  spTimelineArray_create: function(initialCapacity: Integer): PspTimelineArray; cdecl;
  spTimelineArray_dispose: procedure(self: PspTimelineArray); cdecl;
  spTimelineArray_clear: procedure(self: PspTimelineArray); cdecl;
  spTimelineArray_setSize: function(self: PspTimelineArray; newSize: Integer): PspTimelineArray; cdecl;
  spTimelineArray_ensureCapacity: procedure(self: PspTimelineArray; newCapacity: Integer); cdecl;
  spTimelineArray_add: procedure(self: PspTimelineArray; value: PspTimeline); cdecl;
  spTimelineArray_addAll: procedure(self: PspTimelineArray; other: PspTimelineArray); cdecl;
  spTimelineArray_addAllValues: procedure(self: PspTimelineArray; values: PPspTimeline; offset: Integer; count: Integer); cdecl;
  spTimelineArray_removeAt: procedure(self: PspTimelineArray; index: Integer); cdecl;
  spTimelineArray_contains: function(self: PspTimelineArray; value: PspTimeline): Integer; cdecl;
  spTimelineArray_pop: function(self: PspTimelineArray): PspTimeline; cdecl;
  spTimelineArray_peek: function(self: PspTimelineArray): PspTimeline; cdecl;
  spAnimation_create: function(const name: PUTF8Char; timelines: PspTimelineArray; duration: Single): PspAnimation; cdecl;
  spAnimation_dispose: procedure(self: PspAnimation); cdecl;
  spAnimation_hasTimeline: function(self: PspAnimation; ids: PspPropertyId; idsCount: Integer): Integer; cdecl;
  spAnimation_apply: procedure(const self: PspAnimation; skeleton: PspSkeleton; lastTime: Single; time: Single; loop: Integer; events: PPspEvent; eventsCount: PInteger; alpha: Single; blend: spMixBlend; direction: spMixDirection); cdecl;
  spTimeline_dispose: procedure(self: PspTimeline); cdecl;
  spTimeline_apply: procedure(self: PspTimeline; skeleton: PspSkeleton; lastTime: Single; time: Single; firedEvents: PPspEvent; eventsCount: PInteger; alpha: Single; blend: spMixBlend; direction: spMixDirection); cdecl;
  spTimeline_setBezier: procedure(self: PspTimeline; bezier: Integer; frame: Integer; value: Single; time1: Single; value1: Single; cx1: Single; cy1: Single; cx2: Single; cy2: Single; time2: Single; value2: Single); cdecl;
  spTimeline_getDuration: function(const self: PspTimeline): Single; cdecl;
  spCurveTimeline_setLinear: procedure(self: PspCurveTimeline; frameIndex: Integer); cdecl;
  spCurveTimeline_setStepped: procedure(self: PspCurveTimeline; frameIndex: Integer); cdecl;
  spCurveTimeline1_setFrame: procedure(self: PspCurveTimeline1; frame: Integer; time: Single; value: Single); cdecl;
  spCurveTimeline1_getCurveValue: function(self: PspCurveTimeline1; time: Single): Single; cdecl;
  spCurveTimeline1_getRelativeValue: function(timeline: PspCurveTimeline1; time: Single; alpha: Single; blend: spMixBlend; current: Single; setup: Single): Single; cdecl;
  spCurveTimeline1_getAbsoluteValue: function(timeline: PspCurveTimeline1; time: Single; alpha: Single; blend: spMixBlend; current: Single; setup: Single): Single; cdecl;
  spCurveTimeline1_getAbsoluteValue2: function(timeline: PspCurveTimeline1; time: Single; alpha: Single; blend: spMixBlend; current: Single; setup: Single; value: Single): Single; cdecl;
  spCurveTimeline1_getScaleValue: function(timeline: PspCurveTimeline1; time: Single; alpha: Single; blend: spMixBlend; direction: spMixDirection; current: Single; setup: Single): Single; cdecl;
  spCurveTimeline2_setFrame: procedure(self: PspCurveTimeline1; frame: Integer; time: Single; value1: Single; value2: Single); cdecl;
  spRotateTimeline_create: function(frameCount: Integer; bezierCount: Integer; boneIndex: Integer): PspRotateTimeline; cdecl;
  spRotateTimeline_setFrame: procedure(self: PspRotateTimeline; frameIndex: Integer; time: Single; angle: Single); cdecl;
  spTranslateTimeline_create: function(frameCount: Integer; bezierCount: Integer; boneIndex: Integer): PspTranslateTimeline; cdecl;
  spTranslateTimeline_setFrame: procedure(self: PspTranslateTimeline; frameIndex: Integer; time: Single; x: Single; y: Single); cdecl;
  spTranslateXTimeline_create: function(frameCount: Integer; bezierCount: Integer; boneIndex: Integer): PspTranslateXTimeline; cdecl;
  spTranslateXTimeline_setFrame: procedure(self: PspTranslateXTimeline; frame: Integer; time: Single; x: Single); cdecl;
  spTranslateYTimeline_create: function(frameCount: Integer; bezierCount: Integer; boneIndex: Integer): PspTranslateYTimeline; cdecl;
  spTranslateYTimeline_setFrame: procedure(self: PspTranslateYTimeline; frame: Integer; time: Single; y: Single); cdecl;
  spScaleTimeline_create: function(frameCount: Integer; bezierCount: Integer; boneIndex: Integer): PspScaleTimeline; cdecl;
  spScaleTimeline_setFrame: procedure(self: PspScaleTimeline; frameIndex: Integer; time: Single; x: Single; y: Single); cdecl;
  spScaleXTimeline_create: function(frameCount: Integer; bezierCount: Integer; boneIndex: Integer): PspScaleXTimeline; cdecl;
  spScaleXTimeline_setFrame: procedure(self: PspScaleXTimeline; frame: Integer; time: Single; x: Single); cdecl;
  spScaleYTimeline_create: function(frameCount: Integer; bezierCount: Integer; boneIndex: Integer): PspScaleYTimeline; cdecl;
  spScaleYTimeline_setFrame: procedure(self: PspScaleYTimeline; frame: Integer; time: Single; y: Single); cdecl;
  spShearTimeline_create: function(frameCount: Integer; bezierCount: Integer; boneIndex: Integer): PspShearTimeline; cdecl;
  spShearTimeline_setFrame: procedure(self: PspShearTimeline; frameIndex: Integer; time: Single; x: Single; y: Single); cdecl;
  spShearXTimeline_create: function(frameCount: Integer; bezierCount: Integer; boneIndex: Integer): PspShearXTimeline; cdecl;
  spShearXTimeline_setFrame: procedure(self: PspShearXTimeline; frame: Integer; time: Single; x: Single); cdecl;
  spShearYTimeline_create: function(frameCount: Integer; bezierCount: Integer; boneIndex: Integer): PspShearYTimeline; cdecl;
  spShearYTimeline_setFrame: procedure(self: PspShearYTimeline; frame: Integer; time: Single; x: Single); cdecl;
  spRGBATimeline_create: function(framesCount: Integer; bezierCount: Integer; slotIndex: Integer): PspRGBATimeline; cdecl;
  spRGBATimeline_setFrame: procedure(self: PspRGBATimeline; frameIndex: Integer; time: Single; r: Single; g: Single; b: Single; a: Single); cdecl;
  spRGBTimeline_create: function(framesCount: Integer; bezierCount: Integer; slotIndex: Integer): PspRGBTimeline; cdecl;
  spRGBTimeline_setFrame: procedure(self: PspRGBTimeline; frameIndex: Integer; time: Single; r: Single; g: Single; b: Single); cdecl;
  spAlphaTimeline_create: function(frameCount: Integer; bezierCount: Integer; slotIndex: Integer): PspAlphaTimeline; cdecl;
  spAlphaTimeline_setFrame: procedure(self: PspAlphaTimeline; frame: Integer; time: Single; x: Single); cdecl;
  spRGBA2Timeline_create: function(framesCount: Integer; bezierCount: Integer; slotIndex: Integer): PspRGBA2Timeline; cdecl;
  spRGBA2Timeline_setFrame: procedure(self: PspRGBA2Timeline; frameIndex: Integer; time: Single; r: Single; g: Single; b: Single; a: Single; r2: Single; g2: Single; b2: Single); cdecl;
  spRGB2Timeline_create: function(framesCount: Integer; bezierCount: Integer; slotIndex: Integer): PspRGB2Timeline; cdecl;
  spRGB2Timeline_setFrame: procedure(self: PspRGB2Timeline; frameIndex: Integer; time: Single; r: Single; g: Single; b: Single; r2: Single; g2: Single; b2: Single); cdecl;
  spAttachmentTimeline_create: function(framesCount: Integer; SlotIndex: Integer): PspAttachmentTimeline; cdecl;
  spAttachmentTimeline_setFrame: procedure(self: PspAttachmentTimeline; frameIndex: Integer; time: Single; const attachmentName: PUTF8Char); cdecl;
  spDeformTimeline_create: function(framesCount: Integer; frameVerticesCount: Integer; bezierCount: Integer; slotIndex: Integer; attachment: PspVertexAttachment): PspDeformTimeline; cdecl;
  spDeformTimeline_setFrame: procedure(self: PspDeformTimeline; frameIndex: Integer; time: Single; vertices: PSingle); cdecl;
  spSequenceTimeline_create: function(framesCount: Integer; slotIndex: Integer; attachment: PspAttachment): PspSequenceTimeline; cdecl;
  spSequenceTimeline_setFrame: procedure(self: PspSequenceTimeline; frameIndex: Integer; time: Single; mode: Integer; index: Integer; delay: Single); cdecl;
  spEventTimeline_create: function(framesCount: Integer): PspEventTimeline; cdecl;
  spEventTimeline_setFrame: procedure(self: PspEventTimeline; frameIndex: Integer; event: PspEvent); cdecl;
  spDrawOrderTimeline_create: function(framesCount: Integer; slotsCount: Integer): PspDrawOrderTimeline; cdecl;
  spDrawOrderTimeline_setFrame: procedure(self: PspDrawOrderTimeline; frameIndex: Integer; time: Single; const drawOrder: PInteger); cdecl;
  spInheritTimeline_create: function(framesCount: Integer; boneIndex: Integer): PspInheritTimeline; cdecl;
  spInheritTimeline_setFrame: procedure(self: PspInheritTimeline; frameIndex: Integer; time: Single; inherit: spInherit); cdecl;
  spIkConstraintTimeline_create: function(framesCount: Integer; bezierCount: Integer; transformConstraintIndex: Integer): PspIkConstraintTimeline; cdecl;
  spIkConstraintTimeline_setFrame: procedure(self: PspIkConstraintTimeline; frameIndex: Integer; time: Single; mix: Single; softness: Single; bendDirection: Integer; compress: Integer; stretch: Integer); cdecl;
  spTransformConstraintTimeline_create: function(framesCount: Integer; bezierCount: Integer; transformConstraintIndex: Integer): PspTransformConstraintTimeline; cdecl;
  spTransformConstraintTimeline_setFrame: procedure(self: PspTransformConstraintTimeline; frameIndex: Integer; time: Single; mixRotate: Single; mixX: Single; mixY: Single; mixScaleX: Single; mixScaleY: Single; mixShearY: Single); cdecl;
  spPathConstraintPositionTimeline_create: function(framesCount: Integer; bezierCount: Integer; pathConstraintIndex: Integer): PspPathConstraintPositionTimeline; cdecl;
  spPathConstraintPositionTimeline_setFrame: procedure(self: PspPathConstraintPositionTimeline; frameIndex: Integer; time: Single; value: Single); cdecl;
  spPathConstraintSpacingTimeline_create: function(framesCount: Integer; bezierCount: Integer; pathConstraintIndex: Integer): PspPathConstraintSpacingTimeline; cdecl;
  spPathConstraintSpacingTimeline_setFrame: procedure(self: PspPathConstraintSpacingTimeline; frameIndex: Integer; time: Single; value: Single); cdecl;
  spPathConstraintMixTimeline_create: function(framesCount: Integer; bezierCount: Integer; pathConstraintIndex: Integer): PspPathConstraintMixTimeline; cdecl;
  spPathConstraintMixTimeline_setFrame: procedure(self: PspPathConstraintMixTimeline; frameIndex: Integer; time: Single; mixRotate: Single; mixX: Single; mixY: Single); cdecl;
  spPhysicsConstraintTimeline_create: function(framesCount: Integer; bezierCount: Integer; physicsConstraintIndex: Integer; &type: spTimelineType): PspPhysicsConstraintTimeline; cdecl;
  spPhysicsConstraintTimeline_setFrame: procedure(self: PspPhysicsConstraintTimeline; frame: Integer; time: Single; value: Single); cdecl;
  spPhysicsConstraintResetTimeline_create: function(framesCount: Integer; boneIndex: Integer): PspPhysicsConstraintResetTimeline; cdecl;
  spPhysicsConstraintResetTimeline_setFrame: procedure(self: PspPhysicsConstraintResetTimeline; frameIndex: Integer; time: Single); cdecl;
  spIkConstraintData_create: function(const name: PUTF8Char): PspIkConstraintData; cdecl;
  spIkConstraintData_dispose: procedure(self: PspIkConstraintData); cdecl;
  spTransformConstraintData_create: function(const name: PUTF8Char): PspTransformConstraintData; cdecl;
  spTransformConstraintData_dispose: procedure(self: PspTransformConstraintData); cdecl;
  spPathConstraintData_create: function(const name: PUTF8Char): PspPathConstraintData; cdecl;
  spPathConstraintData_dispose: procedure(self: PspPathConstraintData); cdecl;
  spPhysicsConstraintData_create: function(const name: PUTF8Char): PspPhysicsConstraintData; cdecl;
  spPhysicsConstraintData_dispose: procedure(self: PspPhysicsConstraintData); cdecl;
  spBoneDataArray_create: function(initialCapacity: Integer): PspBoneDataArray; cdecl;
  spBoneDataArray_dispose: procedure(self: PspBoneDataArray); cdecl;
  spBoneDataArray_clear: procedure(self: PspBoneDataArray); cdecl;
  spBoneDataArray_setSize: function(self: PspBoneDataArray; newSize: Integer): PspBoneDataArray; cdecl;
  spBoneDataArray_ensureCapacity: procedure(self: PspBoneDataArray; newCapacity: Integer); cdecl;
  spBoneDataArray_add: procedure(self: PspBoneDataArray; value: PspBoneData); cdecl;
  spBoneDataArray_addAll: procedure(self: PspBoneDataArray; other: PspBoneDataArray); cdecl;
  spBoneDataArray_addAllValues: procedure(self: PspBoneDataArray; values: PPspBoneData; offset: Integer; count: Integer); cdecl;
  spBoneDataArray_removeAt: procedure(self: PspBoneDataArray; index: Integer); cdecl;
  spBoneDataArray_contains: function(self: PspBoneDataArray; value: PspBoneData): Integer; cdecl;
  spBoneDataArray_pop: function(self: PspBoneDataArray): PspBoneData; cdecl;
  spBoneDataArray_peek: function(self: PspBoneDataArray): PspBoneData; cdecl;
  spIkConstraintDataArray_create: function(initialCapacity: Integer): PspIkConstraintDataArray; cdecl;
  spIkConstraintDataArray_dispose: procedure(self: PspIkConstraintDataArray); cdecl;
  spIkConstraintDataArray_clear: procedure(self: PspIkConstraintDataArray); cdecl;
  spIkConstraintDataArray_setSize: function(self: PspIkConstraintDataArray; newSize: Integer): PspIkConstraintDataArray; cdecl;
  spIkConstraintDataArray_ensureCapacity: procedure(self: PspIkConstraintDataArray; newCapacity: Integer); cdecl;
  spIkConstraintDataArray_add: procedure(self: PspIkConstraintDataArray; value: PspIkConstraintData); cdecl;
  spIkConstraintDataArray_addAll: procedure(self: PspIkConstraintDataArray; other: PspIkConstraintDataArray); cdecl;
  spIkConstraintDataArray_addAllValues: procedure(self: PspIkConstraintDataArray; values: PPspIkConstraintData; offset: Integer; count: Integer); cdecl;
  spIkConstraintDataArray_removeAt: procedure(self: PspIkConstraintDataArray; index: Integer); cdecl;
  spIkConstraintDataArray_contains: function(self: PspIkConstraintDataArray; value: PspIkConstraintData): Integer; cdecl;
  spIkConstraintDataArray_pop: function(self: PspIkConstraintDataArray): PspIkConstraintData; cdecl;
  spIkConstraintDataArray_peek: function(self: PspIkConstraintDataArray): PspIkConstraintData; cdecl;
  spTransformConstraintDataArray_create: function(initialCapacity: Integer): PspTransformConstraintDataArray; cdecl;
  spTransformConstraintDataArray_dispose: procedure(self: PspTransformConstraintDataArray); cdecl;
  spTransformConstraintDataArray_clear: procedure(self: PspTransformConstraintDataArray); cdecl;
  spTransformConstraintDataArray_setSize: function(self: PspTransformConstraintDataArray; newSize: Integer): PspTransformConstraintDataArray; cdecl;
  spTransformConstraintDataArray_ensureCapacity: procedure(self: PspTransformConstraintDataArray; newCapacity: Integer); cdecl;
  spTransformConstraintDataArray_add: procedure(self: PspTransformConstraintDataArray; value: PspTransformConstraintData); cdecl;
  spTransformConstraintDataArray_addAll: procedure(self: PspTransformConstraintDataArray; other: PspTransformConstraintDataArray); cdecl;
  spTransformConstraintDataArray_addAllValues: procedure(self: PspTransformConstraintDataArray; values: PPspTransformConstraintData; offset: Integer; count: Integer); cdecl;
  spTransformConstraintDataArray_removeAt: procedure(self: PspTransformConstraintDataArray; index: Integer); cdecl;
  spTransformConstraintDataArray_contains: function(self: PspTransformConstraintDataArray; value: PspTransformConstraintData): Integer; cdecl;
  spTransformConstraintDataArray_pop: function(self: PspTransformConstraintDataArray): PspTransformConstraintData; cdecl;
  spTransformConstraintDataArray_peek: function(self: PspTransformConstraintDataArray): PspTransformConstraintData; cdecl;
  spPathConstraintDataArray_create: function(initialCapacity: Integer): PspPathConstraintDataArray; cdecl;
  spPathConstraintDataArray_dispose: procedure(self: PspPathConstraintDataArray); cdecl;
  spPathConstraintDataArray_clear: procedure(self: PspPathConstraintDataArray); cdecl;
  spPathConstraintDataArray_setSize: function(self: PspPathConstraintDataArray; newSize: Integer): PspPathConstraintDataArray; cdecl;
  spPathConstraintDataArray_ensureCapacity: procedure(self: PspPathConstraintDataArray; newCapacity: Integer); cdecl;
  spPathConstraintDataArray_add: procedure(self: PspPathConstraintDataArray; value: PspPathConstraintData); cdecl;
  spPathConstraintDataArray_addAll: procedure(self: PspPathConstraintDataArray; other: PspPathConstraintDataArray); cdecl;
  spPathConstraintDataArray_addAllValues: procedure(self: PspPathConstraintDataArray; values: PPspPathConstraintData; offset: Integer; count: Integer); cdecl;
  spPathConstraintDataArray_removeAt: procedure(self: PspPathConstraintDataArray; index: Integer); cdecl;
  spPathConstraintDataArray_contains: function(self: PspPathConstraintDataArray; value: PspPathConstraintData): Integer; cdecl;
  spPathConstraintDataArray_pop: function(self: PspPathConstraintDataArray): PspPathConstraintData; cdecl;
  spPathConstraintDataArray_peek: function(self: PspPathConstraintDataArray): PspPathConstraintData; cdecl;
  spPhysicsConstraintDataArray_create: function(initialCapacity: Integer): PspPhysicsConstraintDataArray; cdecl;
  spPhysicsConstraintDataArray_dispose: procedure(self: PspPhysicsConstraintDataArray); cdecl;
  spPhysicsConstraintDataArray_clear: procedure(self: PspPhysicsConstraintDataArray); cdecl;
  spPhysicsConstraintDataArray_setSize: function(self: PspPhysicsConstraintDataArray; newSize: Integer): PspPhysicsConstraintDataArray; cdecl;
  spPhysicsConstraintDataArray_ensureCapacity: procedure(self: PspPhysicsConstraintDataArray; newCapacity: Integer); cdecl;
  spPhysicsConstraintDataArray_add: procedure(self: PspPhysicsConstraintDataArray; value: PspPhysicsConstraintData); cdecl;
  spPhysicsConstraintDataArray_addAll: procedure(self: PspPhysicsConstraintDataArray; other: PspPhysicsConstraintDataArray); cdecl;
  spPhysicsConstraintDataArray_addAllValues: procedure(self: PspPhysicsConstraintDataArray; values: PPspPhysicsConstraintData; offset: Integer; count: Integer); cdecl;
  spPhysicsConstraintDataArray_removeAt: procedure(self: PspPhysicsConstraintDataArray; index: Integer); cdecl;
  spPhysicsConstraintDataArray_contains: function(self: PspPhysicsConstraintDataArray; value: PspPhysicsConstraintData): Integer; cdecl;
  spPhysicsConstraintDataArray_pop: function(self: PspPhysicsConstraintDataArray): PspPhysicsConstraintData; cdecl;
  spPhysicsConstraintDataArray_peek: function(self: PspPhysicsConstraintDataArray): PspPhysicsConstraintData; cdecl;
  spSkin_create: function(const name: PUTF8Char): PspSkin; cdecl;
  spSkin_dispose: procedure(self: PspSkin); cdecl;
  spSkin_setAttachment: procedure(self: PspSkin; slotIndex: Integer; const name: PUTF8Char; attachment: PspAttachment); cdecl;
  spSkin_getAttachment: function(const self: PspSkin; slotIndex: Integer; const name: PUTF8Char): PspAttachment; cdecl;
  spSkin_getAttachmentName: function(const self: PspSkin; slotIndex: Integer; attachmentIndex: Integer): PUTF8Char; cdecl;
  spSkin_attachAll: procedure(const self: PspSkin; skeleton: PspSkeleton; const oldspSkin: PspSkin); cdecl;
  spSkin_addSkin: procedure(self: PspSkin; const other: PspSkin); cdecl;
  spSkin_copySkin: procedure(self: PspSkin; const other: PspSkin); cdecl;
  spSkin_getAttachments: function(const self: PspSkin): PspSkinEntry; cdecl;
  spSkin_clear: procedure(self: PspSkin); cdecl;
  spSkeletonData_create: function(): PspSkeletonData; cdecl;
  spSkeletonData_dispose: procedure(self: PspSkeletonData); cdecl;
  spSkeletonData_findBone: function(const self: PspSkeletonData; const boneName: PUTF8Char): PspBoneData; cdecl;
  spSkeletonData_findSlot: function(const self: PspSkeletonData; const slotName: PUTF8Char): PspSlotData; cdecl;
  spSkeletonData_findSkin: function(const self: PspSkeletonData; const skinName: PUTF8Char): PspSkin; cdecl;
  spSkeletonData_findEvent: function(const self: PspSkeletonData; const eventName: PUTF8Char): PspEventData; cdecl;
  spSkeletonData_findAnimation: function(const self: PspSkeletonData; const animationName: PUTF8Char): PspAnimation; cdecl;
  spSkeletonData_findIkConstraint: function(const self: PspSkeletonData; const constraintName: PUTF8Char): PspIkConstraintData; cdecl;
  spSkeletonData_findTransformConstraint: function(const self: PspSkeletonData; const constraintName: PUTF8Char): PspTransformConstraintData; cdecl;
  spSkeletonData_findPathConstraint: function(const self: PspSkeletonData; const constraintName: PUTF8Char): PspPathConstraintData; cdecl;
  spSkeletonData_findPhysicsConstraint: function(const self: PspSkeletonData; const constraintName: PUTF8Char): PspPhysicsConstraintData; cdecl;
  spAnimationStateData_create: function(skeletonData: PspSkeletonData): PspAnimationStateData; cdecl;
  spAnimationStateData_dispose: procedure(self: PspAnimationStateData); cdecl;
  spAnimationStateData_setMixByName: procedure(self: PspAnimationStateData; const fromName: PUTF8Char; const toName: PUTF8Char; duration: Single); cdecl;
  spAnimationStateData_setMix: procedure(self: PspAnimationStateData; from: PspAnimation; &to: PspAnimation; duration: Single); cdecl;
  spAnimationStateData_getMix: function(self: PspAnimationStateData; from: PspAnimation; &to: PspAnimation): Single; cdecl;
  spTrackEntryArray_create: function(initialCapacity: Integer): PspTrackEntryArray; cdecl;
  spTrackEntryArray_dispose: procedure(self: PspTrackEntryArray); cdecl;
  spTrackEntryArray_clear: procedure(self: PspTrackEntryArray); cdecl;
  spTrackEntryArray_setSize: function(self: PspTrackEntryArray; newSize: Integer): PspTrackEntryArray; cdecl;
  spTrackEntryArray_ensureCapacity: procedure(self: PspTrackEntryArray; newCapacity: Integer); cdecl;
  spTrackEntryArray_add: procedure(self: PspTrackEntryArray; value: PspTrackEntry); cdecl;
  spTrackEntryArray_addAll: procedure(self: PspTrackEntryArray; other: PspTrackEntryArray); cdecl;
  spTrackEntryArray_addAllValues: procedure(self: PspTrackEntryArray; values: PPspTrackEntry; offset: Integer; count: Integer); cdecl;
  spTrackEntryArray_removeAt: procedure(self: PspTrackEntryArray; index: Integer); cdecl;
  spTrackEntryArray_contains: function(self: PspTrackEntryArray; value: PspTrackEntry): Integer; cdecl;
  spTrackEntryArray_pop: function(self: PspTrackEntryArray): PspTrackEntry; cdecl;
  spTrackEntryArray_peek: function(self: PspTrackEntryArray): PspTrackEntry; cdecl;
  spAnimationState_create: function(data: PspAnimationStateData): PspAnimationState; cdecl;
  spAnimationState_dispose: procedure(self: PspAnimationState); cdecl;
  spAnimationState_update: procedure(self: PspAnimationState; delta: Single); cdecl;
  spAnimationState_apply: function(self: PspAnimationState; skeleton: PspSkeleton): Integer; cdecl;
  spAnimationState_clearTracks: procedure(self: PspAnimationState); cdecl;
  spAnimationState_clearTrack: procedure(self: PspAnimationState; trackIndex: Integer); cdecl;
  spAnimationState_setAnimationByName: function(self: PspAnimationState; trackIndex: Integer; const animationName: PUTF8Char; loop: Integer): PspTrackEntry; cdecl;
  spAnimationState_setAnimation: function(self: PspAnimationState; trackIndex: Integer; animation: PspAnimation; loop: Integer): PspTrackEntry; cdecl;
  spAnimationState_addAnimationByName: function(self: PspAnimationState; trackIndex: Integer; const animationName: PUTF8Char; loop: Integer; delay: Single): PspTrackEntry; cdecl;
  spAnimationState_addAnimation: function(self: PspAnimationState; trackIndex: Integer; animation: PspAnimation; loop: Integer; delay: Single): PspTrackEntry; cdecl;
  spAnimationState_setEmptyAnimation: function(self: PspAnimationState; trackIndex: Integer; mixDuration: Single): PspTrackEntry; cdecl;
  spAnimationState_addEmptyAnimation: function(self: PspAnimationState; trackIndex: Integer; mixDuration: Single; delay: Single): PspTrackEntry; cdecl;
  spAnimationState_setEmptyAnimations: procedure(self: PspAnimationState; mixDuration: Single); cdecl;
  spAnimationState_getCurrent: function(self: PspAnimationState; trackIndex: Integer): PspTrackEntry; cdecl;
  spAnimationState_clearListenerNotifications: procedure(self: PspAnimationState); cdecl;
  spTrackEntry_getAnimationTime: function(entry: PspTrackEntry): Single; cdecl;
  spTrackEntry_resetRotationDirections: procedure(entry: PspTrackEntry); cdecl;
  spTrackEntry_getTrackComplete: function(entry: PspTrackEntry): Single; cdecl;
  spTrackEntry_setMixDuration: procedure(entry: PspTrackEntry; mixDuration: Single; delay: Single); cdecl;
  spTrackEntry_wasApplied: function(entry: PspTrackEntry): Integer; cdecl;
  spTrackEntry_isNextReady: function(entry: PspTrackEntry): Integer; cdecl;
  spAnimationState_clearNext: procedure(self: PspAnimationState; entry: PspTrackEntry); cdecl;
  spAnimationState_disposeStatics: procedure(); cdecl;
  spAttachmentLoader_dispose: procedure(self: PspAttachmentLoader); cdecl;
  spAttachmentLoader_createAttachment: function(self: PspAttachmentLoader; skin: PspSkin; &type: spAttachmentType; const name: PUTF8Char; const path: PUTF8Char; sequence: PspSequence): PspAttachment; cdecl;
  spAttachmentLoader_configureAttachment: procedure(self: PspAttachmentLoader; attachment: PspAttachment); cdecl;
  spAttachmentLoader_disposeAttachment: procedure(self: PspAttachmentLoader; attachment: PspAttachment); cdecl;
  spAtlasAttachmentLoader_create: function(atlas: PspAtlas): PspAtlasAttachmentLoader; cdecl;
  spRegionAttachment_create: function(const name: PUTF8Char): PspRegionAttachment; cdecl;
  spRegionAttachment_updateRegion: procedure(self: PspRegionAttachment); cdecl;
  spRegionAttachment_computeWorldVertices: procedure(self: PspRegionAttachment; slot: PspSlot; vertices: PSingle; offset: Integer; stride: Integer); cdecl;
  spMeshAttachment_create: function(const name: PUTF8Char): PspMeshAttachment; cdecl;
  spMeshAttachment_updateRegion: procedure(self: PspMeshAttachment); cdecl;
  spMeshAttachment_setParentMesh: procedure(self: PspMeshAttachment; parentMesh: PspMeshAttachment); cdecl;
  spMeshAttachment_newLinkedMesh: function(self: PspMeshAttachment): PspMeshAttachment; cdecl;
  spBoundingBoxAttachment_create: function(const name: PUTF8Char): PspBoundingBoxAttachment; cdecl;
  _spClippingAttachment_dispose: procedure(self: PspAttachment); cdecl;
  spClippingAttachment_create: function(const name: PUTF8Char): PspClippingAttachment; cdecl;
  spPointAttachment_create: function(const name: PUTF8Char): PspPointAttachment; cdecl;
  spPointAttachment_computeWorldPosition: procedure(self: PspPointAttachment; bone: PspBone; x: PSingle; y: PSingle); cdecl;
  spPointAttachment_computeWorldRotation: function(self: PspPointAttachment; bone: PspBone): Single; cdecl;
  spIkConstraint_create: function(data: PspIkConstraintData; const skeleton: PspSkeleton): PspIkConstraint; cdecl;
  spIkConstraint_dispose: procedure(self: PspIkConstraint); cdecl;
  spIkConstraint_update: procedure(self: PspIkConstraint); cdecl;
  spIkConstraint_setToSetupPose: procedure(self: PspIkConstraint); cdecl;
  spIkConstraint_apply1: procedure(bone: PspBone; targetX: Single; targetY: Single; compress: Integer; stretch: Integer; uniform: Integer; alpha: Single); cdecl;
  spIkConstraint_apply2: procedure(parent: PspBone; child: PspBone; targetX: Single; targetY: Single; bendDirection: Integer; stretch: Integer; uniform: Integer; softness: Single; alpha: Single); cdecl;
  spTransformConstraint_create: function(data: PspTransformConstraintData; const skeleton: PspSkeleton): PspTransformConstraint; cdecl;
  spTransformConstraint_dispose: procedure(self: PspTransformConstraint); cdecl;
  spTransformConstraint_update: procedure(self: PspTransformConstraint); cdecl;
  spTransformConstraint_setToSetupPose: procedure(self: PspTransformConstraint); cdecl;
  spPathAttachment_create: function(const name: PUTF8Char): PspPathAttachment; cdecl;
  spPathConstraint_create: function(data: PspPathConstraintData; const skeleton: PspSkeleton): PspPathConstraint; cdecl;
  spPathConstraint_dispose: procedure(self: PspPathConstraint); cdecl;
  spPathConstraint_update: procedure(self: PspPathConstraint); cdecl;
  spPathConstraint_setToSetupPose: procedure(self: PspPathConstraint); cdecl;
  spPathConstraint_computeWorldPositions: function(self: PspPathConstraint; path: PspPathAttachment; spacesCount: Integer; tangents: Integer): PSingle; cdecl;
  spPhysicsConstraint_create: function(data: PspPhysicsConstraintData; skeleton: PspSkeleton): PspPhysicsConstraint; cdecl;
  spPhysicsConstraint_dispose: procedure(self: PspPhysicsConstraint); cdecl;
  spPhysicsConstraint_reset: procedure(self: PspPhysicsConstraint); cdecl;
  spPhysicsConstraint_setToSetupPose: procedure(self: PspPhysicsConstraint); cdecl;
  spPhysicsConstraint_update: procedure(self: PspPhysicsConstraint; physics: spPhysics); cdecl;
  spPhysicsConstraint_rotate: procedure(self: PspPhysicsConstraint; x: Single; y: Single; degrees: Single); cdecl;
  spPhysicsConstraint_translate: procedure(self: PspPhysicsConstraint; x: Single; y: Single); cdecl;
  spSkeleton_create: function(data: PspSkeletonData): PspSkeleton; cdecl;
  spSkeleton_dispose: procedure(self: PspSkeleton); cdecl;
  spSkeleton_updateCache: procedure(self: PspSkeleton); cdecl;
  spSkeleton_updateWorldTransform: procedure(const self: PspSkeleton; physics: spPhysics); cdecl;
  spSkeleton_update: procedure(self: PspSkeleton; delta: Single); cdecl;
  spSkeleton_setToSetupPose: procedure(const self: PspSkeleton); cdecl;
  spSkeleton_setBonesToSetupPose: procedure(const self: PspSkeleton); cdecl;
  spSkeleton_setSlotsToSetupPose: procedure(const self: PspSkeleton); cdecl;
  spSkeleton_findBone: function(const self: PspSkeleton; const boneName: PUTF8Char): PspBone; cdecl;
  spSkeleton_findSlot: function(const self: PspSkeleton; const slotName: PUTF8Char): PspSlot; cdecl;
  spSkeleton_setSkin: procedure(self: PspSkeleton; skin: PspSkin); cdecl;
  spSkeleton_setSkinByName: function(self: PspSkeleton; const skinName: PUTF8Char): Integer; cdecl;
  spSkeleton_getAttachmentForSlotName: function(const self: PspSkeleton; const slotName: PUTF8Char; const attachmentName: PUTF8Char): PspAttachment; cdecl;
  spSkeleton_getAttachmentForSlotIndex: function(const self: PspSkeleton; slotIndex: Integer; const attachmentName: PUTF8Char): PspAttachment; cdecl;
  spSkeleton_setAttachment: function(self: PspSkeleton; const slotName: PUTF8Char; const attachmentName: PUTF8Char): Integer; cdecl;
  spSkeleton_findIkConstraint: function(const self: PspSkeleton; const constraintName: PUTF8Char): PspIkConstraint; cdecl;
  spSkeleton_findTransformConstraint: function(const self: PspSkeleton; const constraintName: PUTF8Char): PspTransformConstraint; cdecl;
  spSkeleton_findPathConstraint: function(const self: PspSkeleton; const constraintName: PUTF8Char): PspPathConstraint; cdecl;
  spSkeleton_findPhysicsConstraint: function(const self: PspSkeleton; const constraintName: PUTF8Char): PspPhysicsConstraint; cdecl;
  spSkeleton_physicsTranslate: procedure(self: PspSkeleton; x: Single; y: Single); cdecl;
  spSkeleton_physicsRotate: procedure(self: PspSkeleton; x: Single; y: Single; degrees: Single); cdecl;
  spPolygon_create: function(capacity: Integer): PspPolygon; cdecl;
  spPolygon_dispose: procedure(self: PspPolygon); cdecl;
  spPolygon_containsPoint: function(polygon: PspPolygon; x: Single; y: Single): Integer; cdecl;
  spPolygon_intersectsSegment: function(polygon: PspPolygon; x1: Single; y1: Single; x2: Single; y2: Single): Integer; cdecl;
  spSkeletonBounds_create: function(): PspSkeletonBounds; cdecl;
  spSkeletonBounds_dispose: procedure(self: PspSkeletonBounds); cdecl;
  spSkeletonBounds_update: procedure(self: PspSkeletonBounds; skeleton: PspSkeleton; updateAabb: Integer); cdecl;
  spSkeletonBounds_aabbContainsPoint: function(self: PspSkeletonBounds; x: Single; y: Single): Integer; cdecl;
  spSkeletonBounds_aabbIntersectsSegment: function(self: PspSkeletonBounds; x1: Single; y1: Single; x2: Single; y2: Single): Integer; cdecl;
  spSkeletonBounds_aabbIntersectsSkeleton: function(self: PspSkeletonBounds; bounds: PspSkeletonBounds): Integer; cdecl;
  spSkeletonBounds_containsPoint: function(self: PspSkeletonBounds; x: Single; y: Single): PspBoundingBoxAttachment; cdecl;
  spSkeletonBounds_intersectsSegment: function(self: PspSkeletonBounds; x1: Single; y1: Single; x2: Single; y2: Single): PspBoundingBoxAttachment; cdecl;
  spSkeletonBounds_getPolygon: function(self: PspSkeletonBounds; boundingBox: PspBoundingBoxAttachment): PspPolygon; cdecl;
  spSkeletonBinary_createWithLoader: function(attachmentLoader: PspAttachmentLoader): PspSkeletonBinary; cdecl;
  spSkeletonBinary_create: function(atlas: PspAtlas): PspSkeletonBinary; cdecl;
  spSkeletonBinary_dispose: procedure(self: PspSkeletonBinary); cdecl;
  spSkeletonBinary_readSkeletonData: function(self: PspSkeletonBinary; const binary: PByte; const length: Integer): PspSkeletonData; cdecl;
  spSkeletonBinary_readSkeletonDataFile: function(self: PspSkeletonBinary; const path: PUTF8Char): PspSkeletonData; cdecl;
  spSkeletonJson_createWithLoader: function(attachmentLoader: PspAttachmentLoader): PspSkeletonJson; cdecl;
  spSkeletonJson_create: function(atlas: PspAtlas): PspSkeletonJson; cdecl;
  spSkeletonJson_dispose: procedure(self: PspSkeletonJson); cdecl;
  spSkeletonJson_readSkeletonData: function(self: PspSkeletonJson; const json: PUTF8Char): PspSkeletonData; cdecl;
  spSkeletonJson_readSkeletonDataFile: function(self: PspSkeletonJson; const path: PUTF8Char): PspSkeletonData; cdecl;
  spTriangulator_create: function(): PspTriangulator; cdecl;
  spTriangulator_triangulate: function(self: PspTriangulator; verticesArray: PspFloatArray): PspShortArray; cdecl;
  spTriangulator_decompose: function(self: PspTriangulator; verticesArray: PspFloatArray; triangles: PspShortArray): PspArrayFloatArray; cdecl;
  spTriangulator_dispose: procedure(self: PspTriangulator); cdecl;
  spSkeletonClipping_create: function(): PspSkeletonClipping; cdecl;
  spSkeletonClipping_clipStart: function(self: PspSkeletonClipping; slot: PspSlot; clip: PspClippingAttachment): Integer; cdecl;
  spSkeletonClipping_clipEnd: procedure(self: PspSkeletonClipping; slot: PspSlot); cdecl;
  spSkeletonClipping_clipEnd2: procedure(self: PspSkeletonClipping); cdecl;
  spSkeletonClipping_isClipping: function(self: PspSkeletonClipping): Integer; cdecl;
  spSkeletonClipping_clipTriangles: procedure(self: PspSkeletonClipping; vertices: PSingle; verticesLength: Integer; triangles: PWord; trianglesLength: Integer; uvs: PSingle; stride: Integer); cdecl;
  spSkeletonClipping_dispose: procedure(self: PspSkeletonClipping); cdecl;
  spSdlVertexArray_create: function(initialCapacity: Integer): PspSdlVertexArray; cdecl;
  spSdlVertexArray_dispose: procedure(self: PspSdlVertexArray); cdecl;
  spSdlVertexArray_clear: procedure(self: PspSdlVertexArray); cdecl;
  spSdlVertexArray_setSize: function(self: PspSdlVertexArray; newSize: Integer): PspSdlVertexArray; cdecl;
  spSdlVertexArray_ensureCapacity: procedure(self: PspSdlVertexArray; newCapacity: Integer); cdecl;
  spSdlVertexArray_add: procedure(self: PspSdlVertexArray; value: sfVertex); cdecl;
  spSdlVertexArray_addAll: procedure(self: PspSdlVertexArray; other: PspSdlVertexArray); cdecl;
  spSdlVertexArray_addAllValues: procedure(self: PspSdlVertexArray; values: PsfVertex; offset: Integer; count: Integer); cdecl;
  spSdlVertexArray_removeAt: procedure(self: PspSdlVertexArray; index: Integer); cdecl;
  spSdlVertexArray_pop: function(self: PspSdlVertexArray): sfVertex; cdecl;
  spSdlVertexArray_peek: function(self: PspSdlVertexArray): sfVertex; cdecl;
  spAtlasPage_setCallbacks: procedure(createCallback: spAtlasPage_createTexture_cb; disposeCallback: spAtlasPage_disposeTexture_cb; userData: Pointer); cdecl;
  spSkeletonDrawable_create: function(skeletonData: PspSkeletonData; animationStateData: PspAnimationStateData): PspSkeletonDrawable; cdecl;
  spSkeletonDrawable_dispose: procedure(self: PspSkeletonDrawable); cdecl;
  spSkeletonDrawable_update: procedure(self: PspSkeletonDrawable; delta: Single; physics: spPhysics); cdecl;
  spSkeletonDrawable_draw: procedure(self: PspSkeletonDrawable; window: PsfRenderWindow); cdecl;

procedure GetExports(const aDLLHandle: THandle);

{$ENDREGION}

{$REGION ' Pyro.Common '}
type
  { TVirtualBuffer }
  TVirtualBuffer = class(TCustomMemoryStream)
  protected
    FHandle: THandle;
    FName: string;
    procedure Clear;
  public
    constructor Create(aSize: Cardinal);
    destructor Destroy; override;
    function Write(const aBuffer; aCount: Longint): Longint; override;
    function Write(const aBuffer: TBytes; aOffset, aCount: Longint): Longint; override;
    procedure SaveToFile(aFilename: string);
    property Name: string read FName;
    function  Eob: Boolean;
    function  ReadString: WideString;
    class function LoadFromFile(const aFilename: string): TVirtualBuffer;
  end;

{ TRingBuffer }
  TRingBuffer<T> = class
  private type
    PType = ^T;
  private
    FBuffer: array of T;
    FReadIndex, FWriteIndex, FCapacity: Integer;
  public
    constructor Create(ACapacity: Integer);
    function Write(const AData: array of T; ACount: Integer): Integer;
    function Read(var AData: array of T; ACount: Integer): Integer;
    function DirectReadPointer(ACount: Integer): Pointer;
    function AvailableBytes: Integer;
    procedure Clear;
  end;

  { TVirtualRingBuffer }
  TVirtualRingBuffer<T> = class
  private type
    PType = ^T;
  private
    FBuffer: TVirtualBuffer;
    FReadIndex, FWriteIndex, FCapacity: Integer;
    function GetArrayValue(AIndex: Integer): T;
    procedure SetArrayValue(AIndex: Integer; AValue: T);
  public
    constructor Create(ACapacity: Integer);
    destructor Destroy; override;
    function Write(const AData: array of T; ACount: Integer): Integer;
    function Read(var AData: array of T; ACount: Integer): Integer;
    function DirectReadPointer(ACount: Integer): Pointer;
    function AvailableBytes: Integer;
    procedure Clear;
  end;

  { TBaseObject }
  TBaseObject = class
  public
    constructor Create(); virtual;
    destructor Destroy(); override;
  end;

procedure FreeNilObject(const [ref] AObject: TObject);
function  UnitToScalarValue(const aValue, aMaxValue: Double): Double;
function  GetScreenWorkAreaSize(): sfVector2i;
function  SampleTimeToPosition(SampleRate: Integer; TimeInSeconds: Double; Channels: Integer; SampleSizeInBits: Integer): Int64;
function  FloatToSmallInt(Value: Single): SmallInt; inline;
procedure ClearKeyboardBuffer();
function  WasRunFromConsole() : Boolean;
function  IsStartedFromDelphiIDE: Boolean;
procedure Pause();
function  GetTempStaticBuffer(): PByte;
function  GetTempStaticBufferSize(): Integer;
procedure EnterCriticalSection();
procedure LeaveCriticalSection();
function  EnableVirtualTerminalProcessing(): DWORD;
function  HasConsoleOutput: Boolean;
function  IsValidWin64PE(const AFilePath: string): Boolean;
function  AddResFromMemory(const aModuleFile: string; const aName: string; aData: Pointer; aSize: Cardinal): Boolean;
function  ResourceExists(aInstance: THandle; const aResName: string): Boolean;
function  RemoveBOM(const AString: string): string; overload;
function  RemoveBOM(const ABytes: TBytes): TBytes; overload;
function  AsUTF8(const AText: string; const AArgs: array of const; const AUseArgs: Boolean=True; const ARemoveBOM: Boolean=False): Pointer;
procedure UpdateIconResource(const AExeFilePath, AIconFilePath: string);
procedure UpdateVersionInfoResource(const PEFilePath: string; const AMajor, AMinor, APatch: Word; const AProductName, ADescription, AFilename, ACompanyName, ACopyright: string);
function  HasEnoughDiskSpace(const APath: string; ARequiredSpace: Int64): Boolean;

{$ENDREGION}

{$REGION ' Pyro.Deps.Ext '}
type
  sfErrorCallback = procedure(const AText: string; const AUserData: Pointer); cdecl;

procedure sfError_setCallback(const AHandler: sfErrorCallback;  const AUserData: Pointer); cdecl;
function  sfError_getCallback(): sfErrorCallback; cdecl;
procedure sfError_set(const AMsg: string; const AArgs: array of const); cdecl;
function  sfError_getLast(): string; cdecl;

{ sfConsole }
const
  sfCR   = #13;
  sfLF   = #10;
  sfCRLF = #13#10;
  sfEsc  = #27;

  // Cursor Movement
  sfCSICursorPos = sfEsc + '[%d;%dH';         // Set cursor position
  sfCSICursorUp = sfEsc + '[%dA';             // Move cursor up
  sfCSICursorDown = sfEsc + '[%dB';           // Move cursor down
  sfCSICursorForward = sfEsc + '[%dC';        // Move cursor forward
  sfCSICursorBack = sfEsc + '[%dD';           // Move cursor backward
  sfCSISaveCursorPos = sfEsc + '[s';          // Save cursor position
  sfCSIRestoreCursorPos = sfEsc + '[u';       // Restore cursor position

  // Cursor Visibility
  sfCSIShowCursor = sfEsc + '[?25h';          // Show cursor
  sfCSIHideCursor = sfEsc + '[?25l';          // Hide cursor
  sfCSIBlinkCursor = sfEsc + '[?12h';         // Enable cursor blinking
  sfCSISteadyCursor = sfEsc + '[?12l';        // Disable cursor blinking

  // Screen Manipulation
  sfCSIClearScreen = sfEsc + '[2J';           // Clear screen
  sfCSIClearLine = sfEsc + '[2K';             // Clear line
  sfCSIScrollUp = sfEsc + '[%dS';             // Scroll up by n lines
  sfCSIScrollDown = sfEsc + '[%dT';           // Scroll down by n lines

  // Text Formatting
  sfCSIBold = sfEsc + '[1m';                  // Bold text
  sfCSIUnderline = sfEsc + '[4m';             // Underline text
  sfCSIResetFormat = sfEsc + '[0m';           // Reset text formatting
  sfCSIResetBackground = #27'[49m';         // Reset background text formatting
  sfCSIResetForeground = #27'[39m';         // Reset forground text formatting
  sfCSIInvertColors = sfEsc + '[7m';          // Invert foreground/background
  sfCSINormalColors = sfEsc + '[27m';         // Normal colors

  sfCSIDim = sfEsc + '[2m';
  sfCSIItalic = sfEsc + '[3m';
  sfCSIBlink = sfEsc + '[5m';
  sfCSIFramed = sfEsc + '[51m';
  sfCSIEncircled = sfEsc + '[52m';

  // Text Modification
  sfCSIInsertChar = sfEsc + '[%d@';           // Insert n spaces at cursor position
  sfCSIDeleteChar = sfEsc + '[%dP';           // Delete n characters at cursor position
  sfCSIEraseChar = sfEsc + '[%dX';            // Erase n characters at cursor position

  // Colors (Foreground and Background)
  sfCSIFGBlack = sfEsc + '[30m';
  sfCSIFGRed = sfEsc + '[31m';
  sfCSIFGGreen = sfEsc + '[32m';
  sfCSIFGYellow = sfEsc + '[33m';
  sfCSIFGBlue = sfEsc + '[34m';
  sfCSIFGMagenta = sfEsc + '[35m';
  sfCSIFGCyan = sfEsc + '[36m';
  sfCSIFGWhite = sfEsc + '[37m';

  sfCSIBGBlack = sfEsc + '[40m';
  sfCSIBGRed = sfEsc + '[41m';
  sfCSIBGGreen = sfEsc + '[42m';
  sfCSIBGYellow = sfEsc + '[43m';
  sfCSIBGBlue = sfEsc + '[44m';
  sfCSIBGMagenta = sfEsc + '[45m';
  sfCSIBGCyan = sfEsc + '[46m';
  sfCSIBGWhite = sfEsc + '[47m';

  sfCSIFGBrightBlack = sfEsc + '[90m';
  sfCSIFGBrightRed = sfEsc + '[91m';
  sfCSIFGBrightGreen = sfEsc + '[92m';
  sfCSIFGBrightYellow = sfEsc + '[93m';
  sfCSIFGBrightBlue = sfEsc + '[94m';
  sfCSIFGBrightMagenta = sfEsc + '[95m';
  sfCSIFGBrightCyan = sfEsc + '[96m';
  sfCSIFGBrightWhite = sfEsc + '[97m';

  sfCSIBGBrightBlack = sfEsc + '[100m';
  sfCSIBGBrightRed = sfEsc + '[101m';
  sfCSIBGBrightGreen = sfEsc + '[102m';
  sfCSIBGBrightYellow = sfEsc + '[103m';
  sfCSIBGBrightBlue = sfEsc + '[104m';
  sfCSIBGBrightMagenta = sfEsc + '[105m';
  sfCSIBGBrightCyan = sfEsc + '[106m';
  sfCSIBGBrightWhite = sfEsc + '[107m';

  sfCSIFGRGB = sfEsc + '[38;2;%d;%d;%dm';        // Foreground RGB
  sfCSIBGRGB = sfEsc + '[48;2;%d;%d;%dm';        // Background RGB

procedure sfConsole_print(); cdecl; overload;
procedure sfConsole_Print(const AMsg: string; const AArgs: array of const); cdecl; overload;
procedure sfConsole_printLn() cdecl; overload;
procedure sfConsole_printLn(const AMsg: string; const AArgs: array of const); cdecl; overload;

procedure sfConsole_setCursorPos(const X, Y: Integer); cdecl
procedure sfConsole_moveCursorUp(const ALines: Integer); cdecl
procedure sfConsole_moveCursorDown(const ALines: Integer); cdecl
procedure sfConsole_moveCursorForward(const ACols: Integer); cdecl
procedure sfConsole_moveCursorBack(const ACols: Integer); cdecl
procedure sfConsole_clearScreen(); cdecl
procedure sfConsole_clearLine(); cdecl
procedure sfConsole_hideCursor(); cdecl
procedure sfConsole_showCursor(); cdecl
procedure sfConsole_saveCursorPos(); cdecl
procedure sfConsole_restoreCursorPos(); cdecl
procedure sfConsole_setBoldText(); cdecl
procedure sfConsole_resetTextFormat(); cdecl
procedure sfConsole_setForegroundColor(const AColor: string); cdecl
procedure sfConsole_setBackgroundColor(const AColor: string); cdecl
procedure sfConsole_setForegroundRGB(const ARed, AGreen, ABlue: Byte); cdecl
procedure sfConsole_setBackgroundRGB(const ARed, AGreen, ABlue: Byte); cdecl

procedure sfConsole_waitForAnyKey(); cdecl
function  sfConsole_anyKeyPressed(): Boolean; cdecl

procedure sfConsole_pause(const AForcePause: Boolean=False; AColor: string=sfCSIFGWhite; const AMsg: string=''); cdecl
procedure sfConsole_setTitle(const ATitle: string); cdecl

{ sfTransform_Identity }
const
  sfTransform_Identity: sfTransform = (
    matrix: (
      1, 0, 0, // First row
      0, 1, 0, // Second row
      0, 0, 1  // Third row
    )
  );

{$REGION ' Common Blend Modes '}
const
  sfBlendAlpha: sfBlendMode = (
    colorSrcFactor: sfBlendFactorSrcAlpha;
    colorDstFactor: sfBlendFactorOneMinusSrcAlpha;
    colorEquation: sfBlendEquationAdd;
    alphaSrcFactor: sfBlendFactorOne;
    alphaDstFactor: sfBlendFactorOneMinusSrcAlpha;
    alphaEquation: sfBlendEquationAdd
  );

  sfBlendAdd: sfBlendMode = (
    colorSrcFactor: sfBlendFactorSrcAlpha;
    colorDstFactor: sfBlendFactorOne;
    colorEquation: sfBlendEquationAdd;
    alphaSrcFactor: sfBlendFactorOne;
    alphaDstFactor: sfBlendFactorOne;
    alphaEquation: sfBlendEquationAdd
  );

  sfBlendMultiply: sfBlendMode = (
    colorSrcFactor: sfBlendFactorDstColor;
    colorDstFactor: sfBlendFactorZero;
    colorEquation: sfBlendEquationAdd;
    alphaSrcFactor: sfBlendFactorDstColor;
    alphaDstFactor: sfBlendFactorZero;
    alphaEquation: sfBlendEquationAdd
  );

  sfBlendMin: sfBlendMode = (
    colorSrcFactor: sfBlendFactorOne;
    colorDstFactor: sfBlendFactorOne;
    colorEquation: sfBlendEquationMin;
    alphaSrcFactor: sfBlendFactorOne;
    alphaDstFactor: sfBlendFactorOne;
    alphaEquation: sfBlendEquationMin
  );

  sfBlendMax: sfBlendMode = (
    colorSrcFactor: sfBlendFactorOne;
    colorDstFactor: sfBlendFactorOne;
    colorEquation: sfBlendEquationMax;
    alphaSrcFactor: sfBlendFactorOne;
    alphaDstFactor: sfBlendFactorOne;
    alphaEquation: sfBlendEquationMax
  );

  sfBlendNone: sfBlendMode = (
    colorSrcFactor: sfBlendFactorOne;
    colorDstFactor: sfBlendFactorZero;
    colorEquation: sfBlendEquationAdd;
    alphaSrcFactor: sfBlendFactorOne;
    alphaDstFactor: sfBlendFactorZero;
    alphaEquation: sfBlendEquationAdd
  );
{$ENDREGION}

{$REGION ' Common Colors '}
const
  ALICEBLUE           : sfColor = (r:$F0; g:$F8; b:$FF; a:$FF);
  ANTIQUEWHITE        : sfColor = (r:$FA; g:$EB; b:$D7; a:$FF);
  AQUA                : sfColor = (r:$00; g:$FF; b:$FF; a:$FF);
  AQUAMARINE          : sfColor = (r:$7F; g:$FF; b:$D4; a:$FF);
  AZURE               : sfColor = (r:$F0; g:$FF; b:$FF; a:$FF);
  BEIGE               : sfColor = (r:$F5; g:$F5; b:$DC; a:$FF);
  BISQUE              : sfColor = (r:$FF; g:$E4; b:$C4; a:$FF);
  BLACK               : sfColor = (r:$00; g:$00; b:$00; a:$FF);
  BLANCHEDALMOND      : sfColor = (r:$FF; g:$EB; b:$CD; a:$FF);
  BLUE                : sfColor = (r:$00; g:$00; b:$FF; a:$FF);
  BLUEVIOLET          : sfColor = (r:$8A; g:$2B; b:$E2; a:$FF);
  BROWN               : sfColor = (r:$A5; g:$2A; b:$2A; a:$FF);
  BURLYWOOD           : sfColor = (r:$DE; g:$B8; b:$87; a:$FF);
  CADETBLUE           : sfColor = (r:$5F; g:$9E; b:$A0; a:$FF);
  CHARTREUSE          : sfColor = (r:$7F; g:$FF; b:$00; a:$FF);
  CHOCOLATE           : sfColor = (r:$D2; g:$69; b:$1E; a:$FF);
  CORAL               : sfColor = (r:$FF; g:$7F; b:$50; a:$FF);
  CORNFLOWERBLUE      : sfColor = (r:$64; g:$95; b:$ED; a:$FF);
  CORNSILK            : sfColor = (r:$FF; g:$F8; b:$DC; a:$FF);
  CRIMSON             : sfColor = (r:$DC; g:$14; b:$3C; a:$FF);
  CYAN                : sfColor = (r:$00; g:$FF; b:$FF; a:$FF);
  DARKBLUE            : sfColor = (r:$00; g:$00; b:$8B; a:$FF);
  DARKCYAN            : sfColor = (r:$00; g:$8B; b:$8B; a:$FF);
  DARKGOLDENROD       : sfColor = (r:$B8; g:$86; b:$0B; a:$FF);
  DARKGRAY            : sfColor = (r:$A9; g:$A9; b:$A9; a:$FF);
  DARKGREEN           : sfColor = (r:$00; g:$64; b:$00; a:$FF);
  DARKGREY            : sfColor = (r:$A9; g:$A9; b:$A9; a:$FF);
  DARKKHAKI           : sfColor = (r:$BD; g:$B7; b:$6B; a:$FF);
  DARKMAGENTA         : sfColor = (r:$8B; g:$00; b:$8B; a:$FF);
  DARKOLIVEGREEN      : sfColor = (r:$55; g:$6B; b:$2F; a:$FF);
  DARKORANGE          : sfColor = (r:$FF; g:$8C; b:$00; a:$FF);
  DARKORCHID          : sfColor = (r:$99; g:$32; b:$CC; a:$FF);
  DARKRED             : sfColor = (r:$8B; g:$00; b:$00; a:$FF);
  DARKSALMON          : sfColor = (r:$E9; g:$96; b:$7A; a:$FF);
  DARKSEAGREEN        : sfColor = (r:$8F; g:$BC; b:$8F; a:$FF);
  DARKSLATEBLUE       : sfColor = (r:$48; g:$3D; b:$8B; a:$FF);
  DARKSLATEGRAY       : sfColor = (r:$2F; g:$4F; b:$4F; a:$FF);
  DARKSLATEGREY       : sfColor = (r:$2F; g:$4F; b:$4F; a:$FF);
  DARKTURQUOISE       : sfColor = (r:$00; g:$CE; b:$D1; a:$FF);
  DARKVIOLET          : sfColor = (r:$94; g:$00; b:$D3; a:$FF);
  DEEPPINK            : sfColor = (r:$FF; g:$14; b:$93; a:$FF);
  DEEPSKYBLUE         : sfColor = (r:$00; g:$BF; b:$FF; a:$FF);
  DIMGRAY             : sfColor = (r:$69; g:$69; b:$69; a:$FF);
  DIMGREY             : sfColor = (r:$69; g:$69; b:$69; a:$FF);
  DODGERBLUE          : sfColor = (r:$1E; g:$90; b:$FF; a:$FF);
  FIREBRICK           : sfColor = (r:$B2; g:$22; b:$22; a:$FF);
  FLORALWHITE         : sfColor = (r:$FF; g:$FA; b:$F0; a:$FF);
  FORESTGREEN         : sfColor = (r:$22; g:$8B; b:$22; a:$FF);
  FUCHSIA             : sfColor = (r:$FF; g:$00; b:$FF; a:$FF);
  GAINSBORO           : sfColor = (r:$DC; g:$DC; b:$DC; a:$FF);
  GHOSTWHITE          : sfColor = (r:$F8; g:$F8; b:$FF; a:$FF);
  GOLD                : sfColor = (r:$FF; g:$D7; b:$00; a:$FF);
  GOLDENROD           : sfColor = (r:$DA; g:$A5; b:$20; a:$FF);
  GRAY                : sfColor = (r:$80; g:$80; b:$80; a:$FF);
  GREEN               : sfColor = (r:$00; g:$80; b:$00; a:$FF);
  GREENYELLOW         : sfColor = (r:$AD; g:$FF; b:$2F; a:$FF);
  GREY                : sfColor = (r:$80; g:$80; b:$80; a:$FF);
  HONEYDEW            : sfColor = (r:$F0; g:$FF; b:$F0; a:$FF);
  HOTPINK             : sfColor = (r:$FF; g:$69; b:$B4; a:$FF);
  INDIANRED           : sfColor = (r:$CD; g:$5C; b:$5C; a:$FF);
  INDIGO              : sfColor = (r:$4B; g:$00; b:$82; a:$FF);
  IVORY               : sfColor = (r:$FF; g:$FF; b:$F0; a:$FF);
  KHAKI               : sfColor = (r:$F0; g:$E6; b:$8C; a:$FF);
  LAVENDER            : sfColor = (r:$E6; g:$E6; b:$FA; a:$FF);
  LAVENDERBLUSH       : sfColor = (r:$FF; g:$F0; b:$F5; a:$FF);
  LAWNGREEN           : sfColor = (r:$7C; g:$FC; b:$00; a:$FF);
  LEMONCHIFFON        : sfColor = (r:$FF; g:$FA; b:$CD; a:$FF);
  LIGHTBLUE           : sfColor = (r:$AD; g:$D8; b:$E6; a:$FF);
  LIGHTCORAL          : sfColor = (r:$F0; g:$80; b:$80; a:$FF);
  LIGHTCYAN           : sfColor = (r:$E0; g:$FF; b:$FF; a:$FF);
  LIGHTGOLDENRODYELLOW: sfColor = (r:$FA; g:$FA; b:$D2; a:$FF);
  LIGHTGRAY           : sfColor = (r:$D3; g:$D3; b:$D3; a:$FF);
  LIGHTGREEN          : sfColor = (r:$90; g:$EE; b:$90; a:$FF);
  LIGHTGREY           : sfColor = (r:$D3; g:$D3; b:$D3; a:$FF);
  LIGHTPINK           : sfColor = (r:$FF; g:$B6; b:$C1; a:$FF);
  LIGHTSALMON         : sfColor = (r:$FF; g:$A0; b:$7A; a:$FF);
  LIGHTSEAGREEN       : sfColor = (r:$20; g:$B2; b:$AA; a:$FF);
  LIGHTSKYBLUE        : sfColor = (r:$87; g:$CE; b:$FA; a:$FF);
  LIGHTSLATEGRAY      : sfColor = (r:$77; g:$88; b:$99; a:$FF);
  LIGHTSLATEGREY      : sfColor = (r:$77; g:$88; b:$99; a:$FF);
  LIGHTSTEELBLUE      : sfColor = (r:$B0; g:$C4; b:$DE; a:$FF);
  LIGHTYELLOW         : sfColor = (r:$FF; g:$FF; b:$E0; a:$FF);
  LIME                : sfColor = (r:$00; g:$FF; b:$00; a:$FF);
  LIMEGREEN           : sfColor = (r:$32; g:$CD; b:$32; a:$FF);
  LINEN               : sfColor = (r:$FA; g:$F0; b:$E6; a:$FF);
  MAGENTA             : sfColor = (r:$FF; g:$00; b:$FF; a:$FF);
  MAROON              : sfColor = (r:$80; g:$00; b:$00; a:$FF);
  MEDIUMAQUAMARINE    : sfColor = (r:$66; g:$CD; b:$AA; a:$FF);
  MEDIUMBLUE          : sfColor = (r:$00; g:$00; b:$CD; a:$FF);
  MEDIUMORCHID        : sfColor = (r:$BA; g:$55; b:$D3; a:$FF);
  MEDIUMPURPLE        : sfColor = (r:$93; g:$70; b:$DB; a:$FF);
  MEDIUMSEAGREEN      : sfColor = (r:$3C; g:$B3; b:$71; a:$FF);
  MEDIUMSLATEBLUE     : sfColor = (r:$7B; g:$68; b:$EE; a:$FF);
  MEDIUMSPRINGGREEN   : sfColor = (r:$00; g:$FA; b:$9A; a:$FF);
  MEDIUMTURQUOISE     : sfColor = (r:$48; g:$D1; b:$CC; a:$FF);
  MEDIUMVIOLETRED     : sfColor = (r:$C7; g:$15; b:$85; a:$FF);
  MIDNIGHTBLUE        : sfColor = (r:$19; g:$19; b:$70; a:$FF);
  MINTCREAM           : sfColor = (r:$F5; g:$FF; b:$FA; a:$FF);
  MISTYROSE           : sfColor = (r:$FF; g:$E4; b:$E1; a:$FF);
  MOCCASIN            : sfColor = (r:$FF; g:$E4; b:$B5; a:$FF);
  NAVAJOWHITE         : sfColor = (r:$FF; g:$DE; b:$AD; a:$FF);
  NAVY                : sfColor = (r:$00; g:$00; b:$80; a:$FF);
  OLDLACE             : sfColor = (r:$FD; g:$F5; b:$E6; a:$FF);
  OLIVE               : sfColor = (r:$80; g:$80; b:$00; a:$FF);
  OLIVEDRAB           : sfColor = (r:$6B; g:$8E; b:$23; a:$FF);
  ORANGE              : sfColor = (r:$FF; g:$A5; b:$00; a:$FF);
  ORANGERED           : sfColor = (r:$FF; g:$45; b:$00; a:$FF);
  ORCHID              : sfColor = (r:$DA; g:$70; b:$D6; a:$FF);
  PALEGOLDENROD       : sfColor = (r:$EE; g:$E8; b:$AA; a:$FF);
  PALEGREEN           : sfColor = (r:$98; g:$FB; b:$98; a:$FF);
  PALETURQUOISE       : sfColor = (r:$AF; g:$EE; b:$EE; a:$FF);
  PALEVIOLETRED       : sfColor = (r:$DB; g:$70; b:$93; a:$FF);
  PAPAYAWHIP          : sfColor = (r:$FF; g:$EF; b:$D5; a:$FF);
  PEACHPUFF           : sfColor = (r:$FF; g:$DA; b:$B9; a:$FF);
  PERU                : sfColor = (r:$CD; g:$85; b:$3F; a:$FF);
  PINK                : sfColor = (r:$FF; g:$C0; b:$CB; a:$FF);
  PLUM                : sfColor = (r:$DD; g:$A0; b:$DD; a:$FF);
  POWDERBLUE          : sfColor = (r:$B0; g:$E0; b:$E6; a:$FF);
  PURPLE              : sfColor = (r:$80; g:$00; b:$80; a:$FF);
  REBECCAPURPLE       : sfColor = (r:$66; g:$33; b:$99; a:$FF);
  RED                 : sfColor = (r:$FF; g:$00; b:$00; a:$FF);
  ROSYBROWN           : sfColor = (r:$BC; g:$8F; b:$8F; a:$FF);
  ROYALBLUE           : sfColor = (r:$41; g:$69; b:$E1; a:$FF);
  SADDLEBROWN         : sfColor = (r:$8B; g:$45; b:$13; a:$FF);
  SALMON              : sfColor = (r:$FA; g:$80; b:$72; a:$FF);
  SANDYBROWN          : sfColor = (r:$F4; g:$A4; b:$60; a:$FF);
  SEAGREEN            : sfColor = (r:$2E; g:$8B; b:$57; a:$FF);
  SEASHELL            : sfColor = (r:$FF; g:$F5; b:$EE; a:$FF);
  SIENNA              : sfColor = (r:$A0; g:$52; b:$2D; a:$FF);
  SILVER              : sfColor = (r:$C0; g:$C0; b:$C0; a:$FF);
  SKYBLUE             : sfColor = (r:$87; g:$CE; b:$EB; a:$FF);
  SLATEBLUE           : sfColor = (r:$6A; g:$5A; b:$CD; a:$FF);
  SLATEGRAY           : sfColor = (r:$70; g:$80; b:$90; a:$FF);
  SLATEGREY           : sfColor = (r:$70; g:$80; b:$90; a:$FF);
  SNOW                : sfColor = (r:$FF; g:$FA; b:$FA; a:$FF);
  SPRINGGREEN         : sfColor = (r:$00; g:$FF; b:$7F; a:$FF);
  STEELBLUE           : sfColor = (r:$46; g:$82; b:$B4; a:$FF);
  TAN                 : sfColor = (r:$D2; g:$B4; b:$8C; a:$FF);
  TEAL                : sfColor = (r:$00; g:$80; b:$80; a:$FF);
  THISTLE             : sfColor = (r:$D8; g:$BF; b:$D8; a:$FF);
  TOMATO              : sfColor = (r:$FF; g:$63; b:$47; a:$FF);
  TURQUOISE           : sfColor = (r:$40; g:$E0; b:$D0; a:$FF);
  VIOLET              : sfColor = (r:$EE; g:$82; b:$EE; a:$FF);
  WHEAT               : sfColor = (r:$F5; g:$DE; b:$B3; a:$FF);
  WHITE               : sfColor = (r:$FF; g:$FF; b:$FF; a:$FF);
  WHITESMOKE          : sfColor = (r:$F5; g:$F5; b:$F5; a:$FF);
  YELLOW              : sfColor = (r:$FF; g:$FF; b:$00; a:$FF);
  YELLOWGREEN         : sfColor = (r:$9A; g:$CD; b:$32; a:$FF);
  BLANK               : sfColor = (r:$00; g:$00; b:$00; a:$00);
  WHITE2              : sfColor = (r:$F5; g:$F5; b:$F5; a:$FF);
  RED22               : sfColor = (r:$7E; g:$32; b:$3F; a:255);
  COLORKEY            : sfColor = (r:$FF; g:$00; b:$FF; a:$FF);
  OVERLAY1            : sfColor = (r:$00; g:$20; b:$29; a:$B4);
  OVERLAY2            : sfColor = (r:$01; g:$1B; b:$01; a:255);
  DIMWHITE            : sfColor = (r:$10; g:$10; b:$10; a:$10);
  DARKSLATEBROWN      : sfColor = (r:30;  g:31;  b:30;  a:255);
  RAYWHITE            : sfColor = (r:245; g:245; b:245; a:255);
  TRANSPARENT         : sfColor = (r:255; g:255; b:255; a:0);
{$ENDREGION}

{ sfTiming }
const
  sfTime_Zero: sfTime = (Microseconds: 0);

{ sfVector}
function  sfVector2i_create(const X, Y: Integer): sfVector2i; cdecl;
function  sfVector2u_create(const X, Y: Cardinal): sfVector2u; cdecl;
function  sfVector2f_create(const X, Y: Single): sfVector2f; cdecl;
function  sfVector3f_create(const X, Y, Z: Single): sfVector3f; cdecl;

{ sfRect }
function  sfFloatRect_create(const ALeft, ATop, AWidth, AHeight: Single): sfFloatRect; cdecl;
function  sfIntRect_create(const ALeft, ATop, AWidth, AHeight: Integer): sfIntRect; cdecl;


{ sfZipFile }
const
  sfZipFileDefaultPassword = 'Q.<g%zw[k6T,7:4N2DWC>Y]+n;(r3yj@JcF?Ru=s5LbM`paPf!';

type
  { sfZipFile_buildProgressCallback }
  sfZipFile_buildProgressCallback = procedure(const ASender: Pointer; const AFilename: string; const AProgress: Integer; const ANewFile: Boolean); cdecl;

function sfZipFile_build(const AArchive, ADirectory: string; const APassword: string=sfZipFileDefaultPassword; const ASender: Pointer=nil; const AHandler: sfZipFile_buildProgressCallback=nil): Boolean; cdecl;


{ sfInputStream }
type
  { sfInputStreamCloseFunc }
  sfInputStreamCloseFunc = function(userData: Pointer): Boolean; cdecl;

  { sfInputStream }
  PsfInputStreamEx = ^sfInputStreamEx;
  sfInputStreamEx = record
    Base: sfInputStream;
    close: sfInputStreamCloseFunc;
  end;

function sfInputStream_createEx(): PsfInputStreamEx; cdecl;
function sfInputStream_readEx(const AInputStream: PsfInputStreamEx; const AData: Pointer; const ASize: Int64): Int64; cdecl;
function sfInputStream_seekEx(const AInputStream: PsfInputStreamEx; const APosition: Int64): Int64; cdecl;
function sfInputStream_tellEx(const AInputStream: PsfInputStreamEx): Int64; cdecl;
function sfInputStream_getSizeEx(const AInputStream: PsfInputStreamEx): Int64; cdecl;
function sfInputStream_eofEx(const AInputStream: PsfInputStreamEx): Boolean; cdecl;
function sfInputStream_closeEx(var AInputStream: PsfInputStreamEx): Boolean; cdecl;
function sfInputStream_createFromFileEx(const AFilename: string): PsfInputStreamEx; cdecl;
function sfInputStream_createFromMemoryEx(const ABuffer: Pointer; const ASize: Int64): PsfInputStreamEx; cdecl;
function sfInputStream_createFromZipFileEx(const AZipFilename, AFilename: string; const APassword: string=sfZipFileDefaultPassword): PsfInputStreamEx; cdecl;

{ sfRenderWindow}
const
  sfDefaultWindow_width = 1920 div 2;
  sfDefaultWindow_height = 1080 div 2;
  sfDefaultWindow_style = sfClose or sfResize;

type
  TsfTiming = record
    Clock: PsfClock;         // The clock used for timing
    ElapsedTime: sfTime;     // Total elapsed time
    FrameRate: Single;       // Calculated frame rate
    FrameCount: Integer;     // Number of frames counted
    Limit: Cardinal;         // Frame rate limit
    PreviousTime: sfTime;    // Time of the previous frame
    DeltaTime: Single;       // Time difference between the last frame and the current frame
  end;

  PsfRenderWindowEx = ^TsfRenderWindowEx;
  TsfRenderWindowEx = record
    Handle: PsfRenderWindow;
    Mode: sfVideoMode;
    Settings: sfContextSettings;
    Scale: Single;
    Dpi: Cardinal;
    Timing: TsfTiming;
    View: PsfView;
    Size: sfVector2f;
    ScaleSize: sfVector2f;
    Fullscreen: Boolean;
    ClearRectangle: PsfRectangleShape;
    MousePos: sfVector2u;
  end;

function  sfRenderWindow_createEx(ATitle: string; const AWidth: Cardinal=sfDefaultWindow_width; const AHeight: Cardinal=sfDefaultWindow_height; const AStyle: Uint32=Ord(sfDefaultWindow_style)): PsfRenderWindowEx; cdecl;
procedure sfRenderWindow_destroyEx(var AWindow: PsfRenderWindowEx); cdecl;
procedure sfRenderWindow_toggleFullscreenEx(const AWindow: PsfRenderWindowEx); cdecl;
procedure sfRenderWindow_toggleBordersEx(const AWindow: PsfRenderWindowEx; const AShow: Boolean); cdecl;
function  sfRenderWindow_areBordersVisibleEx(const AWindow: PsfRenderWindowEx): Boolean; cdecl;
procedure sfRenderWindow_minimizeEx(const AWindow: PsfRenderWindowEx); cdecl;
function  sfRenderWindow_isMinimizedEx(const AWindow: PsfRenderWindowEx): Boolean; cdecl;
procedure sfRenderWindow_maximizeEx(const AWindow: PsfRenderWindowEx); cdecl;
function  sfRenderWindow_isMaximizedEx(const AWindow: PsfRenderWindowEx): Boolean; cdecl;
procedure sfRenderWindow_restoreEx(const AWindow: PsfRenderWindowEx); cdecl;
function  sfRenderWindow_isRestoredEx(const AWindow: PsfRenderWindowEx): Boolean; cdecl;
procedure sfRenderWindow_setFramerateLimitEx(const AWindow: PsfRenderWindowEx; limit: Cardinal); cdecl;
procedure sfRenderWindow_startFrameEx(const AWindow: PsfRenderWindowEx); cdecl;
function  sfRenderWindow_getFrameMousePosEx(const AWindow: PsfRenderWindowEx): sfVector2u; cdecl;
procedure sfRenderWindow_clearFrameEx(const AWindow: PsfRenderWindowEx; const AColor: sfColor); cdecl;
procedure sfRenderWindow_resizeFrameEx(const AWindow: PsfRenderWindowEx; const AWidth, AHeight: Cardinal); cdecl;
procedure sfRenderWindow_endFrameEx(const AWindow: PsfRenderWindowEx); cdecl;
procedure sfRenderWindow_displayEx(const AWindow: PsfRenderWindowEx); cdecl;
function  sfRenderWindow_getFrameRateEx(const AWindow: PsfRenderWindowEx): Cardinal; cdecl;
procedure sfRenderWindow_resetTimingEx(const AWindow: PsfRenderWindowEx); cdecl;
procedure sfRenderWindow_setTitleEx(const AWindow: PsfRenderWindowEx; const title: string); cdecl;
function  sfRenderWindow_createUnicodeEx(mode: sfVideoMode; const title: PUint32; style: Uint32; const settings: PsfContextSettings): PsfRenderWindowEx; cdecl;
function  sfRenderWindow_createFromHandleEx(handle: sfWindowHandle; const settings: PsfContextSettings): PsfRenderWindowEx; cdecl;
procedure sfRenderWindow_closeEx(renderWindow: PsfRenderWindowEx); cdecl;
function  sfRenderWindow_isOpenEx(const renderWindow: PsfRenderWindowEx): Boolean; cdecl;
function  sfRenderWindow_getSettingsEx(const renderWindow: PsfRenderWindowEx): sfContextSettings; cdecl;
function  sfRenderWindow_pollEventEx(renderWindow: PsfRenderWindowEx; event: PsfEvent): Boolean; cdecl;
function  sfRenderWindow_waitEventEx(renderWindow: PsfRenderWindowEx; timeout: sfTime; event: PsfEvent): Boolean; cdecl;
function  sfRenderWindow_getPositionEx(const renderWindow: PsfRenderWindowEx): sfVector2i; cdecl;
procedure sfRenderWindow_setPositionEx(renderWindow: PsfRenderWindowEx; position: sfVector2i); cdecl;
function  sfRenderWindow_getSizeEx(const renderWindow: PsfRenderWindowEx): sfVector2u; cdecl;
function  sfRenderWindow_isSrgbEx(const renderWindow: PsfRenderWindowEx): Boolean; cdecl;
procedure sfRenderWindow_setSizeEx(renderWindow: PsfRenderWindowEx; size: sfVector2u); cdecl;
procedure sfRenderWindow_setUnicodeTitleEx(renderWindow: PsfRenderWindowEx; const title: string); cdecl;
procedure sfRenderWindow_setIconEx(renderWindow: PsfRenderWindowEx; width: Cardinal; height: Cardinal; const pixels: PUint8); cdecl;
procedure sfRenderWindow_setVisibleEx(renderWindow: PsfRenderWindowEx; visible: Boolean); cdecl;
procedure sfRenderWindow_setVerticalSyncEnabledEx(renderWindow: PsfRenderWindowEx; enabled: Boolean); cdecl;
procedure sfRenderWindow_setMouseCursorVisibleEx(renderWindow: PsfRenderWindowEx; show: Boolean); cdecl;
procedure sfRenderWindow_setMouseCursorGrabbedEx(renderWindow: PsfRenderWindowEx; grabbed: Boolean); cdecl;
procedure sfRenderWindow_setMouseCursorEx(window: PsfRenderWindowEx; const cursor: PsfCursor); cdecl;
procedure sfRenderWindow_setKeyRepeatEnabledEx(renderWindow: PsfRenderWindowEx; enabled: Boolean); cdecl;
procedure sfRenderWindow_setJoystickThresholdEx(renderWindow: PsfRenderWindowEx; threshold: Single); cdecl;
function  sfRenderWindow_setActiveEx(renderWindow: PsfRenderWindowEx; active: Boolean): Boolean; cdecl;
procedure sfRenderWindow_requestFocusEx(renderWindow: PsfRenderWindowEx); cdecl;
function  sfRenderWindow_hasFocusEx(const renderWindow: PsfRenderWindowEx): Boolean; cdecl;
function  sfRenderWindow_getSystemHandleEx(const renderWindow: PsfRenderWindowEx): sfWindowHandle; cdecl;
procedure sfRenderWindow_clearEx(renderWindow: PsfRenderWindowEx; color: sfColor); cdecl;
procedure sfRenderWindow_setViewEx(renderWindow: PsfRenderWindowEx; const view: PsfView); cdecl;
function  sfRenderWindow_getViewEx(const renderWindow: PsfRenderWindowEx): PsfView; cdecl;
function  sfRenderWindow_getDefaultViewEx(const renderWindow: PsfRenderWindowEx): PsfView; cdecl;
function  sfRenderWindow_getViewportEx(const renderWindow: PsfRenderWindowEx; const view: PsfView): sfIntRect; cdecl;
function  sfRenderWindow_mapPixelToCoordsEx(const renderWindow: PsfRenderWindowEx; point: sfVector2i; const view: PsfView): sfVector2f; cdecl;
function  sfRenderWindow_mapCoordsToPixelEx(const renderWindow: PsfRenderWindowEx; point: sfVector2f; const view: PsfView): sfVector2i; cdecl;
procedure sfRenderWindow_drawSpriteEx(renderWindow: PsfRenderWindowEx; const &object: PsfSprite; const states: PsfRenderStates); cdecl;
procedure sfRenderWindow_drawShapeEx(renderWindow: PsfRenderWindowEx; const &object: PsfShape; const states: PsfRenderStates); cdecl;
procedure sfRenderWindow_drawCircleShapeEx(renderWindow: PsfRenderWindowEx; const &object: PsfCircleShape; const states: PsfRenderStates); cdecl;
procedure sfRenderWindow_drawConvexShapeEx(renderWindow: PsfRenderWindowEx; const &object: PsfConvexShape; const states: PsfRenderStates); cdecl;
procedure sfRenderWindow_drawRectangleShapeEx(renderWindow: PsfRenderWindowEx; const &object: PsfRectangleShape; const states: PsfRenderStates); cdecl;
procedure sfRenderWindow_drawVertexArrayEx(renderWindow: PsfRenderWindowEx; const &object: PsfVertexArray; const states: PsfRenderStates); cdecl;
procedure sfRenderWindow_drawVertexBufferEx(renderWindow: PsfRenderWindowEx; const &object: PsfVertexBuffer; const states: PsfRenderStates); cdecl;
procedure sfRenderWindow_drawVertexBufferRangeEx(renderWindow: PsfRenderWindowEx; const &object: PsfVertexBuffer; firstVertex: NativeUInt; vertexCount: NativeUInt; const states: PsfRenderStates); cdecl;
procedure sfRenderWindow_drawPrimitivesEx(renderWindow: PsfRenderWindowEx; const vertices: PsfVertex; vertexCount: NativeUInt; &type: sfPrimitiveType; const states: PsfRenderStates); cdecl;
procedure sfRenderWindow_pushGLStatesEx(renderWindow: PsfRenderWindowEx); cdecl;
procedure sfRenderWindow_popGLStatesEx(renderWindow: PsfRenderWindowEx); cdecl;
procedure sfRenderWindow_resetGLStatesEx(renderWindow: PsfRenderWindowEx); cdecl;
function  sfRenderWindow_captureEx(const renderWindow: PsfRenderWindowEx): PsfImage; cdecl;
function  sfRenderWindow_getDPIEx(const AWindow: PsfRenderWindowEx): Cardinal; cdecl;
function  sfRenderWindow_scaleToDPIEx(const AWindow: PsfRenderWindowEx; const ABaseWidth, ABaseHeight: Cardinal; const ACenter: Boolean; const ADefaultDPI: Integer=96): Boolean; cdecl;
procedure sfRenderWindow_scaleOnDPIChangeEx(const AWindow: PsfRenderWindowEx); cdecl;
procedure sfRenderWindow_setDefaultIconEx(const AWindow: PsfRenderWindowEx); cdecl;
procedure sfRenderWindow_drawLineEx(const AWindow: PsfRenderWindowEx; const X1, Y1, X2, Y2: Single; const AColor: sfColor; const AThickness: Single); cdecl;
procedure sfRenderWindow_drawRectEx(const AWindow: PsfRenderWindowEx; const X, Y, AWidth, AHeight, AThickness: Single; const AColor: sfColor); cdecl;
procedure sfRenderWindow_drawFilledRectEx(const ARenderWindow: PsfRenderWindowEx; const X, Y, AWidth, AHeight: Single; const AColor: sfColor); cdecl;
procedure sfRenderWindow_drawTextEx(const AWindow: PsfRenderWindowEx; const AText: PsfText; const X, Y: Single; const AColor: sfColor; const AMsg: string; const AArgs: array of const); cdecl;
procedure sfRenderWindow_drawTextVarYEx(const AWindow: PsfRenderWindowEx; const AText: PsfText; const X: Single; var Y: Single; const AColor: sfColor; const AMsg: WideString; const AArgs: array of const); cdecl;
procedure sfRenderWindow_drawCircleEx(const AWindow: PsfRenderWindowEx; const X, Y, ARadius, AThickness: Single; const AColor: sfColor); cdecl;
procedure sfRenderWindow_drawFilledCircleEx(const AWindow: PsfRenderWindowEx; const X, Y, ARadius: Single; const AColor: sfColor); cdecl;
procedure sfRenderWindow_drawTriangleEx(const AWindow: PsfRenderWindowEx; const X1, Y1, X2, Y2, X3, Y3, AThickness: Single; const AColor, AOutlineColor: sfColor); cdecl;
procedure sfRenderWindow_drawFilledTriangleEx(const AWindow: PsfRenderWindowEx; const X1, Y1, X2, Y2, X3, Y3: Single; const AColor: sfColor); cdecl;
procedure sfRenderWindow_drawPolygonEx(const AWindow: PsfRenderWindowEx; const APoints: array of sfVector2f; const AThickness: Single; const AColor, AOutlineColor: sfColor); cdecl;
procedure sfRenderWindow_drawFilledPolygonEx(const AWindow: PsfRenderWindowEx; const APoints: array of sfVector2f; const AColor: sfColor); cdecl;
procedure sfRenderWindow_drawPolylineEx(const AWindow: PsfRenderWindowEx; const APoints: array of sfVector2f; const AThickness: Single; const AColor: sfColor); cdecl;
procedure sfRenderWindow_drawEllipseEx(const AWindow: PsfRenderWindowEx; const X, Y, AWidth, AHeight, AThickness: Single; const AColor: sfColor); cdecl;
procedure sfRenderWindow_drawFilledEllipseEx(const AWindow: PsfRenderWindowEx; const X, Y, AWidth, AHeight: Single; const AColor: sfColor); cdecl;

{ sfView }
procedure sfView_setLetterBox(const AView: PsfView; const AWindowWidth, AWindowHeight: Integer); cdecl;
function  sfView_createLetterBox(const AWindowWidth, AWindowHeight: Integer): PsfView; cdecl;

{ sfFont }
function sfFont_createFromRes(const AInstance: HINST; const AResName: string): PsfFont; cdecl;
function sfFont_createDefaultFont(): PsfFont; cdecl;
function sfFont_createFromStreamEx(stream: PsfInputStreamEx): PsfFont; cdecl;

{ sfText }
procedure sfText_setCharacterSizeEx(const AWindow: PsfRenderWindowEx; const AText: PsfText; const ASize: Cardinal); cdecl;
procedure sfText_setUnicodeStringEx(const AText: PsfText; const AString: string); cdecl;

{ sfTexture }
function sfTexture_createFromRes(const AInstance: HINST; const AResName: string; const AArea: PsfIntRect): PsfTexture; cdecl;
function sfTexture_createFromStreamEx(stream: PsfInputStreamEx; const area: PsfIntRect): PsfTexture; cdecl;
function sfTexture_createSrgbFromStreamEx(stream: PsfInputStreamEx; const area: PsfIntRect): PsfTexture; cdecl;

{ sfImage }
function sfImage_createFromStreamEx(stream: PsfInputStreamEx): PsfImage; cdecl;

{ sfMusic }
function sfMusic_createFromStreamEx(stream: PsfInputStreamEx): PsfMusic; cdecl;

{ sfSoundBuffer }
function sfSoundBuffer_createFromStreamEx(stream: PsfInputStreamEx): PsfSoundBuffer; cdecl;

{ sfTime }
procedure sfTime_sleep(const AMilliseconds: Integer); cdecl;

{ sfSoundStream }
procedure sfSoundStream_destroyEx(const soundStream: PsfSoundStream); cdecl;
procedure sfSoundStream_pauseEx(soundStream: PsfSoundStream); cdecl;
procedure sfSoundStream_stopEx(soundStream: PsfSoundStream); cdecl;


{ sfShader }
function sfShader_createFromStreamEx(vertexShaderStream: PsfInputStreamEx; geometryShaderStream: PsfInputStreamEx; fragmentShaderStream: PsfInputStreamEx): PsfShader; cdecl;

{ sfVideo }
type
  sfVideoStatus = (vsPlaying, vsStopped, vsPaused);
  sfVideoStatusCallback = procedure(const ASender: Pointer; const AStatus: sfVideoStatus; const AFilename: string); cdecl;

function  sfVideo_playFromStream(const AStream: PsfInputStreamEx; const AVolume: Single; const ALoop: Boolean; const AName: string; const ASender: Pointer; const AHandler: sfVideoStatusCallback): Boolean; cdecl;
function  sfVideo_playFromFile(const AFilename: string; const AVolume: Single; const ALoop: Boolean; const ASender: Pointer=nil; const AHandler: sfVideoStatusCallback=nil): Boolean; cdecl;
function  sfVideo_playFromZipFile(const AZipFilename, AFilename: string; const AVolume: Single; const ALoop: Boolean; const ASender: Pointer=nil; const AHandler: sfVideoStatusCallback=nil; const APassword: string=sfZipFileDefaultPassword): Boolean; cdecl;
procedure sfVideo_destroy(); cdecl;
function  sfVideo_update(const AWindow: PsfRenderWindowEx): sfVideoStatus; cdecl;
procedure sfVideo_render(const AWindow: PsfRenderWindowEx; const X, Y, AScale: Single); cdecl;
function  sfVideo_getStatus(): sfVideoStatus; cdecl;
function  sfVideo_isLooping(): Boolean; cdecl;
procedure sfVideo_setLooping(const ALoop: Boolean); cdecl;
function  sfVideo_getVolume(): Single; cdecl;
procedure sfVideo_setVolume(const AVolume: Single); cdecl;

{ sfAudio }

{$ENDREGION}

{$REGION ' Pyro.Math '}
const
  sfKilobyte = 1024;                     // 1 KB = 1024 bytes
  sfMegabyte = 1024 * 1024;              // 1 MB = 1024 * 1024 bytes
  sfGigabyte = 1024 * 1024 * 1024;       // 1 GB = 1024 * 1024 * 1024 bytes

  sfRadToDeg = 180.0 / PI;
  sfDegToRad = PI / 180.0;
  sfEpsilon  = 0.00001;
  sfNan      =  0.0 / 0.0;

type
  { sfVector }
  PsfVector = ^sfVector;
  sfVector = record
    x,y,z,w: Single;
  end;

function  sfVector_fromVector2f(const A: sfVector2f): sfVector;
function  sfVector_fromVector2u(const A: sfVector2u): sfVector;
procedure sfVector_assignXY(var A: sfVector; const X, Y: Single);
procedure sfVector_assigneXYZ(var A: sfVector; const X, Y, Z: Single);
procedure sfVector_assignXYZW(var A: sfVector; const X, Y, Z, W: Single);
procedure sfVector_assignVector(var A: sfVector; const B: sfVector);
procedure sfVector_clear(var A: sfVector);
procedure sfVector_add(var A: sfVector; const B: sfVector);
procedure sfVector_subtract(var A: sfVector; const B: sfVector);
procedure sfVector_multiply(var A: sfVector; const B: sfVector);
procedure sfVector_divide(var A: sfVector; const B: sfVector);
function  sfVector_magnitude(const A: sfVector): Single;
function  sfVector_magnitudeTruncate(const A: sfVector; const AMaxMagnitude: Single): sfVector;
function  sfVector_distance(const A, B: sfVector): Single;
procedure sfVector_normalize(var A: sfVector);
function  sfVector_angle(const A, B: sfVector): Single;
procedure sfVector_thrust(var A: sfVector; const AAngle, ASpeed: Single);
function  sfVector_magnitudeSquared(const A: sfVector): Single;
function  sfVector_dotProduct(const A, B: sfVector): Single;
procedure sfVector_scalerBy(var A: sfVector; const AValue: Single);
procedure sfVector_divideBy(var A: sfVector; const AValue: Single);
function  sfVector_project(const A, B: sfVector): sfVector;
procedure sfVector_negate(var A: sfVector);

type
  { sfPoint }
  PsfPoint = ^sfPoint;
  sfPoint = record
    x,y,z: Single;
  end;

  { sfSize }
  PsfSize = ^sfSize;
  sfSize = record
    w, h: Single;
  end;

  { sfRect }
  PsfRect = ^sfRect;
  sfRect = record
    x, y, w,h: Single;
  end;

  { sfExtent }
  PsfExtent = ^sfExtent;
  sfExtent = record
    minx,miny,maxx,maxy: Single;
  end;

  { sfLineIntersection }
  sfLineIntersection = (sfLineIntersecNone, sfLineIntersecTrue,
    sfLineIntersecParallel);

  { sfEase }
  sfEase = (sfEaseLinearTween, sfEaseInQuad, sfEaseOutQuad,
    sfEaseInOutQuad, sfEaseInCubic, sfEaseOutCubic, sfEaseInOutCubic,
    sfEaseInQuart, sfEaseOutQuart, sfEaseInOutQuart, sfEaseInQuint,
    sfEaseOutQuint, sfEaseInOutQuint, sfEaseInSine, sfEaseOutSine,
    sfEaseInOutSine, sfEaseInExpo, sfEaseOutExpo, sfEaseInOutExpo,
    sfEaseInCircle, sfEaseOutCircle, sfEaseInOutCircle);

  { sfOBB }
  PsfOBB = ^sfOBB;
  sfOBB = record
    Center: sfPoint;
    Extents: sfPoint;
    Rotation: Single;
  end;

{ Structs }
function  sfPoint_create(const X, Y: Single): sfPoint;
function  sfVector_create(const X, Y: Single): sfVector;
function  sfSize_create(const AWidth, AHeight: Single): sfSize;
function  sfRect_create(const X, Y, AWidth, AHeight: Single): sfRect;
function  sfExtent_create(const AMinX, AMinY, AMaxX, AMaxY: Single): sfExtent;

{ Angle }
function  sfAngle_cos(const AAngle: Cardinal): Single;
function  sfAngle_sin(const AAngle: Cardinal): Single;
function  sfAngle_difference(const ASrcAngle, ADestAngle: Single): Single;
procedure sfAngle_rotatePos(const AAngle: Single; var AX, AY: Single);

{ Random }
function  sfRandom_rangeInt(const AMin, AMax: Integer): Integer;
function  sfRandom_rangeFloat(const AMin, AMax: Single): Single;
function  sfRandom_bool(): Boolean;
function  sfRandom_getSeed(): Integer;
procedure sfRandom_setSeed(const AVaLue: Integer);

{ ClipValue }
function  sfClipValue_float(var AVaLue: Single; const AMin, AMax: Single; const AWrap: Boolean): Single;
function  sfClipValue_int(var AVaLue: Integer; const aMin, AMax: Integer; const AWrap: Boolean): Integer;

{ SameSign }
function  sfSameSign_int(const AVaLue1, AVaLue2: Integer): Boolean;
function  sfSameSign_float(const AVaLue1, AVaLue2: Single): Boolean;
function  sfSameValue_double(const A, B: Double; const AEpsilon: Double = 0): Boolean;
function  sfSameValue_float(const A, B: Single; const AEpsilon: Single = 0): Boolean;

{ Collision }
function  sfCollision_pointInRectangle(const APoint: sfVector; const ARect: sfRect): Boolean;
function  sfCollision_pointInCircle(const APoint, ACenter: sfVector; const ARadius: Single): Boolean;
function  sfCollision_pointInTriangle(const APoint, P1, P2, P3: sfVector): Boolean;
function  sfCollision_circlesOverlap(const ACenter1: sfVector; const ARadius1: Single; const ACenter2: sfVector; const ARadius2: Single): Boolean;
function  sfCollision_circleInRectangle(const ACenter: sfVector; const ARadius: Single; const ARect: sfRect): Boolean;
function  sfCollision_rectanglesOverlap(const ARect1, ARect2: sfRect): Boolean;
function  sfCollision_rectangleIntersection(const ARect1, ARect2: sfRect): sfRect;
function  sfCollision_lineIntersection(const X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer; var X: Integer; var Y: Integer): UInt32;
function  sfCollision_radiusOverlap(const ARadius1, X1, Y1, ARadius2, X2, Y2, AShrinkFactor: Single): Boolean;
function  sfEase_Value(ACurrentTime: Double; AStartValue: Double; AChangeInValue: Double; ADuration: Double; AEaseType: UInt32): Double;
function  sfEase_position(AStartPos: Double; AEndPos: Double; ACurrentPos: Double; AEaseType: UInt32): Double;
function  sfCollision_oBBIntersect(const AObbA, AObbB: sfOBB): Boolean;

{ Misc }
procedure sfMove_smooth(var AVaLue: Single; const AAmount, AMax, ADrag: Single);
function  sfLerp(const AFrom, ATo, ATime: Double): Double;
function  sfUnit_toScalarValue(const AValue, AMaxValue: Double): Double;

{$ENDREGION}

{$REGION ' Pyro.Audio '}
const
  // Audio Constants
  sfAudioBufferCount    = 256;
  sfAudioChannelCount   = 16;
  sfAudioDynamicChannel = -1;
  sfAudioInvalidIndex   = -2;

{ Init }
procedure sfAudio_open(); cdecl;
procedure sfAudio_close(); cdecl;
procedure sfAudio_pause(aPause: Boolean); cdecl;
procedure sfAudio_reset(); cdecl;

{ Music }
function  sfAudio_loadMusic(var AInputStream: PsfInputStreamEx; const AFilename: string): Integer; cdecl; overload;
function  sfAudio_loadMusic(const AZipFilename, AFilename: string; const APassword: string=sfZipFileDefaultPassword): Integer; cdecl; overload;
procedure sfAudio_unloadMusic(var AMusic: Integer); cdecl;
procedure sfAudio_unloadAllMusic(); cdecl;
procedure sfAudio_playMusic(const AMusic: Integer); cdecl; overload;
procedure sfAudio_playMusic(const AMusic: Integer; const AVolume: Single; const ALoop: Boolean); cdecl; overload;
procedure sfAudio_stopMusic(const AMusic: Integer); cdecl;
procedure sfAudio_pauseMusic(const AMusic: Integer); cdecl;
procedure sfAudio_pauseAllMusic(const APause: Boolean); cdecl;
procedure sfAudio_setMusicLoop(const AMusic: Integer; const ALoop: Boolean); cdecl;
function  sfAudio_getMusicLoop(const AMusic: Integer): Boolean; cdecl;
procedure sfAudio_setMusicVolume(const AMusic: Integer; const AVolume: Single); cdecl;
function  sfAudio_getMusicVolume(const AMusic: Integer): Single; cdecl;
function  sfAudio_getMusicStatus(const AMusic: Integer): sfSoundStatus; cdecl;
procedure sfAudio_setMusicOffset(const AMusic: Integer; const ASeconds: Single); cdecl;

{ Sound }
function  sfAudio_loadSound(var AInputStream: PsfInputStreamEx; const AFilename: string): Integer; cdecl; overload;
function  sfAudio_loadSound(const AZipFilename, AFilename: string; const APassword: string=sfZipFileDefaultPassword): Integer; cdecl; overload;
procedure sfAudio_unloadSound(const ASound: Integer); cdecl;
function  sfAudio_playSound(const AChannel, ASound: Integer): Integer; cdecl; overload;
function  sfAudio_playSound(const AChannel, ASound: Integer; const AVolume: Single; const ALoop: Boolean): Integer; cdecl; overload;

{ Channel }
procedure sfAudio_setChannelReserved(const AChannel: Integer; const AReserve: Boolean); cdecl;
function  sfAudio_getChannelReserved(const AChannel: Integer): Boolean; cdecl;
procedure sfAudio_pauseChannel(const AChannel: Integer; const APause: Boolean); cdecl;
function  sfAudio_getChannelStatus(const AChannel: Integer): sfSoundStatus; cdecl;
procedure sfAudio_setChannelVolume(const AChannel: Integer; const AVolume: Single); cdecl;
function  sfAudio_getChannelVolume(const AChannel: Integer): Single; cdecl;
procedure sfAudio_setChannelLoop(const AChannel: Integer; const ALoop: Boolean); cdecl;
function  sfAudio_getChannelLoop(const AChannel: Integer): Boolean; cdecl;
procedure sfAudio_setChannelPitch(const AChannel: Integer; const APitch: Single); cdecl;
function  sfAudio_getChannelPitch(const AChannel: Integer): Single; cdecl;
procedure sfAudio_setChannelPosition(const AChannel: Integer; const X, Y: Single); cdecl;
procedure sfAudio_getChannelPosition(const AChannel: Integer; var X: Single; var Y: Single); cdecl;
procedure sfAudio_setChannelMinDistance(const AChannel: Integer; const ADistance: Single); cdecl;
function  sfAudio_getChannelMinDistance(const AChannel: Integer): Single; cdecl;
procedure sfAudio_setChannelRelativeToListener(const AChannel: Integer; const ARelative: Boolean); cdecl;
function  sfAudio_getChannelRelativeToListener(const AChannel: Integer): Boolean; cdecl;
procedure sfAudio_setChannelAttenuation(const AChannel: Integer; const AAttenuation: Single); cdecl;
function  sfAudio_getChannelAttenuation(const AChannel: Integer): Single; cdecl;
procedure sfAudio_stopChannel(const AChannel: Integer); cdecl;
procedure sfAudio_stopAllChannels(); cdecl;

{ Listener }
procedure sfAudio_setListenerGlobalVolume(const AVolume: Single); cdecl;
function  sfAudio_getListenerGlobalVolume(): Single; cdecl;
procedure sfAudio_setListenerPosition(const X, Y: Single); cdecl;
procedure sfAudio_getListenerPosition(var X: Single; var Y: Single); cdecl;

{$ENDREGION}

{$REGION ' Pyro.Lua '}
type
  TLuaType = (
    ltNone = -1,
    ltNil = 0,
    ltBoolean = 1,
    ltLightUserData = 2,
    ltNumber = 3,
    ltString = 4,
    ltTable = 5,
    ltFunction = 6,
    ltUserData = 7,
    ltThread = 8
  );

  TLuaTable = (LuaTable);

  TLuaValueType = (
    vtInteger,
    vtDouble,
    vtString,
    vtTable,
    vtPointer,
    vtBoolean
  );

  TLuaValue = record
    AsType: TLuaValueType;

    class operator Implicit(const AValue: Integer): TLuaValue;
    class operator Implicit(const AValue: Double): TLuaValue;
    class operator Implicit(const AValue: System.PChar): TLuaValue;
    class operator Implicit(const AValue: TLuaTable): TLuaValue;
    class operator Implicit(const AValue: Pointer): TLuaValue;
    class operator Implicit(const AValue: Boolean): TLuaValue;
    class operator Implicit(const AValue: TLuaValue): Integer;
    class operator Implicit(const AValue: TLuaValue): Double;
    class operator Implicit(const AValue: TLuaValue): System.PChar;
    class operator Implicit(const AValue: TLuaValue): Pointer;
    class operator Implicit(const AValue: TLuaValue): Boolean;

    case Integer of
      0: (AsInteger: Integer);
      1: (AsNumber: Double);
      2: (AsString: System.PChar);
      3: (AsTable: TLuaTable);
      4: (AsPointer: Pointer);
      5: (AsBoolean: Boolean);
  end;

  TLuaResetCallback = procedure(const AUserData: Pointer);

  ILua = interface;
  ILuaContext = interface
    ['{6AEC306C-45BC-4C65-A0E1-044739DED1EB}']
    function ArgCount(): Integer;
    function PushCount(): Integer;
    procedure ClearStack();
    procedure PopStack(const ACount: Integer);
    function GetStackType(const AIndex: Integer): TLuaType;
    function GetValue(const AType: TLuaValueType; const AIndex: Integer): TLuaValue;
    procedure PushValue(const AValue: TLuaValue);
    procedure SetTableFieldValue(const AName: string; const AValue: TLuaValue; const AIndex: Integer);
    function GetTableFieldValue(const AName: string; const AType: TLuaValueType; const AIndex: Integer): TLuaValue;
    procedure SetTableIndexValue(const AName: string; const AValue: TLuaValue; const AIndex: Integer; const AKey: Integer);
    function GetTableIndexValue(const AName: string; const AType: TLuaValueType; const AIndex: Integer; const AKey: Integer): TLuaValue;
    function Lua(): ILua;
  end;

  TLuaFunction = procedure(const ALua: ILuaContext) of object;

  ILua = interface
    ['{671FAB20-00F2-4C81-96A6-6F675A37D00B}']
    function GetBeforeResetCallback(): TLuaResetCallback;
    procedure SetBeforeResetCallback(const AHandler: TLuaResetCallback; const AUserData: Pointer);
    function GetAfterResetCallback(): TLuaResetCallback;
    procedure SetAfterResetCallback(const AHandler: TLuaResetCallback; const AUserData: Pointer);
    procedure Reset();
    procedure AddSearchPath(const APath: string);
    procedure Print(const AText: string; const AArgs: array of const);
    procedure PrintLn(const AText: string; const AArgs: array of const);
    procedure LoadStream(const AStream: TStream; const ASize: NativeUInt = 0; const AAutoRun: Boolean = True);
    function LoadFile(const AFilename: string; const AAutoRun: Boolean = True): Boolean;
    procedure LoadString(const AData: string; const AAutoRun: Boolean = True);
    procedure LoadBuffer(const AData: Pointer; const ASize: NativeUInt; const AAutoRun: Boolean = True);
    procedure Run();
    function RoutineExist(const AName: string): Boolean;
    function Call(const AName: string; const AParams: array of TLuaValue): TLuaValue; overload;
    function PrepCall(const AName: string): Boolean;
    function Call(const AParamCount: Integer): TLuaValue; overload;
    function VariableExist(const AName: string): Boolean;
    procedure SetVariable(const AName: string; const AValue: TLuaValue);
    function GetVariable(const AName: string; const AType: TLuaValueType): TLuaValue;
    procedure RegisterRoutine(const AName: string; const AData: Pointer; const ACode: Pointer); overload;
    procedure RegisterRoutine(const AName: string; const ARoutine: TLuaFunction); overload;
    procedure RegisterRoutines(const AClass: TClass); overload;
    procedure RegisterRoutines(const AObject: TObject); overload;
    procedure RegisterRoutines(const ATables: string; const AClass: TClass; const ATableName: string = ''); overload;
    procedure RegisterRoutines(const ATables: string; const AObject: TObject; const ATableName: string = ''); overload;
    procedure UpdateArgs(const AStartIndex: Integer);
    procedure SetGCStepSize(const AStep: Integer);
    function GetGCStepSize(): Integer;
    function GetGCMemoryUsed(): Integer;
    procedure CollectGarbage();
    procedure CompileToStream(const AFilename: string; const AStream: TStream; const ACleanOutput: Boolean);
    function PayloadExist(): Boolean;
    function RunPayload(): Boolean;
    function SavePayloadExe(const AFilename: string): Boolean;
    function StorePayload(const ASourceFilename, AEXEFilename: string): Boolean;
    function UpdatePayloadIcon(const AEXEFilename, AIconFilename: string): Boolean;
    function UpdatePayloadVersionInfo(const AEXEFilename: string; const AMajor, AMinor, APatch: Word; const AProductName, ADescription, AFilename, ACompanyName, ACopyright: string): Boolean;
  end;

  TLua = class;

  TLuaContext = class;

  ELuaException = class(Exception);

  TLuaContext = class(TNoRefCountObject, ILuaContext)
  protected
    FLua: TLua;
    FPushCount: Integer;
    FPushFlag: Boolean;
    procedure Setup();
    procedure Check();
    procedure IncStackPushCount();
    procedure Cleanup();
    function PushTableForSet(const AName: array of string; const AIndex: Integer; var AStackIndex: Integer; var AFieldNameIndex: Integer): Boolean;
    function PushTableForGet(const AName: array of string; const AIndex: Integer; var AStackIndex: Integer; var AFieldNameIndex: Integer): Boolean;
  public
    constructor Create(const ALua: TLua);
    destructor Destroy(); override;
    function ArgCount(): Integer;
    function PushCount(): Integer;
    procedure ClearStack();
    procedure PopStack(const ACount: Integer);
    function GetStackType(const AIndex: Integer): TLuaType;
    function GetValue(const AType: TLuaValueType; const AIndex: Integer): TLuaValue; overload;
    procedure PushValue(const AValue: TLuaValue); overload;
    procedure SetTableFieldValue(const AName: string; const AValue: TLuaValue; const AIndex: Integer);
    function GetTableFieldValue(const AName: string; const AType: TLuaValueType; const AIndex: Integer): TLuaValue;
    procedure SetTableIndexValue(const AName: string; const AValue: TLuaValue; const AIndex: Integer; const AKey: Integer);
    function GetTableIndexValue(const AName: string; const AType: TLuaValueType; const AIndex: Integer; const AKey: Integer): TLuaValue;
    function Lua(): ILua;
  end;

  TLua = class(TNoRefCountObject, ILua)
  protected type
    TCallback<T> = record
      Handler: T;
      UserData: Pointer;
    end;
  protected
    FState: Pointer;
    FContext: TLuaContext;
    FGCStep: Integer;
    FOnBeforeReset: TCallback<TLuaResetCallback>;
    FOnAfterReset: TCallback<TLuaResetCallback>;
    function Open(): Boolean;
    procedure Close();
    procedure CheckLuaError(const AError: Integer);
    function PushGlobalTableForSet(const AName: array of string; var AIndex: Integer): Boolean;
    function PushGlobalTableForGet(const AName: array of string; var AIndex: Integer): Boolean;
    procedure PushTValue(const AValue: System.RTTI.TValue);
    function CallFunction(const AParams: array of TValue): TValue;
    procedure SaveByteCode(const AStream: TStream);
    procedure LoadByteCode(const AStream: TStream; const AName: string; const AAutoRun: Boolean = True);
    procedure Bundle(const AInFilename: string; const AOutFilename: string);
    procedure PushLuaValue(const AValue: TLuaValue);
    function GetLuaValue(const AIndex: Integer): TLuaValue;
    function DoCall(const AParams: array of TLuaValue): TLuaValue; overload;
    function DoCall(const AParamCount: Integer): TLuaValue; overload;
    procedure CleanStack();
    procedure OnBeforeReset();
    procedure OnAfterReset();
    property State: Pointer read FState;
    property Context: TLuaContext read FContext;
  public
    constructor Create(); virtual;
    destructor Destroy(); override;
    function GetBeforeResetCallback(): TLuaResetCallback;
    procedure SetBeforeResetCallback(const AHandler: TLuaResetCallback; const AUserData: Pointer);
    function GetAfterResetCallback(): TLuaResetCallback;
    procedure SetAfterResetCallback(const AHandler: TLuaResetCallback; const AUserData: Pointer);
    procedure Reset();
    procedure AddSearchPath(const APath: string);
    procedure Print(const AText: string; const AArgs: array of const);
    procedure PrintLn(const AText: string; const AArgs: array of const);
    procedure LoadStream(const AStream: TStream; const ASize: NativeUInt = 0; const AAutoRun: Boolean = True);
    function LoadFile(const AFilename: string; const AAutoRun: Boolean = True): Boolean;
    procedure LoadString(const AData: string; const AAutoRun: Boolean = True);
    procedure LoadBuffer(const AData: Pointer; const ASize: NativeUInt; const AAutoRun: Boolean = True);
    function Call(const AName: string; const AParams: array of TLuaValue): TLuaValue; overload;
    function PrepCall(const AName: string): Boolean;
    function Call(const AParamCount: Integer): TLuaValue; overload;
    procedure Run();
    function RoutineExist(const AName: string): Boolean;
    function VariableExist(const AName: string): Boolean;
    procedure SetVariable(const AName: string; const AValue: TLuaValue);
    function GetVariable(const AName: string; const AType: TLuaValueType): TLuaValue;
    procedure RegisterRoutine(const AName: string; const AData: Pointer; const ACode: Pointer); overload;
    procedure RegisterRoutine(const AName: string; const ARoutine: TLuaFunction); overload;
    procedure RegisterRoutines(const AClass: TClass); overload;
    procedure RegisterRoutines(const AObject: TObject); overload;
    procedure RegisterRoutines(const ATables: string; const AClass: TClass; const ATableName: string = ''); overload;
    procedure RegisterRoutines(const ATables: string; const AObject: TObject; const ATableName: string = ''); overload;
    procedure UpdateArgs(const AStartIndex: Integer);
    procedure SetGCStepSize(const AStep: Integer);
    function GetGCStepSize(): Integer;
    function GetGCMemoryUsed(): Integer;
    procedure CollectGarbage();
    procedure CompileToStream(const AFilename: string; const AStream: TStream; const ACleanOutput: Boolean);
    function PayloadExist(): Boolean;
    function RunPayload(): Boolean;
    function SavePayloadExe(const AFilename: string): Boolean;
    function StorePayload(const ASourceFilename, AEXEFilename: string): Boolean;
    function UpdatePayloadIcon(const AEXEFilename, AIconFilename: string): Boolean;
    function UpdatePayloadVersionInfo(const AEXEFilename: string; const AMajor, AMinor, APatch: Word; const AProductName, ADescription, AFilename, ACompanyName, ACopyright: string): Boolean;
  end;

{$ENDREGION}

{$REGION ' Pyro '}
const
  PYRO_VERSION = '0.1.0';

{$ENDREGION}

implementation

{$REGION ' Pyro.Deps '}
procedure GetExports(const aDLLHandle: THandle);
begin
  if aDllHandle = 0 then Exit;
  _spClippingAttachment_dispose := GetProcAddress(aDLLHandle, '_spClippingAttachment_dispose');
  crc32 := GetProcAddress(aDLLHandle, 'crc32');
  lua_atpanic := GetProcAddress(aDLLHandle, 'lua_atpanic');
  lua_call := GetProcAddress(aDLLHandle, 'lua_call');
  lua_checkstack := GetProcAddress(aDLLHandle, 'lua_checkstack');
  lua_close := GetProcAddress(aDLLHandle, 'lua_close');
  lua_concat := GetProcAddress(aDLLHandle, 'lua_concat');
  lua_copy := GetProcAddress(aDLLHandle, 'lua_copy');
  lua_cpcall := GetProcAddress(aDLLHandle, 'lua_cpcall');
  lua_createtable := GetProcAddress(aDLLHandle, 'lua_createtable');
  lua_dump := GetProcAddress(aDLLHandle, 'lua_dump');
  lua_equal := GetProcAddress(aDLLHandle, 'lua_equal');
  lua_error := GetProcAddress(aDLLHandle, 'lua_error');
  lua_gc := GetProcAddress(aDLLHandle, 'lua_gc');
  lua_getallocf := GetProcAddress(aDLLHandle, 'lua_getallocf');
  lua_getfenv := GetProcAddress(aDLLHandle, 'lua_getfenv');
  lua_getfield := GetProcAddress(aDLLHandle, 'lua_getfield');
  lua_gethook := GetProcAddress(aDLLHandle, 'lua_gethook');
  lua_gethookcount := GetProcAddress(aDLLHandle, 'lua_gethookcount');
  lua_gethookmask := GetProcAddress(aDLLHandle, 'lua_gethookmask');
  lua_getinfo := GetProcAddress(aDLLHandle, 'lua_getinfo');
  lua_getlocal := GetProcAddress(aDLLHandle, 'lua_getlocal');
  lua_getmetatable := GetProcAddress(aDLLHandle, 'lua_getmetatable');
  lua_getstack := GetProcAddress(aDLLHandle, 'lua_getstack');
  lua_gettable := GetProcAddress(aDLLHandle, 'lua_gettable');
  lua_gettop := GetProcAddress(aDLLHandle, 'lua_gettop');
  lua_getupvalue := GetProcAddress(aDLLHandle, 'lua_getupvalue');
  lua_insert := GetProcAddress(aDLLHandle, 'lua_insert');
  lua_iscfunction := GetProcAddress(aDLLHandle, 'lua_iscfunction');
  lua_isnumber := GetProcAddress(aDLLHandle, 'lua_isnumber');
  lua_isstring := GetProcAddress(aDLLHandle, 'lua_isstring');
  lua_isuserdata := GetProcAddress(aDLLHandle, 'lua_isuserdata');
  lua_isyieldable := GetProcAddress(aDLLHandle, 'lua_isyieldable');
  lua_lessthan := GetProcAddress(aDLLHandle, 'lua_lessthan');
  lua_load := GetProcAddress(aDLLHandle, 'lua_load');
  lua_loadx := GetProcAddress(aDLLHandle, 'lua_loadx');
  lua_newstate := GetProcAddress(aDLLHandle, 'lua_newstate');
  lua_newthread := GetProcAddress(aDLLHandle, 'lua_newthread');
  lua_newuserdata := GetProcAddress(aDLLHandle, 'lua_newuserdata');
  lua_next := GetProcAddress(aDLLHandle, 'lua_next');
  lua_objlen := GetProcAddress(aDLLHandle, 'lua_objlen');
  lua_pcall := GetProcAddress(aDLLHandle, 'lua_pcall');
  lua_pushboolean := GetProcAddress(aDLLHandle, 'lua_pushboolean');
  lua_pushcclosure := GetProcAddress(aDLLHandle, 'lua_pushcclosure');
  lua_pushfstring := GetProcAddress(aDLLHandle, 'lua_pushfstring');
  lua_pushinteger := GetProcAddress(aDLLHandle, 'lua_pushinteger');
  lua_pushlightuserdata := GetProcAddress(aDLLHandle, 'lua_pushlightuserdata');
  lua_pushlstring := GetProcAddress(aDLLHandle, 'lua_pushlstring');
  lua_pushnil := GetProcAddress(aDLLHandle, 'lua_pushnil');
  lua_pushnumber := GetProcAddress(aDLLHandle, 'lua_pushnumber');
  lua_pushstring := GetProcAddress(aDLLHandle, 'lua_pushstring');
  lua_pushthread := GetProcAddress(aDLLHandle, 'lua_pushthread');
  lua_pushvalue := GetProcAddress(aDLLHandle, 'lua_pushvalue');
  lua_pushvfstring := GetProcAddress(aDLLHandle, 'lua_pushvfstring');
  lua_rawequal := GetProcAddress(aDLLHandle, 'lua_rawequal');
  lua_rawget := GetProcAddress(aDLLHandle, 'lua_rawget');
  lua_rawgeti := GetProcAddress(aDLLHandle, 'lua_rawgeti');
  lua_rawset := GetProcAddress(aDLLHandle, 'lua_rawset');
  lua_rawseti := GetProcAddress(aDLLHandle, 'lua_rawseti');
  lua_remove := GetProcAddress(aDLLHandle, 'lua_remove');
  lua_replace := GetProcAddress(aDLLHandle, 'lua_replace');
  lua_resume := GetProcAddress(aDLLHandle, 'lua_resume');
  lua_setallocf := GetProcAddress(aDLLHandle, 'lua_setallocf');
  lua_setfenv := GetProcAddress(aDLLHandle, 'lua_setfenv');
  lua_setfield := GetProcAddress(aDLLHandle, 'lua_setfield');
  lua_sethook := GetProcAddress(aDLLHandle, 'lua_sethook');
  lua_setlocal := GetProcAddress(aDLLHandle, 'lua_setlocal');
  lua_setmetatable := GetProcAddress(aDLLHandle, 'lua_setmetatable');
  lua_settable := GetProcAddress(aDLLHandle, 'lua_settable');
  lua_settop := GetProcAddress(aDLLHandle, 'lua_settop');
  lua_setupvalue := GetProcAddress(aDLLHandle, 'lua_setupvalue');
  lua_status := GetProcAddress(aDLLHandle, 'lua_status');
  lua_toboolean := GetProcAddress(aDLLHandle, 'lua_toboolean');
  lua_tocfunction := GetProcAddress(aDLLHandle, 'lua_tocfunction');
  lua_tointeger := GetProcAddress(aDLLHandle, 'lua_tointeger');
  lua_tointegerx := GetProcAddress(aDLLHandle, 'lua_tointegerx');
  lua_tolstring := GetProcAddress(aDLLHandle, 'lua_tolstring');
  lua_tonumber := GetProcAddress(aDLLHandle, 'lua_tonumber');
  lua_tonumberx := GetProcAddress(aDLLHandle, 'lua_tonumberx');
  lua_topointer := GetProcAddress(aDLLHandle, 'lua_topointer');
  lua_tothread := GetProcAddress(aDLLHandle, 'lua_tothread');
  lua_touserdata := GetProcAddress(aDLLHandle, 'lua_touserdata');
  lua_type := GetProcAddress(aDLLHandle, 'lua_type');
  lua_typename := GetProcAddress(aDLLHandle, 'lua_typename');
  lua_upvalueid := GetProcAddress(aDLLHandle, 'lua_upvalueid');
  lua_upvaluejoin := GetProcAddress(aDLLHandle, 'lua_upvaluejoin');
  lua_version := GetProcAddress(aDLLHandle, 'lua_version');
  lua_xmove := GetProcAddress(aDLLHandle, 'lua_xmove');
  lua_yield := GetProcAddress(aDLLHandle, 'lua_yield');
  luaJIT_profile_dumpstack := GetProcAddress(aDLLHandle, 'luaJIT_profile_dumpstack');
  luaJIT_profile_start := GetProcAddress(aDLLHandle, 'luaJIT_profile_start');
  luaJIT_profile_stop := GetProcAddress(aDLLHandle, 'luaJIT_profile_stop');
  luaJIT_setmode := GetProcAddress(aDLLHandle, 'luaJIT_setmode');
  luaJIT_version_2_1_1734355927 := GetProcAddress(aDLLHandle, 'luaJIT_version_2_1_1734355927');
  luaL_addlstring := GetProcAddress(aDLLHandle, 'luaL_addlstring');
  luaL_addstring := GetProcAddress(aDLLHandle, 'luaL_addstring');
  luaL_addvalue := GetProcAddress(aDLLHandle, 'luaL_addvalue');
  luaL_argerror := GetProcAddress(aDLLHandle, 'luaL_argerror');
  luaL_buffinit := GetProcAddress(aDLLHandle, 'luaL_buffinit');
  luaL_callmeta := GetProcAddress(aDLLHandle, 'luaL_callmeta');
  luaL_checkany := GetProcAddress(aDLLHandle, 'luaL_checkany');
  luaL_checkinteger := GetProcAddress(aDLLHandle, 'luaL_checkinteger');
  luaL_checklstring := GetProcAddress(aDLLHandle, 'luaL_checklstring');
  luaL_checknumber := GetProcAddress(aDLLHandle, 'luaL_checknumber');
  luaL_checkoption := GetProcAddress(aDLLHandle, 'luaL_checkoption');
  luaL_checkstack := GetProcAddress(aDLLHandle, 'luaL_checkstack');
  luaL_checktype := GetProcAddress(aDLLHandle, 'luaL_checktype');
  luaL_checkudata := GetProcAddress(aDLLHandle, 'luaL_checkudata');
  luaL_error := GetProcAddress(aDLLHandle, 'luaL_error');
  luaL_execresult := GetProcAddress(aDLLHandle, 'luaL_execresult');
  luaL_fileresult := GetProcAddress(aDLLHandle, 'luaL_fileresult');
  luaL_findtable := GetProcAddress(aDLLHandle, 'luaL_findtable');
  luaL_getmetafield := GetProcAddress(aDLLHandle, 'luaL_getmetafield');
  luaL_gsub := GetProcAddress(aDLLHandle, 'luaL_gsub');
  luaL_loadbuffer := GetProcAddress(aDLLHandle, 'luaL_loadbuffer');
  luaL_loadbufferx := GetProcAddress(aDLLHandle, 'luaL_loadbufferx');
  luaL_loadfile := GetProcAddress(aDLLHandle, 'luaL_loadfile');
  luaL_loadfilex := GetProcAddress(aDLLHandle, 'luaL_loadfilex');
  luaL_loadstring := GetProcAddress(aDLLHandle, 'luaL_loadstring');
  luaL_newmetatable := GetProcAddress(aDLLHandle, 'luaL_newmetatable');
  luaL_newstate := GetProcAddress(aDLLHandle, 'luaL_newstate');
  luaL_openlib := GetProcAddress(aDLLHandle, 'luaL_openlib');
  luaL_openlibs := GetProcAddress(aDLLHandle, 'luaL_openlibs');
  luaL_optinteger := GetProcAddress(aDLLHandle, 'luaL_optinteger');
  luaL_optlstring := GetProcAddress(aDLLHandle, 'luaL_optlstring');
  luaL_optnumber := GetProcAddress(aDLLHandle, 'luaL_optnumber');
  luaL_prepbuffer := GetProcAddress(aDLLHandle, 'luaL_prepbuffer');
  luaL_pushmodule := GetProcAddress(aDLLHandle, 'luaL_pushmodule');
  luaL_pushresult := GetProcAddress(aDLLHandle, 'luaL_pushresult');
  luaL_ref := GetProcAddress(aDLLHandle, 'luaL_ref');
  luaL_register := GetProcAddress(aDLLHandle, 'luaL_register');
  luaL_setfuncs := GetProcAddress(aDLLHandle, 'luaL_setfuncs');
  luaL_setmetatable := GetProcAddress(aDLLHandle, 'luaL_setmetatable');
  luaL_testudata := GetProcAddress(aDLLHandle, 'luaL_testudata');
  luaL_traceback := GetProcAddress(aDLLHandle, 'luaL_traceback');
  luaL_typerror := GetProcAddress(aDLLHandle, 'luaL_typerror');
  luaL_unref := GetProcAddress(aDLLHandle, 'luaL_unref');
  luaL_where := GetProcAddress(aDLLHandle, 'luaL_where');
  luaopen_base := GetProcAddress(aDLLHandle, 'luaopen_base');
  luaopen_bit := GetProcAddress(aDLLHandle, 'luaopen_bit');
  luaopen_debug := GetProcAddress(aDLLHandle, 'luaopen_debug');
  luaopen_ffi := GetProcAddress(aDLLHandle, 'luaopen_ffi');
  luaopen_io := GetProcAddress(aDLLHandle, 'luaopen_io');
  luaopen_jit := GetProcAddress(aDLLHandle, 'luaopen_jit');
  luaopen_math := GetProcAddress(aDLLHandle, 'luaopen_math');
  luaopen_os := GetProcAddress(aDLLHandle, 'luaopen_os');
  luaopen_package := GetProcAddress(aDLLHandle, 'luaopen_package');
  luaopen_string := GetProcAddress(aDLLHandle, 'luaopen_string');
  luaopen_string_buffer := GetProcAddress(aDLLHandle, 'luaopen_string_buffer');
  luaopen_table := GetProcAddress(aDLLHandle, 'luaopen_table');
  plm_audio_create_with_buffer := GetProcAddress(aDLLHandle, 'plm_audio_create_with_buffer');
  plm_audio_decode := GetProcAddress(aDLLHandle, 'plm_audio_decode');
  plm_audio_destroy := GetProcAddress(aDLLHandle, 'plm_audio_destroy');
  plm_audio_get_samplerate := GetProcAddress(aDLLHandle, 'plm_audio_get_samplerate');
  plm_audio_get_time := GetProcAddress(aDLLHandle, 'plm_audio_get_time');
  plm_audio_has_ended := GetProcAddress(aDLLHandle, 'plm_audio_has_ended');
  plm_audio_has_header := GetProcAddress(aDLLHandle, 'plm_audio_has_header');
  plm_audio_rewind := GetProcAddress(aDLLHandle, 'plm_audio_rewind');
  plm_audio_set_time := GetProcAddress(aDLLHandle, 'plm_audio_set_time');
  plm_buffer_create_for_appending := GetProcAddress(aDLLHandle, 'plm_buffer_create_for_appending');
  plm_buffer_create_with_capacity := GetProcAddress(aDLLHandle, 'plm_buffer_create_with_capacity');
  plm_buffer_create_with_file := GetProcAddress(aDLLHandle, 'plm_buffer_create_with_file');
  plm_buffer_create_with_filename := GetProcAddress(aDLLHandle, 'plm_buffer_create_with_filename');
  plm_buffer_create_with_memory := GetProcAddress(aDLLHandle, 'plm_buffer_create_with_memory');
  plm_buffer_destroy := GetProcAddress(aDLLHandle, 'plm_buffer_destroy');
  plm_buffer_get_remaining := GetProcAddress(aDLLHandle, 'plm_buffer_get_remaining');
  plm_buffer_get_size := GetProcAddress(aDLLHandle, 'plm_buffer_get_size');
  plm_buffer_has_ended := GetProcAddress(aDLLHandle, 'plm_buffer_has_ended');
  plm_buffer_rewind := GetProcAddress(aDLLHandle, 'plm_buffer_rewind');
  plm_buffer_set_load_callback := GetProcAddress(aDLLHandle, 'plm_buffer_set_load_callback');
  plm_buffer_signal_end := GetProcAddress(aDLLHandle, 'plm_buffer_signal_end');
  plm_buffer_write := GetProcAddress(aDLLHandle, 'plm_buffer_write');
  plm_create_with_buffer := GetProcAddress(aDLLHandle, 'plm_create_with_buffer');
  plm_create_with_file := GetProcAddress(aDLLHandle, 'plm_create_with_file');
  plm_create_with_filename := GetProcAddress(aDLLHandle, 'plm_create_with_filename');
  plm_create_with_memory := GetProcAddress(aDLLHandle, 'plm_create_with_memory');
  plm_decode := GetProcAddress(aDLLHandle, 'plm_decode');
  plm_decode_audio := GetProcAddress(aDLLHandle, 'plm_decode_audio');
  plm_decode_video := GetProcAddress(aDLLHandle, 'plm_decode_video');
  plm_demux_create := GetProcAddress(aDLLHandle, 'plm_demux_create');
  plm_demux_decode := GetProcAddress(aDLLHandle, 'plm_demux_decode');
  plm_demux_destroy := GetProcAddress(aDLLHandle, 'plm_demux_destroy');
  plm_demux_get_duration := GetProcAddress(aDLLHandle, 'plm_demux_get_duration');
  plm_demux_get_num_audio_streams := GetProcAddress(aDLLHandle, 'plm_demux_get_num_audio_streams');
  plm_demux_get_num_video_streams := GetProcAddress(aDLLHandle, 'plm_demux_get_num_video_streams');
  plm_demux_get_start_time := GetProcAddress(aDLLHandle, 'plm_demux_get_start_time');
  plm_demux_has_ended := GetProcAddress(aDLLHandle, 'plm_demux_has_ended');
  plm_demux_has_headers := GetProcAddress(aDLLHandle, 'plm_demux_has_headers');
  plm_demux_probe := GetProcAddress(aDLLHandle, 'plm_demux_probe');
  plm_demux_rewind := GetProcAddress(aDLLHandle, 'plm_demux_rewind');
  plm_demux_seek := GetProcAddress(aDLLHandle, 'plm_demux_seek');
  plm_destroy := GetProcAddress(aDLLHandle, 'plm_destroy');
  plm_frame_to_abgr := GetProcAddress(aDLLHandle, 'plm_frame_to_abgr');
  plm_frame_to_argb := GetProcAddress(aDLLHandle, 'plm_frame_to_argb');
  plm_frame_to_bgr := GetProcAddress(aDLLHandle, 'plm_frame_to_bgr');
  plm_frame_to_bgra := GetProcAddress(aDLLHandle, 'plm_frame_to_bgra');
  plm_frame_to_rgb := GetProcAddress(aDLLHandle, 'plm_frame_to_rgb');
  plm_frame_to_rgba := GetProcAddress(aDLLHandle, 'plm_frame_to_rgba');
  plm_get_audio_enabled := GetProcAddress(aDLLHandle, 'plm_get_audio_enabled');
  plm_get_audio_lead_time := GetProcAddress(aDLLHandle, 'plm_get_audio_lead_time');
  plm_get_duration := GetProcAddress(aDLLHandle, 'plm_get_duration');
  plm_get_framerate := GetProcAddress(aDLLHandle, 'plm_get_framerate');
  plm_get_height := GetProcAddress(aDLLHandle, 'plm_get_height');
  plm_get_loop := GetProcAddress(aDLLHandle, 'plm_get_loop');
  plm_get_num_audio_streams := GetProcAddress(aDLLHandle, 'plm_get_num_audio_streams');
  plm_get_num_video_streams := GetProcAddress(aDLLHandle, 'plm_get_num_video_streams');
  plm_get_pixel_aspect_ratio := GetProcAddress(aDLLHandle, 'plm_get_pixel_aspect_ratio');
  plm_get_samplerate := GetProcAddress(aDLLHandle, 'plm_get_samplerate');
  plm_get_time := GetProcAddress(aDLLHandle, 'plm_get_time');
  plm_get_video_enabled := GetProcAddress(aDLLHandle, 'plm_get_video_enabled');
  plm_get_width := GetProcAddress(aDLLHandle, 'plm_get_width');
  plm_has_ended := GetProcAddress(aDLLHandle, 'plm_has_ended');
  plm_has_headers := GetProcAddress(aDLLHandle, 'plm_has_headers');
  plm_probe := GetProcAddress(aDLLHandle, 'plm_probe');
  plm_rewind := GetProcAddress(aDLLHandle, 'plm_rewind');
  plm_seek := GetProcAddress(aDLLHandle, 'plm_seek');
  plm_seek_frame := GetProcAddress(aDLLHandle, 'plm_seek_frame');
  plm_set_audio_decode_callback := GetProcAddress(aDLLHandle, 'plm_set_audio_decode_callback');
  plm_set_audio_enabled := GetProcAddress(aDLLHandle, 'plm_set_audio_enabled');
  plm_set_audio_lead_time := GetProcAddress(aDLLHandle, 'plm_set_audio_lead_time');
  plm_set_audio_stream := GetProcAddress(aDLLHandle, 'plm_set_audio_stream');
  plm_set_loop := GetProcAddress(aDLLHandle, 'plm_set_loop');
  plm_set_video_decode_callback := GetProcAddress(aDLLHandle, 'plm_set_video_decode_callback');
  plm_set_video_enabled := GetProcAddress(aDLLHandle, 'plm_set_video_enabled');
  plm_video_create_with_buffer := GetProcAddress(aDLLHandle, 'plm_video_create_with_buffer');
  plm_video_decode := GetProcAddress(aDLLHandle, 'plm_video_decode');
  plm_video_destroy := GetProcAddress(aDLLHandle, 'plm_video_destroy');
  plm_video_get_framerate := GetProcAddress(aDLLHandle, 'plm_video_get_framerate');
  plm_video_get_height := GetProcAddress(aDLLHandle, 'plm_video_get_height');
  plm_video_get_pixel_aspect_ratio := GetProcAddress(aDLLHandle, 'plm_video_get_pixel_aspect_ratio');
  plm_video_get_time := GetProcAddress(aDLLHandle, 'plm_video_get_time');
  plm_video_get_width := GetProcAddress(aDLLHandle, 'plm_video_get_width');
  plm_video_has_ended := GetProcAddress(aDLLHandle, 'plm_video_has_ended');
  plm_video_has_header := GetProcAddress(aDLLHandle, 'plm_video_has_header');
  plm_video_rewind := GetProcAddress(aDLLHandle, 'plm_video_rewind');
  plm_video_set_no_delay := GetProcAddress(aDLLHandle, 'plm_video_set_no_delay');
  plm_video_set_time := GetProcAddress(aDLLHandle, 'plm_video_set_time');
  sfBuffer_create := GetProcAddress(aDLLHandle, 'sfBuffer_create');
  sfBuffer_destroy := GetProcAddress(aDLLHandle, 'sfBuffer_destroy');
  sfBuffer_getData := GetProcAddress(aDLLHandle, 'sfBuffer_getData');
  sfBuffer_getSize := GetProcAddress(aDLLHandle, 'sfBuffer_getSize');
  sfCircleShape_copy := GetProcAddress(aDLLHandle, 'sfCircleShape_copy');
  sfCircleShape_create := GetProcAddress(aDLLHandle, 'sfCircleShape_create');
  sfCircleShape_destroy := GetProcAddress(aDLLHandle, 'sfCircleShape_destroy');
  sfCircleShape_getFillColor := GetProcAddress(aDLLHandle, 'sfCircleShape_getFillColor');
  sfCircleShape_getGeometricCenter := GetProcAddress(aDLLHandle, 'sfCircleShape_getGeometricCenter');
  sfCircleShape_getGlobalBounds := GetProcAddress(aDLLHandle, 'sfCircleShape_getGlobalBounds');
  sfCircleShape_getInverseTransform := GetProcAddress(aDLLHandle, 'sfCircleShape_getInverseTransform');
  sfCircleShape_getLocalBounds := GetProcAddress(aDLLHandle, 'sfCircleShape_getLocalBounds');
  sfCircleShape_getOrigin := GetProcAddress(aDLLHandle, 'sfCircleShape_getOrigin');
  sfCircleShape_getOutlineColor := GetProcAddress(aDLLHandle, 'sfCircleShape_getOutlineColor');
  sfCircleShape_getOutlineThickness := GetProcAddress(aDLLHandle, 'sfCircleShape_getOutlineThickness');
  sfCircleShape_getPoint := GetProcAddress(aDLLHandle, 'sfCircleShape_getPoint');
  sfCircleShape_getPointCount := GetProcAddress(aDLLHandle, 'sfCircleShape_getPointCount');
  sfCircleShape_getPosition := GetProcAddress(aDLLHandle, 'sfCircleShape_getPosition');
  sfCircleShape_getRadius := GetProcAddress(aDLLHandle, 'sfCircleShape_getRadius');
  sfCircleShape_getRotation := GetProcAddress(aDLLHandle, 'sfCircleShape_getRotation');
  sfCircleShape_getScale := GetProcAddress(aDLLHandle, 'sfCircleShape_getScale');
  sfCircleShape_getTexture := GetProcAddress(aDLLHandle, 'sfCircleShape_getTexture');
  sfCircleShape_getTextureRect := GetProcAddress(aDLLHandle, 'sfCircleShape_getTextureRect');
  sfCircleShape_getTransform := GetProcAddress(aDLLHandle, 'sfCircleShape_getTransform');
  sfCircleShape_move := GetProcAddress(aDLLHandle, 'sfCircleShape_move');
  sfCircleShape_rotate := GetProcAddress(aDLLHandle, 'sfCircleShape_rotate');
  sfCircleShape_scale := GetProcAddress(aDLLHandle, 'sfCircleShape_scale');
  sfCircleShape_setFillColor := GetProcAddress(aDLLHandle, 'sfCircleShape_setFillColor');
  sfCircleShape_setOrigin := GetProcAddress(aDLLHandle, 'sfCircleShape_setOrigin');
  sfCircleShape_setOutlineColor := GetProcAddress(aDLLHandle, 'sfCircleShape_setOutlineColor');
  sfCircleShape_setOutlineThickness := GetProcAddress(aDLLHandle, 'sfCircleShape_setOutlineThickness');
  sfCircleShape_setPointCount := GetProcAddress(aDLLHandle, 'sfCircleShape_setPointCount');
  sfCircleShape_setPosition := GetProcAddress(aDLLHandle, 'sfCircleShape_setPosition');
  sfCircleShape_setRadius := GetProcAddress(aDLLHandle, 'sfCircleShape_setRadius');
  sfCircleShape_setRotation := GetProcAddress(aDLLHandle, 'sfCircleShape_setRotation');
  sfCircleShape_setScale := GetProcAddress(aDLLHandle, 'sfCircleShape_setScale');
  sfCircleShape_setTexture := GetProcAddress(aDLLHandle, 'sfCircleShape_setTexture');
  sfCircleShape_setTextureRect := GetProcAddress(aDLLHandle, 'sfCircleShape_setTextureRect');
  sfClipboard_getString := GetProcAddress(aDLLHandle, 'sfClipboard_getString');
  sfClipboard_getUnicodeString := GetProcAddress(aDLLHandle, 'sfClipboard_getUnicodeString');
  sfClipboard_setString := GetProcAddress(aDLLHandle, 'sfClipboard_setString');
  sfClipboard_setUnicodeString := GetProcAddress(aDLLHandle, 'sfClipboard_setUnicodeString');
  sfClock_copy := GetProcAddress(aDLLHandle, 'sfClock_copy');
  sfClock_create := GetProcAddress(aDLLHandle, 'sfClock_create');
  sfClock_destroy := GetProcAddress(aDLLHandle, 'sfClock_destroy');
  sfClock_getElapsedTime := GetProcAddress(aDLLHandle, 'sfClock_getElapsedTime');
  sfClock_isRunning := GetProcAddress(aDLLHandle, 'sfClock_isRunning');
  sfClock_reset := GetProcAddress(aDLLHandle, 'sfClock_reset');
  sfClock_restart := GetProcAddress(aDLLHandle, 'sfClock_restart');
  sfClock_start := GetProcAddress(aDLLHandle, 'sfClock_start');
  sfClock_stop := GetProcAddress(aDLLHandle, 'sfClock_stop');
  sfColor_add := GetProcAddress(aDLLHandle, 'sfColor_add');
  sfColor_fromInteger := GetProcAddress(aDLLHandle, 'sfColor_fromInteger');
  sfColor_fromRGB := GetProcAddress(aDLLHandle, 'sfColor_fromRGB');
  sfColor_fromRGBA := GetProcAddress(aDLLHandle, 'sfColor_fromRGBA');
  sfColor_modulate := GetProcAddress(aDLLHandle, 'sfColor_modulate');
  sfColor_subtract := GetProcAddress(aDLLHandle, 'sfColor_subtract');
  sfColor_toInteger := GetProcAddress(aDLLHandle, 'sfColor_toInteger');
  sfContext_create := GetProcAddress(aDLLHandle, 'sfContext_create');
  sfContext_destroy := GetProcAddress(aDLLHandle, 'sfContext_destroy');
  sfContext_getActiveContextId := GetProcAddress(aDLLHandle, 'sfContext_getActiveContextId');
  sfContext_getFunction := GetProcAddress(aDLLHandle, 'sfContext_getFunction');
  sfContext_getSettings := GetProcAddress(aDLLHandle, 'sfContext_getSettings');
  sfContext_isExtensionAvailable := GetProcAddress(aDLLHandle, 'sfContext_isExtensionAvailable');
  sfContext_setActive := GetProcAddress(aDLLHandle, 'sfContext_setActive');
  sfConvexShape_copy := GetProcAddress(aDLLHandle, 'sfConvexShape_copy');
  sfConvexShape_create := GetProcAddress(aDLLHandle, 'sfConvexShape_create');
  sfConvexShape_destroy := GetProcAddress(aDLLHandle, 'sfConvexShape_destroy');
  sfConvexShape_getFillColor := GetProcAddress(aDLLHandle, 'sfConvexShape_getFillColor');
  sfConvexShape_getGeometricCenter := GetProcAddress(aDLLHandle, 'sfConvexShape_getGeometricCenter');
  sfConvexShape_getGlobalBounds := GetProcAddress(aDLLHandle, 'sfConvexShape_getGlobalBounds');
  sfConvexShape_getInverseTransform := GetProcAddress(aDLLHandle, 'sfConvexShape_getInverseTransform');
  sfConvexShape_getLocalBounds := GetProcAddress(aDLLHandle, 'sfConvexShape_getLocalBounds');
  sfConvexShape_getOrigin := GetProcAddress(aDLLHandle, 'sfConvexShape_getOrigin');
  sfConvexShape_getOutlineColor := GetProcAddress(aDLLHandle, 'sfConvexShape_getOutlineColor');
  sfConvexShape_getOutlineThickness := GetProcAddress(aDLLHandle, 'sfConvexShape_getOutlineThickness');
  sfConvexShape_getPoint := GetProcAddress(aDLLHandle, 'sfConvexShape_getPoint');
  sfConvexShape_getPointCount := GetProcAddress(aDLLHandle, 'sfConvexShape_getPointCount');
  sfConvexShape_getPosition := GetProcAddress(aDLLHandle, 'sfConvexShape_getPosition');
  sfConvexShape_getRotation := GetProcAddress(aDLLHandle, 'sfConvexShape_getRotation');
  sfConvexShape_getScale := GetProcAddress(aDLLHandle, 'sfConvexShape_getScale');
  sfConvexShape_getTexture := GetProcAddress(aDLLHandle, 'sfConvexShape_getTexture');
  sfConvexShape_getTextureRect := GetProcAddress(aDLLHandle, 'sfConvexShape_getTextureRect');
  sfConvexShape_getTransform := GetProcAddress(aDLLHandle, 'sfConvexShape_getTransform');
  sfConvexShape_move := GetProcAddress(aDLLHandle, 'sfConvexShape_move');
  sfConvexShape_rotate := GetProcAddress(aDLLHandle, 'sfConvexShape_rotate');
  sfConvexShape_scale := GetProcAddress(aDLLHandle, 'sfConvexShape_scale');
  sfConvexShape_setFillColor := GetProcAddress(aDLLHandle, 'sfConvexShape_setFillColor');
  sfConvexShape_setOrigin := GetProcAddress(aDLLHandle, 'sfConvexShape_setOrigin');
  sfConvexShape_setOutlineColor := GetProcAddress(aDLLHandle, 'sfConvexShape_setOutlineColor');
  sfConvexShape_setOutlineThickness := GetProcAddress(aDLLHandle, 'sfConvexShape_setOutlineThickness');
  sfConvexShape_setPoint := GetProcAddress(aDLLHandle, 'sfConvexShape_setPoint');
  sfConvexShape_setPointCount := GetProcAddress(aDLLHandle, 'sfConvexShape_setPointCount');
  sfConvexShape_setPosition := GetProcAddress(aDLLHandle, 'sfConvexShape_setPosition');
  sfConvexShape_setRotation := GetProcAddress(aDLLHandle, 'sfConvexShape_setRotation');
  sfConvexShape_setScale := GetProcAddress(aDLLHandle, 'sfConvexShape_setScale');
  sfConvexShape_setTexture := GetProcAddress(aDLLHandle, 'sfConvexShape_setTexture');
  sfConvexShape_setTextureRect := GetProcAddress(aDLLHandle, 'sfConvexShape_setTextureRect');
  sfCursor_createFromPixels := GetProcAddress(aDLLHandle, 'sfCursor_createFromPixels');
  sfCursor_createFromSystem := GetProcAddress(aDLLHandle, 'sfCursor_createFromSystem');
  sfCursor_destroy := GetProcAddress(aDLLHandle, 'sfCursor_destroy');
  sfFloatRect_contains := GetProcAddress(aDLLHandle, 'sfFloatRect_contains');
  sfFloatRect_intersects := GetProcAddress(aDLLHandle, 'sfFloatRect_intersects');
  sfFont_copy := GetProcAddress(aDLLHandle, 'sfFont_copy');
  sfFont_createFromFile := GetProcAddress(aDLLHandle, 'sfFont_createFromFile');
  sfFont_createFromMemory := GetProcAddress(aDLLHandle, 'sfFont_createFromMemory');
  sfFont_createFromStream := GetProcAddress(aDLLHandle, 'sfFont_createFromStream');
  sfFont_destroy := GetProcAddress(aDLLHandle, 'sfFont_destroy');
  sfFont_getBoldKerning := GetProcAddress(aDLLHandle, 'sfFont_getBoldKerning');
  sfFont_getGlyph := GetProcAddress(aDLLHandle, 'sfFont_getGlyph');
  sfFont_getInfo := GetProcAddress(aDLLHandle, 'sfFont_getInfo');
  sfFont_getKerning := GetProcAddress(aDLLHandle, 'sfFont_getKerning');
  sfFont_getLineSpacing := GetProcAddress(aDLLHandle, 'sfFont_getLineSpacing');
  sfFont_getTexture := GetProcAddress(aDLLHandle, 'sfFont_getTexture');
  sfFont_getUnderlinePosition := GetProcAddress(aDLLHandle, 'sfFont_getUnderlinePosition');
  sfFont_getUnderlineThickness := GetProcAddress(aDLLHandle, 'sfFont_getUnderlineThickness');
  sfFont_hasGlyph := GetProcAddress(aDLLHandle, 'sfFont_hasGlyph');
  sfFont_isSmooth := GetProcAddress(aDLLHandle, 'sfFont_isSmooth');
  sfFont_setSmooth := GetProcAddress(aDLLHandle, 'sfFont_setSmooth');
  sfFtp_changeDirectory := GetProcAddress(aDLLHandle, 'sfFtp_changeDirectory');
  sfFtp_connect := GetProcAddress(aDLLHandle, 'sfFtp_connect');
  sfFtp_create := GetProcAddress(aDLLHandle, 'sfFtp_create');
  sfFtp_createDirectory := GetProcAddress(aDLLHandle, 'sfFtp_createDirectory');
  sfFtp_deleteDirectory := GetProcAddress(aDLLHandle, 'sfFtp_deleteDirectory');
  sfFtp_deleteFile := GetProcAddress(aDLLHandle, 'sfFtp_deleteFile');
  sfFtp_destroy := GetProcAddress(aDLLHandle, 'sfFtp_destroy');
  sfFtp_disconnect := GetProcAddress(aDLLHandle, 'sfFtp_disconnect');
  sfFtp_download := GetProcAddress(aDLLHandle, 'sfFtp_download');
  sfFtp_getDirectoryListing := GetProcAddress(aDLLHandle, 'sfFtp_getDirectoryListing');
  sfFtp_getWorkingDirectory := GetProcAddress(aDLLHandle, 'sfFtp_getWorkingDirectory');
  sfFtp_keepAlive := GetProcAddress(aDLLHandle, 'sfFtp_keepAlive');
  sfFtp_login := GetProcAddress(aDLLHandle, 'sfFtp_login');
  sfFtp_loginAnonymous := GetProcAddress(aDLLHandle, 'sfFtp_loginAnonymous');
  sfFtp_parentDirectory := GetProcAddress(aDLLHandle, 'sfFtp_parentDirectory');
  sfFtp_renameFile := GetProcAddress(aDLLHandle, 'sfFtp_renameFile');
  sfFtp_sendCommand := GetProcAddress(aDLLHandle, 'sfFtp_sendCommand');
  sfFtp_upload := GetProcAddress(aDLLHandle, 'sfFtp_upload');
  sfFtpDirectoryResponse_destroy := GetProcAddress(aDLLHandle, 'sfFtpDirectoryResponse_destroy');
  sfFtpDirectoryResponse_getDirectory := GetProcAddress(aDLLHandle, 'sfFtpDirectoryResponse_getDirectory');
  sfFtpDirectoryResponse_getDirectoryUnicode := GetProcAddress(aDLLHandle, 'sfFtpDirectoryResponse_getDirectoryUnicode');
  sfFtpDirectoryResponse_getMessage := GetProcAddress(aDLLHandle, 'sfFtpDirectoryResponse_getMessage');
  sfFtpDirectoryResponse_getStatus := GetProcAddress(aDLLHandle, 'sfFtpDirectoryResponse_getStatus');
  sfFtpDirectoryResponse_isOk := GetProcAddress(aDLLHandle, 'sfFtpDirectoryResponse_isOk');
  sfFtpListingResponse_destroy := GetProcAddress(aDLLHandle, 'sfFtpListingResponse_destroy');
  sfFtpListingResponse_getCount := GetProcAddress(aDLLHandle, 'sfFtpListingResponse_getCount');
  sfFtpListingResponse_getMessage := GetProcAddress(aDLLHandle, 'sfFtpListingResponse_getMessage');
  sfFtpListingResponse_getName := GetProcAddress(aDLLHandle, 'sfFtpListingResponse_getName');
  sfFtpListingResponse_getStatus := GetProcAddress(aDLLHandle, 'sfFtpListingResponse_getStatus');
  sfFtpListingResponse_isOk := GetProcAddress(aDLLHandle, 'sfFtpListingResponse_isOk');
  sfFtpResponse_destroy := GetProcAddress(aDLLHandle, 'sfFtpResponse_destroy');
  sfFtpResponse_getMessage := GetProcAddress(aDLLHandle, 'sfFtpResponse_getMessage');
  sfFtpResponse_getStatus := GetProcAddress(aDLLHandle, 'sfFtpResponse_getStatus');
  sfFtpResponse_isOk := GetProcAddress(aDLLHandle, 'sfFtpResponse_isOk');
  sfHttp_create := GetProcAddress(aDLLHandle, 'sfHttp_create');
  sfHttp_destroy := GetProcAddress(aDLLHandle, 'sfHttp_destroy');
  sfHttp_sendRequest := GetProcAddress(aDLLHandle, 'sfHttp_sendRequest');
  sfHttp_setHost := GetProcAddress(aDLLHandle, 'sfHttp_setHost');
  sfHttpRequest_create := GetProcAddress(aDLLHandle, 'sfHttpRequest_create');
  sfHttpRequest_destroy := GetProcAddress(aDLLHandle, 'sfHttpRequest_destroy');
  sfHttpRequest_setBody := GetProcAddress(aDLLHandle, 'sfHttpRequest_setBody');
  sfHttpRequest_setField := GetProcAddress(aDLLHandle, 'sfHttpRequest_setField');
  sfHttpRequest_setHttpVersion := GetProcAddress(aDLLHandle, 'sfHttpRequest_setHttpVersion');
  sfHttpRequest_setMethod := GetProcAddress(aDLLHandle, 'sfHttpRequest_setMethod');
  sfHttpRequest_setUri := GetProcAddress(aDLLHandle, 'sfHttpRequest_setUri');
  sfHttpResponse_destroy := GetProcAddress(aDLLHandle, 'sfHttpResponse_destroy');
  sfHttpResponse_getBody := GetProcAddress(aDLLHandle, 'sfHttpResponse_getBody');
  sfHttpResponse_getField := GetProcAddress(aDLLHandle, 'sfHttpResponse_getField');
  sfHttpResponse_getMajorVersion := GetProcAddress(aDLLHandle, 'sfHttpResponse_getMajorVersion');
  sfHttpResponse_getMinorVersion := GetProcAddress(aDLLHandle, 'sfHttpResponse_getMinorVersion');
  sfHttpResponse_getStatus := GetProcAddress(aDLLHandle, 'sfHttpResponse_getStatus');
  sfImage_copy := GetProcAddress(aDLLHandle, 'sfImage_copy');
  sfImage_copyImage := GetProcAddress(aDLLHandle, 'sfImage_copyImage');
  sfImage_create := GetProcAddress(aDLLHandle, 'sfImage_create');
  sfImage_createFromColor := GetProcAddress(aDLLHandle, 'sfImage_createFromColor');
  sfImage_createFromFile := GetProcAddress(aDLLHandle, 'sfImage_createFromFile');
  sfImage_createFromMemory := GetProcAddress(aDLLHandle, 'sfImage_createFromMemory');
  sfImage_createFromPixels := GetProcAddress(aDLLHandle, 'sfImage_createFromPixels');
  sfImage_createFromStream := GetProcAddress(aDLLHandle, 'sfImage_createFromStream');
  sfImage_createMaskFromColor := GetProcAddress(aDLLHandle, 'sfImage_createMaskFromColor');
  sfImage_destroy := GetProcAddress(aDLLHandle, 'sfImage_destroy');
  sfImage_flipHorizontally := GetProcAddress(aDLLHandle, 'sfImage_flipHorizontally');
  sfImage_flipVertically := GetProcAddress(aDLLHandle, 'sfImage_flipVertically');
  sfImage_getPixel := GetProcAddress(aDLLHandle, 'sfImage_getPixel');
  sfImage_getPixelsPtr := GetProcAddress(aDLLHandle, 'sfImage_getPixelsPtr');
  sfImage_getSize := GetProcAddress(aDLLHandle, 'sfImage_getSize');
  sfImage_saveToFile := GetProcAddress(aDLLHandle, 'sfImage_saveToFile');
  sfImage_saveToMemory := GetProcAddress(aDLLHandle, 'sfImage_saveToMemory');
  sfImage_setPixel := GetProcAddress(aDLLHandle, 'sfImage_setPixel');
  sfIntRect_contains := GetProcAddress(aDLLHandle, 'sfIntRect_contains');
  sfIntRect_intersects := GetProcAddress(aDLLHandle, 'sfIntRect_intersects');
  sfIpAddress_fromBytes := GetProcAddress(aDLLHandle, 'sfIpAddress_fromBytes');
  sfIpAddress_fromInteger := GetProcAddress(aDLLHandle, 'sfIpAddress_fromInteger');
  sfIpAddress_fromString := GetProcAddress(aDLLHandle, 'sfIpAddress_fromString');
  sfIpAddress_getLocalAddress := GetProcAddress(aDLLHandle, 'sfIpAddress_getLocalAddress');
  sfIpAddress_getPublicAddress := GetProcAddress(aDLLHandle, 'sfIpAddress_getPublicAddress');
  sfIpAddress_toInteger := GetProcAddress(aDLLHandle, 'sfIpAddress_toInteger');
  sfIpAddress_toString := GetProcAddress(aDLLHandle, 'sfIpAddress_toString');
  sfJoystick_getAxisPosition := GetProcAddress(aDLLHandle, 'sfJoystick_getAxisPosition');
  sfJoystick_getButtonCount := GetProcAddress(aDLLHandle, 'sfJoystick_getButtonCount');
  sfJoystick_getIdentification := GetProcAddress(aDLLHandle, 'sfJoystick_getIdentification');
  sfJoystick_hasAxis := GetProcAddress(aDLLHandle, 'sfJoystick_hasAxis');
  sfJoystick_isButtonPressed := GetProcAddress(aDLLHandle, 'sfJoystick_isButtonPressed');
  sfJoystick_isConnected := GetProcAddress(aDLLHandle, 'sfJoystick_isConnected');
  sfJoystick_update := GetProcAddress(aDLLHandle, 'sfJoystick_update');
  sfKeyboard_delocalize := GetProcAddress(aDLLHandle, 'sfKeyboard_delocalize');
  sfKeyboard_getDescription := GetProcAddress(aDLLHandle, 'sfKeyboard_getDescription');
  sfKeyboard_isKeyPressed := GetProcAddress(aDLLHandle, 'sfKeyboard_isKeyPressed');
  sfKeyboard_isScancodePressed := GetProcAddress(aDLLHandle, 'sfKeyboard_isScancodePressed');
  sfKeyboard_localize := GetProcAddress(aDLLHandle, 'sfKeyboard_localize');
  sfKeyboard_setVirtualKeyboardVisible := GetProcAddress(aDLLHandle, 'sfKeyboard_setVirtualKeyboardVisible');
  sfListener_getCone := GetProcAddress(aDLLHandle, 'sfListener_getCone');
  sfListener_getDirection := GetProcAddress(aDLLHandle, 'sfListener_getDirection');
  sfListener_getGlobalVolume := GetProcAddress(aDLLHandle, 'sfListener_getGlobalVolume');
  sfListener_getPosition := GetProcAddress(aDLLHandle, 'sfListener_getPosition');
  sfListener_getUpVector := GetProcAddress(aDLLHandle, 'sfListener_getUpVector');
  sfListener_getVelocity := GetProcAddress(aDLLHandle, 'sfListener_getVelocity');
  sfListener_setCone := GetProcAddress(aDLLHandle, 'sfListener_setCone');
  sfListener_setDirection := GetProcAddress(aDLLHandle, 'sfListener_setDirection');
  sfListener_setGlobalVolume := GetProcAddress(aDLLHandle, 'sfListener_setGlobalVolume');
  sfListener_setPosition := GetProcAddress(aDLLHandle, 'sfListener_setPosition');
  sfListener_setUpVector := GetProcAddress(aDLLHandle, 'sfListener_setUpVector');
  sfListener_setVelocity := GetProcAddress(aDLLHandle, 'sfListener_setVelocity');
  sfMicroseconds := GetProcAddress(aDLLHandle, 'sfMicroseconds');
  sfMilliseconds := GetProcAddress(aDLLHandle, 'sfMilliseconds');
  sfMouse_getPosition := GetProcAddress(aDLLHandle, 'sfMouse_getPosition');
  sfMouse_getPositionRenderWindow := GetProcAddress(aDLLHandle, 'sfMouse_getPositionRenderWindow');
  sfMouse_getPositionWindowBase := GetProcAddress(aDLLHandle, 'sfMouse_getPositionWindowBase');
  sfMouse_isButtonPressed := GetProcAddress(aDLLHandle, 'sfMouse_isButtonPressed');
  sfMouse_setPosition := GetProcAddress(aDLLHandle, 'sfMouse_setPosition');
  sfMouse_setPositionRenderWindow := GetProcAddress(aDLLHandle, 'sfMouse_setPositionRenderWindow');
  sfMouse_setPositionWindowBase := GetProcAddress(aDLLHandle, 'sfMouse_setPositionWindowBase');
  sfMusic_createFromFile := GetProcAddress(aDLLHandle, 'sfMusic_createFromFile');
  sfMusic_createFromMemory := GetProcAddress(aDLLHandle, 'sfMusic_createFromMemory');
  sfMusic_createFromStream := GetProcAddress(aDLLHandle, 'sfMusic_createFromStream');
  sfMusic_destroy := GetProcAddress(aDLLHandle, 'sfMusic_destroy');
  sfMusic_getAttenuation := GetProcAddress(aDLLHandle, 'sfMusic_getAttenuation');
  sfMusic_getChannelCount := GetProcAddress(aDLLHandle, 'sfMusic_getChannelCount');
  sfMusic_getChannelMap := GetProcAddress(aDLLHandle, 'sfMusic_getChannelMap');
  sfMusic_getCone := GetProcAddress(aDLLHandle, 'sfMusic_getCone');
  sfMusic_getDirection := GetProcAddress(aDLLHandle, 'sfMusic_getDirection');
  sfMusic_getDirectionalAttenuationFactor := GetProcAddress(aDLLHandle, 'sfMusic_getDirectionalAttenuationFactor');
  sfMusic_getDopplerFactor := GetProcAddress(aDLLHandle, 'sfMusic_getDopplerFactor');
  sfMusic_getDuration := GetProcAddress(aDLLHandle, 'sfMusic_getDuration');
  sfMusic_getLoopPoints := GetProcAddress(aDLLHandle, 'sfMusic_getLoopPoints');
  sfMusic_getMaxDistance := GetProcAddress(aDLLHandle, 'sfMusic_getMaxDistance');
  sfMusic_getMaxGain := GetProcAddress(aDLLHandle, 'sfMusic_getMaxGain');
  sfMusic_getMinDistance := GetProcAddress(aDLLHandle, 'sfMusic_getMinDistance');
  sfMusic_getMinGain := GetProcAddress(aDLLHandle, 'sfMusic_getMinGain');
  sfMusic_getPan := GetProcAddress(aDLLHandle, 'sfMusic_getPan');
  sfMusic_getPitch := GetProcAddress(aDLLHandle, 'sfMusic_getPitch');
  sfMusic_getPlayingOffset := GetProcAddress(aDLLHandle, 'sfMusic_getPlayingOffset');
  sfMusic_getPosition := GetProcAddress(aDLLHandle, 'sfMusic_getPosition');
  sfMusic_getSampleRate := GetProcAddress(aDLLHandle, 'sfMusic_getSampleRate');
  sfMusic_getStatus := GetProcAddress(aDLLHandle, 'sfMusic_getStatus');
  sfMusic_getVelocity := GetProcAddress(aDLLHandle, 'sfMusic_getVelocity');
  sfMusic_getVolume := GetProcAddress(aDLLHandle, 'sfMusic_getVolume');
  sfMusic_isLooping := GetProcAddress(aDLLHandle, 'sfMusic_isLooping');
  sfMusic_isRelativeToListener := GetProcAddress(aDLLHandle, 'sfMusic_isRelativeToListener');
  sfMusic_isSpatializationEnabled := GetProcAddress(aDLLHandle, 'sfMusic_isSpatializationEnabled');
  sfMusic_pause := GetProcAddress(aDLLHandle, 'sfMusic_pause');
  sfMusic_play := GetProcAddress(aDLLHandle, 'sfMusic_play');
  sfMusic_setAttenuation := GetProcAddress(aDLLHandle, 'sfMusic_setAttenuation');
  sfMusic_setCone := GetProcAddress(aDLLHandle, 'sfMusic_setCone');
  sfMusic_setDirection := GetProcAddress(aDLLHandle, 'sfMusic_setDirection');
  sfMusic_setDirectionalAttenuationFactor := GetProcAddress(aDLLHandle, 'sfMusic_setDirectionalAttenuationFactor');
  sfMusic_setDopplerFactor := GetProcAddress(aDLLHandle, 'sfMusic_setDopplerFactor');
  sfMusic_setEffectProcessor := GetProcAddress(aDLLHandle, 'sfMusic_setEffectProcessor');
  sfMusic_setLooping := GetProcAddress(aDLLHandle, 'sfMusic_setLooping');
  sfMusic_setLoopPoints := GetProcAddress(aDLLHandle, 'sfMusic_setLoopPoints');
  sfMusic_setMaxDistance := GetProcAddress(aDLLHandle, 'sfMusic_setMaxDistance');
  sfMusic_setMaxGain := GetProcAddress(aDLLHandle, 'sfMusic_setMaxGain');
  sfMusic_setMinDistance := GetProcAddress(aDLLHandle, 'sfMusic_setMinDistance');
  sfMusic_setMinGain := GetProcAddress(aDLLHandle, 'sfMusic_setMinGain');
  sfMusic_setPan := GetProcAddress(aDLLHandle, 'sfMusic_setPan');
  sfMusic_setPitch := GetProcAddress(aDLLHandle, 'sfMusic_setPitch');
  sfMusic_setPlayingOffset := GetProcAddress(aDLLHandle, 'sfMusic_setPlayingOffset');
  sfMusic_setPosition := GetProcAddress(aDLLHandle, 'sfMusic_setPosition');
  sfMusic_setRelativeToListener := GetProcAddress(aDLLHandle, 'sfMusic_setRelativeToListener');
  sfMusic_setSpatializationEnabled := GetProcAddress(aDLLHandle, 'sfMusic_setSpatializationEnabled');
  sfMusic_setVelocity := GetProcAddress(aDLLHandle, 'sfMusic_setVelocity');
  sfMusic_setVolume := GetProcAddress(aDLLHandle, 'sfMusic_setVolume');
  sfMusic_stop := GetProcAddress(aDLLHandle, 'sfMusic_stop');
  sfPacket_append := GetProcAddress(aDLLHandle, 'sfPacket_append');
  sfPacket_canRead := GetProcAddress(aDLLHandle, 'sfPacket_canRead');
  sfPacket_clear := GetProcAddress(aDLLHandle, 'sfPacket_clear');
  sfPacket_copy := GetProcAddress(aDLLHandle, 'sfPacket_copy');
  sfPacket_create := GetProcAddress(aDLLHandle, 'sfPacket_create');
  sfPacket_destroy := GetProcAddress(aDLLHandle, 'sfPacket_destroy');
  sfPacket_endOfPacket := GetProcAddress(aDLLHandle, 'sfPacket_endOfPacket');
  sfPacket_getData := GetProcAddress(aDLLHandle, 'sfPacket_getData');
  sfPacket_getDataSize := GetProcAddress(aDLLHandle, 'sfPacket_getDataSize');
  sfPacket_getReadPosition := GetProcAddress(aDLLHandle, 'sfPacket_getReadPosition');
  sfPacket_readBool := GetProcAddress(aDLLHandle, 'sfPacket_readBool');
  sfPacket_readDouble := GetProcAddress(aDLLHandle, 'sfPacket_readDouble');
  sfPacket_readFloat := GetProcAddress(aDLLHandle, 'sfPacket_readFloat');
  sfPacket_readInt16 := GetProcAddress(aDLLHandle, 'sfPacket_readInt16');
  sfPacket_readInt32 := GetProcAddress(aDLLHandle, 'sfPacket_readInt32');
  sfPacket_readInt8 := GetProcAddress(aDLLHandle, 'sfPacket_readInt8');
  sfPacket_readString := GetProcAddress(aDLLHandle, 'sfPacket_readString');
  sfPacket_readUint16 := GetProcAddress(aDLLHandle, 'sfPacket_readUint16');
  sfPacket_readUint32 := GetProcAddress(aDLLHandle, 'sfPacket_readUint32');
  sfPacket_readUint8 := GetProcAddress(aDLLHandle, 'sfPacket_readUint8');
  sfPacket_readWideString := GetProcAddress(aDLLHandle, 'sfPacket_readWideString');
  sfPacket_writeBool := GetProcAddress(aDLLHandle, 'sfPacket_writeBool');
  sfPacket_writeDouble := GetProcAddress(aDLLHandle, 'sfPacket_writeDouble');
  sfPacket_writeFloat := GetProcAddress(aDLLHandle, 'sfPacket_writeFloat');
  sfPacket_writeInt16 := GetProcAddress(aDLLHandle, 'sfPacket_writeInt16');
  sfPacket_writeInt32 := GetProcAddress(aDLLHandle, 'sfPacket_writeInt32');
  sfPacket_writeInt8 := GetProcAddress(aDLLHandle, 'sfPacket_writeInt8');
  sfPacket_writeString := GetProcAddress(aDLLHandle, 'sfPacket_writeString');
  sfPacket_writeUint16 := GetProcAddress(aDLLHandle, 'sfPacket_writeUint16');
  sfPacket_writeUint32 := GetProcAddress(aDLLHandle, 'sfPacket_writeUint32');
  sfPacket_writeUint8 := GetProcAddress(aDLLHandle, 'sfPacket_writeUint8');
  sfPacket_writeWideString := GetProcAddress(aDLLHandle, 'sfPacket_writeWideString');
  sfRectangleShape_copy := GetProcAddress(aDLLHandle, 'sfRectangleShape_copy');
  sfRectangleShape_create := GetProcAddress(aDLLHandle, 'sfRectangleShape_create');
  sfRectangleShape_destroy := GetProcAddress(aDLLHandle, 'sfRectangleShape_destroy');
  sfRectangleShape_getFillColor := GetProcAddress(aDLLHandle, 'sfRectangleShape_getFillColor');
  sfRectangleShape_getGeometricCenter := GetProcAddress(aDLLHandle, 'sfRectangleShape_getGeometricCenter');
  sfRectangleShape_getGlobalBounds := GetProcAddress(aDLLHandle, 'sfRectangleShape_getGlobalBounds');
  sfRectangleShape_getInverseTransform := GetProcAddress(aDLLHandle, 'sfRectangleShape_getInverseTransform');
  sfRectangleShape_getLocalBounds := GetProcAddress(aDLLHandle, 'sfRectangleShape_getLocalBounds');
  sfRectangleShape_getOrigin := GetProcAddress(aDLLHandle, 'sfRectangleShape_getOrigin');
  sfRectangleShape_getOutlineColor := GetProcAddress(aDLLHandle, 'sfRectangleShape_getOutlineColor');
  sfRectangleShape_getOutlineThickness := GetProcAddress(aDLLHandle, 'sfRectangleShape_getOutlineThickness');
  sfRectangleShape_getPoint := GetProcAddress(aDLLHandle, 'sfRectangleShape_getPoint');
  sfRectangleShape_getPointCount := GetProcAddress(aDLLHandle, 'sfRectangleShape_getPointCount');
  sfRectangleShape_getPosition := GetProcAddress(aDLLHandle, 'sfRectangleShape_getPosition');
  sfRectangleShape_getRotation := GetProcAddress(aDLLHandle, 'sfRectangleShape_getRotation');
  sfRectangleShape_getScale := GetProcAddress(aDLLHandle, 'sfRectangleShape_getScale');
  sfRectangleShape_getSize := GetProcAddress(aDLLHandle, 'sfRectangleShape_getSize');
  sfRectangleShape_getTexture := GetProcAddress(aDLLHandle, 'sfRectangleShape_getTexture');
  sfRectangleShape_getTextureRect := GetProcAddress(aDLLHandle, 'sfRectangleShape_getTextureRect');
  sfRectangleShape_getTransform := GetProcAddress(aDLLHandle, 'sfRectangleShape_getTransform');
  sfRectangleShape_move := GetProcAddress(aDLLHandle, 'sfRectangleShape_move');
  sfRectangleShape_rotate := GetProcAddress(aDLLHandle, 'sfRectangleShape_rotate');
  sfRectangleShape_scale := GetProcAddress(aDLLHandle, 'sfRectangleShape_scale');
  sfRectangleShape_setFillColor := GetProcAddress(aDLLHandle, 'sfRectangleShape_setFillColor');
  sfRectangleShape_setOrigin := GetProcAddress(aDLLHandle, 'sfRectangleShape_setOrigin');
  sfRectangleShape_setOutlineColor := GetProcAddress(aDLLHandle, 'sfRectangleShape_setOutlineColor');
  sfRectangleShape_setOutlineThickness := GetProcAddress(aDLLHandle, 'sfRectangleShape_setOutlineThickness');
  sfRectangleShape_setPosition := GetProcAddress(aDLLHandle, 'sfRectangleShape_setPosition');
  sfRectangleShape_setRotation := GetProcAddress(aDLLHandle, 'sfRectangleShape_setRotation');
  sfRectangleShape_setScale := GetProcAddress(aDLLHandle, 'sfRectangleShape_setScale');
  sfRectangleShape_setSize := GetProcAddress(aDLLHandle, 'sfRectangleShape_setSize');
  sfRectangleShape_setTexture := GetProcAddress(aDLLHandle, 'sfRectangleShape_setTexture');
  sfRectangleShape_setTextureRect := GetProcAddress(aDLLHandle, 'sfRectangleShape_setTextureRect');
  sfRenderTexture_clear := GetProcAddress(aDLLHandle, 'sfRenderTexture_clear');
  sfRenderTexture_clearColorAndStencil := GetProcAddress(aDLLHandle, 'sfRenderTexture_clearColorAndStencil');
  sfRenderTexture_clearStencil := GetProcAddress(aDLLHandle, 'sfRenderTexture_clearStencil');
  sfRenderTexture_create := GetProcAddress(aDLLHandle, 'sfRenderTexture_create');
  sfRenderTexture_destroy := GetProcAddress(aDLLHandle, 'sfRenderTexture_destroy');
  sfRenderTexture_display := GetProcAddress(aDLLHandle, 'sfRenderTexture_display');
  sfRenderTexture_drawCircleShape := GetProcAddress(aDLLHandle, 'sfRenderTexture_drawCircleShape');
  sfRenderTexture_drawConvexShape := GetProcAddress(aDLLHandle, 'sfRenderTexture_drawConvexShape');
  sfRenderTexture_drawPrimitives := GetProcAddress(aDLLHandle, 'sfRenderTexture_drawPrimitives');
  sfRenderTexture_drawRectangleShape := GetProcAddress(aDLLHandle, 'sfRenderTexture_drawRectangleShape');
  sfRenderTexture_drawShape := GetProcAddress(aDLLHandle, 'sfRenderTexture_drawShape');
  sfRenderTexture_drawSprite := GetProcAddress(aDLLHandle, 'sfRenderTexture_drawSprite');
  sfRenderTexture_drawText := GetProcAddress(aDLLHandle, 'sfRenderTexture_drawText');
  sfRenderTexture_drawVertexArray := GetProcAddress(aDLLHandle, 'sfRenderTexture_drawVertexArray');
  sfRenderTexture_drawVertexBuffer := GetProcAddress(aDLLHandle, 'sfRenderTexture_drawVertexBuffer');
  sfRenderTexture_drawVertexBufferRange := GetProcAddress(aDLLHandle, 'sfRenderTexture_drawVertexBufferRange');
  sfRenderTexture_generateMipmap := GetProcAddress(aDLLHandle, 'sfRenderTexture_generateMipmap');
  sfRenderTexture_getDefaultView := GetProcAddress(aDLLHandle, 'sfRenderTexture_getDefaultView');
  sfRenderTexture_getMaximumAntiAliasingLevel := GetProcAddress(aDLLHandle, 'sfRenderTexture_getMaximumAntiAliasingLevel');
  sfRenderTexture_getScissor := GetProcAddress(aDLLHandle, 'sfRenderTexture_getScissor');
  sfRenderTexture_getSize := GetProcAddress(aDLLHandle, 'sfRenderTexture_getSize');
  sfRenderTexture_getTexture := GetProcAddress(aDLLHandle, 'sfRenderTexture_getTexture');
  sfRenderTexture_getView := GetProcAddress(aDLLHandle, 'sfRenderTexture_getView');
  sfRenderTexture_getViewport := GetProcAddress(aDLLHandle, 'sfRenderTexture_getViewport');
  sfRenderTexture_isRepeated := GetProcAddress(aDLLHandle, 'sfRenderTexture_isRepeated');
  sfRenderTexture_isSmooth := GetProcAddress(aDLLHandle, 'sfRenderTexture_isSmooth');
  sfRenderTexture_isSrgb := GetProcAddress(aDLLHandle, 'sfRenderTexture_isSrgb');
  sfRenderTexture_mapCoordsToPixel := GetProcAddress(aDLLHandle, 'sfRenderTexture_mapCoordsToPixel');
  sfRenderTexture_mapPixelToCoords := GetProcAddress(aDLLHandle, 'sfRenderTexture_mapPixelToCoords');
  sfRenderTexture_popGLStates := GetProcAddress(aDLLHandle, 'sfRenderTexture_popGLStates');
  sfRenderTexture_pushGLStates := GetProcAddress(aDLLHandle, 'sfRenderTexture_pushGLStates');
  sfRenderTexture_resetGLStates := GetProcAddress(aDLLHandle, 'sfRenderTexture_resetGLStates');
  sfRenderTexture_setActive := GetProcAddress(aDLLHandle, 'sfRenderTexture_setActive');
  sfRenderTexture_setRepeated := GetProcAddress(aDLLHandle, 'sfRenderTexture_setRepeated');
  sfRenderTexture_setSmooth := GetProcAddress(aDLLHandle, 'sfRenderTexture_setSmooth');
  sfRenderTexture_setView := GetProcAddress(aDLLHandle, 'sfRenderTexture_setView');
  sfRenderWindow_clear := GetProcAddress(aDLLHandle, 'sfRenderWindow_clear');
  sfRenderWindow_clearColorAndStencil := GetProcAddress(aDLLHandle, 'sfRenderWindow_clearColorAndStencil');
  sfRenderWindow_clearStencil := GetProcAddress(aDLLHandle, 'sfRenderWindow_clearStencil');
  sfRenderWindow_close := GetProcAddress(aDLLHandle, 'sfRenderWindow_close');
  sfRenderWindow_create := GetProcAddress(aDLLHandle, 'sfRenderWindow_create');
  sfRenderWindow_createFromHandle := GetProcAddress(aDLLHandle, 'sfRenderWindow_createFromHandle');
  sfRenderWindow_createUnicode := GetProcAddress(aDLLHandle, 'sfRenderWindow_createUnicode');
  sfRenderWindow_createVulkanSurface := GetProcAddress(aDLLHandle, 'sfRenderWindow_createVulkanSurface');
  sfRenderWindow_destroy := GetProcAddress(aDLLHandle, 'sfRenderWindow_destroy');
  sfRenderWindow_display := GetProcAddress(aDLLHandle, 'sfRenderWindow_display');
  sfRenderWindow_drawCircleShape := GetProcAddress(aDLLHandle, 'sfRenderWindow_drawCircleShape');
  sfRenderWindow_drawConvexShape := GetProcAddress(aDLLHandle, 'sfRenderWindow_drawConvexShape');
  sfRenderWindow_drawPrimitives := GetProcAddress(aDLLHandle, 'sfRenderWindow_drawPrimitives');
  sfRenderWindow_drawRectangleShape := GetProcAddress(aDLLHandle, 'sfRenderWindow_drawRectangleShape');
  sfRenderWindow_drawShape := GetProcAddress(aDLLHandle, 'sfRenderWindow_drawShape');
  sfRenderWindow_drawSprite := GetProcAddress(aDLLHandle, 'sfRenderWindow_drawSprite');
  sfRenderWindow_drawText := GetProcAddress(aDLLHandle, 'sfRenderWindow_drawText');
  sfRenderWindow_drawVertexArray := GetProcAddress(aDLLHandle, 'sfRenderWindow_drawVertexArray');
  sfRenderWindow_drawVertexBuffer := GetProcAddress(aDLLHandle, 'sfRenderWindow_drawVertexBuffer');
  sfRenderWindow_drawVertexBufferRange := GetProcAddress(aDLLHandle, 'sfRenderWindow_drawVertexBufferRange');
  sfRenderWindow_getDefaultView := GetProcAddress(aDLLHandle, 'sfRenderWindow_getDefaultView');
  sfRenderWindow_getNativeHandle := GetProcAddress(aDLLHandle, 'sfRenderWindow_getNativeHandle');
  sfRenderWindow_getPosition := GetProcAddress(aDLLHandle, 'sfRenderWindow_getPosition');
  sfRenderWindow_getScissor := GetProcAddress(aDLLHandle, 'sfRenderWindow_getScissor');
  sfRenderWindow_getSettings := GetProcAddress(aDLLHandle, 'sfRenderWindow_getSettings');
  sfRenderWindow_getSize := GetProcAddress(aDLLHandle, 'sfRenderWindow_getSize');
  sfRenderWindow_getView := GetProcAddress(aDLLHandle, 'sfRenderWindow_getView');
  sfRenderWindow_getViewport := GetProcAddress(aDLLHandle, 'sfRenderWindow_getViewport');
  sfRenderWindow_hasFocus := GetProcAddress(aDLLHandle, 'sfRenderWindow_hasFocus');
  sfRenderWindow_isOpen := GetProcAddress(aDLLHandle, 'sfRenderWindow_isOpen');
  sfRenderWindow_isSrgb := GetProcAddress(aDLLHandle, 'sfRenderWindow_isSrgb');
  sfRenderWindow_mapCoordsToPixel := GetProcAddress(aDLLHandle, 'sfRenderWindow_mapCoordsToPixel');
  sfRenderWindow_mapPixelToCoords := GetProcAddress(aDLLHandle, 'sfRenderWindow_mapPixelToCoords');
  sfRenderWindow_pollEvent := GetProcAddress(aDLLHandle, 'sfRenderWindow_pollEvent');
  sfRenderWindow_popGLStates := GetProcAddress(aDLLHandle, 'sfRenderWindow_popGLStates');
  sfRenderWindow_pushGLStates := GetProcAddress(aDLLHandle, 'sfRenderWindow_pushGLStates');
  sfRenderWindow_requestFocus := GetProcAddress(aDLLHandle, 'sfRenderWindow_requestFocus');
  sfRenderWindow_resetGLStates := GetProcAddress(aDLLHandle, 'sfRenderWindow_resetGLStates');
  sfRenderWindow_setActive := GetProcAddress(aDLLHandle, 'sfRenderWindow_setActive');
  sfRenderWindow_setFramerateLimit := GetProcAddress(aDLLHandle, 'sfRenderWindow_setFramerateLimit');
  sfRenderWindow_setIcon := GetProcAddress(aDLLHandle, 'sfRenderWindow_setIcon');
  sfRenderWindow_setJoystickThreshold := GetProcAddress(aDLLHandle, 'sfRenderWindow_setJoystickThreshold');
  sfRenderWindow_setKeyRepeatEnabled := GetProcAddress(aDLLHandle, 'sfRenderWindow_setKeyRepeatEnabled');
  sfRenderWindow_setMouseCursor := GetProcAddress(aDLLHandle, 'sfRenderWindow_setMouseCursor');
  sfRenderWindow_setMouseCursorGrabbed := GetProcAddress(aDLLHandle, 'sfRenderWindow_setMouseCursorGrabbed');
  sfRenderWindow_setMouseCursorVisible := GetProcAddress(aDLLHandle, 'sfRenderWindow_setMouseCursorVisible');
  sfRenderWindow_setPosition := GetProcAddress(aDLLHandle, 'sfRenderWindow_setPosition');
  sfRenderWindow_setSize := GetProcAddress(aDLLHandle, 'sfRenderWindow_setSize');
  sfRenderWindow_setTitle := GetProcAddress(aDLLHandle, 'sfRenderWindow_setTitle');
  sfRenderWindow_setUnicodeTitle := GetProcAddress(aDLLHandle, 'sfRenderWindow_setUnicodeTitle');
  sfRenderWindow_setVerticalSyncEnabled := GetProcAddress(aDLLHandle, 'sfRenderWindow_setVerticalSyncEnabled');
  sfRenderWindow_setView := GetProcAddress(aDLLHandle, 'sfRenderWindow_setView');
  sfRenderWindow_setVisible := GetProcAddress(aDLLHandle, 'sfRenderWindow_setVisible');
  sfRenderWindow_waitEvent := GetProcAddress(aDLLHandle, 'sfRenderWindow_waitEvent');
  sfSeconds := GetProcAddress(aDLLHandle, 'sfSeconds');
  sfSensor_getValue := GetProcAddress(aDLLHandle, 'sfSensor_getValue');
  sfSensor_isAvailable := GetProcAddress(aDLLHandle, 'sfSensor_isAvailable');
  sfSensor_setEnabled := GetProcAddress(aDLLHandle, 'sfSensor_setEnabled');
  sfShader_bind := GetProcAddress(aDLLHandle, 'sfShader_bind');
  sfShader_createFromFile := GetProcAddress(aDLLHandle, 'sfShader_createFromFile');
  sfShader_createFromMemory := GetProcAddress(aDLLHandle, 'sfShader_createFromMemory');
  sfShader_createFromStream := GetProcAddress(aDLLHandle, 'sfShader_createFromStream');
  sfShader_destroy := GetProcAddress(aDLLHandle, 'sfShader_destroy');
  sfShader_getNativeHandle := GetProcAddress(aDLLHandle, 'sfShader_getNativeHandle');
  sfShader_isAvailable := GetProcAddress(aDLLHandle, 'sfShader_isAvailable');
  sfShader_isGeometryAvailable := GetProcAddress(aDLLHandle, 'sfShader_isGeometryAvailable');
  sfShader_setBoolUniform := GetProcAddress(aDLLHandle, 'sfShader_setBoolUniform');
  sfShader_setBvec2Uniform := GetProcAddress(aDLLHandle, 'sfShader_setBvec2Uniform');
  sfShader_setBvec3Uniform := GetProcAddress(aDLLHandle, 'sfShader_setBvec3Uniform');
  sfShader_setBvec4Uniform := GetProcAddress(aDLLHandle, 'sfShader_setBvec4Uniform');
  sfShader_setColorUniform := GetProcAddress(aDLLHandle, 'sfShader_setColorUniform');
  sfShader_setCurrentTextureUniform := GetProcAddress(aDLLHandle, 'sfShader_setCurrentTextureUniform');
  sfShader_setFloatUniform := GetProcAddress(aDLLHandle, 'sfShader_setFloatUniform');
  sfShader_setFloatUniformArray := GetProcAddress(aDLLHandle, 'sfShader_setFloatUniformArray');
  sfShader_setIntColorUniform := GetProcAddress(aDLLHandle, 'sfShader_setIntColorUniform');
  sfShader_setIntUniform := GetProcAddress(aDLLHandle, 'sfShader_setIntUniform');
  sfShader_setIvec2Uniform := GetProcAddress(aDLLHandle, 'sfShader_setIvec2Uniform');
  sfShader_setIvec3Uniform := GetProcAddress(aDLLHandle, 'sfShader_setIvec3Uniform');
  sfShader_setIvec4Uniform := GetProcAddress(aDLLHandle, 'sfShader_setIvec4Uniform');
  sfShader_setMat3Uniform := GetProcAddress(aDLLHandle, 'sfShader_setMat3Uniform');
  sfShader_setMat3UniformArray := GetProcAddress(aDLLHandle, 'sfShader_setMat3UniformArray');
  sfShader_setMat4Uniform := GetProcAddress(aDLLHandle, 'sfShader_setMat4Uniform');
  sfShader_setMat4UniformArray := GetProcAddress(aDLLHandle, 'sfShader_setMat4UniformArray');
  sfShader_setTextureUniform := GetProcAddress(aDLLHandle, 'sfShader_setTextureUniform');
  sfShader_setVec2Uniform := GetProcAddress(aDLLHandle, 'sfShader_setVec2Uniform');
  sfShader_setVec2UniformArray := GetProcAddress(aDLLHandle, 'sfShader_setVec2UniformArray');
  sfShader_setVec3Uniform := GetProcAddress(aDLLHandle, 'sfShader_setVec3Uniform');
  sfShader_setVec3UniformArray := GetProcAddress(aDLLHandle, 'sfShader_setVec3UniformArray');
  sfShader_setVec4Uniform := GetProcAddress(aDLLHandle, 'sfShader_setVec4Uniform');
  sfShader_setVec4UniformArray := GetProcAddress(aDLLHandle, 'sfShader_setVec4UniformArray');
  sfShape_create := GetProcAddress(aDLLHandle, 'sfShape_create');
  sfShape_destroy := GetProcAddress(aDLLHandle, 'sfShape_destroy');
  sfShape_getFillColor := GetProcAddress(aDLLHandle, 'sfShape_getFillColor');
  sfShape_getGeometricCenter := GetProcAddress(aDLLHandle, 'sfShape_getGeometricCenter');
  sfShape_getGlobalBounds := GetProcAddress(aDLLHandle, 'sfShape_getGlobalBounds');
  sfShape_getInverseTransform := GetProcAddress(aDLLHandle, 'sfShape_getInverseTransform');
  sfShape_getLocalBounds := GetProcAddress(aDLLHandle, 'sfShape_getLocalBounds');
  sfShape_getOrigin := GetProcAddress(aDLLHandle, 'sfShape_getOrigin');
  sfShape_getOutlineColor := GetProcAddress(aDLLHandle, 'sfShape_getOutlineColor');
  sfShape_getOutlineThickness := GetProcAddress(aDLLHandle, 'sfShape_getOutlineThickness');
  sfShape_getPoint := GetProcAddress(aDLLHandle, 'sfShape_getPoint');
  sfShape_getPointCount := GetProcAddress(aDLLHandle, 'sfShape_getPointCount');
  sfShape_getPosition := GetProcAddress(aDLLHandle, 'sfShape_getPosition');
  sfShape_getRotation := GetProcAddress(aDLLHandle, 'sfShape_getRotation');
  sfShape_getScale := GetProcAddress(aDLLHandle, 'sfShape_getScale');
  sfShape_getTexture := GetProcAddress(aDLLHandle, 'sfShape_getTexture');
  sfShape_getTextureRect := GetProcAddress(aDLLHandle, 'sfShape_getTextureRect');
  sfShape_getTransform := GetProcAddress(aDLLHandle, 'sfShape_getTransform');
  sfShape_move := GetProcAddress(aDLLHandle, 'sfShape_move');
  sfShape_rotate := GetProcAddress(aDLLHandle, 'sfShape_rotate');
  sfShape_scale := GetProcAddress(aDLLHandle, 'sfShape_scale');
  sfShape_setFillColor := GetProcAddress(aDLLHandle, 'sfShape_setFillColor');
  sfShape_setOrigin := GetProcAddress(aDLLHandle, 'sfShape_setOrigin');
  sfShape_setOutlineColor := GetProcAddress(aDLLHandle, 'sfShape_setOutlineColor');
  sfShape_setOutlineThickness := GetProcAddress(aDLLHandle, 'sfShape_setOutlineThickness');
  sfShape_setPosition := GetProcAddress(aDLLHandle, 'sfShape_setPosition');
  sfShape_setRotation := GetProcAddress(aDLLHandle, 'sfShape_setRotation');
  sfShape_setScale := GetProcAddress(aDLLHandle, 'sfShape_setScale');
  sfShape_setTexture := GetProcAddress(aDLLHandle, 'sfShape_setTexture');
  sfShape_setTextureRect := GetProcAddress(aDLLHandle, 'sfShape_setTextureRect');
  sfShape_update := GetProcAddress(aDLLHandle, 'sfShape_update');
  sfSleep := GetProcAddress(aDLLHandle, 'sfSleep');
  sfSocketSelector_addTcpListener := GetProcAddress(aDLLHandle, 'sfSocketSelector_addTcpListener');
  sfSocketSelector_addTcpSocket := GetProcAddress(aDLLHandle, 'sfSocketSelector_addTcpSocket');
  sfSocketSelector_addUdpSocket := GetProcAddress(aDLLHandle, 'sfSocketSelector_addUdpSocket');
  sfSocketSelector_clear := GetProcAddress(aDLLHandle, 'sfSocketSelector_clear');
  sfSocketSelector_copy := GetProcAddress(aDLLHandle, 'sfSocketSelector_copy');
  sfSocketSelector_create := GetProcAddress(aDLLHandle, 'sfSocketSelector_create');
  sfSocketSelector_destroy := GetProcAddress(aDLLHandle, 'sfSocketSelector_destroy');
  sfSocketSelector_isTcpListenerReady := GetProcAddress(aDLLHandle, 'sfSocketSelector_isTcpListenerReady');
  sfSocketSelector_isTcpSocketReady := GetProcAddress(aDLLHandle, 'sfSocketSelector_isTcpSocketReady');
  sfSocketSelector_isUdpSocketReady := GetProcAddress(aDLLHandle, 'sfSocketSelector_isUdpSocketReady');
  sfSocketSelector_removeTcpListener := GetProcAddress(aDLLHandle, 'sfSocketSelector_removeTcpListener');
  sfSocketSelector_removeTcpSocket := GetProcAddress(aDLLHandle, 'sfSocketSelector_removeTcpSocket');
  sfSocketSelector_removeUdpSocket := GetProcAddress(aDLLHandle, 'sfSocketSelector_removeUdpSocket');
  sfSocketSelector_wait := GetProcAddress(aDLLHandle, 'sfSocketSelector_wait');
  sfSound_copy := GetProcAddress(aDLLHandle, 'sfSound_copy');
  sfSound_create := GetProcAddress(aDLLHandle, 'sfSound_create');
  sfSound_destroy := GetProcAddress(aDLLHandle, 'sfSound_destroy');
  sfSound_getAttenuation := GetProcAddress(aDLLHandle, 'sfSound_getAttenuation');
  sfSound_getBuffer := GetProcAddress(aDLLHandle, 'sfSound_getBuffer');
  sfSound_getCone := GetProcAddress(aDLLHandle, 'sfSound_getCone');
  sfSound_getDirection := GetProcAddress(aDLLHandle, 'sfSound_getDirection');
  sfSound_getDirectionalAttenuationFactor := GetProcAddress(aDLLHandle, 'sfSound_getDirectionalAttenuationFactor');
  sfSound_getDopplerFactor := GetProcAddress(aDLLHandle, 'sfSound_getDopplerFactor');
  sfSound_getMaxDistance := GetProcAddress(aDLLHandle, 'sfSound_getMaxDistance');
  sfSound_getMaxGain := GetProcAddress(aDLLHandle, 'sfSound_getMaxGain');
  sfSound_getMinDistance := GetProcAddress(aDLLHandle, 'sfSound_getMinDistance');
  sfSound_getMinGain := GetProcAddress(aDLLHandle, 'sfSound_getMinGain');
  sfSound_getPan := GetProcAddress(aDLLHandle, 'sfSound_getPan');
  sfSound_getPitch := GetProcAddress(aDLLHandle, 'sfSound_getPitch');
  sfSound_getPlayingOffset := GetProcAddress(aDLLHandle, 'sfSound_getPlayingOffset');
  sfSound_getPosition := GetProcAddress(aDLLHandle, 'sfSound_getPosition');
  sfSound_getStatus := GetProcAddress(aDLLHandle, 'sfSound_getStatus');
  sfSound_getVelocity := GetProcAddress(aDLLHandle, 'sfSound_getVelocity');
  sfSound_getVolume := GetProcAddress(aDLLHandle, 'sfSound_getVolume');
  sfSound_isLooping := GetProcAddress(aDLLHandle, 'sfSound_isLooping');
  sfSound_isRelativeToListener := GetProcAddress(aDLLHandle, 'sfSound_isRelativeToListener');
  sfSound_isSpatializationEnabled := GetProcAddress(aDLLHandle, 'sfSound_isSpatializationEnabled');
  sfSound_pause := GetProcAddress(aDLLHandle, 'sfSound_pause');
  sfSound_play := GetProcAddress(aDLLHandle, 'sfSound_play');
  sfSound_setAttenuation := GetProcAddress(aDLLHandle, 'sfSound_setAttenuation');
  sfSound_setBuffer := GetProcAddress(aDLLHandle, 'sfSound_setBuffer');
  sfSound_setCone := GetProcAddress(aDLLHandle, 'sfSound_setCone');
  sfSound_setDirection := GetProcAddress(aDLLHandle, 'sfSound_setDirection');
  sfSound_setDirectionalAttenuationFactor := GetProcAddress(aDLLHandle, 'sfSound_setDirectionalAttenuationFactor');
  sfSound_setDopplerFactor := GetProcAddress(aDLLHandle, 'sfSound_setDopplerFactor');
  sfSound_setEffectProcessor := GetProcAddress(aDLLHandle, 'sfSound_setEffectProcessor');
  sfSound_setLooping := GetProcAddress(aDLLHandle, 'sfSound_setLooping');
  sfSound_setMaxDistance := GetProcAddress(aDLLHandle, 'sfSound_setMaxDistance');
  sfSound_setMaxGain := GetProcAddress(aDLLHandle, 'sfSound_setMaxGain');
  sfSound_setMinDistance := GetProcAddress(aDLLHandle, 'sfSound_setMinDistance');
  sfSound_setMinGain := GetProcAddress(aDLLHandle, 'sfSound_setMinGain');
  sfSound_setPan := GetProcAddress(aDLLHandle, 'sfSound_setPan');
  sfSound_setPitch := GetProcAddress(aDLLHandle, 'sfSound_setPitch');
  sfSound_setPlayingOffset := GetProcAddress(aDLLHandle, 'sfSound_setPlayingOffset');
  sfSound_setPosition := GetProcAddress(aDLLHandle, 'sfSound_setPosition');
  sfSound_setRelativeToListener := GetProcAddress(aDLLHandle, 'sfSound_setRelativeToListener');
  sfSound_setSpatializationEnabled := GetProcAddress(aDLLHandle, 'sfSound_setSpatializationEnabled');
  sfSound_setVelocity := GetProcAddress(aDLLHandle, 'sfSound_setVelocity');
  sfSound_setVolume := GetProcAddress(aDLLHandle, 'sfSound_setVolume');
  sfSound_stop := GetProcAddress(aDLLHandle, 'sfSound_stop');
  sfSoundBuffer_copy := GetProcAddress(aDLLHandle, 'sfSoundBuffer_copy');
  sfSoundBuffer_createFromFile := GetProcAddress(aDLLHandle, 'sfSoundBuffer_createFromFile');
  sfSoundBuffer_createFromMemory := GetProcAddress(aDLLHandle, 'sfSoundBuffer_createFromMemory');
  sfSoundBuffer_createFromSamples := GetProcAddress(aDLLHandle, 'sfSoundBuffer_createFromSamples');
  sfSoundBuffer_createFromStream := GetProcAddress(aDLLHandle, 'sfSoundBuffer_createFromStream');
  sfSoundBuffer_destroy := GetProcAddress(aDLLHandle, 'sfSoundBuffer_destroy');
  sfSoundBuffer_getChannelCount := GetProcAddress(aDLLHandle, 'sfSoundBuffer_getChannelCount');
  sfSoundBuffer_getChannelMap := GetProcAddress(aDLLHandle, 'sfSoundBuffer_getChannelMap');
  sfSoundBuffer_getDuration := GetProcAddress(aDLLHandle, 'sfSoundBuffer_getDuration');
  sfSoundBuffer_getSampleCount := GetProcAddress(aDLLHandle, 'sfSoundBuffer_getSampleCount');
  sfSoundBuffer_getSampleRate := GetProcAddress(aDLLHandle, 'sfSoundBuffer_getSampleRate');
  sfSoundBuffer_getSamples := GetProcAddress(aDLLHandle, 'sfSoundBuffer_getSamples');
  sfSoundBuffer_saveToFile := GetProcAddress(aDLLHandle, 'sfSoundBuffer_saveToFile');
  sfSoundBufferRecorder_create := GetProcAddress(aDLLHandle, 'sfSoundBufferRecorder_create');
  sfSoundBufferRecorder_destroy := GetProcAddress(aDLLHandle, 'sfSoundBufferRecorder_destroy');
  sfSoundBufferRecorder_getBuffer := GetProcAddress(aDLLHandle, 'sfSoundBufferRecorder_getBuffer');
  sfSoundBufferRecorder_getChannelCount := GetProcAddress(aDLLHandle, 'sfSoundBufferRecorder_getChannelCount');
  sfSoundBufferRecorder_getDevice := GetProcAddress(aDLLHandle, 'sfSoundBufferRecorder_getDevice');
  sfSoundBufferRecorder_getSampleRate := GetProcAddress(aDLLHandle, 'sfSoundBufferRecorder_getSampleRate');
  sfSoundBufferRecorder_setChannelCount := GetProcAddress(aDLLHandle, 'sfSoundBufferRecorder_setChannelCount');
  sfSoundBufferRecorder_setDevice := GetProcAddress(aDLLHandle, 'sfSoundBufferRecorder_setDevice');
  sfSoundBufferRecorder_start := GetProcAddress(aDLLHandle, 'sfSoundBufferRecorder_start');
  sfSoundBufferRecorder_stop := GetProcAddress(aDLLHandle, 'sfSoundBufferRecorder_stop');
  sfSoundRecorder_create := GetProcAddress(aDLLHandle, 'sfSoundRecorder_create');
  sfSoundRecorder_destroy := GetProcAddress(aDLLHandle, 'sfSoundRecorder_destroy');
  sfSoundRecorder_getAvailableDevices := GetProcAddress(aDLLHandle, 'sfSoundRecorder_getAvailableDevices');
  sfSoundRecorder_getChannelCount := GetProcAddress(aDLLHandle, 'sfSoundRecorder_getChannelCount');
  sfSoundRecorder_getChannelMap := GetProcAddress(aDLLHandle, 'sfSoundRecorder_getChannelMap');
  sfSoundRecorder_getDefaultDevice := GetProcAddress(aDLLHandle, 'sfSoundRecorder_getDefaultDevice');
  sfSoundRecorder_getDevice := GetProcAddress(aDLLHandle, 'sfSoundRecorder_getDevice');
  sfSoundRecorder_getSampleRate := GetProcAddress(aDLLHandle, 'sfSoundRecorder_getSampleRate');
  sfSoundRecorder_isAvailable := GetProcAddress(aDLLHandle, 'sfSoundRecorder_isAvailable');
  sfSoundRecorder_setChannelCount := GetProcAddress(aDLLHandle, 'sfSoundRecorder_setChannelCount');
  sfSoundRecorder_setDevice := GetProcAddress(aDLLHandle, 'sfSoundRecorder_setDevice');
  sfSoundRecorder_start := GetProcAddress(aDLLHandle, 'sfSoundRecorder_start');
  sfSoundRecorder_stop := GetProcAddress(aDLLHandle, 'sfSoundRecorder_stop');
  sfSoundStream_create := GetProcAddress(aDLLHandle, 'sfSoundStream_create');
  sfSoundStream_destroy := GetProcAddress(aDLLHandle, 'sfSoundStream_destroy');
  sfSoundStream_getAttenuation := GetProcAddress(aDLLHandle, 'sfSoundStream_getAttenuation');
  sfSoundStream_getChannelCount := GetProcAddress(aDLLHandle, 'sfSoundStream_getChannelCount');
  sfSoundStream_getChannelMap := GetProcAddress(aDLLHandle, 'sfSoundStream_getChannelMap');
  sfSoundStream_getCone := GetProcAddress(aDLLHandle, 'sfSoundStream_getCone');
  sfSoundStream_getDirection := GetProcAddress(aDLLHandle, 'sfSoundStream_getDirection');
  sfSoundStream_getDirectionalAttenuationFactor := GetProcAddress(aDLLHandle, 'sfSoundStream_getDirectionalAttenuationFactor');
  sfSoundStream_getDopplerFactor := GetProcAddress(aDLLHandle, 'sfSoundStream_getDopplerFactor');
  sfSoundStream_getMaxDistance := GetProcAddress(aDLLHandle, 'sfSoundStream_getMaxDistance');
  sfSoundStream_getMaxGain := GetProcAddress(aDLLHandle, 'sfSoundStream_getMaxGain');
  sfSoundStream_getMinDistance := GetProcAddress(aDLLHandle, 'sfSoundStream_getMinDistance');
  sfSoundStream_getMinGain := GetProcAddress(aDLLHandle, 'sfSoundStream_getMinGain');
  sfSoundStream_getPan := GetProcAddress(aDLLHandle, 'sfSoundStream_getPan');
  sfSoundStream_getPitch := GetProcAddress(aDLLHandle, 'sfSoundStream_getPitch');
  sfSoundStream_getPlayingOffset := GetProcAddress(aDLLHandle, 'sfSoundStream_getPlayingOffset');
  sfSoundStream_getPosition := GetProcAddress(aDLLHandle, 'sfSoundStream_getPosition');
  sfSoundStream_getSampleRate := GetProcAddress(aDLLHandle, 'sfSoundStream_getSampleRate');
  sfSoundStream_getStatus := GetProcAddress(aDLLHandle, 'sfSoundStream_getStatus');
  sfSoundStream_getVelocity := GetProcAddress(aDLLHandle, 'sfSoundStream_getVelocity');
  sfSoundStream_getVolume := GetProcAddress(aDLLHandle, 'sfSoundStream_getVolume');
  sfSoundStream_isLooping := GetProcAddress(aDLLHandle, 'sfSoundStream_isLooping');
  sfSoundStream_isRelativeToListener := GetProcAddress(aDLLHandle, 'sfSoundStream_isRelativeToListener');
  sfSoundStream_isSpatializationEnabled := GetProcAddress(aDLLHandle, 'sfSoundStream_isSpatializationEnabled');
  sfSoundStream_pause := GetProcAddress(aDLLHandle, 'sfSoundStream_pause');
  sfSoundStream_play := GetProcAddress(aDLLHandle, 'sfSoundStream_play');
  sfSoundStream_setAttenuation := GetProcAddress(aDLLHandle, 'sfSoundStream_setAttenuation');
  sfSoundStream_setCone := GetProcAddress(aDLLHandle, 'sfSoundStream_setCone');
  sfSoundStream_setDirection := GetProcAddress(aDLLHandle, 'sfSoundStream_setDirection');
  sfSoundStream_setDirectionalAttenuationFactor := GetProcAddress(aDLLHandle, 'sfSoundStream_setDirectionalAttenuationFactor');
  sfSoundStream_setDopplerFactor := GetProcAddress(aDLLHandle, 'sfSoundStream_setDopplerFactor');
  sfSoundStream_setEffectProcessor := GetProcAddress(aDLLHandle, 'sfSoundStream_setEffectProcessor');
  sfSoundStream_setLooping := GetProcAddress(aDLLHandle, 'sfSoundStream_setLooping');
  sfSoundStream_setMaxDistance := GetProcAddress(aDLLHandle, 'sfSoundStream_setMaxDistance');
  sfSoundStream_setMaxGain := GetProcAddress(aDLLHandle, 'sfSoundStream_setMaxGain');
  sfSoundStream_setMinDistance := GetProcAddress(aDLLHandle, 'sfSoundStream_setMinDistance');
  sfSoundStream_setMinGain := GetProcAddress(aDLLHandle, 'sfSoundStream_setMinGain');
  sfSoundStream_setPan := GetProcAddress(aDLLHandle, 'sfSoundStream_setPan');
  sfSoundStream_setPitch := GetProcAddress(aDLLHandle, 'sfSoundStream_setPitch');
  sfSoundStream_setPlayingOffset := GetProcAddress(aDLLHandle, 'sfSoundStream_setPlayingOffset');
  sfSoundStream_setPosition := GetProcAddress(aDLLHandle, 'sfSoundStream_setPosition');
  sfSoundStream_setRelativeToListener := GetProcAddress(aDLLHandle, 'sfSoundStream_setRelativeToListener');
  sfSoundStream_setSpatializationEnabled := GetProcAddress(aDLLHandle, 'sfSoundStream_setSpatializationEnabled');
  sfSoundStream_setVelocity := GetProcAddress(aDLLHandle, 'sfSoundStream_setVelocity');
  sfSoundStream_setVolume := GetProcAddress(aDLLHandle, 'sfSoundStream_setVolume');
  sfSoundStream_stop := GetProcAddress(aDLLHandle, 'sfSoundStream_stop');
  sfSprite_copy := GetProcAddress(aDLLHandle, 'sfSprite_copy');
  sfSprite_create := GetProcAddress(aDLLHandle, 'sfSprite_create');
  sfSprite_destroy := GetProcAddress(aDLLHandle, 'sfSprite_destroy');
  sfSprite_getColor := GetProcAddress(aDLLHandle, 'sfSprite_getColor');
  sfSprite_getGlobalBounds := GetProcAddress(aDLLHandle, 'sfSprite_getGlobalBounds');
  sfSprite_getInverseTransform := GetProcAddress(aDLLHandle, 'sfSprite_getInverseTransform');
  sfSprite_getLocalBounds := GetProcAddress(aDLLHandle, 'sfSprite_getLocalBounds');
  sfSprite_getOrigin := GetProcAddress(aDLLHandle, 'sfSprite_getOrigin');
  sfSprite_getPosition := GetProcAddress(aDLLHandle, 'sfSprite_getPosition');
  sfSprite_getRotation := GetProcAddress(aDLLHandle, 'sfSprite_getRotation');
  sfSprite_getScale := GetProcAddress(aDLLHandle, 'sfSprite_getScale');
  sfSprite_getTexture := GetProcAddress(aDLLHandle, 'sfSprite_getTexture');
  sfSprite_getTextureRect := GetProcAddress(aDLLHandle, 'sfSprite_getTextureRect');
  sfSprite_getTransform := GetProcAddress(aDLLHandle, 'sfSprite_getTransform');
  sfSprite_move := GetProcAddress(aDLLHandle, 'sfSprite_move');
  sfSprite_rotate := GetProcAddress(aDLLHandle, 'sfSprite_rotate');
  sfSprite_scale := GetProcAddress(aDLLHandle, 'sfSprite_scale');
  sfSprite_setColor := GetProcAddress(aDLLHandle, 'sfSprite_setColor');
  sfSprite_setOrigin := GetProcAddress(aDLLHandle, 'sfSprite_setOrigin');
  sfSprite_setPosition := GetProcAddress(aDLLHandle, 'sfSprite_setPosition');
  sfSprite_setRotation := GetProcAddress(aDLLHandle, 'sfSprite_setRotation');
  sfSprite_setScale := GetProcAddress(aDLLHandle, 'sfSprite_setScale');
  sfSprite_setTexture := GetProcAddress(aDLLHandle, 'sfSprite_setTexture');
  sfSprite_setTextureRect := GetProcAddress(aDLLHandle, 'sfSprite_setTextureRect');
  sfTcpListener_accept := GetProcAddress(aDLLHandle, 'sfTcpListener_accept');
  sfTcpListener_create := GetProcAddress(aDLLHandle, 'sfTcpListener_create');
  sfTcpListener_destroy := GetProcAddress(aDLLHandle, 'sfTcpListener_destroy');
  sfTcpListener_getLocalPort := GetProcAddress(aDLLHandle, 'sfTcpListener_getLocalPort');
  sfTcpListener_isBlocking := GetProcAddress(aDLLHandle, 'sfTcpListener_isBlocking');
  sfTcpListener_listen := GetProcAddress(aDLLHandle, 'sfTcpListener_listen');
  sfTcpListener_setBlocking := GetProcAddress(aDLLHandle, 'sfTcpListener_setBlocking');
  sfTcpSocket_connect := GetProcAddress(aDLLHandle, 'sfTcpSocket_connect');
  sfTcpSocket_create := GetProcAddress(aDLLHandle, 'sfTcpSocket_create');
  sfTcpSocket_destroy := GetProcAddress(aDLLHandle, 'sfTcpSocket_destroy');
  sfTcpSocket_disconnect := GetProcAddress(aDLLHandle, 'sfTcpSocket_disconnect');
  sfTcpSocket_getLocalPort := GetProcAddress(aDLLHandle, 'sfTcpSocket_getLocalPort');
  sfTcpSocket_getRemoteAddress := GetProcAddress(aDLLHandle, 'sfTcpSocket_getRemoteAddress');
  sfTcpSocket_getRemotePort := GetProcAddress(aDLLHandle, 'sfTcpSocket_getRemotePort');
  sfTcpSocket_isBlocking := GetProcAddress(aDLLHandle, 'sfTcpSocket_isBlocking');
  sfTcpSocket_receive := GetProcAddress(aDLLHandle, 'sfTcpSocket_receive');
  sfTcpSocket_receivePacket := GetProcAddress(aDLLHandle, 'sfTcpSocket_receivePacket');
  sfTcpSocket_send := GetProcAddress(aDLLHandle, 'sfTcpSocket_send');
  sfTcpSocket_sendPacket := GetProcAddress(aDLLHandle, 'sfTcpSocket_sendPacket');
  sfTcpSocket_sendPartial := GetProcAddress(aDLLHandle, 'sfTcpSocket_sendPartial');
  sfTcpSocket_setBlocking := GetProcAddress(aDLLHandle, 'sfTcpSocket_setBlocking');
  sfText_copy := GetProcAddress(aDLLHandle, 'sfText_copy');
  sfText_create := GetProcAddress(aDLLHandle, 'sfText_create');
  sfText_destroy := GetProcAddress(aDLLHandle, 'sfText_destroy');
  sfText_findCharacterPos := GetProcAddress(aDLLHandle, 'sfText_findCharacterPos');
  sfText_getCharacterSize := GetProcAddress(aDLLHandle, 'sfText_getCharacterSize');
  sfText_getFillColor := GetProcAddress(aDLLHandle, 'sfText_getFillColor');
  sfText_getFont := GetProcAddress(aDLLHandle, 'sfText_getFont');
  sfText_getGlobalBounds := GetProcAddress(aDLLHandle, 'sfText_getGlobalBounds');
  sfText_getInverseTransform := GetProcAddress(aDLLHandle, 'sfText_getInverseTransform');
  sfText_getLetterSpacing := GetProcAddress(aDLLHandle, 'sfText_getLetterSpacing');
  sfText_getLineSpacing := GetProcAddress(aDLLHandle, 'sfText_getLineSpacing');
  sfText_getLocalBounds := GetProcAddress(aDLLHandle, 'sfText_getLocalBounds');
  sfText_getOrigin := GetProcAddress(aDLLHandle, 'sfText_getOrigin');
  sfText_getOutlineColor := GetProcAddress(aDLLHandle, 'sfText_getOutlineColor');
  sfText_getOutlineThickness := GetProcAddress(aDLLHandle, 'sfText_getOutlineThickness');
  sfText_getPosition := GetProcAddress(aDLLHandle, 'sfText_getPosition');
  sfText_getRotation := GetProcAddress(aDLLHandle, 'sfText_getRotation');
  sfText_getScale := GetProcAddress(aDLLHandle, 'sfText_getScale');
  sfText_getString := GetProcAddress(aDLLHandle, 'sfText_getString');
  sfText_getStyle := GetProcAddress(aDLLHandle, 'sfText_getStyle');
  sfText_getTransform := GetProcAddress(aDLLHandle, 'sfText_getTransform');
  sfText_getUnicodeString := GetProcAddress(aDLLHandle, 'sfText_getUnicodeString');
  sfText_move := GetProcAddress(aDLLHandle, 'sfText_move');
  sfText_rotate := GetProcAddress(aDLLHandle, 'sfText_rotate');
  sfText_scale := GetProcAddress(aDLLHandle, 'sfText_scale');
  sfText_setCharacterSize := GetProcAddress(aDLLHandle, 'sfText_setCharacterSize');
  sfText_setFillColor := GetProcAddress(aDLLHandle, 'sfText_setFillColor');
  sfText_setFont := GetProcAddress(aDLLHandle, 'sfText_setFont');
  sfText_setLetterSpacing := GetProcAddress(aDLLHandle, 'sfText_setLetterSpacing');
  sfText_setLineSpacing := GetProcAddress(aDLLHandle, 'sfText_setLineSpacing');
  sfText_setOrigin := GetProcAddress(aDLLHandle, 'sfText_setOrigin');
  sfText_setOutlineColor := GetProcAddress(aDLLHandle, 'sfText_setOutlineColor');
  sfText_setOutlineThickness := GetProcAddress(aDLLHandle, 'sfText_setOutlineThickness');
  sfText_setPosition := GetProcAddress(aDLLHandle, 'sfText_setPosition');
  sfText_setRotation := GetProcAddress(aDLLHandle, 'sfText_setRotation');
  sfText_setScale := GetProcAddress(aDLLHandle, 'sfText_setScale');
  sfText_setString := GetProcAddress(aDLLHandle, 'sfText_setString');
  sfText_setStyle := GetProcAddress(aDLLHandle, 'sfText_setStyle');
  sfText_setUnicodeString := GetProcAddress(aDLLHandle, 'sfText_setUnicodeString');
  sfTexture_bind := GetProcAddress(aDLLHandle, 'sfTexture_bind');
  sfTexture_copy := GetProcAddress(aDLLHandle, 'sfTexture_copy');
  sfTexture_copyToImage := GetProcAddress(aDLLHandle, 'sfTexture_copyToImage');
  sfTexture_create := GetProcAddress(aDLLHandle, 'sfTexture_create');
  sfTexture_createFromFile := GetProcAddress(aDLLHandle, 'sfTexture_createFromFile');
  sfTexture_createFromImage := GetProcAddress(aDLLHandle, 'sfTexture_createFromImage');
  sfTexture_createFromMemory := GetProcAddress(aDLLHandle, 'sfTexture_createFromMemory');
  sfTexture_createFromStream := GetProcAddress(aDLLHandle, 'sfTexture_createFromStream');
  sfTexture_createSrgb := GetProcAddress(aDLLHandle, 'sfTexture_createSrgb');
  sfTexture_createSrgbFromFile := GetProcAddress(aDLLHandle, 'sfTexture_createSrgbFromFile');
  sfTexture_createSrgbFromImage := GetProcAddress(aDLLHandle, 'sfTexture_createSrgbFromImage');
  sfTexture_createSrgbFromMemory := GetProcAddress(aDLLHandle, 'sfTexture_createSrgbFromMemory');
  sfTexture_createSrgbFromStream := GetProcAddress(aDLLHandle, 'sfTexture_createSrgbFromStream');
  sfTexture_destroy := GetProcAddress(aDLLHandle, 'sfTexture_destroy');
  sfTexture_generateMipmap := GetProcAddress(aDLLHandle, 'sfTexture_generateMipmap');
  sfTexture_getMaximumSize := GetProcAddress(aDLLHandle, 'sfTexture_getMaximumSize');
  sfTexture_getNativeHandle := GetProcAddress(aDLLHandle, 'sfTexture_getNativeHandle');
  sfTexture_getSize := GetProcAddress(aDLLHandle, 'sfTexture_getSize');
  sfTexture_isRepeated := GetProcAddress(aDLLHandle, 'sfTexture_isRepeated');
  sfTexture_isSmooth := GetProcAddress(aDLLHandle, 'sfTexture_isSmooth');
  sfTexture_isSrgb := GetProcAddress(aDLLHandle, 'sfTexture_isSrgb');
  sfTexture_setRepeated := GetProcAddress(aDLLHandle, 'sfTexture_setRepeated');
  sfTexture_setSmooth := GetProcAddress(aDLLHandle, 'sfTexture_setSmooth');
  sfTexture_swap := GetProcAddress(aDLLHandle, 'sfTexture_swap');
  sfTexture_updateFromImage := GetProcAddress(aDLLHandle, 'sfTexture_updateFromImage');
  sfTexture_updateFromPixels := GetProcAddress(aDLLHandle, 'sfTexture_updateFromPixels');
  sfTexture_updateFromRenderWindow := GetProcAddress(aDLLHandle, 'sfTexture_updateFromRenderWindow');
  sfTexture_updateFromTexture := GetProcAddress(aDLLHandle, 'sfTexture_updateFromTexture');
  sfTexture_updateFromWindow := GetProcAddress(aDLLHandle, 'sfTexture_updateFromWindow');
  sfTime_asMicroseconds := GetProcAddress(aDLLHandle, 'sfTime_asMicroseconds');
  sfTime_asMilliseconds := GetProcAddress(aDLLHandle, 'sfTime_asMilliseconds');
  sfTime_asSeconds := GetProcAddress(aDLLHandle, 'sfTime_asSeconds');
  sfTouch_getPosition := GetProcAddress(aDLLHandle, 'sfTouch_getPosition');
  sfTouch_getPositionRenderWindow := GetProcAddress(aDLLHandle, 'sfTouch_getPositionRenderWindow');
  sfTouch_getPositionWindowBase := GetProcAddress(aDLLHandle, 'sfTouch_getPositionWindowBase');
  sfTouch_isDown := GetProcAddress(aDLLHandle, 'sfTouch_isDown');
  sfTransform_combine := GetProcAddress(aDLLHandle, 'sfTransform_combine');
  sfTransform_equal := GetProcAddress(aDLLHandle, 'sfTransform_equal');
  sfTransform_fromMatrix := GetProcAddress(aDLLHandle, 'sfTransform_fromMatrix');
  sfTransform_getInverse := GetProcAddress(aDLLHandle, 'sfTransform_getInverse');
  sfTransform_getMatrix := GetProcAddress(aDLLHandle, 'sfTransform_getMatrix');
  sfTransform_rotate := GetProcAddress(aDLLHandle, 'sfTransform_rotate');
  sfTransform_rotateWithCenter := GetProcAddress(aDLLHandle, 'sfTransform_rotateWithCenter');
  sfTransform_scale := GetProcAddress(aDLLHandle, 'sfTransform_scale');
  sfTransform_scaleWithCenter := GetProcAddress(aDLLHandle, 'sfTransform_scaleWithCenter');
  sfTransform_transformPoint := GetProcAddress(aDLLHandle, 'sfTransform_transformPoint');
  sfTransform_transformRect := GetProcAddress(aDLLHandle, 'sfTransform_transformRect');
  sfTransform_translate := GetProcAddress(aDLLHandle, 'sfTransform_translate');
  sfTransformable_copy := GetProcAddress(aDLLHandle, 'sfTransformable_copy');
  sfTransformable_create := GetProcAddress(aDLLHandle, 'sfTransformable_create');
  sfTransformable_destroy := GetProcAddress(aDLLHandle, 'sfTransformable_destroy');
  sfTransformable_getInverseTransform := GetProcAddress(aDLLHandle, 'sfTransformable_getInverseTransform');
  sfTransformable_getOrigin := GetProcAddress(aDLLHandle, 'sfTransformable_getOrigin');
  sfTransformable_getPosition := GetProcAddress(aDLLHandle, 'sfTransformable_getPosition');
  sfTransformable_getRotation := GetProcAddress(aDLLHandle, 'sfTransformable_getRotation');
  sfTransformable_getScale := GetProcAddress(aDLLHandle, 'sfTransformable_getScale');
  sfTransformable_getTransform := GetProcAddress(aDLLHandle, 'sfTransformable_getTransform');
  sfTransformable_move := GetProcAddress(aDLLHandle, 'sfTransformable_move');
  sfTransformable_rotate := GetProcAddress(aDLLHandle, 'sfTransformable_rotate');
  sfTransformable_scale := GetProcAddress(aDLLHandle, 'sfTransformable_scale');
  sfTransformable_setOrigin := GetProcAddress(aDLLHandle, 'sfTransformable_setOrigin');
  sfTransformable_setPosition := GetProcAddress(aDLLHandle, 'sfTransformable_setPosition');
  sfTransformable_setRotation := GetProcAddress(aDLLHandle, 'sfTransformable_setRotation');
  sfTransformable_setScale := GetProcAddress(aDLLHandle, 'sfTransformable_setScale');
  sfUdpSocket_bind := GetProcAddress(aDLLHandle, 'sfUdpSocket_bind');
  sfUdpSocket_create := GetProcAddress(aDLLHandle, 'sfUdpSocket_create');
  sfUdpSocket_destroy := GetProcAddress(aDLLHandle, 'sfUdpSocket_destroy');
  sfUdpSocket_getLocalPort := GetProcAddress(aDLLHandle, 'sfUdpSocket_getLocalPort');
  sfUdpSocket_isBlocking := GetProcAddress(aDLLHandle, 'sfUdpSocket_isBlocking');
  sfUdpSocket_maxDatagramSize := GetProcAddress(aDLLHandle, 'sfUdpSocket_maxDatagramSize');
  sfUdpSocket_receive := GetProcAddress(aDLLHandle, 'sfUdpSocket_receive');
  sfUdpSocket_receivePacket := GetProcAddress(aDLLHandle, 'sfUdpSocket_receivePacket');
  sfUdpSocket_send := GetProcAddress(aDLLHandle, 'sfUdpSocket_send');
  sfUdpSocket_sendPacket := GetProcAddress(aDLLHandle, 'sfUdpSocket_sendPacket');
  sfUdpSocket_setBlocking := GetProcAddress(aDLLHandle, 'sfUdpSocket_setBlocking');
  sfUdpSocket_unbind := GetProcAddress(aDLLHandle, 'sfUdpSocket_unbind');
  sfVertexArray_append := GetProcAddress(aDLLHandle, 'sfVertexArray_append');
  sfVertexArray_clear := GetProcAddress(aDLLHandle, 'sfVertexArray_clear');
  sfVertexArray_copy := GetProcAddress(aDLLHandle, 'sfVertexArray_copy');
  sfVertexArray_create := GetProcAddress(aDLLHandle, 'sfVertexArray_create');
  sfVertexArray_destroy := GetProcAddress(aDLLHandle, 'sfVertexArray_destroy');
  sfVertexArray_getBounds := GetProcAddress(aDLLHandle, 'sfVertexArray_getBounds');
  sfVertexArray_getPrimitiveType := GetProcAddress(aDLLHandle, 'sfVertexArray_getPrimitiveType');
  sfVertexArray_getVertex := GetProcAddress(aDLLHandle, 'sfVertexArray_getVertex');
  sfVertexArray_getVertexCount := GetProcAddress(aDLLHandle, 'sfVertexArray_getVertexCount');
  sfVertexArray_resize := GetProcAddress(aDLLHandle, 'sfVertexArray_resize');
  sfVertexArray_setPrimitiveType := GetProcAddress(aDLLHandle, 'sfVertexArray_setPrimitiveType');
  sfVertexBuffer_bind := GetProcAddress(aDLLHandle, 'sfVertexBuffer_bind');
  sfVertexBuffer_copy := GetProcAddress(aDLLHandle, 'sfVertexBuffer_copy');
  sfVertexBuffer_create := GetProcAddress(aDLLHandle, 'sfVertexBuffer_create');
  sfVertexBuffer_destroy := GetProcAddress(aDLLHandle, 'sfVertexBuffer_destroy');
  sfVertexBuffer_getNativeHandle := GetProcAddress(aDLLHandle, 'sfVertexBuffer_getNativeHandle');
  sfVertexBuffer_getPrimitiveType := GetProcAddress(aDLLHandle, 'sfVertexBuffer_getPrimitiveType');
  sfVertexBuffer_getUsage := GetProcAddress(aDLLHandle, 'sfVertexBuffer_getUsage');
  sfVertexBuffer_getVertexCount := GetProcAddress(aDLLHandle, 'sfVertexBuffer_getVertexCount');
  sfVertexBuffer_isAvailable := GetProcAddress(aDLLHandle, 'sfVertexBuffer_isAvailable');
  sfVertexBuffer_setPrimitiveType := GetProcAddress(aDLLHandle, 'sfVertexBuffer_setPrimitiveType');
  sfVertexBuffer_setUsage := GetProcAddress(aDLLHandle, 'sfVertexBuffer_setUsage');
  sfVertexBuffer_swap := GetProcAddress(aDLLHandle, 'sfVertexBuffer_swap');
  sfVertexBuffer_update := GetProcAddress(aDLLHandle, 'sfVertexBuffer_update');
  sfVertexBuffer_updateFromVertexBuffer := GetProcAddress(aDLLHandle, 'sfVertexBuffer_updateFromVertexBuffer');
  sfVideoMode_getDesktopMode := GetProcAddress(aDLLHandle, 'sfVideoMode_getDesktopMode');
  sfVideoMode_getFullscreenModes := GetProcAddress(aDLLHandle, 'sfVideoMode_getFullscreenModes');
  sfVideoMode_isValid := GetProcAddress(aDLLHandle, 'sfVideoMode_isValid');
  sfView_copy := GetProcAddress(aDLLHandle, 'sfView_copy');
  sfView_create := GetProcAddress(aDLLHandle, 'sfView_create');
  sfView_createFromRect := GetProcAddress(aDLLHandle, 'sfView_createFromRect');
  sfView_destroy := GetProcAddress(aDLLHandle, 'sfView_destroy');
  sfView_getCenter := GetProcAddress(aDLLHandle, 'sfView_getCenter');
  sfView_getRotation := GetProcAddress(aDLLHandle, 'sfView_getRotation');
  sfView_getScissor := GetProcAddress(aDLLHandle, 'sfView_getScissor');
  sfView_getSize := GetProcAddress(aDLLHandle, 'sfView_getSize');
  sfView_getViewport := GetProcAddress(aDLLHandle, 'sfView_getViewport');
  sfView_move := GetProcAddress(aDLLHandle, 'sfView_move');
  sfView_rotate := GetProcAddress(aDLLHandle, 'sfView_rotate');
  sfView_setCenter := GetProcAddress(aDLLHandle, 'sfView_setCenter');
  sfView_setRotation := GetProcAddress(aDLLHandle, 'sfView_setRotation');
  sfView_setScissor := GetProcAddress(aDLLHandle, 'sfView_setScissor');
  sfView_setSize := GetProcAddress(aDLLHandle, 'sfView_setSize');
  sfView_setViewport := GetProcAddress(aDLLHandle, 'sfView_setViewport');
  sfView_zoom := GetProcAddress(aDLLHandle, 'sfView_zoom');
  sfVulkan_getFunction := GetProcAddress(aDLLHandle, 'sfVulkan_getFunction');
  sfVulkan_getGraphicsRequiredInstanceExtensions := GetProcAddress(aDLLHandle, 'sfVulkan_getGraphicsRequiredInstanceExtensions');
  sfVulkan_isAvailable := GetProcAddress(aDLLHandle, 'sfVulkan_isAvailable');
  sfWindow_close := GetProcAddress(aDLLHandle, 'sfWindow_close');
  sfWindow_create := GetProcAddress(aDLLHandle, 'sfWindow_create');
  sfWindow_createFromHandle := GetProcAddress(aDLLHandle, 'sfWindow_createFromHandle');
  sfWindow_createUnicode := GetProcAddress(aDLLHandle, 'sfWindow_createUnicode');
  sfWindow_createVulkanSurface := GetProcAddress(aDLLHandle, 'sfWindow_createVulkanSurface');
  sfWindow_destroy := GetProcAddress(aDLLHandle, 'sfWindow_destroy');
  sfWindow_display := GetProcAddress(aDLLHandle, 'sfWindow_display');
  sfWindow_getNativeHandle := GetProcAddress(aDLLHandle, 'sfWindow_getNativeHandle');
  sfWindow_getPosition := GetProcAddress(aDLLHandle, 'sfWindow_getPosition');
  sfWindow_getSettings := GetProcAddress(aDLLHandle, 'sfWindow_getSettings');
  sfWindow_getSize := GetProcAddress(aDLLHandle, 'sfWindow_getSize');
  sfWindow_hasFocus := GetProcAddress(aDLLHandle, 'sfWindow_hasFocus');
  sfWindow_isOpen := GetProcAddress(aDLLHandle, 'sfWindow_isOpen');
  sfWindow_pollEvent := GetProcAddress(aDLLHandle, 'sfWindow_pollEvent');
  sfWindow_requestFocus := GetProcAddress(aDLLHandle, 'sfWindow_requestFocus');
  sfWindow_setActive := GetProcAddress(aDLLHandle, 'sfWindow_setActive');
  sfWindow_setFramerateLimit := GetProcAddress(aDLLHandle, 'sfWindow_setFramerateLimit');
  sfWindow_setIcon := GetProcAddress(aDLLHandle, 'sfWindow_setIcon');
  sfWindow_setJoystickThreshold := GetProcAddress(aDLLHandle, 'sfWindow_setJoystickThreshold');
  sfWindow_setKeyRepeatEnabled := GetProcAddress(aDLLHandle, 'sfWindow_setKeyRepeatEnabled');
  sfWindow_setMouseCursor := GetProcAddress(aDLLHandle, 'sfWindow_setMouseCursor');
  sfWindow_setMouseCursorGrabbed := GetProcAddress(aDLLHandle, 'sfWindow_setMouseCursorGrabbed');
  sfWindow_setMouseCursorVisible := GetProcAddress(aDLLHandle, 'sfWindow_setMouseCursorVisible');
  sfWindow_setPosition := GetProcAddress(aDLLHandle, 'sfWindow_setPosition');
  sfWindow_setSize := GetProcAddress(aDLLHandle, 'sfWindow_setSize');
  sfWindow_setTitle := GetProcAddress(aDLLHandle, 'sfWindow_setTitle');
  sfWindow_setUnicodeTitle := GetProcAddress(aDLLHandle, 'sfWindow_setUnicodeTitle');
  sfWindow_setVerticalSyncEnabled := GetProcAddress(aDLLHandle, 'sfWindow_setVerticalSyncEnabled');
  sfWindow_setVisible := GetProcAddress(aDLLHandle, 'sfWindow_setVisible');
  sfWindow_waitEvent := GetProcAddress(aDLLHandle, 'sfWindow_waitEvent');
  sfWindowBase_close := GetProcAddress(aDLLHandle, 'sfWindowBase_close');
  sfWindowBase_create := GetProcAddress(aDLLHandle, 'sfWindowBase_create');
  sfWindowBase_createFromHandle := GetProcAddress(aDLLHandle, 'sfWindowBase_createFromHandle');
  sfWindowBase_createUnicode := GetProcAddress(aDLLHandle, 'sfWindowBase_createUnicode');
  sfWindowBase_createVulkanSurface := GetProcAddress(aDLLHandle, 'sfWindowBase_createVulkanSurface');
  sfWindowBase_destroy := GetProcAddress(aDLLHandle, 'sfWindowBase_destroy');
  sfWindowBase_getNativeHandle := GetProcAddress(aDLLHandle, 'sfWindowBase_getNativeHandle');
  sfWindowBase_getPosition := GetProcAddress(aDLLHandle, 'sfWindowBase_getPosition');
  sfWindowBase_getSize := GetProcAddress(aDLLHandle, 'sfWindowBase_getSize');
  sfWindowBase_hasFocus := GetProcAddress(aDLLHandle, 'sfWindowBase_hasFocus');
  sfWindowBase_isOpen := GetProcAddress(aDLLHandle, 'sfWindowBase_isOpen');
  sfWindowBase_pollEvent := GetProcAddress(aDLLHandle, 'sfWindowBase_pollEvent');
  sfWindowBase_requestFocus := GetProcAddress(aDLLHandle, 'sfWindowBase_requestFocus');
  sfWindowBase_setIcon := GetProcAddress(aDLLHandle, 'sfWindowBase_setIcon');
  sfWindowBase_setJoystickThreshold := GetProcAddress(aDLLHandle, 'sfWindowBase_setJoystickThreshold');
  sfWindowBase_setKeyRepeatEnabled := GetProcAddress(aDLLHandle, 'sfWindowBase_setKeyRepeatEnabled');
  sfWindowBase_setMouseCursor := GetProcAddress(aDLLHandle, 'sfWindowBase_setMouseCursor');
  sfWindowBase_setMouseCursorGrabbed := GetProcAddress(aDLLHandle, 'sfWindowBase_setMouseCursorGrabbed');
  sfWindowBase_setMouseCursorVisible := GetProcAddress(aDLLHandle, 'sfWindowBase_setMouseCursorVisible');
  sfWindowBase_setPosition := GetProcAddress(aDLLHandle, 'sfWindowBase_setPosition');
  sfWindowBase_setSize := GetProcAddress(aDLLHandle, 'sfWindowBase_setSize');
  sfWindowBase_setTitle := GetProcAddress(aDLLHandle, 'sfWindowBase_setTitle');
  sfWindowBase_setUnicodeTitle := GetProcAddress(aDLLHandle, 'sfWindowBase_setUnicodeTitle');
  sfWindowBase_setVisible := GetProcAddress(aDLLHandle, 'sfWindowBase_setVisible');
  sfWindowBase_waitEvent := GetProcAddress(aDLLHandle, 'sfWindowBase_waitEvent');
  spAlphaTimeline_create := GetProcAddress(aDLLHandle, 'spAlphaTimeline_create');
  spAlphaTimeline_setFrame := GetProcAddress(aDLLHandle, 'spAlphaTimeline_setFrame');
  spAnimation_apply := GetProcAddress(aDLLHandle, 'spAnimation_apply');
  spAnimation_create := GetProcAddress(aDLLHandle, 'spAnimation_create');
  spAnimation_dispose := GetProcAddress(aDLLHandle, 'spAnimation_dispose');
  spAnimation_hasTimeline := GetProcAddress(aDLLHandle, 'spAnimation_hasTimeline');
  spAnimationState_addAnimation := GetProcAddress(aDLLHandle, 'spAnimationState_addAnimation');
  spAnimationState_addAnimationByName := GetProcAddress(aDLLHandle, 'spAnimationState_addAnimationByName');
  spAnimationState_addEmptyAnimation := GetProcAddress(aDLLHandle, 'spAnimationState_addEmptyAnimation');
  spAnimationState_apply := GetProcAddress(aDLLHandle, 'spAnimationState_apply');
  spAnimationState_clearListenerNotifications := GetProcAddress(aDLLHandle, 'spAnimationState_clearListenerNotifications');
  spAnimationState_clearNext := GetProcAddress(aDLLHandle, 'spAnimationState_clearNext');
  spAnimationState_clearTrack := GetProcAddress(aDLLHandle, 'spAnimationState_clearTrack');
  spAnimationState_clearTracks := GetProcAddress(aDLLHandle, 'spAnimationState_clearTracks');
  spAnimationState_create := GetProcAddress(aDLLHandle, 'spAnimationState_create');
  spAnimationState_dispose := GetProcAddress(aDLLHandle, 'spAnimationState_dispose');
  spAnimationState_disposeStatics := GetProcAddress(aDLLHandle, 'spAnimationState_disposeStatics');
  spAnimationState_getCurrent := GetProcAddress(aDLLHandle, 'spAnimationState_getCurrent');
  spAnimationState_setAnimation := GetProcAddress(aDLLHandle, 'spAnimationState_setAnimation');
  spAnimationState_setAnimationByName := GetProcAddress(aDLLHandle, 'spAnimationState_setAnimationByName');
  spAnimationState_setEmptyAnimation := GetProcAddress(aDLLHandle, 'spAnimationState_setEmptyAnimation');
  spAnimationState_setEmptyAnimations := GetProcAddress(aDLLHandle, 'spAnimationState_setEmptyAnimations');
  spAnimationState_update := GetProcAddress(aDLLHandle, 'spAnimationState_update');
  spAnimationStateData_create := GetProcAddress(aDLLHandle, 'spAnimationStateData_create');
  spAnimationStateData_dispose := GetProcAddress(aDLLHandle, 'spAnimationStateData_dispose');
  spAnimationStateData_getMix := GetProcAddress(aDLLHandle, 'spAnimationStateData_getMix');
  spAnimationStateData_setMix := GetProcAddress(aDLLHandle, 'spAnimationStateData_setMix');
  spAnimationStateData_setMixByName := GetProcAddress(aDLLHandle, 'spAnimationStateData_setMixByName');
  spArrayFloatArray_add := GetProcAddress(aDLLHandle, 'spArrayFloatArray_add');
  spArrayFloatArray_addAll := GetProcAddress(aDLLHandle, 'spArrayFloatArray_addAll');
  spArrayFloatArray_addAllValues := GetProcAddress(aDLLHandle, 'spArrayFloatArray_addAllValues');
  spArrayFloatArray_clear := GetProcAddress(aDLLHandle, 'spArrayFloatArray_clear');
  spArrayFloatArray_contains := GetProcAddress(aDLLHandle, 'spArrayFloatArray_contains');
  spArrayFloatArray_create := GetProcAddress(aDLLHandle, 'spArrayFloatArray_create');
  spArrayFloatArray_dispose := GetProcAddress(aDLLHandle, 'spArrayFloatArray_dispose');
  spArrayFloatArray_ensureCapacity := GetProcAddress(aDLLHandle, 'spArrayFloatArray_ensureCapacity');
  spArrayFloatArray_peek := GetProcAddress(aDLLHandle, 'spArrayFloatArray_peek');
  spArrayFloatArray_pop := GetProcAddress(aDLLHandle, 'spArrayFloatArray_pop');
  spArrayFloatArray_removeAt := GetProcAddress(aDLLHandle, 'spArrayFloatArray_removeAt');
  spArrayFloatArray_setSize := GetProcAddress(aDLLHandle, 'spArrayFloatArray_setSize');
  spArrayShortArray_add := GetProcAddress(aDLLHandle, 'spArrayShortArray_add');
  spArrayShortArray_addAll := GetProcAddress(aDLLHandle, 'spArrayShortArray_addAll');
  spArrayShortArray_addAllValues := GetProcAddress(aDLLHandle, 'spArrayShortArray_addAllValues');
  spArrayShortArray_clear := GetProcAddress(aDLLHandle, 'spArrayShortArray_clear');
  spArrayShortArray_contains := GetProcAddress(aDLLHandle, 'spArrayShortArray_contains');
  spArrayShortArray_create := GetProcAddress(aDLLHandle, 'spArrayShortArray_create');
  spArrayShortArray_dispose := GetProcAddress(aDLLHandle, 'spArrayShortArray_dispose');
  spArrayShortArray_ensureCapacity := GetProcAddress(aDLLHandle, 'spArrayShortArray_ensureCapacity');
  spArrayShortArray_peek := GetProcAddress(aDLLHandle, 'spArrayShortArray_peek');
  spArrayShortArray_pop := GetProcAddress(aDLLHandle, 'spArrayShortArray_pop');
  spArrayShortArray_removeAt := GetProcAddress(aDLLHandle, 'spArrayShortArray_removeAt');
  spArrayShortArray_setSize := GetProcAddress(aDLLHandle, 'spArrayShortArray_setSize');
  spAtlas_create := GetProcAddress(aDLLHandle, 'spAtlas_create');
  spAtlas_createFromFile := GetProcAddress(aDLLHandle, 'spAtlas_createFromFile');
  spAtlas_dispose := GetProcAddress(aDLLHandle, 'spAtlas_dispose');
  spAtlas_findRegion := GetProcAddress(aDLLHandle, 'spAtlas_findRegion');
  spAtlasAttachmentLoader_create := GetProcAddress(aDLLHandle, 'spAtlasAttachmentLoader_create');
  spAtlasPage_create := GetProcAddress(aDLLHandle, 'spAtlasPage_create');
  spAtlasPage_dispose := GetProcAddress(aDLLHandle, 'spAtlasPage_dispose');
  spAtlasPage_setCallbacks := GetProcAddress(aDLLHandle, 'spAtlasPage_setCallbacks');
  spAtlasRegion_create := GetProcAddress(aDLLHandle, 'spAtlasRegion_create');
  spAtlasRegion_dispose := GetProcAddress(aDLLHandle, 'spAtlasRegion_dispose');
  spAttachment_copy := GetProcAddress(aDLLHandle, 'spAttachment_copy');
  spAttachment_dispose := GetProcAddress(aDLLHandle, 'spAttachment_dispose');
  spAttachmentLoader_configureAttachment := GetProcAddress(aDLLHandle, 'spAttachmentLoader_configureAttachment');
  spAttachmentLoader_createAttachment := GetProcAddress(aDLLHandle, 'spAttachmentLoader_createAttachment');
  spAttachmentLoader_dispose := GetProcAddress(aDLLHandle, 'spAttachmentLoader_dispose');
  spAttachmentLoader_disposeAttachment := GetProcAddress(aDLLHandle, 'spAttachmentLoader_disposeAttachment');
  spAttachmentTimeline_create := GetProcAddress(aDLLHandle, 'spAttachmentTimeline_create');
  spAttachmentTimeline_setFrame := GetProcAddress(aDLLHandle, 'spAttachmentTimeline_setFrame');
  spBone_create := GetProcAddress(aDLLHandle, 'spBone_create');
  spBone_dispose := GetProcAddress(aDLLHandle, 'spBone_dispose');
  spBone_getWorldRotationX := GetProcAddress(aDLLHandle, 'spBone_getWorldRotationX');
  spBone_getWorldRotationY := GetProcAddress(aDLLHandle, 'spBone_getWorldRotationY');
  spBone_getWorldScaleX := GetProcAddress(aDLLHandle, 'spBone_getWorldScaleX');
  spBone_getWorldScaleY := GetProcAddress(aDLLHandle, 'spBone_getWorldScaleY');
  spBone_isYDown := GetProcAddress(aDLLHandle, 'spBone_isYDown');
  spBone_localToWorld := GetProcAddress(aDLLHandle, 'spBone_localToWorld');
  spBone_localToWorldRotation := GetProcAddress(aDLLHandle, 'spBone_localToWorldRotation');
  spBone_rotateWorld := GetProcAddress(aDLLHandle, 'spBone_rotateWorld');
  spBone_setToSetupPose := GetProcAddress(aDLLHandle, 'spBone_setToSetupPose');
  spBone_setYDown := GetProcAddress(aDLLHandle, 'spBone_setYDown');
  spBone_update := GetProcAddress(aDLLHandle, 'spBone_update');
  spBone_updateAppliedTransform := GetProcAddress(aDLLHandle, 'spBone_updateAppliedTransform');
  spBone_updateWorldTransform := GetProcAddress(aDLLHandle, 'spBone_updateWorldTransform');
  spBone_updateWorldTransformWith := GetProcAddress(aDLLHandle, 'spBone_updateWorldTransformWith');
  spBone_worldToLocal := GetProcAddress(aDLLHandle, 'spBone_worldToLocal');
  spBone_worldToLocalRotation := GetProcAddress(aDLLHandle, 'spBone_worldToLocalRotation');
  spBone_worldToParent := GetProcAddress(aDLLHandle, 'spBone_worldToParent');
  spBoneData_create := GetProcAddress(aDLLHandle, 'spBoneData_create');
  spBoneData_dispose := GetProcAddress(aDLLHandle, 'spBoneData_dispose');
  spBoneDataArray_add := GetProcAddress(aDLLHandle, 'spBoneDataArray_add');
  spBoneDataArray_addAll := GetProcAddress(aDLLHandle, 'spBoneDataArray_addAll');
  spBoneDataArray_addAllValues := GetProcAddress(aDLLHandle, 'spBoneDataArray_addAllValues');
  spBoneDataArray_clear := GetProcAddress(aDLLHandle, 'spBoneDataArray_clear');
  spBoneDataArray_contains := GetProcAddress(aDLLHandle, 'spBoneDataArray_contains');
  spBoneDataArray_create := GetProcAddress(aDLLHandle, 'spBoneDataArray_create');
  spBoneDataArray_dispose := GetProcAddress(aDLLHandle, 'spBoneDataArray_dispose');
  spBoneDataArray_ensureCapacity := GetProcAddress(aDLLHandle, 'spBoneDataArray_ensureCapacity');
  spBoneDataArray_peek := GetProcAddress(aDLLHandle, 'spBoneDataArray_peek');
  spBoneDataArray_pop := GetProcAddress(aDLLHandle, 'spBoneDataArray_pop');
  spBoneDataArray_removeAt := GetProcAddress(aDLLHandle, 'spBoneDataArray_removeAt');
  spBoneDataArray_setSize := GetProcAddress(aDLLHandle, 'spBoneDataArray_setSize');
  spBoundingBoxAttachment_create := GetProcAddress(aDLLHandle, 'spBoundingBoxAttachment_create');
  spClippingAttachment_create := GetProcAddress(aDLLHandle, 'spClippingAttachment_create');
  spColor_addColor := GetProcAddress(aDLLHandle, 'spColor_addColor');
  spColor_addFloats := GetProcAddress(aDLLHandle, 'spColor_addFloats');
  spColor_addFloats3 := GetProcAddress(aDLLHandle, 'spColor_addFloats3');
  spColor_clamp := GetProcAddress(aDLLHandle, 'spColor_clamp');
  spColor_create := GetProcAddress(aDLLHandle, 'spColor_create');
  spColor_dispose := GetProcAddress(aDLLHandle, 'spColor_dispose');
  spColor_setFromColor := GetProcAddress(aDLLHandle, 'spColor_setFromColor');
  spColor_setFromColor3 := GetProcAddress(aDLLHandle, 'spColor_setFromColor3');
  spColor_setFromFloats := GetProcAddress(aDLLHandle, 'spColor_setFromFloats');
  spColor_setFromFloats3 := GetProcAddress(aDLLHandle, 'spColor_setFromFloats3');
  spCurveTimeline_setLinear := GetProcAddress(aDLLHandle, 'spCurveTimeline_setLinear');
  spCurveTimeline_setStepped := GetProcAddress(aDLLHandle, 'spCurveTimeline_setStepped');
  spCurveTimeline1_getAbsoluteValue := GetProcAddress(aDLLHandle, 'spCurveTimeline1_getAbsoluteValue');
  spCurveTimeline1_getAbsoluteValue2 := GetProcAddress(aDLLHandle, 'spCurveTimeline1_getAbsoluteValue2');
  spCurveTimeline1_getCurveValue := GetProcAddress(aDLLHandle, 'spCurveTimeline1_getCurveValue');
  spCurveTimeline1_getRelativeValue := GetProcAddress(aDLLHandle, 'spCurveTimeline1_getRelativeValue');
  spCurveTimeline1_getScaleValue := GetProcAddress(aDLLHandle, 'spCurveTimeline1_getScaleValue');
  spCurveTimeline1_setFrame := GetProcAddress(aDLLHandle, 'spCurveTimeline1_setFrame');
  spCurveTimeline2_setFrame := GetProcAddress(aDLLHandle, 'spCurveTimeline2_setFrame');
  spDeformTimeline_create := GetProcAddress(aDLLHandle, 'spDeformTimeline_create');
  spDeformTimeline_setFrame := GetProcAddress(aDLLHandle, 'spDeformTimeline_setFrame');
  spDrawOrderTimeline_create := GetProcAddress(aDLLHandle, 'spDrawOrderTimeline_create');
  spDrawOrderTimeline_setFrame := GetProcAddress(aDLLHandle, 'spDrawOrderTimeline_setFrame');
  spEvent_create := GetProcAddress(aDLLHandle, 'spEvent_create');
  spEvent_dispose := GetProcAddress(aDLLHandle, 'spEvent_dispose');
  spEventData_create := GetProcAddress(aDLLHandle, 'spEventData_create');
  spEventData_dispose := GetProcAddress(aDLLHandle, 'spEventData_dispose');
  spEventTimeline_create := GetProcAddress(aDLLHandle, 'spEventTimeline_create');
  spEventTimeline_setFrame := GetProcAddress(aDLLHandle, 'spEventTimeline_setFrame');
  spFloatArray_add := GetProcAddress(aDLLHandle, 'spFloatArray_add');
  spFloatArray_addAll := GetProcAddress(aDLLHandle, 'spFloatArray_addAll');
  spFloatArray_addAllValues := GetProcAddress(aDLLHandle, 'spFloatArray_addAllValues');
  spFloatArray_clear := GetProcAddress(aDLLHandle, 'spFloatArray_clear');
  spFloatArray_contains := GetProcAddress(aDLLHandle, 'spFloatArray_contains');
  spFloatArray_create := GetProcAddress(aDLLHandle, 'spFloatArray_create');
  spFloatArray_dispose := GetProcAddress(aDLLHandle, 'spFloatArray_dispose');
  spFloatArray_ensureCapacity := GetProcAddress(aDLLHandle, 'spFloatArray_ensureCapacity');
  spFloatArray_peek := GetProcAddress(aDLLHandle, 'spFloatArray_peek');
  spFloatArray_pop := GetProcAddress(aDLLHandle, 'spFloatArray_pop');
  spFloatArray_removeAt := GetProcAddress(aDLLHandle, 'spFloatArray_removeAt');
  spFloatArray_setSize := GetProcAddress(aDLLHandle, 'spFloatArray_setSize');
  spIkConstraint_apply1 := GetProcAddress(aDLLHandle, 'spIkConstraint_apply1');
  spIkConstraint_apply2 := GetProcAddress(aDLLHandle, 'spIkConstraint_apply2');
  spIkConstraint_create := GetProcAddress(aDLLHandle, 'spIkConstraint_create');
  spIkConstraint_dispose := GetProcAddress(aDLLHandle, 'spIkConstraint_dispose');
  spIkConstraint_setToSetupPose := GetProcAddress(aDLLHandle, 'spIkConstraint_setToSetupPose');
  spIkConstraint_update := GetProcAddress(aDLLHandle, 'spIkConstraint_update');
  spIkConstraintData_create := GetProcAddress(aDLLHandle, 'spIkConstraintData_create');
  spIkConstraintData_dispose := GetProcAddress(aDLLHandle, 'spIkConstraintData_dispose');
  spIkConstraintDataArray_add := GetProcAddress(aDLLHandle, 'spIkConstraintDataArray_add');
  spIkConstraintDataArray_addAll := GetProcAddress(aDLLHandle, 'spIkConstraintDataArray_addAll');
  spIkConstraintDataArray_addAllValues := GetProcAddress(aDLLHandle, 'spIkConstraintDataArray_addAllValues');
  spIkConstraintDataArray_clear := GetProcAddress(aDLLHandle, 'spIkConstraintDataArray_clear');
  spIkConstraintDataArray_contains := GetProcAddress(aDLLHandle, 'spIkConstraintDataArray_contains');
  spIkConstraintDataArray_create := GetProcAddress(aDLLHandle, 'spIkConstraintDataArray_create');
  spIkConstraintDataArray_dispose := GetProcAddress(aDLLHandle, 'spIkConstraintDataArray_dispose');
  spIkConstraintDataArray_ensureCapacity := GetProcAddress(aDLLHandle, 'spIkConstraintDataArray_ensureCapacity');
  spIkConstraintDataArray_peek := GetProcAddress(aDLLHandle, 'spIkConstraintDataArray_peek');
  spIkConstraintDataArray_pop := GetProcAddress(aDLLHandle, 'spIkConstraintDataArray_pop');
  spIkConstraintDataArray_removeAt := GetProcAddress(aDLLHandle, 'spIkConstraintDataArray_removeAt');
  spIkConstraintDataArray_setSize := GetProcAddress(aDLLHandle, 'spIkConstraintDataArray_setSize');
  spIkConstraintTimeline_create := GetProcAddress(aDLLHandle, 'spIkConstraintTimeline_create');
  spIkConstraintTimeline_setFrame := GetProcAddress(aDLLHandle, 'spIkConstraintTimeline_setFrame');
  spInheritTimeline_create := GetProcAddress(aDLLHandle, 'spInheritTimeline_create');
  spInheritTimeline_setFrame := GetProcAddress(aDLLHandle, 'spInheritTimeline_setFrame');
  spIntArray_add := GetProcAddress(aDLLHandle, 'spIntArray_add');
  spIntArray_addAll := GetProcAddress(aDLLHandle, 'spIntArray_addAll');
  spIntArray_addAllValues := GetProcAddress(aDLLHandle, 'spIntArray_addAllValues');
  spIntArray_clear := GetProcAddress(aDLLHandle, 'spIntArray_clear');
  spIntArray_contains := GetProcAddress(aDLLHandle, 'spIntArray_contains');
  spIntArray_create := GetProcAddress(aDLLHandle, 'spIntArray_create');
  spIntArray_dispose := GetProcAddress(aDLLHandle, 'spIntArray_dispose');
  spIntArray_ensureCapacity := GetProcAddress(aDLLHandle, 'spIntArray_ensureCapacity');
  spIntArray_peek := GetProcAddress(aDLLHandle, 'spIntArray_peek');
  spIntArray_pop := GetProcAddress(aDLLHandle, 'spIntArray_pop');
  spIntArray_removeAt := GetProcAddress(aDLLHandle, 'spIntArray_removeAt');
  spIntArray_setSize := GetProcAddress(aDLLHandle, 'spIntArray_setSize');
  spKeyValueArray_add := GetProcAddress(aDLLHandle, 'spKeyValueArray_add');
  spKeyValueArray_addAll := GetProcAddress(aDLLHandle, 'spKeyValueArray_addAll');
  spKeyValueArray_addAllValues := GetProcAddress(aDLLHandle, 'spKeyValueArray_addAllValues');
  spKeyValueArray_clear := GetProcAddress(aDLLHandle, 'spKeyValueArray_clear');
  spKeyValueArray_contains := GetProcAddress(aDLLHandle, 'spKeyValueArray_contains');
  spKeyValueArray_create := GetProcAddress(aDLLHandle, 'spKeyValueArray_create');
  spKeyValueArray_dispose := GetProcAddress(aDLLHandle, 'spKeyValueArray_dispose');
  spKeyValueArray_ensureCapacity := GetProcAddress(aDLLHandle, 'spKeyValueArray_ensureCapacity');
  spKeyValueArray_peek := GetProcAddress(aDLLHandle, 'spKeyValueArray_peek');
  spKeyValueArray_pop := GetProcAddress(aDLLHandle, 'spKeyValueArray_pop');
  spKeyValueArray_setSize := GetProcAddress(aDLLHandle, 'spKeyValueArray_setSize');
  spMeshAttachment_create := GetProcAddress(aDLLHandle, 'spMeshAttachment_create');
  spMeshAttachment_newLinkedMesh := GetProcAddress(aDLLHandle, 'spMeshAttachment_newLinkedMesh');
  spMeshAttachment_setParentMesh := GetProcAddress(aDLLHandle, 'spMeshAttachment_setParentMesh');
  spMeshAttachment_updateRegion := GetProcAddress(aDLLHandle, 'spMeshAttachment_updateRegion');
  spPathAttachment_create := GetProcAddress(aDLLHandle, 'spPathAttachment_create');
  spPathConstraint_computeWorldPositions := GetProcAddress(aDLLHandle, 'spPathConstraint_computeWorldPositions');
  spPathConstraint_create := GetProcAddress(aDLLHandle, 'spPathConstraint_create');
  spPathConstraint_dispose := GetProcAddress(aDLLHandle, 'spPathConstraint_dispose');
  spPathConstraint_setToSetupPose := GetProcAddress(aDLLHandle, 'spPathConstraint_setToSetupPose');
  spPathConstraint_update := GetProcAddress(aDLLHandle, 'spPathConstraint_update');
  spPathConstraintData_create := GetProcAddress(aDLLHandle, 'spPathConstraintData_create');
  spPathConstraintData_dispose := GetProcAddress(aDLLHandle, 'spPathConstraintData_dispose');
  spPathConstraintDataArray_add := GetProcAddress(aDLLHandle, 'spPathConstraintDataArray_add');
  spPathConstraintDataArray_addAll := GetProcAddress(aDLLHandle, 'spPathConstraintDataArray_addAll');
  spPathConstraintDataArray_addAllValues := GetProcAddress(aDLLHandle, 'spPathConstraintDataArray_addAllValues');
  spPathConstraintDataArray_clear := GetProcAddress(aDLLHandle, 'spPathConstraintDataArray_clear');
  spPathConstraintDataArray_contains := GetProcAddress(aDLLHandle, 'spPathConstraintDataArray_contains');
  spPathConstraintDataArray_create := GetProcAddress(aDLLHandle, 'spPathConstraintDataArray_create');
  spPathConstraintDataArray_dispose := GetProcAddress(aDLLHandle, 'spPathConstraintDataArray_dispose');
  spPathConstraintDataArray_ensureCapacity := GetProcAddress(aDLLHandle, 'spPathConstraintDataArray_ensureCapacity');
  spPathConstraintDataArray_peek := GetProcAddress(aDLLHandle, 'spPathConstraintDataArray_peek');
  spPathConstraintDataArray_pop := GetProcAddress(aDLLHandle, 'spPathConstraintDataArray_pop');
  spPathConstraintDataArray_removeAt := GetProcAddress(aDLLHandle, 'spPathConstraintDataArray_removeAt');
  spPathConstraintDataArray_setSize := GetProcAddress(aDLLHandle, 'spPathConstraintDataArray_setSize');
  spPathConstraintMixTimeline_create := GetProcAddress(aDLLHandle, 'spPathConstraintMixTimeline_create');
  spPathConstraintMixTimeline_setFrame := GetProcAddress(aDLLHandle, 'spPathConstraintMixTimeline_setFrame');
  spPathConstraintPositionTimeline_create := GetProcAddress(aDLLHandle, 'spPathConstraintPositionTimeline_create');
  spPathConstraintPositionTimeline_setFrame := GetProcAddress(aDLLHandle, 'spPathConstraintPositionTimeline_setFrame');
  spPathConstraintSpacingTimeline_create := GetProcAddress(aDLLHandle, 'spPathConstraintSpacingTimeline_create');
  spPathConstraintSpacingTimeline_setFrame := GetProcAddress(aDLLHandle, 'spPathConstraintSpacingTimeline_setFrame');
  spPhysicsConstraint_create := GetProcAddress(aDLLHandle, 'spPhysicsConstraint_create');
  spPhysicsConstraint_dispose := GetProcAddress(aDLLHandle, 'spPhysicsConstraint_dispose');
  spPhysicsConstraint_reset := GetProcAddress(aDLLHandle, 'spPhysicsConstraint_reset');
  spPhysicsConstraint_rotate := GetProcAddress(aDLLHandle, 'spPhysicsConstraint_rotate');
  spPhysicsConstraint_setToSetupPose := GetProcAddress(aDLLHandle, 'spPhysicsConstraint_setToSetupPose');
  spPhysicsConstraint_translate := GetProcAddress(aDLLHandle, 'spPhysicsConstraint_translate');
  spPhysicsConstraint_update := GetProcAddress(aDLLHandle, 'spPhysicsConstraint_update');
  spPhysicsConstraintData_create := GetProcAddress(aDLLHandle, 'spPhysicsConstraintData_create');
  spPhysicsConstraintData_dispose := GetProcAddress(aDLLHandle, 'spPhysicsConstraintData_dispose');
  spPhysicsConstraintDataArray_add := GetProcAddress(aDLLHandle, 'spPhysicsConstraintDataArray_add');
  spPhysicsConstraintDataArray_addAll := GetProcAddress(aDLLHandle, 'spPhysicsConstraintDataArray_addAll');
  spPhysicsConstraintDataArray_addAllValues := GetProcAddress(aDLLHandle, 'spPhysicsConstraintDataArray_addAllValues');
  spPhysicsConstraintDataArray_clear := GetProcAddress(aDLLHandle, 'spPhysicsConstraintDataArray_clear');
  spPhysicsConstraintDataArray_contains := GetProcAddress(aDLLHandle, 'spPhysicsConstraintDataArray_contains');
  spPhysicsConstraintDataArray_create := GetProcAddress(aDLLHandle, 'spPhysicsConstraintDataArray_create');
  spPhysicsConstraintDataArray_dispose := GetProcAddress(aDLLHandle, 'spPhysicsConstraintDataArray_dispose');
  spPhysicsConstraintDataArray_ensureCapacity := GetProcAddress(aDLLHandle, 'spPhysicsConstraintDataArray_ensureCapacity');
  spPhysicsConstraintDataArray_peek := GetProcAddress(aDLLHandle, 'spPhysicsConstraintDataArray_peek');
  spPhysicsConstraintDataArray_pop := GetProcAddress(aDLLHandle, 'spPhysicsConstraintDataArray_pop');
  spPhysicsConstraintDataArray_removeAt := GetProcAddress(aDLLHandle, 'spPhysicsConstraintDataArray_removeAt');
  spPhysicsConstraintDataArray_setSize := GetProcAddress(aDLLHandle, 'spPhysicsConstraintDataArray_setSize');
  spPhysicsConstraintResetTimeline_create := GetProcAddress(aDLLHandle, 'spPhysicsConstraintResetTimeline_create');
  spPhysicsConstraintResetTimeline_setFrame := GetProcAddress(aDLLHandle, 'spPhysicsConstraintResetTimeline_setFrame');
  spPhysicsConstraintTimeline_create := GetProcAddress(aDLLHandle, 'spPhysicsConstraintTimeline_create');
  spPhysicsConstraintTimeline_setFrame := GetProcAddress(aDLLHandle, 'spPhysicsConstraintTimeline_setFrame');
  spPointAttachment_computeWorldPosition := GetProcAddress(aDLLHandle, 'spPointAttachment_computeWorldPosition');
  spPointAttachment_computeWorldRotation := GetProcAddress(aDLLHandle, 'spPointAttachment_computeWorldRotation');
  spPointAttachment_create := GetProcAddress(aDLLHandle, 'spPointAttachment_create');
  spPolygon_containsPoint := GetProcAddress(aDLLHandle, 'spPolygon_containsPoint');
  spPolygon_create := GetProcAddress(aDLLHandle, 'spPolygon_create');
  spPolygon_dispose := GetProcAddress(aDLLHandle, 'spPolygon_dispose');
  spPolygon_intersectsSegment := GetProcAddress(aDLLHandle, 'spPolygon_intersectsSegment');
  spPropertyIdArray_add := GetProcAddress(aDLLHandle, 'spPropertyIdArray_add');
  spPropertyIdArray_addAll := GetProcAddress(aDLLHandle, 'spPropertyIdArray_addAll');
  spPropertyIdArray_addAllValues := GetProcAddress(aDLLHandle, 'spPropertyIdArray_addAllValues');
  spPropertyIdArray_clear := GetProcAddress(aDLLHandle, 'spPropertyIdArray_clear');
  spPropertyIdArray_contains := GetProcAddress(aDLLHandle, 'spPropertyIdArray_contains');
  spPropertyIdArray_create := GetProcAddress(aDLLHandle, 'spPropertyIdArray_create');
  spPropertyIdArray_dispose := GetProcAddress(aDLLHandle, 'spPropertyIdArray_dispose');
  spPropertyIdArray_ensureCapacity := GetProcAddress(aDLLHandle, 'spPropertyIdArray_ensureCapacity');
  spPropertyIdArray_peek := GetProcAddress(aDLLHandle, 'spPropertyIdArray_peek');
  spPropertyIdArray_pop := GetProcAddress(aDLLHandle, 'spPropertyIdArray_pop');
  spPropertyIdArray_removeAt := GetProcAddress(aDLLHandle, 'spPropertyIdArray_removeAt');
  spPropertyIdArray_setSize := GetProcAddress(aDLLHandle, 'spPropertyIdArray_setSize');
  spRegionAttachment_computeWorldVertices := GetProcAddress(aDLLHandle, 'spRegionAttachment_computeWorldVertices');
  spRegionAttachment_create := GetProcAddress(aDLLHandle, 'spRegionAttachment_create');
  spRegionAttachment_updateRegion := GetProcAddress(aDLLHandle, 'spRegionAttachment_updateRegion');
  spRGB2Timeline_create := GetProcAddress(aDLLHandle, 'spRGB2Timeline_create');
  spRGB2Timeline_setFrame := GetProcAddress(aDLLHandle, 'spRGB2Timeline_setFrame');
  spRGBA2Timeline_create := GetProcAddress(aDLLHandle, 'spRGBA2Timeline_create');
  spRGBA2Timeline_setFrame := GetProcAddress(aDLLHandle, 'spRGBA2Timeline_setFrame');
  spRGBATimeline_create := GetProcAddress(aDLLHandle, 'spRGBATimeline_create');
  spRGBATimeline_setFrame := GetProcAddress(aDLLHandle, 'spRGBATimeline_setFrame');
  spRGBTimeline_create := GetProcAddress(aDLLHandle, 'spRGBTimeline_create');
  spRGBTimeline_setFrame := GetProcAddress(aDLLHandle, 'spRGBTimeline_setFrame');
  spRotateTimeline_create := GetProcAddress(aDLLHandle, 'spRotateTimeline_create');
  spRotateTimeline_setFrame := GetProcAddress(aDLLHandle, 'spRotateTimeline_setFrame');
  spScaleTimeline_create := GetProcAddress(aDLLHandle, 'spScaleTimeline_create');
  spScaleTimeline_setFrame := GetProcAddress(aDLLHandle, 'spScaleTimeline_setFrame');
  spScaleXTimeline_create := GetProcAddress(aDLLHandle, 'spScaleXTimeline_create');
  spScaleXTimeline_setFrame := GetProcAddress(aDLLHandle, 'spScaleXTimeline_setFrame');
  spScaleYTimeline_create := GetProcAddress(aDLLHandle, 'spScaleYTimeline_create');
  spScaleYTimeline_setFrame := GetProcAddress(aDLLHandle, 'spScaleYTimeline_setFrame');
  spSdlVertexArray_add := GetProcAddress(aDLLHandle, 'spSdlVertexArray_add');
  spSdlVertexArray_addAll := GetProcAddress(aDLLHandle, 'spSdlVertexArray_addAll');
  spSdlVertexArray_addAllValues := GetProcAddress(aDLLHandle, 'spSdlVertexArray_addAllValues');
  spSdlVertexArray_clear := GetProcAddress(aDLLHandle, 'spSdlVertexArray_clear');
  spSdlVertexArray_create := GetProcAddress(aDLLHandle, 'spSdlVertexArray_create');
  spSdlVertexArray_dispose := GetProcAddress(aDLLHandle, 'spSdlVertexArray_dispose');
  spSdlVertexArray_ensureCapacity := GetProcAddress(aDLLHandle, 'spSdlVertexArray_ensureCapacity');
  spSdlVertexArray_peek := GetProcAddress(aDLLHandle, 'spSdlVertexArray_peek');
  spSdlVertexArray_pop := GetProcAddress(aDLLHandle, 'spSdlVertexArray_pop');
  spSdlVertexArray_removeAt := GetProcAddress(aDLLHandle, 'spSdlVertexArray_removeAt');
  spSdlVertexArray_setSize := GetProcAddress(aDLLHandle, 'spSdlVertexArray_setSize');
  spSequence_apply := GetProcAddress(aDLLHandle, 'spSequence_apply');
  spSequence_copy := GetProcAddress(aDLLHandle, 'spSequence_copy');
  spSequence_create := GetProcAddress(aDLLHandle, 'spSequence_create');
  spSequence_dispose := GetProcAddress(aDLLHandle, 'spSequence_dispose');
  spSequence_getPath := GetProcAddress(aDLLHandle, 'spSequence_getPath');
  spSequenceTimeline_create := GetProcAddress(aDLLHandle, 'spSequenceTimeline_create');
  spSequenceTimeline_setFrame := GetProcAddress(aDLLHandle, 'spSequenceTimeline_setFrame');
  spShearTimeline_create := GetProcAddress(aDLLHandle, 'spShearTimeline_create');
  spShearTimeline_setFrame := GetProcAddress(aDLLHandle, 'spShearTimeline_setFrame');
  spShearXTimeline_create := GetProcAddress(aDLLHandle, 'spShearXTimeline_create');
  spShearXTimeline_setFrame := GetProcAddress(aDLLHandle, 'spShearXTimeline_setFrame');
  spShearYTimeline_create := GetProcAddress(aDLLHandle, 'spShearYTimeline_create');
  spShearYTimeline_setFrame := GetProcAddress(aDLLHandle, 'spShearYTimeline_setFrame');
  spShortArray_add := GetProcAddress(aDLLHandle, 'spShortArray_add');
  spShortArray_addAll := GetProcAddress(aDLLHandle, 'spShortArray_addAll');
  spShortArray_addAllValues := GetProcAddress(aDLLHandle, 'spShortArray_addAllValues');
  spShortArray_clear := GetProcAddress(aDLLHandle, 'spShortArray_clear');
  spShortArray_contains := GetProcAddress(aDLLHandle, 'spShortArray_contains');
  spShortArray_create := GetProcAddress(aDLLHandle, 'spShortArray_create');
  spShortArray_dispose := GetProcAddress(aDLLHandle, 'spShortArray_dispose');
  spShortArray_ensureCapacity := GetProcAddress(aDLLHandle, 'spShortArray_ensureCapacity');
  spShortArray_peek := GetProcAddress(aDLLHandle, 'spShortArray_peek');
  spShortArray_pop := GetProcAddress(aDLLHandle, 'spShortArray_pop');
  spShortArray_removeAt := GetProcAddress(aDLLHandle, 'spShortArray_removeAt');
  spShortArray_setSize := GetProcAddress(aDLLHandle, 'spShortArray_setSize');
  spSkeleton_create := GetProcAddress(aDLLHandle, 'spSkeleton_create');
  spSkeleton_dispose := GetProcAddress(aDLLHandle, 'spSkeleton_dispose');
  spSkeleton_findBone := GetProcAddress(aDLLHandle, 'spSkeleton_findBone');
  spSkeleton_findIkConstraint := GetProcAddress(aDLLHandle, 'spSkeleton_findIkConstraint');
  spSkeleton_findPathConstraint := GetProcAddress(aDLLHandle, 'spSkeleton_findPathConstraint');
  spSkeleton_findPhysicsConstraint := GetProcAddress(aDLLHandle, 'spSkeleton_findPhysicsConstraint');
  spSkeleton_findSlot := GetProcAddress(aDLLHandle, 'spSkeleton_findSlot');
  spSkeleton_findTransformConstraint := GetProcAddress(aDLLHandle, 'spSkeleton_findTransformConstraint');
  spSkeleton_getAttachmentForSlotIndex := GetProcAddress(aDLLHandle, 'spSkeleton_getAttachmentForSlotIndex');
  spSkeleton_getAttachmentForSlotName := GetProcAddress(aDLLHandle, 'spSkeleton_getAttachmentForSlotName');
  spSkeleton_physicsRotate := GetProcAddress(aDLLHandle, 'spSkeleton_physicsRotate');
  spSkeleton_physicsTranslate := GetProcAddress(aDLLHandle, 'spSkeleton_physicsTranslate');
  spSkeleton_setAttachment := GetProcAddress(aDLLHandle, 'spSkeleton_setAttachment');
  spSkeleton_setBonesToSetupPose := GetProcAddress(aDLLHandle, 'spSkeleton_setBonesToSetupPose');
  spSkeleton_setSkin := GetProcAddress(aDLLHandle, 'spSkeleton_setSkin');
  spSkeleton_setSkinByName := GetProcAddress(aDLLHandle, 'spSkeleton_setSkinByName');
  spSkeleton_setSlotsToSetupPose := GetProcAddress(aDLLHandle, 'spSkeleton_setSlotsToSetupPose');
  spSkeleton_setToSetupPose := GetProcAddress(aDLLHandle, 'spSkeleton_setToSetupPose');
  spSkeleton_update := GetProcAddress(aDLLHandle, 'spSkeleton_update');
  spSkeleton_updateCache := GetProcAddress(aDLLHandle, 'spSkeleton_updateCache');
  spSkeleton_updateWorldTransform := GetProcAddress(aDLLHandle, 'spSkeleton_updateWorldTransform');
  spSkeletonBinary_create := GetProcAddress(aDLLHandle, 'spSkeletonBinary_create');
  spSkeletonBinary_createWithLoader := GetProcAddress(aDLLHandle, 'spSkeletonBinary_createWithLoader');
  spSkeletonBinary_dispose := GetProcAddress(aDLLHandle, 'spSkeletonBinary_dispose');
  spSkeletonBinary_readSkeletonData := GetProcAddress(aDLLHandle, 'spSkeletonBinary_readSkeletonData');
  spSkeletonBinary_readSkeletonDataFile := GetProcAddress(aDLLHandle, 'spSkeletonBinary_readSkeletonDataFile');
  spSkeletonBounds_aabbContainsPoint := GetProcAddress(aDLLHandle, 'spSkeletonBounds_aabbContainsPoint');
  spSkeletonBounds_aabbIntersectsSegment := GetProcAddress(aDLLHandle, 'spSkeletonBounds_aabbIntersectsSegment');
  spSkeletonBounds_aabbIntersectsSkeleton := GetProcAddress(aDLLHandle, 'spSkeletonBounds_aabbIntersectsSkeleton');
  spSkeletonBounds_containsPoint := GetProcAddress(aDLLHandle, 'spSkeletonBounds_containsPoint');
  spSkeletonBounds_create := GetProcAddress(aDLLHandle, 'spSkeletonBounds_create');
  spSkeletonBounds_dispose := GetProcAddress(aDLLHandle, 'spSkeletonBounds_dispose');
  spSkeletonBounds_getPolygon := GetProcAddress(aDLLHandle, 'spSkeletonBounds_getPolygon');
  spSkeletonBounds_intersectsSegment := GetProcAddress(aDLLHandle, 'spSkeletonBounds_intersectsSegment');
  spSkeletonBounds_update := GetProcAddress(aDLLHandle, 'spSkeletonBounds_update');
  spSkeletonClipping_clipEnd := GetProcAddress(aDLLHandle, 'spSkeletonClipping_clipEnd');
  spSkeletonClipping_clipEnd2 := GetProcAddress(aDLLHandle, 'spSkeletonClipping_clipEnd2');
  spSkeletonClipping_clipStart := GetProcAddress(aDLLHandle, 'spSkeletonClipping_clipStart');
  spSkeletonClipping_clipTriangles := GetProcAddress(aDLLHandle, 'spSkeletonClipping_clipTriangles');
  spSkeletonClipping_create := GetProcAddress(aDLLHandle, 'spSkeletonClipping_create');
  spSkeletonClipping_dispose := GetProcAddress(aDLLHandle, 'spSkeletonClipping_dispose');
  spSkeletonClipping_isClipping := GetProcAddress(aDLLHandle, 'spSkeletonClipping_isClipping');
  spSkeletonData_create := GetProcAddress(aDLLHandle, 'spSkeletonData_create');
  spSkeletonData_dispose := GetProcAddress(aDLLHandle, 'spSkeletonData_dispose');
  spSkeletonData_findAnimation := GetProcAddress(aDLLHandle, 'spSkeletonData_findAnimation');
  spSkeletonData_findBone := GetProcAddress(aDLLHandle, 'spSkeletonData_findBone');
  spSkeletonData_findEvent := GetProcAddress(aDLLHandle, 'spSkeletonData_findEvent');
  spSkeletonData_findIkConstraint := GetProcAddress(aDLLHandle, 'spSkeletonData_findIkConstraint');
  spSkeletonData_findPathConstraint := GetProcAddress(aDLLHandle, 'spSkeletonData_findPathConstraint');
  spSkeletonData_findPhysicsConstraint := GetProcAddress(aDLLHandle, 'spSkeletonData_findPhysicsConstraint');
  spSkeletonData_findSkin := GetProcAddress(aDLLHandle, 'spSkeletonData_findSkin');
  spSkeletonData_findSlot := GetProcAddress(aDLLHandle, 'spSkeletonData_findSlot');
  spSkeletonData_findTransformConstraint := GetProcAddress(aDLLHandle, 'spSkeletonData_findTransformConstraint');
  spSkeletonDrawable_create := GetProcAddress(aDLLHandle, 'spSkeletonDrawable_create');
  spSkeletonDrawable_dispose := GetProcAddress(aDLLHandle, 'spSkeletonDrawable_dispose');
  spSkeletonDrawable_draw := GetProcAddress(aDLLHandle, 'spSkeletonDrawable_draw');
  spSkeletonDrawable_update := GetProcAddress(aDLLHandle, 'spSkeletonDrawable_update');
  spSkeletonJson_create := GetProcAddress(aDLLHandle, 'spSkeletonJson_create');
  spSkeletonJson_createWithLoader := GetProcAddress(aDLLHandle, 'spSkeletonJson_createWithLoader');
  spSkeletonJson_dispose := GetProcAddress(aDLLHandle, 'spSkeletonJson_dispose');
  spSkeletonJson_readSkeletonData := GetProcAddress(aDLLHandle, 'spSkeletonJson_readSkeletonData');
  spSkeletonJson_readSkeletonDataFile := GetProcAddress(aDLLHandle, 'spSkeletonJson_readSkeletonDataFile');
  spSkin_addSkin := GetProcAddress(aDLLHandle, 'spSkin_addSkin');
  spSkin_attachAll := GetProcAddress(aDLLHandle, 'spSkin_attachAll');
  spSkin_clear := GetProcAddress(aDLLHandle, 'spSkin_clear');
  spSkin_copySkin := GetProcAddress(aDLLHandle, 'spSkin_copySkin');
  spSkin_create := GetProcAddress(aDLLHandle, 'spSkin_create');
  spSkin_dispose := GetProcAddress(aDLLHandle, 'spSkin_dispose');
  spSkin_getAttachment := GetProcAddress(aDLLHandle, 'spSkin_getAttachment');
  spSkin_getAttachmentName := GetProcAddress(aDLLHandle, 'spSkin_getAttachmentName');
  spSkin_getAttachments := GetProcAddress(aDLLHandle, 'spSkin_getAttachments');
  spSkin_setAttachment := GetProcAddress(aDLLHandle, 'spSkin_setAttachment');
  spSlot_create := GetProcAddress(aDLLHandle, 'spSlot_create');
  spSlot_dispose := GetProcAddress(aDLLHandle, 'spSlot_dispose');
  spSlot_setAttachment := GetProcAddress(aDLLHandle, 'spSlot_setAttachment');
  spSlot_setToSetupPose := GetProcAddress(aDLLHandle, 'spSlot_setToSetupPose');
  spSlotData_create := GetProcAddress(aDLLHandle, 'spSlotData_create');
  spSlotData_dispose := GetProcAddress(aDLLHandle, 'spSlotData_dispose');
  spSlotData_setAttachmentName := GetProcAddress(aDLLHandle, 'spSlotData_setAttachmentName');
  spTextureRegionArray_add := GetProcAddress(aDLLHandle, 'spTextureRegionArray_add');
  spTextureRegionArray_addAll := GetProcAddress(aDLLHandle, 'spTextureRegionArray_addAll');
  spTextureRegionArray_addAllValues := GetProcAddress(aDLLHandle, 'spTextureRegionArray_addAllValues');
  spTextureRegionArray_clear := GetProcAddress(aDLLHandle, 'spTextureRegionArray_clear');
  spTextureRegionArray_contains := GetProcAddress(aDLLHandle, 'spTextureRegionArray_contains');
  spTextureRegionArray_create := GetProcAddress(aDLLHandle, 'spTextureRegionArray_create');
  spTextureRegionArray_dispose := GetProcAddress(aDLLHandle, 'spTextureRegionArray_dispose');
  spTextureRegionArray_ensureCapacity := GetProcAddress(aDLLHandle, 'spTextureRegionArray_ensureCapacity');
  spTextureRegionArray_peek := GetProcAddress(aDLLHandle, 'spTextureRegionArray_peek');
  spTextureRegionArray_pop := GetProcAddress(aDLLHandle, 'spTextureRegionArray_pop');
  spTextureRegionArray_removeAt := GetProcAddress(aDLLHandle, 'spTextureRegionArray_removeAt');
  spTextureRegionArray_setSize := GetProcAddress(aDLLHandle, 'spTextureRegionArray_setSize');
  spTimeline_apply := GetProcAddress(aDLLHandle, 'spTimeline_apply');
  spTimeline_dispose := GetProcAddress(aDLLHandle, 'spTimeline_dispose');
  spTimeline_getDuration := GetProcAddress(aDLLHandle, 'spTimeline_getDuration');
  spTimeline_setBezier := GetProcAddress(aDLLHandle, 'spTimeline_setBezier');
  spTimelineArray_add := GetProcAddress(aDLLHandle, 'spTimelineArray_add');
  spTimelineArray_addAll := GetProcAddress(aDLLHandle, 'spTimelineArray_addAll');
  spTimelineArray_addAllValues := GetProcAddress(aDLLHandle, 'spTimelineArray_addAllValues');
  spTimelineArray_clear := GetProcAddress(aDLLHandle, 'spTimelineArray_clear');
  spTimelineArray_contains := GetProcAddress(aDLLHandle, 'spTimelineArray_contains');
  spTimelineArray_create := GetProcAddress(aDLLHandle, 'spTimelineArray_create');
  spTimelineArray_dispose := GetProcAddress(aDLLHandle, 'spTimelineArray_dispose');
  spTimelineArray_ensureCapacity := GetProcAddress(aDLLHandle, 'spTimelineArray_ensureCapacity');
  spTimelineArray_peek := GetProcAddress(aDLLHandle, 'spTimelineArray_peek');
  spTimelineArray_pop := GetProcAddress(aDLLHandle, 'spTimelineArray_pop');
  spTimelineArray_removeAt := GetProcAddress(aDLLHandle, 'spTimelineArray_removeAt');
  spTimelineArray_setSize := GetProcAddress(aDLLHandle, 'spTimelineArray_setSize');
  spTrackEntry_getAnimationTime := GetProcAddress(aDLLHandle, 'spTrackEntry_getAnimationTime');
  spTrackEntry_getTrackComplete := GetProcAddress(aDLLHandle, 'spTrackEntry_getTrackComplete');
  spTrackEntry_isNextReady := GetProcAddress(aDLLHandle, 'spTrackEntry_isNextReady');
  spTrackEntry_resetRotationDirections := GetProcAddress(aDLLHandle, 'spTrackEntry_resetRotationDirections');
  spTrackEntry_setMixDuration := GetProcAddress(aDLLHandle, 'spTrackEntry_setMixDuration');
  spTrackEntry_wasApplied := GetProcAddress(aDLLHandle, 'spTrackEntry_wasApplied');
  spTrackEntryArray_add := GetProcAddress(aDLLHandle, 'spTrackEntryArray_add');
  spTrackEntryArray_addAll := GetProcAddress(aDLLHandle, 'spTrackEntryArray_addAll');
  spTrackEntryArray_addAllValues := GetProcAddress(aDLLHandle, 'spTrackEntryArray_addAllValues');
  spTrackEntryArray_clear := GetProcAddress(aDLLHandle, 'spTrackEntryArray_clear');
  spTrackEntryArray_contains := GetProcAddress(aDLLHandle, 'spTrackEntryArray_contains');
  spTrackEntryArray_create := GetProcAddress(aDLLHandle, 'spTrackEntryArray_create');
  spTrackEntryArray_dispose := GetProcAddress(aDLLHandle, 'spTrackEntryArray_dispose');
  spTrackEntryArray_ensureCapacity := GetProcAddress(aDLLHandle, 'spTrackEntryArray_ensureCapacity');
  spTrackEntryArray_peek := GetProcAddress(aDLLHandle, 'spTrackEntryArray_peek');
  spTrackEntryArray_pop := GetProcAddress(aDLLHandle, 'spTrackEntryArray_pop');
  spTrackEntryArray_removeAt := GetProcAddress(aDLLHandle, 'spTrackEntryArray_removeAt');
  spTrackEntryArray_setSize := GetProcAddress(aDLLHandle, 'spTrackEntryArray_setSize');
  spTransformConstraint_create := GetProcAddress(aDLLHandle, 'spTransformConstraint_create');
  spTransformConstraint_dispose := GetProcAddress(aDLLHandle, 'spTransformConstraint_dispose');
  spTransformConstraint_setToSetupPose := GetProcAddress(aDLLHandle, 'spTransformConstraint_setToSetupPose');
  spTransformConstraint_update := GetProcAddress(aDLLHandle, 'spTransformConstraint_update');
  spTransformConstraintData_create := GetProcAddress(aDLLHandle, 'spTransformConstraintData_create');
  spTransformConstraintData_dispose := GetProcAddress(aDLLHandle, 'spTransformConstraintData_dispose');
  spTransformConstraintDataArray_add := GetProcAddress(aDLLHandle, 'spTransformConstraintDataArray_add');
  spTransformConstraintDataArray_addAll := GetProcAddress(aDLLHandle, 'spTransformConstraintDataArray_addAll');
  spTransformConstraintDataArray_addAllValues := GetProcAddress(aDLLHandle, 'spTransformConstraintDataArray_addAllValues');
  spTransformConstraintDataArray_clear := GetProcAddress(aDLLHandle, 'spTransformConstraintDataArray_clear');
  spTransformConstraintDataArray_contains := GetProcAddress(aDLLHandle, 'spTransformConstraintDataArray_contains');
  spTransformConstraintDataArray_create := GetProcAddress(aDLLHandle, 'spTransformConstraintDataArray_create');
  spTransformConstraintDataArray_dispose := GetProcAddress(aDLLHandle, 'spTransformConstraintDataArray_dispose');
  spTransformConstraintDataArray_ensureCapacity := GetProcAddress(aDLLHandle, 'spTransformConstraintDataArray_ensureCapacity');
  spTransformConstraintDataArray_peek := GetProcAddress(aDLLHandle, 'spTransformConstraintDataArray_peek');
  spTransformConstraintDataArray_pop := GetProcAddress(aDLLHandle, 'spTransformConstraintDataArray_pop');
  spTransformConstraintDataArray_removeAt := GetProcAddress(aDLLHandle, 'spTransformConstraintDataArray_removeAt');
  spTransformConstraintDataArray_setSize := GetProcAddress(aDLLHandle, 'spTransformConstraintDataArray_setSize');
  spTransformConstraintTimeline_create := GetProcAddress(aDLLHandle, 'spTransformConstraintTimeline_create');
  spTransformConstraintTimeline_setFrame := GetProcAddress(aDLLHandle, 'spTransformConstraintTimeline_setFrame');
  spTranslateTimeline_create := GetProcAddress(aDLLHandle, 'spTranslateTimeline_create');
  spTranslateTimeline_setFrame := GetProcAddress(aDLLHandle, 'spTranslateTimeline_setFrame');
  spTranslateXTimeline_create := GetProcAddress(aDLLHandle, 'spTranslateXTimeline_create');
  spTranslateXTimeline_setFrame := GetProcAddress(aDLLHandle, 'spTranslateXTimeline_setFrame');
  spTranslateYTimeline_create := GetProcAddress(aDLLHandle, 'spTranslateYTimeline_create');
  spTranslateYTimeline_setFrame := GetProcAddress(aDLLHandle, 'spTranslateYTimeline_setFrame');
  spTriangulator_create := GetProcAddress(aDLLHandle, 'spTriangulator_create');
  spTriangulator_decompose := GetProcAddress(aDLLHandle, 'spTriangulator_decompose');
  spTriangulator_dispose := GetProcAddress(aDLLHandle, 'spTriangulator_dispose');
  spTriangulator_triangulate := GetProcAddress(aDLLHandle, 'spTriangulator_triangulate');
  spUnsignedShortArray_add := GetProcAddress(aDLLHandle, 'spUnsignedShortArray_add');
  spUnsignedShortArray_addAll := GetProcAddress(aDLLHandle, 'spUnsignedShortArray_addAll');
  spUnsignedShortArray_addAllValues := GetProcAddress(aDLLHandle, 'spUnsignedShortArray_addAllValues');
  spUnsignedShortArray_clear := GetProcAddress(aDLLHandle, 'spUnsignedShortArray_clear');
  spUnsignedShortArray_contains := GetProcAddress(aDLLHandle, 'spUnsignedShortArray_contains');
  spUnsignedShortArray_create := GetProcAddress(aDLLHandle, 'spUnsignedShortArray_create');
  spUnsignedShortArray_dispose := GetProcAddress(aDLLHandle, 'spUnsignedShortArray_dispose');
  spUnsignedShortArray_ensureCapacity := GetProcAddress(aDLLHandle, 'spUnsignedShortArray_ensureCapacity');
  spUnsignedShortArray_peek := GetProcAddress(aDLLHandle, 'spUnsignedShortArray_peek');
  spUnsignedShortArray_pop := GetProcAddress(aDLLHandle, 'spUnsignedShortArray_pop');
  spUnsignedShortArray_removeAt := GetProcAddress(aDLLHandle, 'spUnsignedShortArray_removeAt');
  spUnsignedShortArray_setSize := GetProcAddress(aDLLHandle, 'spUnsignedShortArray_setSize');
  spVertexAttachment_computeWorldVertices := GetProcAddress(aDLLHandle, 'spVertexAttachment_computeWorldVertices');
  spVertexAttachment_copyTo := GetProcAddress(aDLLHandle, 'spVertexAttachment_copyTo');
  unzClose := GetProcAddress(aDLLHandle, 'unzClose');
  unzCloseCurrentFile := GetProcAddress(aDLLHandle, 'unzCloseCurrentFile');
  unzGetCurrentFileInfo64 := GetProcAddress(aDLLHandle, 'unzGetCurrentFileInfo64');
  unzLocateFile := GetProcAddress(aDLLHandle, 'unzLocateFile');
  unzOpen64 := GetProcAddress(aDLLHandle, 'unzOpen64');
  unzOpenCurrentFilePassword := GetProcAddress(aDLLHandle, 'unzOpenCurrentFilePassword');
  unzReadCurrentFile := GetProcAddress(aDLLHandle, 'unzReadCurrentFile');
  unztell64 := GetProcAddress(aDLLHandle, 'unztell64');
  zipClose := GetProcAddress(aDLLHandle, 'zipClose');
  zipCloseFileInZip := GetProcAddress(aDLLHandle, 'zipCloseFileInZip');
  zipOpen64 := GetProcAddress(aDLLHandle, 'zipOpen64');
  zipOpenNewFileInZip3_64 := GetProcAddress(aDLLHandle, 'zipOpenNewFileInZip3_64');
  zipWriteInFileInZip := GetProcAddress(aDLLHandle, 'zipWriteInFileInZip');
end;

{$ENDREGION}

{$REGION ' Pyro.Common '}
const
  CTempStaticBufferSize = 4096;

var
  CriticalSection: TCriticalSection;
  Marshaller: TMarshaller;
  TempStaticBuffer: array[0..CTempStaticBufferSize - 1] of Byte;

function  UnitToScalarValue(const aValue, aMaxValue: Double): Double;
var
  LGain: Double;
  LFactor: Double;
  LVolume: Double;
begin
  LGain := (EnsureRange(aValue, 0.0, 1.0) * 50) - 50;
  LFactor := Power(10, LGain * 0.05);
  LVolume := EnsureRange(aMaxValue * LFactor, 0, aMaxValue);
  Result := LVolume;
end;

procedure FreeNilObject(const [ref] AObject: TObject);
var
  LTemp: TObject;
begin
  if not Assigned(AObject) then Exit;
  try
    CriticalSection.Enter;
    LTemp := AObject;
    TObject(Pointer(@AObject)^) := nil;
    LTemp.Free;
  finally
    CriticalSection.Leave;
  end;
end;

function  GetScreenWorkAreaSize(): sfVector2i;
var
  LRect: TRect;
begin
  SystemParametersInfo(SPI_GETWORKAREA, 0, LRect, 0);
  Result.X := LRect.Width;
  Result.Y := LRect.Height;
end;

function SampleTimeToPosition(SampleRate: Integer; TimeInSeconds: Double; Channels: Integer; SampleSizeInBits: Integer): Int64;
begin
  Result := Round(SampleRate * TimeInSeconds * Channels * (SampleSizeInBits div 8));
end;

function FloatToSmallInt(Value: Single): SmallInt; inline;
begin
  Result := Round(EnsureRange(Value, -1.0, 1.0) * 32767);
end;

procedure ClearKeyboardBuffer();
var
  inputRecord: TInputRecord;
  eventsRead: DWORD;
begin
  // Flush the keyboard buffer by reading all pending input events
  while PeekConsoleInput(GetStdHandle(STD_INPUT_HANDLE), inputRecord, 1,
    eventsRead) and (eventsRead > 0) do
  begin
    ReadConsoleInput(GetStdHandle(STD_INPUT_HANDLE), inputRecord, 1,
      eventsRead);
    // Optionally, you can process the input events if needed
  end;
end;

function WasRunFromConsole() : Boolean;
var
  SI: TStartupInfo;
begin
  SI.cb := SizeOf(TStartupInfo);
  GetStartupInfo(SI);
  Result := ((SI.dwFlags and STARTF_USESHOWWINDOW) = 0);
end;

function IsStartedFromDelphiIDE: Boolean;
begin
  // Check if the IDE environment variable is present
  Result := (GetEnvironmentVariable('BDS') <> '');
end;

procedure Pause();
begin
  if not HasConsoleOutput() then Exit;
  WriteLn;
  Write('Press ENTER to continue...');
  ReadLn;
  WriteLN;
end;

function  GetTempStaticBuffer(): PByte;
begin
  Result := @TempStaticBuffer[0];
end;

function  GetTempStaticBufferSize(): Integer;
begin
  Result := CTempStaticBufferSize;
end;

procedure EnterCriticalSection();
begin
  CriticalSection.Enter;
end;

procedure LeaveCriticalSection();
begin
  CriticalSection.Leave;
end;

function EnableVirtualTerminalProcessing(): DWORD;
var
  HOut: THandle;
  LMode: DWORD;
begin
  HOut := GetStdHandle(STD_OUTPUT_HANDLE);
  if HOut = INVALID_HANDLE_VALUE then
  begin
    Result := GetLastError;
    Exit;
  end;

  if not GetConsoleMode(HOut, LMode) then
  begin
    Result := GetLastError;
    Exit;
  end;

  LMode := LMode or ENABLE_VIRTUAL_TERMINAL_PROCESSING;
  if not SetConsoleMode(HOut, LMode) then
  begin
    Result := GetLastError;
    Exit;
  end;

  Result := 0;  // Success
end;

function HasConsoleOutput: Boolean;
var
  Stdout: THandle;
begin
  Stdout := GetStdHandle(Std_Output_Handle);
  Win32Check(Stdout <> Invalid_Handle_Value);
  Result := Stdout <> 0;
end;

function IsValidWin64PE(const AFilePath: string): Boolean;
var
  LFile: TFileStream;
  LDosHeader: TImageDosHeader;
  LPEHeaderOffset: DWORD;
  LPEHeaderSignature: DWORD;
  LFileHeader: TImageFileHeader;
begin
  Result := False;

  if not FileExists(AFilePath) then
    Exit;

  LFile := TFileStream.Create(AFilePath, fmOpenRead or fmShareDenyWrite);
  try
    // Check if file is large enough for DOS header
    if LFile.Size < SizeOf(TImageDosHeader) then
      Exit;

    // Read DOS header
    LFile.ReadBuffer(LDosHeader, SizeOf(TImageDosHeader));

    // Check DOS signature
    if LDosHeader.e_magic <> IMAGE_DOS_SIGNATURE then // 'MZ'
      Exit;

      // Validate PE header offset
    LPEHeaderOffset := LDosHeader._lfanew;
    if LFile.Size < LPEHeaderOffset + SizeOf(DWORD) + SizeOf(TImageFileHeader) then
      Exit;

    // Seek to the PE header
    LFile.Position := LPEHeaderOffset;

    // Read and validate the PE signature
    LFile.ReadBuffer(LPEHeaderSignature, SizeOf(DWORD));
    if LPEHeaderSignature <> IMAGE_NT_SIGNATURE then // 'PE\0\0'
      Exit;

   // Read the file header
    LFile.ReadBuffer(LFileHeader, SizeOf(TImageFileHeader));

    // Check if it is a 64-bit executable
    if LFileHeader.Machine <> IMAGE_FILE_MACHINE_AMD64 then   Exit;

    // If all checks pass, it's a valid Win64 PE file
    Result := True;
  finally
    LFile.Free;
  end;
end;

function AddResFromMemory(const aModuleFile: string; const aName: string; aData: Pointer; aSize: Cardinal): Boolean;
var
  LHandle: THandle;
begin
  Result := False;
  if not TFile.Exists(aModuleFile) then Exit;
  LHandle := WinApi.Windows.BeginUpdateResourceW(PWideChar(aModuleFile), False);
  if LHandle <> 0 then
  begin
    WinApi.Windows.UpdateResourceW(LHandle, RT_RCDATA, PChar(aName), 1033 {ENGLISH, ENGLISH_US}, aData, aSize);
    Result := WinApi.Windows.EndUpdateResourceW(LHandle, False);
  end;
end;

function ResourceExists(aInstance: THandle; const aResName: string): Boolean;
begin
  Result := Boolean((FindResource(aInstance, PChar(aResName), RT_RCDATA) <> 0));
end;

function RemoveBOM(const AString: string): string; overload;
const
  UTF8BOM: array[0..2] of Byte = ($EF, $BB, $BF);
var
  LBytes: TBytes;
begin
  // Convert the input string to a byte array
  LBytes := TEncoding.UTF8.GetBytes(AString);

  // Check for UTF-8 BOM at the beginning
  if (Length(LBytes) >= 3) and
     (LBytes[0] = UTF8BOM[0]) and
     (LBytes[1] = UTF8BOM[1]) and
     (LBytes[2] = UTF8BOM[2]) then
  begin
    // Remove the BOM by copying the bytes after it
    Result := TEncoding.UTF8.GetString(LBytes, 3, Length(LBytes) - 3);
  end
  else
  begin
    // Return the original string if no BOM is detected
    Result := AString;
  end;
end;

function RemoveBOM(const ABytes: TBytes): TBytes; overload;
const
  UTF8BOM: array[0..2] of Byte = ($EF, $BB, $BF);
  UTF16LEBOM: array[0..1] of Byte = ($FF, $FE);
  UTF16BEBOM: array[0..1] of Byte = ($FE, $FF);
var
  LStartIndex: Integer;
begin
  Result := ABytes;

  // Check for UTF-8 BOM
  if (Length(ABytes) >= 3) and
     (ABytes[0] = UTF8BOM[0]) and
     (ABytes[1] = UTF8BOM[1]) and
     (ABytes[2] = UTF8BOM[2]) then
  begin
    LStartIndex := 3; // Skip the UTF-8 BOM
  end
  // Check for UTF-16 LE BOM
  else if (Length(ABytes) >= 2) and
          (ABytes[0] = UTF16LEBOM[0]) and
          (ABytes[1] = UTF16LEBOM[1]) then
  begin
    LStartIndex := 2; // Skip the UTF-16 LE BOM
  end
  // Check for UTF-16 BE BOM
  else if (Length(ABytes) >= 2) and
          (ABytes[0] = UTF16BEBOM[0]) and
          (ABytes[1] = UTF16BEBOM[1]) then
  begin
    LStartIndex := 2; // Skip the UTF-16 BE BOM
  end
  else
  begin
    Exit; // No BOM found, return the original array
  end;

  // Create a new array without the BOM
  Result := Copy(ABytes, LStartIndex, Length(ABytes) - LStartIndex);
end;

function AsUTF8(const AText: string; const AArgs: array of const; const AUseArgs: Boolean; const ARemoveBOM: Boolean): Pointer;
var
  LText: string;
begin
  if ARemoveBOM then
    LText := RemoveBOM(AText)
  else
    LText := AText;

  if AUseArgs then
    LText := Format(LText, AArgs);
  Result := Marshaller.AsUtf8(LText).ToPointer;
end;

procedure UpdateIconResource(const AExeFilePath, AIconFilePath: string);
type
  TIconDir = packed record
    idReserved: Word;  // Reserved, must be 0
    idType: Word;      // Resource type, 1 for icons
    idCount: Word;     // Number of images in the file
  end;
  PIconDir = ^TIconDir;

  TGroupIconDirEntry = packed record
    bWidth: Byte;            // Width of the icon (0 means 256)
    bHeight: Byte;           // Height of the icon (0 means 256)
    bColorCount: Byte;       // Number of colors in the palette (0 if more than 256)
    bReserved: Byte;         // Reserved, must be 0
    wPlanes: Word;           // Color planes
    wBitCount: Word;         // Bits per pixel
    dwBytesInRes: Cardinal;  // Size of the image data
    nID: Word;               // Resource ID of the icon
  end;

  TGroupIconDir = packed record
    idReserved: Word;  // Reserved, must be 0
    idType: Word;      // Resource type, 1 for icons
    idCount: Word;     // Number of images in the file
    Entries: array[0..0] of TGroupIconDirEntry; // Variable-length array
  end;

  TIconResInfo = packed record
    bWidth: Byte;            // Width of the icon (0 means 256)
    bHeight: Byte;           // Height of the icon (0 means 256)
    bColorCount: Byte;       // Number of colors in the palette (0 if more than 256)
    bReserved: Byte;         // Reserved, must be 0
    wPlanes: Word;           // Color planes (should be 1)
    wBitCount: Word;         // Bits per pixel
    dwBytesInRes: Cardinal;  // Size of the image data
    dwImageOffset: Cardinal; // Offset of the image data in the file
  end;
  PIconResInfo = ^TIconResInfo;

var
  LUpdateHandle: THandle;
  LIconStream: TMemoryStream;
  LIconDir: PIconDir;
  LIconGroup: TMemoryStream;
  LIconRes: PByte;
  LIconID: Word;
  I: Integer;
  LGroupEntry: TGroupIconDirEntry;
begin

  if not FileExists(AExeFilePath) then
    raise Exception.Create('The specified executable file does not exist.');

  if not FileExists(AIconFilePath) then
    raise Exception.Create('The specified icon file does not exist.');

  LIconStream := TMemoryStream.Create;
  LIconGroup := TMemoryStream.Create;
  try
    // Load the icon file
    LIconStream.LoadFromFile(AIconFilePath);

    // Read the ICONDIR structure from the icon file
    LIconDir := PIconDir(LIconStream.Memory);
    if LIconDir^.idReserved <> 0 then
      raise Exception.Create('Invalid icon file format.');

    // Begin updating the executable's resources
    LUpdateHandle := BeginUpdateResource(PChar(AExeFilePath), False);
    if LUpdateHandle = 0 then
      raise Exception.Create('Failed to begin resource update.');

    try
      // Process each icon image in the .ico file
      LIconRes := PByte(LIconStream.Memory) + SizeOf(TIconDir);
      for I := 0 to LIconDir^.idCount - 1 do
      begin
        // Assign a unique resource ID for the RT_ICON
        LIconID := I + 1;

        // Add the icon image data as an RT_ICON resource
        if not UpdateResource(LUpdateHandle, RT_ICON, PChar(LIconID), LANG_NEUTRAL,
          Pointer(PByte(LIconStream.Memory) + PIconResInfo(LIconRes)^.dwImageOffset),
          PIconResInfo(LIconRes)^.dwBytesInRes) then
          raise Exception.CreateFmt('Failed to add RT_ICON resource for image %d.', [I]);

        // Move to the next icon entry
        Inc(LIconRes, SizeOf(TIconResInfo));
      end;

      // Create the GROUP_ICON resource
      LIconGroup.Clear;
      LIconGroup.Write(LIconDir^, SizeOf(TIconDir)); // Write ICONDIR header

      LIconRes := PByte(LIconStream.Memory) + SizeOf(TIconDir);
      // Write each GROUP_ICON entry
      for I := 0 to LIconDir^.idCount - 1 do
      begin
        // Populate the GROUP_ICON entry
        LGroupEntry.bWidth := PIconResInfo(LIconRes)^.bWidth;
        LGroupEntry.bHeight := PIconResInfo(LIconRes)^.bHeight;
        LGroupEntry.bColorCount := PIconResInfo(LIconRes)^.bColorCount;
        LGroupEntry.bReserved := 0;
        LGroupEntry.wPlanes := PIconResInfo(LIconRes)^.wPlanes;
        LGroupEntry.wBitCount := PIconResInfo(LIconRes)^.wBitCount;
        LGroupEntry.dwBytesInRes := PIconResInfo(LIconRes)^.dwBytesInRes;
        LGroupEntry.nID := I + 1; // Match resource ID for RT_ICON

        // Write the populated GROUP_ICON entry to the stream
        LIconGroup.Write(LGroupEntry, SizeOf(TGroupIconDirEntry));

        // Move to the next ICONDIRENTRY
        Inc(LIconRes, SizeOf(TIconResInfo));
      end;

      // Add the GROUP_ICON resource to the executable
      if not UpdateResource(LUpdateHandle, RT_GROUP_ICON, 'MAINICON', LANG_NEUTRAL,
        LIconGroup.Memory, LIconGroup.Size) then
        raise Exception.Create('Failed to add RT_GROUP_ICON resource.');

      // Commit the resource updates
      if not EndUpdateResource(LUpdateHandle, False) then
        raise Exception.Create('Failed to commit resource updates.');
    except
      EndUpdateResource(LUpdateHandle, True); // Discard changes on failure
      raise;
    end;
  finally
    LIconStream.Free;
    LIconGroup.Free;
  end;
end;

procedure UpdateVersionInfoResource(const PEFilePath: string; const AMajor, AMinor, APatch: Word; const AProductName, ADescription, AFilename, ACompanyName, ACopyright: string);
type
  { TVSFixedFileInfo }
  TVSFixedFileInfo = packed record
    dwSignature: DWORD;        // e.g. $FEEF04BD
    dwStrucVersion: DWORD;     // e.g. $00010000 for version 1.0
    dwFileVersionMS: DWORD;    // e.g. $00030075 for version 3.75
    dwFileVersionLS: DWORD;    // e.g. $00000031 for version 0.31
    dwProductVersionMS: DWORD; // Same format as dwFileVersionMS
    dwProductVersionLS: DWORD; // Same format as dwFileVersionLS
    dwFileFlagsMask: DWORD;    // = $3F for version "0011 1111"
    dwFileFlags: DWORD;        // e.g. VFF_DEBUG | VFF_PRERELEASE
    dwFileOS: DWORD;           // e.g. VOS_NT_WINDOWS32
    dwFileType: DWORD;         // e.g. VFT_APP
    dwFileSubtype: DWORD;      // e.g. VFT2_UNKNOWN
    dwFileDateMS: DWORD;       // file date
    dwFileDateLS: DWORD;       // file date
  end;

  { TStringPair }
  TStringPair = record
    Key: string;
    Value: string;
  end;

var
  LHandleUpdate: THandle;
  LVersionInfoStream: TMemoryStream;
  LFixedInfo: TVSFixedFileInfo;
  LDataPtr: Pointer;
  LDataSize: Integer;
  LStringFileInfoStart, LStringTableStart, LVarFileInfoStart: Int64;
  LStringPairs: array of TStringPair;
  LVErsion: string;
  LMajor, LMinor,LPatch: Word;
  LVSVersionInfoStart: Int64;
  LPair: TStringPair;
  LStringInfoEnd, LStringStart: Int64;
  LStringEnd, LFinalPos: Int64;
  LTranslationStart: Int64;

  procedure AlignStream(const AStream: TMemoryStream; const AAlignment: Integer);
  var
    LPadding: Integer;
    LPadByte: Byte;
  begin
    LPadding := (AAlignment - (AStream.Position mod AAlignment)) mod AAlignment;
    LPadByte := 0;
    while LPadding > 0 do
    begin
      AStream.WriteBuffer(LPadByte, 1);
      Dec(LPadding);
    end;
  end;

  procedure WriteWideString(const AStream: TMemoryStream; const AText: string);
  var
    LWideText: WideString;
  begin
    LWideText := WideString(AText);
    AStream.WriteBuffer(PWideChar(LWideText)^, (Length(LWideText) + 1) * SizeOf(WideChar));
  end;

  procedure SetFileVersionFromString(const AVersion: string; out AFileVersionMS, AFileVersionLS: DWORD);
  var
    LVersionParts: TArray<string>;
    LMajor, LMinor, LBuild, LRevision: Word;
  begin
    // Split the version string into its components
    LVersionParts := AVersion.Split(['.']);
    if Length(LVersionParts) <> 4 then
      raise Exception.Create('Invalid version string format. Expected "Major.Minor.Build.Revision".');

    // Parse each part into a Word
    LMajor := StrToIntDef(LVersionParts[0], 0);
    LMinor := StrToIntDef(LVersionParts[1], 0);
    LBuild := StrToIntDef(LVersionParts[2], 0);
    LRevision := StrToIntDef(LVersionParts[3], 0);

    // Set the high and low DWORD values
    AFileVersionMS := (DWORD(LMajor) shl 16) or DWORD(LMinor);
    AFileVersionLS := (DWORD(LBuild) shl 16) or DWORD(LRevision);
  end;

begin
  LMajor := EnsureRange(AMajor, 0, MaxWord);
  LMinor := EnsureRange(AMinor, 0, MaxWord);
  LPatch := EnsureRange(APatch, 0, MaxWord);
  LVersion := Format('%d.%d.%d.0', [LMajor, LMinor, LPatch]);

  SetLength(LStringPairs, 8);
  LStringPairs[0].Key := 'CompanyName';
  LStringPairs[0].Value := ACompanyName;
  LStringPairs[1].Key := 'FileDescription';
  LStringPairs[1].Value := ADescription;
  LStringPairs[2].Key := 'FileVersion';
  LStringPairs[2].Value := LVersion;
  LStringPairs[3].Key := 'InternalName';
  LStringPairs[3].Value := ADescription;
  LStringPairs[4].Key := 'LegalCopyright';
  LStringPairs[4].Value := ACopyright;
  LStringPairs[5].Key := 'OriginalFilename';
  LStringPairs[5].Value := AFilename;
  LStringPairs[6].Key := 'ProductName';
  LStringPairs[6].Value := AProductName;
  LStringPairs[7].Key := 'ProductVersion';
  LStringPairs[7].Value := LVersion;

  // Initialize fixed info structure
  FillChar(LFixedInfo, SizeOf(LFixedInfo), 0);
  LFixedInfo.dwSignature := $FEEF04BD;
  LFixedInfo.dwStrucVersion := $00010000;
  LFixedInfo.dwFileVersionMS := $00010000;
  LFixedInfo.dwFileVersionLS := $00000000;
  LFixedInfo.dwProductVersionMS := $00010000;
  LFixedInfo.dwProductVersionLS := $00000000;
  LFixedInfo.dwFileFlagsMask := $3F;
  LFixedInfo.dwFileFlags := 0;
  LFixedInfo.dwFileOS := VOS_NT_WINDOWS32;
  LFixedInfo.dwFileType := VFT_APP;
  LFixedInfo.dwFileSubtype := 0;
  LFixedInfo.dwFileDateMS := 0;
  LFixedInfo.dwFileDateLS := 0;

  // SEt MS and LS for FileVersion and ProductVersion
  SetFileVersionFromString(LVersion, LFixedInfo.dwFileVersionMS, LFixedInfo.dwFileVersionLS);
  SetFileVersionFromString(LVersion, LFixedInfo.dwProductVersionMS, LFixedInfo.dwProductVersionLS);

  LVersionInfoStream := TMemoryStream.Create;
  try
    // VS_VERSION_INFO
    LVSVersionInfoStart := LVersionInfoStream.Position;

    LVersionInfoStream.WriteData<Word>(0);  // Length placeholder
    LVersionInfoStream.WriteData<Word>(SizeOf(TVSFixedFileInfo));  // Value length
    LVersionInfoStream.WriteData<Word>(0);  // Type = 0
    WriteWideString(LVersionInfoStream, 'VS_VERSION_INFO');
    AlignStream(LVersionInfoStream, 4);

    // VS_FIXEDFILEINFO
    LVersionInfoStream.WriteBuffer(LFixedInfo, SizeOf(TVSFixedFileInfo));
    AlignStream(LVersionInfoStream, 4);

    // StringFileInfo
    LStringFileInfoStart := LVersionInfoStream.Position;
    LVersionInfoStream.WriteData<Word>(0);  // Length placeholder
    LVersionInfoStream.WriteData<Word>(0);  // Value length = 0
    LVersionInfoStream.WriteData<Word>(1);  // Type = 1
    WriteWideString(LVersionInfoStream, 'StringFileInfo');
    AlignStream(LVersionInfoStream, 4);

    // StringTable
    LStringTableStart := LVersionInfoStream.Position;
    LVersionInfoStream.WriteData<Word>(0);  // Length placeholder
    LVersionInfoStream.WriteData<Word>(0);  // Value length = 0
    LVersionInfoStream.WriteData<Word>(1);  // Type = 1
    WriteWideString(LVersionInfoStream, '040904B0'); // Match Delphi's default code page
    AlignStream(LVersionInfoStream, 4);

    // Write string pairs
    for LPair in LStringPairs do
    begin
      LStringStart := LVersionInfoStream.Position;

      LVersionInfoStream.WriteData<Word>(0);  // Length placeholder
      LVersionInfoStream.WriteData<Word>((Length(LPair.Value) + 1) * 2);  // Value length
      LVersionInfoStream.WriteData<Word>(1);  // Type = 1
      WriteWideString(LVersionInfoStream, LPair.Key);
      AlignStream(LVersionInfoStream, 4);
      WriteWideString(LVersionInfoStream, LPair.Value);
      AlignStream(LVersionInfoStream, 4);

      LStringEnd := LVersionInfoStream.Position;
      LVersionInfoStream.Position := LStringStart;
      LVersionInfoStream.WriteData<Word>(LStringEnd - LStringStart);
      LVersionInfoStream.Position := LStringEnd;
    end;

    LStringInfoEnd := LVersionInfoStream.Position;

    // Write StringTable length
    LVersionInfoStream.Position := LStringTableStart;
    LVersionInfoStream.WriteData<Word>(LStringInfoEnd - LStringTableStart);

    // Write StringFileInfo length
    LVersionInfoStream.Position := LStringFileInfoStart;
    LVersionInfoStream.WriteData<Word>(LStringInfoEnd - LStringFileInfoStart);

    // Start VarFileInfo where StringFileInfo ended
    LVarFileInfoStart := LStringInfoEnd;
    LVersionInfoStream.Position := LVarFileInfoStart;

    // VarFileInfo header
    LVersionInfoStream.WriteData<Word>(0);  // Length placeholder
    LVersionInfoStream.WriteData<Word>(0);  // Value length = 0
    LVersionInfoStream.WriteData<Word>(1);  // Type = 1 (text)
    WriteWideString(LVersionInfoStream, 'VarFileInfo');
    AlignStream(LVersionInfoStream, 4);

    // Translation value block
    LTranslationStart := LVersionInfoStream.Position;
    LVersionInfoStream.WriteData<Word>(0);  // Length placeholder
    LVersionInfoStream.WriteData<Word>(4);  // Value length = 4 (size of translation value)
    LVersionInfoStream.WriteData<Word>(0);  // Type = 0 (binary)
    WriteWideString(LVersionInfoStream, 'Translation');
    AlignStream(LVersionInfoStream, 4);

    // Write translation value
    LVersionInfoStream.WriteData<Word>($0409);  // Language ID (US English)
    LVersionInfoStream.WriteData<Word>($04B0);  // Unicode code page

    LFinalPos := LVersionInfoStream.Position;

    // Update VarFileInfo block length
    LVersionInfoStream.Position := LVarFileInfoStart;
    LVersionInfoStream.WriteData<Word>(LFinalPos - LVarFileInfoStart);

    // Update translation block length
    LVersionInfoStream.Position := LTranslationStart;
    LVersionInfoStream.WriteData<Word>(LFinalPos - LTranslationStart);

    // Update total version info length
    LVersionInfoStream.Position := LVSVersionInfoStart;
    LVersionInfoStream.WriteData<Word>(LFinalPos);

    LDataPtr := LVersionInfoStream.Memory;
    LDataSize := LVersionInfoStream.Size;

    // Update the resource
    LHandleUpdate := BeginUpdateResource(PChar(PEFilePath), False);
    if LHandleUpdate = 0 then
      RaiseLastOSError;

    try
      if not UpdateResourceW(LHandleUpdate, RT_VERSION, MAKEINTRESOURCE(1),
         MAKELANGID(LANG_NEUTRAL, SUBLANG_NEUTRAL), LDataPtr, LDataSize) then
        RaiseLastOSError;

      if not EndUpdateResource(LHandleUpdate, False) then
        RaiseLastOSError;
    except
      EndUpdateResource(LHandleUpdate, True);
      raise;
    end;
  finally
    LVersionInfoStream.Free;
  end;
end;

function HasEnoughDiskSpace(const APath: string; ARequiredSpace: Int64): Boolean;
var
  LFreeAvailable: Int64;
  LTotalSpace: Int64;
  LTotalFree: Int64;
begin
  Result := GetDiskFreeSpaceEx(PChar(APath), LFreeAvailable, LTotalSpace, @LTotalFree) and
            (LFreeAvailable >= ARequiredSpace);
end;

{ =========================================================================== }

{ TBuffer }
procedure TVirtualBuffer.Clear;
begin
  if (Memory <> nil) then
  begin
    if not UnmapViewOfFile(Memory) then
      raise Exception.Create('Error deallocating mapped memory');
  end;

  if (FHandle <> 0) then
  begin
    if not CloseHandle(FHandle) then
      raise Exception.Create('Error freeing memory mapping handle');
  end;
end;

constructor TVirtualBuffer.Create(aSize: Cardinal);
var
  P: Pointer;
begin
  inherited Create;
  FName := TPath.GetGUIDFileName;
  FHandle := CreateFileMapping(INVALID_HANDLE_VALUE, nil, PAGE_READWRITE, 0, aSize, PChar(FName));
  if FHandle = 0 then
    begin
      Clear;
      raise Exception.Create('Error creating memory mapping');
      FHandle := 0;
    end
  else
    begin
      P := MapViewOfFile(FHandle, FILE_MAP_ALL_ACCESS, 0, 0, 0);
      if P = nil then
        begin
          Clear;
          raise Exception.Create('Error creating memory mapping');
        end
      else
        begin
          Self.SetPointer(P, aSize);
          Position := 0;
        end;
    end;
end;

destructor TVirtualBuffer.Destroy;
begin
  Clear;
  inherited;
end;

function TVirtualBuffer.Write(const aBuffer; aCount: Longint): Longint;
var
  Pos: Int64;
begin
  if (Position >= 0) and (aCount >= 0) then
  begin
    Pos := Position + aCount;
    if Pos > 0 then
    begin
      if Pos > Size then
      begin
        Result := 0;
        Exit;
      end;
      System.Move(aBuffer, (PByte(Memory) + Position)^, aCount);
      Position := Pos;
      Result := aCount;
      Exit;
    end;
  end;
  Result := 0;
end;

function TVirtualBuffer.Write(const aBuffer: TBytes; aOffset, aCount: Longint): Longint;
var
  Pos: Int64;
begin
  if (Position >= 0) and (aCount >= 0) then
  begin
    Pos := Position + aCount;
    if Pos > 0 then
    begin
      if Pos > Size then
      begin
        Result := 0;
        Exit;
      end;
      System.Move(aBuffer[aOffset], (PByte(Memory) + Position)^, aCount);
      Position := Pos;
      Result := aCount;
      Exit;
    end;
  end;
  Result := 0;
end;

procedure TVirtualBuffer.SaveToFile(aFilename: string);
var
  LStream: TFileStream;
begin
  LStream := TFile.Create(aFilename);
  try
    LStream.Write(Memory^, Size);
  finally
    LStream.Free;
  end;
end;

class function TVirtualBuffer.LoadFromFile(const aFilename: string): TVirtualBuffer;
var
  LStream: TStream;
  LBuffer: TVirtualBuffer;
begin
  Result := nil;
  if aFilename.IsEmpty then Exit;
  if not TFile.Exists(aFilename) then Exit;
  LStream := TFile.OpenRead(aFilename);
  try
    LBuffer := TVirtualBuffer.Create(LStream.Size);
    if LBuffer <> nil then
    begin
      LBuffer.CopyFrom(LStream);
    end;
  finally
    FreeAndNil(LStream);
  end;
  Result := LBuffer;
end;

function  TVirtualBuffer.Eob: Boolean;
begin
  Result := Boolean(Position >= Size);
end;

function  TVirtualBuffer.ReadString: WideString;
var
  LLength: LongInt;
begin
  Read(LLength, SizeOf(LLength));
  SetLength(Result, LLength);
  if LLength > 0 then Read(Result[1], LLength * SizeOf(Char));
end;

{ TRingBuffer }
constructor TRingBuffer<T>.Create(ACapacity: Integer);
begin
  SetLength(FBuffer, ACapacity);
  FReadIndex := 0;
  FWriteIndex := 0;
  FCapacity := ACapacity;
  Clear;
end;

function TRingBuffer<T>.Write(const AData: array of T;
  ACount: Integer): Integer;
var
  i, WritePos: Integer;
begin
  EnterCriticalSection;
  try
    for i := 0 to ACount - 1 do
    begin
      WritePos := (FWriteIndex + i) mod FCapacity;
      FBuffer[WritePos] := AData[i];
    end;
    FWriteIndex := (FWriteIndex + ACount) mod FCapacity;
    Result := ACount;
  finally
    LeaveCriticalSection;
  end;
end;

function TRingBuffer<T>.Read(var AData: array of T; ACount: Integer): Integer;
var
  i, ReadPos: Integer;
begin
  for i := 0 to ACount - 1 do
  begin
    ReadPos := (FReadIndex + i) mod FCapacity;
    AData[i] := FBuffer[ReadPos];
  end;
  FReadIndex := (FReadIndex + ACount) mod FCapacity;
  Result := ACount;
end;

function TRingBuffer<T>.DirectReadPointer(ACount: Integer): Pointer;
begin
  Result := @FBuffer[FReadIndex mod FCapacity];
  FReadIndex := (FReadIndex + ACount) mod FCapacity;
end;

function TRingBuffer<T>.AvailableBytes: Integer;
begin
  Result := (FCapacity + FWriteIndex - FReadIndex) mod FCapacity;
end;

procedure TRingBuffer<T>.Clear;
var
  I: Integer;
begin

  EnterCriticalSection;
  try
    for I := Low(FBuffer) to High(FBuffer) do
    begin
      FBuffer[I] := Default(T);
    end;
    FReadIndex := 0;
    FWriteIndex := 0;
  finally
    LeaveCriticalSection;
  end;
end;

{ TVirtualRingBuffer }
function TVirtualRingBuffer<T>.GetArrayValue(AIndex: Integer): T;
begin
  Result := PType(PByte(FBuffer.Memory) + AIndex * SizeOf(T))^;
end;

procedure TVirtualRingBuffer<T>.SetArrayValue(AIndex: Integer; AValue: T);
begin
  PType(PByte(FBuffer.Memory) + AIndex * SizeOf(T))^ := AValue;
end;

constructor TVirtualRingBuffer<T>.Create(ACapacity: Integer);
begin
  FBuffer := TVirtualBuffer.Create(ACapacity*SizeOf(T));
  FReadIndex := 0;
  FWriteIndex := 0;
  FCapacity := ACapacity;
  Clear;
end;

destructor TVirtualRingBuffer<T>.Destroy;
begin
  FBuffer.Free;
  inherited;
end;

function TVirtualRingBuffer<T>.Write(const AData: array of T;
  ACount: Integer): Integer;
var
  i, WritePos: Integer;
begin
  EnterCriticalSection;
  try
    for i := 0 to ACount - 1 do
    begin
      WritePos := (FWriteIndex + i) mod FCapacity;
      SetArrayValue(WritePos, AData[i]);
    end;
    FWriteIndex := (FWriteIndex + ACount) mod FCapacity;
    Result := ACount;
  finally
    LeaveCriticalSection;
  end;
end;

function TVirtualRingBuffer<T>.Read(var AData: array of T; ACount: Integer): Integer;
var
  i, ReadPos: Integer;
begin
  for i := 0 to ACount - 1 do
  begin
    ReadPos := (FReadIndex + i) mod FCapacity;
    AData[i] := GetArrayValue(ReadPos);
  end;
  FReadIndex := (FReadIndex + ACount) mod FCapacity;
  Result := ACount;
end;

function TVirtualRingBuffer<T>.DirectReadPointer(ACount: Integer): Pointer;
begin
  Result := PType(PByte(FBuffer.Memory) + (FReadIndex mod FCapacity) * SizeOf(T));
  FReadIndex := (FReadIndex + ACount) mod FCapacity;
end;

function TVirtualRingBuffer<T>.AvailableBytes: Integer;
begin
  Result := (FCapacity + FWriteIndex - FReadIndex) mod FCapacity;
end;

procedure TVirtualRingBuffer<T>.Clear;
var
  I: Integer;
begin

  EnterCriticalSection;
  try
    for I := 0 to FCapacity-1 do
    begin
     SetArrayValue(I, Default(T));
    end;

    FReadIndex := 0;
    FWriteIndex := 0;
  finally
    LeaveCriticalSection;
  end;
end;

{ TBaseObject }
constructor TBaseObject.Create();
begin
  inherited;
end;

destructor TBaseObject.Destroy();
begin
  inherited;
end;


{$ENDREGION}

{$REGION ' Pyro.Deps.Ext '}
{ sfError }
type
  TsfError = record
    Callback: sfErrorCallback;
    UserData: Pointer;
    Msg: string;
  end;

var
  sfError: TsfError;

procedure cerr_callback(const text: PUTF8Char; user_data: Pointer); cdecl;
begin
  sfError_set(UTF8ToUnicodeString(text), []);
end;

procedure sfError_setCallback(const AHandler: sfErrorCallback;  const AUserData: Pointer);
begin
  sfError.Callback := AHandler;
  sfError.UserData := AUserData;
end;

function  sfError_getCallback(): sfErrorCallback;
begin
  Result := sfError.Callback;
end;

procedure sfError_set(const AMsg: string; const AArgs: array of const);
begin
  sfError.Msg := Format(AMsg, AArgs);
  if Assigned(sfError.Callback) then
  begin
    sfError.Callback(sfError.Msg, sfError.UserData);
  end;
end;

function  sfError_getLast(): string;
begin
  Result := sfError.Msg;
end;

{ sfConsole }
procedure sfConsole_Print(const AMsg: string; const AArgs: array of const);
begin
  if not HasConsoleOutput() then Exit;
  Write(Format(AMsg, AArgs)+sfCSIResetFormat);
end;

procedure sfConsole_print();
begin
  if not HasConsoleOutput() then Exit;
  Write;
  Write(sfCSIResetFormat);
end;


procedure sfConsole_printLn(const AMsg: string; const AArgs: array of const);
begin
  if not HasConsoleOutput() then Exit;
  WriteLn(Format(AMsg, AArgs)+sfCSIResetFormat);
end;

procedure sfConsole_printLn();
begin
  if not HasConsoleOutput() then Exit;
  WriteLn;
  Write(sfCSIResetFormat);
end;

procedure sfConsole_setCursorPos(const X, Y: Integer);
begin
  if not HasConsoleOutput() then Exit;
  Write(Format(sfCSICursorPos, [Y, X]));
end;

procedure sfConsole_moveCursorUp(const ALines: Integer);
begin
  if not HasConsoleOutput() then Exit;
  Write(Format(sfCSICursorUp, [ALines]));
end;

procedure sfConsole_moveCursorDown(const ALines: Integer);
begin
  if not HasConsoleOutput() then Exit;
  Write(Format(sfCSICursorDown, [ALines]));
end;

procedure sfConsole_moveCursorForward(const ACols: Integer);
begin
  if not HasConsoleOutput() then Exit;
  Write(Format(sfCSICursorForward, [ACols]));
end;

procedure sfConsole_moveCursorBack(const ACols: Integer);
begin
  if not HasConsoleOutput() then Exit;
  Write(Format(sfCSICursorBack, [ACols]));
end;

procedure sfConsole_clearScreen();
begin
  if not HasConsoleOutput() then Exit;
  Write(sfCSIClearScreen);
  sfConsole_setCursorPos(0, 0);
end;

procedure sfConsole_clearLine();
begin
  if not HasConsoleOutput() then Exit;
  Write(sfCSIClearLine);
end;

procedure sfConsole_hideCursor();
begin
  if not HasConsoleOutput() then Exit;
  Write(sfCSIHideCursor);
end;

procedure sfConsole_showCursor();
begin
  if not HasConsoleOutput() then Exit;
  Write(sfCSIShowCursor);
end;

procedure sfConsole_saveCursorPos();
begin
  if not HasConsoleOutput() then Exit;
  Write(sfCSISaveCursorPos);
end;

procedure sfConsole_restoreCursorPos();
begin
  if not HasConsoleOutput() then Exit;
  Write(sfCSIRestoreCursorPos);
end;

procedure sfConsole_setBoldText;
begin
  if not HasConsoleOutput() then Exit;
  Write(sfCSIBold);
end;

procedure sfConsole_resetTextFormat();
begin
  if not HasConsoleOutput() then Exit;
  Write(sfCSIResetFormat);
end;

procedure sfConsole_setForegroundColor(const AColor: string);
begin
  if not HasConsoleOutput() then Exit;
  Write(AColor);
end;

procedure sfConsole_setBackgroundColor(const AColor: string);
begin
  if not HasConsoleOutput() then Exit;
  Write(AColor);
end;

procedure sfConsole_setForegroundRGB(const ARed, AGreen, ABlue: Byte);
begin
  if not HasConsoleOutput() then Exit;
  Write(Format(sfCSIFGRGB, [ARed, AGreen, ABlue]));
end;

procedure sfConsole_setBackgroundRGB(const ARed, AGreen, ABlue: Byte);
begin
  if not HasConsoleOutput() then Exit;
  Write(Format(sfCSIBGRGB, [ARed, AGreen, ABlue]));
end;

procedure sfConsole_waitForAnyKey();
var
  LInputRec: TInputRecord;
  LNumRead: Cardinal;
  LOldMode: DWORD;
  LStdIn: THandle;
begin
  LStdIn := GetStdHandle(STD_INPUT_HANDLE);
  GetConsoleMode(LStdIn, LOldMode);
  SetConsoleMode(LStdIn, 0);
  repeat
    ReadConsoleInput(LStdIn, LInputRec, 1, LNumRead);
  until (LInputRec.EventType and KEY_EVENT <> 0) and
    LInputRec.Event.KeyEvent.bKeyDown;
  SetConsoleMode(LStdIn, LOldMode);
end;

function sfConsole_anyKeyPressed(): Boolean;
var
  lpNumberOfEvents     : DWORD;
  lpBuffer             : TInputRecord;
  lpNumberOfEventsRead : DWORD;
  nStdHandle           : THandle;
begin
  Result:=false;
  //get the console handle
  nStdHandle := GetStdHandle(STD_INPUT_HANDLE);
  lpNumberOfEvents:=0;
  //get the number of events
  GetNumberOfConsoleInputEvents(nStdHandle,lpNumberOfEvents);
  if lpNumberOfEvents<> 0 then
  begin
    //retrieve the event
    PeekConsoleInput(nStdHandle,lpBuffer,1,lpNumberOfEventsRead);
    if lpNumberOfEventsRead <> 0 then
    begin
      if lpBuffer.EventType = KEY_EVENT then //is a Keyboard event?
      begin
        if lpBuffer.Event.KeyEvent.bKeyDown then //the key was pressed?
          Result:=true
        else
          FlushConsoleInputBuffer(nStdHandle); //flush the buffer
      end
      else
      FlushConsoleInputBuffer(nStdHandle);//flush the buffer
    end;
  end;
end;

procedure sfConsole_pause(const AForcePause: Boolean; AColor: string; const AMsg: string);
var
  LDoPause: Boolean;
begin
  if not HasConsoleOutput then Exit;

  ClearKeyboardBuffer;

  if not AForcePause then
  begin
    LDoPause := True;
    if WasRunFromConsole then LDoPause := False;
    if IsStartedFromDelphiIDE then LDoPause := True;
    if not LDoPause then Exit;
  end;

  WriteLn;
  if aMsg.IsEmpty then
    sfConsole_print('%sPress any key to continue... ', [aColor])
  else
    //Write(aMsg);
    sfConsole_print('%s%s', [aColor, AMsg]);

  sfConsole_waitForAnyKey;
  WriteLn;
end;

procedure sfConsole_setTitle(const ATitle: string);
begin
  WinApi.Windows.SetConsoleTitle(PChar(ATitle));
end;

{ sfVector }
function  sfVector2i_create(const X, Y: Integer): sfVector2i;
begin
  Result.x := X;
  Result.y := Y;
end;

function  sfVector2u_create(const X, Y: Cardinal): sfVector2u;
begin
  Result.x := X;
  Result.y := Y;
end;

function  sfVector2f_create(const X, Y: Single): sfVector2f;
begin
  Result.x := X;
  Result.y := Y;
end;

function  sfVector3f_create(const X, Y, Z: Single): sfVector3f;
begin
  Result.x := X;
  Result.y := Y;
  Result.z := Z;
end;

{ sfRect }
function  sfFloatRect_create(const ALeft, ATop, AWidth, AHeight: Single): sfFloatRect;
begin
  Result.position.x := ALeft;
  Result.position.y := ATop;
  Result.size.x := AWidth;
  Result.size.y := AHeight;
end;

function  sfIntRect_create(const ALeft, ATop, AWidth, AHeight: Integer): sfIntRect;
begin
  Result.position.x := ALeft;
  Result.position.y := ATop;
  Result.size.x := AWidth;
  Result.size.y := AHeight;
end;

{ sfZipFile }
procedure sfZipFile_buildProgress(const ASender: Pointer; const AFilename: string; const AProgress: Integer; const ANewFile: Boolean); cdecl;
begin
  if aNewFile then sfConsole_PrintLn('', []);
  sfConsole_print(#13+'Adding %s(%d%s)...', [ExtractFileName(aFilename), aProgress, '%']);
end;

function sfZipFile_build(const AArchive, ADirectory: string; const APassword: string; const ASender: Pointer; const AHandler: sfZipFile_buildProgressCallback): Boolean;
var
  LFileList: TStringDynArray;
  LArchive: PAnsiChar;
  LFilename: string;
  LFilename2: PAnsiChar;
  LPassword: PAnsiChar;
  LZipFile: zipFile;
  LZipFileInfo: zip_fileinfo;
  LFile: TStream;
  LCrc: Cardinal;
  LBytesRead: Integer;
  LFileSize: Int64;
  LProgress: Single;
  LNewFile: Boolean;
  LHandler: sfZipFile_buildProgressCallback;
  LSender: Pointer;

  function GetCRC32(aStream: TStream): Cardinal;
  var
    LBytesRead: Integer;
    LBuffer: array of Byte;
  begin
    Result := crc32(0, nil, 0);
    repeat
      LBytesRead := AStream.Read(GetTempStaticBuffer()^, GetTempStaticBufferSize());
      Result := crc32(Result, PBytef(GetTempStaticBuffer()), LBytesRead);
    until LBytesRead = 0;

    LBuffer := nil;
  end;

begin
  Result := False;

  // check if directory exists
  if not TDirectory.Exists(ADirectory) then Exit;

  // init variabls
  FillChar(LZipFileInfo, SizeOf(LZipFileInfo), 0);

  // scan folder and build file list
  LFileList := TDirectory.GetFiles(ADirectory, '*',
    TSearchOption.soAllDirectories);

  LArchive := PAnsiChar(AnsiString(AArchive));
  LPassword := PAnsiChar(AnsiString(APassword));

  // create a zip file
  LZipFile := zipOpen64(LArchive, APPEND_STATUS_CREATE);

  // init handler
  LHandler := AHandler;
  LSender := ASender;

  if not Assigned(LHandler) then
    LHandler := sfZipFile_buildProgress;

  // process zip file
  if LZipFile <> nil then
  begin
    // loop through all files in list
    for LFilename in LFileList do
    begin
      // open file
      LFile := TFile.OpenRead(LFilename);

      // get file size
      LFileSize := LFile.Size;

      // get file crc
      LCrc := GetCRC32(LFile);

      // open new file in zip
      LFilename2 := PAnsiChar(AnsiString(LFilename));
      if ZipOpenNewFileInZip3_64(LZipFile, LFilename2, @LZipFileInfo, nil, 0,
        nil, 0, '',  Z_DEFLATED, 9, 0, 15, 9, Z_DEFAULT_STRATEGY,
        LPassword, LCrc, 1) = Z_OK then
      begin
        // make sure we start at star of stream
        LFile.Position := 0;

        LNewFile := True;

        // read through file
        repeat
          // read in a buffer length of file
          LBytesRead := LFile.Read(GetTempStaticBuffer()^, GetTempStaticBufferSize());

          // write buffer out to zip file
          zipWriteInFileInZip(LZipFile, GetTempStaticBuffer(), LBytesRead);

          // calc file progress percentage
          LProgress := 100.0 * (LFile.Position / LFileSize);

          // show progress
          if Assigned(LHandler) then
          begin
            LHandler(LSender, LFilename, Round(LProgress), LNewFile);
          end;

          LNewFile := False;

        until LBytesRead = 0;

        // close file in zip
        zipCloseFileInZip(LZipFile);

        // free file stream
        //FreeNilObject(LFile);
        LFile.Free();
      end;
    end;

    // close zip file
    zipClose(LZipFile, '');
  end;

  // return true if new zip file exits
  Result := TFile.Exists(LFilename);
end;

{ sfInputStream }
function sfInputStream_createEx(): PsfInputStreamEx;
begin
  New(Result);
end;

function sfInputStream_readEx(const AInputStream: PsfInputStreamEx; const AData: Pointer; const ASize: Int64): Int64;
begin
  Result := -1;
  if not Assigned(AInputStream) then Exit;
  if not Assigned(AInputStream.Base.read) then Exit;
  Result := AInputStream.Base.read(AData, ASize, AInputStream.Base.userData);
end;

function sfInputStream_seekEx(const AInputStream: PsfInputStreamEx; const APosition: Int64): Int64;
begin
  Result := -1;
  if not Assigned(AInputStream) then Exit;
  if not Assigned(AInputStream.Base.seek) then Exit;
  Result := AInputStream.Base.seek(APosition, AInputStream.Base.userData);
end;

function sfInputStream_tellEx(const AInputStream: PsfInputStreamEx): Int64;
begin
  Result := -1;
  if not Assigned(AInputStream) then Exit;
  if not Assigned(AInputStream.Base.tell) then Exit;
  Result := AInputStream.Base.tell(AInputStream.Base.userData);
end;

function sfInputStream_getSizeEx(const AInputStream: PsfInputStreamEx): Int64;
begin
  Result := -1;
  if not Assigned(AInputStream) then Exit;
  if not Assigned(AInputStream.Base.getSize) then Exit;
  Result := AInputStream.Base.getSize(AInputStream.Base.userData);
end;

function sfInputStream_eofEx(const AInputStream: PsfInputStreamEx): Boolean;
begin
  Result := False;
  if not Assigned(AInputStream) then Exit;
  if not Assigned(AInputStream.Base.tell) then Exit;
  Result := Boolean(AInputStream.Base.tell(AInputStream.Base.userData) >= AInputStream.Base.getSize(AInputStream.Base.userData));
end;

function sfInputStream_closeEx(var AInputStream: PsfInputStreamEx): Boolean;
begin
  Result := False;
  if not Assigned(AInputStream) then Exit;
  if not Assigned(AInputStream.close) then Exit;
  AInputStream.close(AInputStream.Base.userData);
  Dispose(AInputStream);
  AInputStream := nil;
end;

{ sfInputStream_createFromFile }
function File_ReadInputStream(data: Pointer; size: UInt64; userData: Pointer): Int64; cdecl;
var
  LFile: TFileStream;
begin
  LFile := userData;
  Result := LFile.Read(data^, size);
end;

function File_SeekInputStream(position: UInt64; userData: Pointer): Int64; cdecl;
var
  LFile: TFileStream;
begin
  LFile := userData;
  Result := LFile.Seek(position, soBeginning);
end;

function File_TellInputStream(userData: Pointer): Int64; cdecl;
var
  LFile: TFileStream;
begin
  LFile := userData;
  Result := LFile.Position;
end;

function File_GetSizeInputStream(userData: Pointer): Int64; cdecl;
var
  LFile: TFileStream;
begin
  LFile := userData;
  Result := LFile.Size;
end;

function File_CloseInputStream(userData: Pointer): Boolean; cdecl;
var
  LFile: TFileStream;
begin
  Result := False;
  LFile := userData;
  if not Assigned(LFile) then Exit;
  LFile.Free();
  Result := True;
end;

function sfInputStream_createFromFileEx(const AFilename: string): PsfInputStreamEx;
var
  LFile: TFileStream;
begin
  Result := nil;
  if not TFile.Exists(AFilename) then Exit;

  LFile := TFile.OpenRead(AFilename);

  Result := sfInputStream_createEx;
  Result.Base.read := File_ReadInputStream;
  Result.Base.seek := File_SeekInputStream;
  Result.Base.tell := File_TellInputStream;
  Result.Base.getSize := File_GetSizeInputStream;
  Result.Base.userData := LFile;
  Result.close := File_CloseInputStream;
end;

{ sfInputStream_createFromMemory }
type
  TStaticMemoryStream = class(TCustomMemoryStream)
  public
    constructor Create(const ABuffer: Pointer; const ASize: NativeInt);
  end;

constructor TStaticMemoryStream.Create(const ABuffer: Pointer; const ASize: NativeInt);
begin
  inherited Create;
  SetPointer(ABuffer, ASize);
end;

function Memory_ReadInputStream(data: Pointer; size: UInt64; userData: Pointer): Int64; cdecl;
var
  LMem: TStaticMemoryStream;
begin
  LMem := userData;
  Result := LMem.Read(data^, size);
end;

function Memory_SeekInputStream(position: UInt64; userData: Pointer): Int64; cdecl;
var
  LMem: TStaticMemoryStream;
begin
  LMem := userData;
  Result := LMem.Seek(position, soBeginning);
end;

function Memory_TellInputStream(userData: Pointer): Int64; cdecl;
var
  LMem: TStaticMemoryStream;
begin
  LMem := userData;
  Result := LMem.Position;
end;

function Memory_GetSizeInputStream(userData: Pointer): Int64; cdecl;
var
  LMem: TStaticMemoryStream;
begin
  LMem := userData;
  Result := LMem.Size;
end;

function Memory_CloseInputStream(userData: Pointer): Boolean; cdecl;
var
  LMem: TStaticMemoryStream;
begin
  Result := False;
  LMem := userData;
  if not Assigned(LMem) then Exit;
  LMem.Free();
  Result := True;
end;

function sfInputStream_createFromMemoryEx(const ABuffer: Pointer; const ASize: Int64): PsfInputStreamEx;
var
  LMem: TStaticMemoryStream;
begin
  Result := nil;
  if not Assigned(ABuffer) then Exit;

  LMem := TStaticMemoryStream.Create(ABuffer, ASize);

  Result := sfInputStream_createEx;
  Result.Base.read := Memory_ReadInputStream;
  Result.Base.seek := Memory_SeekInputStream;
  Result.Base.tell := Memory_TellInputStream;
  Result.Base.getSize := Memory_GetSizeInputStream;
  Result.Base.userData := LMem;
  Result.close := Memory_CloseInputStream;
end;

{ sfInputStream_createFromZipFile }
type
  { TsfZipFile }
  PsfZipFile = ^TsfZipFile;
  TsfZipFile = record
    ZipFile: unzFile;
    Password: AnsiString;
    Filename: AnsiString;
  end;

function ZipFile_ReadInputStream(data: Pointer; size: UInt64; userData: Pointer): Int64; cdecl;
var
  LZipFile: PsfZipFile;
begin
  LZipFile := userData;
  Result := unzReadCurrentFile(LZipFile.ZipFile, data, size);
end;

function ZipFile_SeekInputStream(position: UInt64; userData: Pointer): Int64; cdecl;
var
  LZipFile: PsfZipFile;
  LBytesToRead: Int64;
begin
  LZipFile := userData;
  unzCloseCurrentFile(LZipFile.ZipFile);
  unzLocateFile(LZipFile.ZipFile, PAnsiChar(LZipFile.Filename), 0);
  unzOpenCurrentFilePassword(LZipFile.ZipFile, PAnsiChar(LZipFile.Password));

  LBytesToRead := UInt64(position) - unztell64(LZipFile.ZipFile);
  while LBytesToRead > 0 do
  begin
    if LBytesToRead > GetTempStaticBufferSize() then
      unzReadCurrentFile(LZipFile.ZipFile, GetTempStaticBuffer(), GetTempStaticBufferSize())
    else
      unzReadCurrentFile(LZipFile.ZipFile, GetTempStaticBuffer(), LBytesToRead);

    LBytesToRead := UInt64(position) - unztell64(LZipFile.ZipFile);
  end;

  Result := unztell64(LZipFile.ZipFile);
end;

function ZipFile_TellInputStream(userData: Pointer): Int64; cdecl;
var
  LZipFile: PsfZipFile;
begin
  LZipFile := userData;
  Result := unztell64(LZipFile.ZipFile);
end;

function ZipFile_GetSizeInputStream(userData: Pointer): Int64; cdecl;
var
  LZipFile: PsfZipFile;
  LInfo: unz_file_info64;
begin
  LZipFile := userData;
  unzGetCurrentFileInfo64(LZipFile.ZipFile, @LInfo, nil, 0, nil, 0, nil, 0);
  Result := LInfo.uncompressed_size;
end;

function ZipFile_CloseInputStream(userData: Pointer): Boolean; cdecl;
var
  LZipFile: PsfZipFile;
begin
  Result := False;
  if not Assigned(userData) then Exit;

  LZipFile := userData;

  Assert(unzCloseCurrentFile(LZipFile.ZipFile) = UNZ_OK);
  Assert(unzClose(LZipFile.ZipFile) = UNZ_OK);

  Dispose(LZipFile);

  Result := True;
end;

function sfInputStream_createFromZipFileEx(const AZipFilename, AFilename: string; const APassword: string): PsfInputStreamEx;
var
  LPassword: PAnsiChar;
  LZipFilename: PAnsiChar;
  LFilename: PAnsiChar;
  LFile: unzFile;
  LZipFile: PsfZipFile;
begin
  Result := nil;

  LPassword := PAnsiChar(AnsiString(APassword));
  LZipFilename := PAnsiChar(AnsiString(StringReplace(AZipFilename, '/', '\', [rfReplaceAll])));
  LFilename := PAnsiChar(AnsiString(StringReplace(AFilename, '/', '\', [rfReplaceAll])));

  LFile := unzOpen64(LZipFilename);
  if not Assigned(LFile) then Exit;

  if unzLocateFile(LFile, LFilename, 0) <> UNZ_OK then
  begin
    unzClose(LFile);
    Exit;
  end;

  if unzOpenCurrentFilePassword(LFile, LPassword) <> UNZ_OK then
  begin
    unzClose(LFile);
    Exit;
  end;

  New(LZipFile);
  LZipFile.ZipFile := LFile;
  LZipFile.Password := AnsiString(APassword);
  LZipFile.Filename := AnsiString(AFilename);

  Result := sfInputStream_createEx;
  Result.Base.read := ZipFile_ReadInputStream;
  Result.Base.seek := ZipFile_SeekInputStream;
  Result.Base.tell := ZipFile_TellInputStream;
  Result.Base.getSize := ZipFile_GetSizeInputStream;
  Result.Base.userData := LZipFile;
  Result.close := ZipFile_CloseInputStream;

end;

function  sfRenderWindow_createEx(ATitle: string; const AWidth: Cardinal; const AHeight: Cardinal; const AStyle: Uint32): PsfRenderWindowEx;
begin
  New(Result);

  Result.Mode.size.x := AWidth;
  Result.Mode.size.y := AHeight;
  Result.Mode.BitsPerPixel := 32;

  Result.Settings := Default(sfContextSettings);

  FillChar(Result.settings, SizeOf(Result.settings), 0);
  Result.settings.depthBits := 24;
  Result.settings.stencilBits := 8;
  Result.settings.antialiasingLevel := 8; // Set anti-aliasing level
  Result.Settings.majorVersion := 2;
  Result.Settings.minorVersion := 1;

  Result.Handle := sfRenderWindow_create(Result.Mode, AsUTF8(ATitle, []), AStyle, sfWindowed, @Result.Settings);
  if not Assigned(Result.Handle) then
  begin
    Dispose(Result);
    Exit;
  end;

  sfRenderWindow_setDefaultIconEx(Result);

  if not sfRenderWindow_scaleToDPIEx(Result, AWidth, AHeight, True, 96) then
  begin
    sfRenderWindow_destroyEx(Result);
    Exit;
  end;
  sfRenderWindow_setFramerateLimitEx(Result, 60);
  sfRenderWindow_setVerticalSyncEnabledEx(Result, True);

  Result.View := sfView_createLetterBox(AWidth, AHeight);

  sfRenderWindow_setViewEx(Result, Result.View);

  Result.Size.x := AWidth;
  Result.Size.y := AHeight;

  //Result.Timing := Default(TsfTiming);
  Result.Timing.DeltaTime := 0;
  Result.Timing.FrameCount := 0;
  Result.Timing.FrameRate := 0;
  Result.Timing.Clock := sfClock_create;

  Result.ClearRectangle := sfRectangleShape_create();
  sfRectangleShape_setPosition(Result.ClearRectangle, sfVector2f_create(0, 0));
  sfRectangleShape_setSize(Result.ClearRectangle, sfVector2f_create(AWidth, AHeight));
  sfRectangleShape_setFillColor(Result.ClearRectangle, WHITE);

end;

procedure sfRenderWindow_destroyEx(var AWindow: PsfRenderWindowEx);
begin
  //sfVideo_destroy;
  sfRectangleShape_destroy(AWindow.ClearRectangle);
  sfClock_destroy(AWindow.Timing.Clock);
  sfView_destroy(AWindow.View);
  sfRenderWindow_destroy(AWindow.Handle);
  Dispose(AWindow);
  AWindow := nil;
end;

procedure sfRenderWindow_toggleFullscreenEx(const AWindow: PsfRenderWindowEx);
var
  LWnd: HWND;
begin
  if not Assigned(AWindow) then Exit;
  if not Assigned(AWindow.Handle) then Exit;

  LWnd := HWND(sfRenderWindow_getSystemHandleEx(AWindow));

  AWindow.Fullscreen := not AWindow.Fullscreen;

  if AWindow.Fullscreen then
    begin
      BringWindowToTop(LWnd);
      SetForegroundWindow(LWnd);
      SetActiveWindow(LWnd);
      SetWindowPos(LWnd, HWND_TOP, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_SHOWWINDOW);
      sfRenderWindow_toggleBordersEx(AWindow, False);
      sfRenderWindow_maximizeEx(AWindow);
    end
  else
    begin
      sfRenderWindow_toggleBordersEx(AWindow, True);
      sfRenderWindow_restoreEx(AWindow);
      SetWindowPos(LWnd, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE);
    end;
end;

procedure sfRenderWindow_toggleBordersEx(const AWindow: PsfRenderWindowEx; const AShow: Boolean);
var
  LStyle: LongInt;
  LWnd: HWND;
begin
  if not Assigned(AWindow) then Exit;
  if not Assigned(AWindow.Handle) then Exit;

  LWnd := HWND(sfRenderWindow_getSystemHandleEx(AWindow));

  LStyle := GetWindowLong(LWnd, GWL_STYLE);
  if AShow then
    LStyle := LStyle or (WS_CAPTION or WS_THICKFRAME or WS_BORDER)  // Show title bar and borders
  else
    LStyle := LStyle and not (WS_CAPTION or WS_THICKFRAME or WS_BORDER);  // Hide title bar and borders

  SetWindowLong(LWnd, GWL_STYLE, LStyle);

  // Update window to apply the changes
  SetWindowPos(LWnd, 0, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER or SWP_FRAMECHANGED);
end;

function sfRenderWindow_areBordersVisibleEx(const AWindow: PsfRenderWindowEx): Boolean;
var
  LStyle: LongInt;
  LWnd: HWND;
begin
  Result := False;
  if not Assigned(AWindow) then Exit;
  if not Assigned(AWindow.Handle) then Exit;

  LWnd := HWND(sfRenderWindow_getSystemHandleEx(AWindow));
  LStyle := GetWindowLong(LWnd, GWL_STYLE);
  Result := (LStyle and (WS_BORDER or WS_THICKFRAME)) <> 0;
end;

procedure sfRenderWindow_minimizeEx(const AWindow: PsfRenderWindowEx);
var
  LWnd: HWND;
begin
  if not Assigned(AWindow) then Exit;
  if not Assigned(AWindow.Handle) then Exit;

  LWnd := HWND(sfRenderWindow_getSystemHandleEx(AWindow));
  ShowWindow(LWnd, SW_MINIMIZE);
end;

function sfRenderWindow_isMinimizedEx(const AWindow: PsfRenderWindowEx): Boolean;
var
  LWnd: HWND;
begin
  Result := False;
  if not Assigned(AWindow) then Exit;
  if not Assigned(AWindow.Handle) then Exit;

  LWnd := HWND(sfRenderWindow_getSystemHandleEx(AWindow));
  Result := IsIconic(LWnd);
end;

procedure sfRenderWindow_maximizeEx(const AWindow: PsfRenderWindowEx);
var
  LWnd: HWND;
begin
  if not Assigned(AWindow) then Exit;
  if not Assigned(AWindow.Handle) then Exit;

  LWnd := HWND(sfRenderWindow_getSystemHandleEx(AWindow));
  ShowWindow(LWnd, SW_MAXIMIZE);
end;

function sfRenderWindow_isMaximizedEx(const AWindow: PsfRenderWindowEx): Boolean;
var
  LWnd: HWND;
begin
  Result := False;
  if not Assigned(AWindow) then Exit;
  if not Assigned(AWindow.Handle) then Exit;

  LWnd := HWND(sfRenderWindow_getSystemHandleEx(AWindow));
  Result := IsZoomed(LWnd);
end;

procedure sfRenderWindow_restoreEx(const AWindow: PsfRenderWindowEx);
var
  LWnd: HWND;
begin
  if not Assigned(AWindow) then Exit;
  if not Assigned(AWindow.Handle) then Exit;

  LWnd := HWND(sfRenderWindow_getSystemHandleEx(AWindow));
  ShowWindow(LWnd, SW_RESTORE);
end;

function sfRenderWindow_isRestoredEx(const AWindow: PsfRenderWindowEx): Boolean;
var
  LWnd: HWND;
begin
  Result := False;
  if not Assigned(AWindow) then Exit;
  if not Assigned(AWindow.Handle) then Exit;

  LWnd := HWND(sfRenderWindow_getSystemHandleEx(AWindow));
  Result := not IsIconic(LWnd) and not IsZoomed(LWnd);
end;

procedure sfRenderWindow_setFramerateLimitEx(const AWindow: PsfRenderWindowEx; limit: Cardinal);
begin
  if not Assigned(AWindow) then Exit;
  if not Assigned(AWindow.Handle) then Exit;

  sfRenderWindow_setFramerateLimit(AWindow.Handle, limit);
  AWindow.Timing.Limit := limit;
end;

procedure sfRenderWindow_startFrameEx(const AWindow: PsfRenderWindowEx);
var
  LMousePos: sfVector2i;
  LWorldMousePos: sfVector2f;
begin
  if not Assigned(AWindow) then Exit;
  if not Assigned(AWindow.Handle) then Exit;
  if not Assigned(AWindow.View) then Exit;

  sfRenderWindow_setViewEx(AWindow, AWindow.View);
  sfRenderWindow_drawRectangleShapeEx(AWindow, AWindow.ClearRectangle, nil);

  LMousePos := sfMouse_getPositionRenderWindow(AWindow.Handle);

  LWorldMousePos := sfRenderWindow_mapPixelToCoordsEx(AWindow, LMousePos, AWindow.View);

  LWorldMousePos.x := EnsureRange(LWorldMousePos.x, 0, AWindow.Size.x-1);
  LWorldMousePos.y := EnsureRange(LWorldMousePos.y, 0, AWindow.Size.y-1);

  AWindow.MousePos.x := Round(LWorldMousePos.x);
  AWindow.MousePos.y := Round(LWorldMousePos.y);
end;

function  sfRenderWindow_getFrameMousePosEx(const AWindow: PsfRenderWindowEx): sfVector2u;
begin
  Result := sfVector2u_create(0,0);
  if not Assigned(AWindow) then Exit;
  Result := AWindow.MousePos;
end;

procedure sfRenderWindow_clearFrameEx(const AWindow: PsfRenderWindowEx; const AColor: sfColor);
begin
  if not Assigned(AWindow) then Exit;
  if not Assigned(AWindow.Handle) then Exit;
  if not Assigned(AWindow.ClearRectangle) then Exit;

  sfRectangleShape_setFillColor(AWindow.ClearRectangle, AColor);
end;

procedure sfRenderWindow_resizeFrameEx(const AWindow: PsfRenderWindowEx; const AWidth, AHeight: Cardinal);
begin
  if not Assigned(AWindow) then Exit;
  if not Assigned(AWindow.Handle) then Exit;
  if not Assigned(AWindow.View) then Exit;

  sfView_setLetterBox(AWindow.View, AWidth, AHeight);
end;

procedure sfRenderWindow_endFrameEx(const AWindow: PsfRenderWindowEx);
begin
  if not Assigned(AWindow) then Exit;
  if not Assigned(AWindow.Handle) then Exit;
  if not Assigned(AWindow.ClearRectangle) then Exit;
  sfRenderWindow_setViewEx(AWindow, sfRenderWindow_getDefaultViewEx(AWindow));
end;

procedure sfRenderWindow_displayEx(const AWindow: PsfRenderWindowEx);
var
  LCurrentTime: sfTime;
  LDeltaTime: Single;
begin
  if not Assigned(AWindow) then Exit;
  if not Assigned(AWindow.Handle) then Exit;

  sfRenderWindow_scaleOnDPIChangeEx(AWindow);

  sfRenderWindow_display(AWindow.Handle);

  if Assigned(AWindow.Timing.Clock) then
  begin
    Inc(AWindow.Timing.FrameCount);

    // Get the current elapsed time
    LCurrentTime := sfClock_getElapsedTime(AWindow.Timing.Clock);

    // Calculate delta time
    LDeltaTime := sfTime_asSeconds(LCurrentTime) - sfTime_asSeconds(AWindow.Timing.PreviousTime);

    // Store delta time
    AWindow.Timing.DeltaTime := LDeltaTime;

    // Update previous time for the next frame
    AWindow.Timing.PreviousTime := LCurrentTime;

    // Calculate frame rate if a second has elapsed
    AWindow.Timing.ElapsedTime := LCurrentTime;
    if sfTime_asMilliseconds(AWindow.Timing.ElapsedTime) >= 1000 then
    begin
      AWindow.Timing.FrameRate := AWindow.Timing.FrameCount / (sfTime_asMilliseconds(AWindow.Timing.ElapsedTime) / 1000);
      AWindow.Timing.FrameCount := 0;
      sfClock_restart(AWindow.Timing.Clock);
      AWindow.Timing.PreviousTime := sfTime_Zero; // Reset previous time after restart
    end;
  end;
end;

function   sfRenderWindow_getFrameRateEx(const AWindow: PsfRenderWindowEx): Cardinal;
begin
  Result := Round(AWindow.Timing.FrameRate);
end;

procedure sfRenderWindow_resetTimingEx(const AWindow: PsfRenderWindowEx);
begin
  AWindow.Timing.FrameRate := 0;
  AWindow.Timing.FrameCount := 0;
  sfClock_restart(AWindow.Timing.Clock);
end;

procedure sfRenderWindow_setTitleEx(const AWindow: PsfRenderWindowEx; const title: string);
begin
  if not Assigned(AWindow) then Exit;
  if not Assigned(AWindow.Handle) then Exit;
  sfRenderWindow_setTitle(AWindow.Handle, AsUTF8(title, []));
end;

function  sfRenderWindow_createUnicodeEx(mode: sfVideoMode; const title: PUint32; style: Uint32; const settings: PsfContextSettings): PsfRenderWindowEx;
begin
  Result := sfRenderWindow_createUnicode(mode, PsfChar32(title), style, sfWindowed, settings);
end;

function  sfRenderWindow_createFromHandleEx(handle: sfWindowHandle; const settings: PsfContextSettings): PsfRenderWindowEx;
begin
  Result := sfRenderWindow_createFromHandle(handle, settings);
end;

procedure sfRenderWindow_closeEx(renderWindow: PsfRenderWindowEx);
begin
  sfRenderWindow_close(renderWindow.Handle);
end;

function  sfRenderWindow_isOpenEx(const renderWindow: PsfRenderWindowEx): Boolean;
begin
  Result := sfRenderWindow_isOpen(renderWindow.Handle);
end;

function  sfRenderWindow_getSettingsEx(const renderWindow: PsfRenderWindowEx): sfContextSettings;
begin
  Result := sfRenderWindow_getSettings(renderWindow.Handle);
end;

function  sfRenderWindow_pollEventEx(renderWindow: PsfRenderWindowEx; event: PsfEvent): Boolean;
begin
  Result := sfRenderWindow_pollEvent(renderWindow.Handle, event);
end;

function  sfRenderWindow_waitEventEx(renderWindow: PsfRenderWindowEx; timeout: sfTime; event: PsfEvent): Boolean;
begin
  Result := sfRenderWindow_waitEvent(renderWindow.Handle, timeout, event);
end;

function  sfRenderWindow_getPositionEx(const renderWindow: PsfRenderWindowEx): sfVector2i;
begin
  Result := sfRenderWindow_getPosition(renderWindow.Handle);
end;

procedure sfRenderWindow_setPositionEx(renderWindow: PsfRenderWindowEx; position: sfVector2i);
begin
  sfRenderWindow_setPosition(renderWindow.Handle, position);
end;

function  sfRenderWindow_getSizeEx(const renderWindow: PsfRenderWindowEx): sfVector2u;
begin
  Result := sfRenderWindow_getSize(renderWindow.Handle);
end;

function  sfRenderWindow_isSrgbEx(const renderWindow: PsfRenderWindowEx): Boolean;
begin
  Result := sfRenderWindow_isSrgb(renderWindow.Handle);
end;

procedure sfRenderWindow_setSizeEx(renderWindow: PsfRenderWindowEx; size: sfVector2u);
begin
  sfRenderWindow_setSize(renderWindow.Handle, size);
end;

procedure sfRenderWindow_setUnicodeTitleEx(renderWindow: PsfRenderWindowEx; const title: string);
begin
  sfRenderWindow_setUnicodeTitle(renderWindow.Handle, PsfChar32(title));
end;

procedure sfRenderWindow_setIconEx(renderWindow: PsfRenderWindowEx; width: Cardinal; height: Cardinal; const pixels: PUint8);
var
  LSize: sfVector2u;
begin
  LSize.x := width;
  LSize.y := height;
  sfRenderWindow_setIcon(renderWindow.Handle, LSize, pixels);
end;

procedure sfRenderWindow_setVisibleEx(renderWindow: PsfRenderWindowEx; visible: Boolean);
begin
  sfRenderWindow_setVisible(renderWindow.Handle, visible);
end;

procedure sfRenderWindow_setVerticalSyncEnabledEx(renderWindow: PsfRenderWindowEx; enabled: Boolean);
begin
  sfRenderWindow_setVerticalSyncEnabled(renderWindow.Handle, enabled);
end;

procedure sfRenderWindow_setMouseCursorVisibleEx(renderWindow: PsfRenderWindowEx; show: Boolean);
begin
  sfRenderWindow_setMouseCursorVisible(renderWindow.Handle, show);
end;

procedure sfRenderWindow_setMouseCursorGrabbedEx(renderWindow: PsfRenderWindowEx; grabbed: Boolean);
begin
  sfRenderWindow_setMouseCursorGrabbed(renderWindow.Handle, grabbed);
end;

procedure sfRenderWindow_setMouseCursorEx(window: PsfRenderWindowEx; const cursor: PsfCursor);
begin
  sfRenderWindow_setMouseCursor(window.Handle, cursor);
end;

procedure sfRenderWindow_setKeyRepeatEnabledEx(renderWindow: PsfRenderWindowEx; enabled: Boolean);
begin
 sfRenderWindow_setKeyRepeatEnabled(renderWindow.Handle, enabled);
end;

procedure sfRenderWindow_setJoystickThresholdEx(renderWindow: PsfRenderWindowEx; threshold: Single);
begin
  sfRenderWindow_setJoystickThreshold(renderWindow.Handle, threshold);
end;

function  sfRenderWindow_setActiveEx(renderWindow: PsfRenderWindowEx; active: Boolean): Boolean;
begin
  Result := sfRenderWindow_setActive(renderWindow.Handle, active);
end;

procedure sfRenderWindow_requestFocusEx(renderWindow: PsfRenderWindowEx);
begin
  sfRenderWindow_requestFocus(renderWindow.Handle);
end;

function  sfRenderWindow_hasFocusEx(const renderWindow: PsfRenderWindowEx): Boolean;
begin
  Result := sfRenderWindow_hasFocus(renderWindow.Handle);
end;

function  sfRenderWindow_getSystemHandleEx(const renderWindow: PsfRenderWindowEx): sfWindowHandle;
begin
  Result := sfRenderWindow_getNativeHandle(renderWindow.Handle);
end;

procedure sfRenderWindow_clearEx(renderWindow: PsfRenderWindowEx; color: sfColor);
begin
  sfRenderWindow_clear(renderWindow.Handle, color);
end;

procedure sfRenderWindow_setViewEx(renderWindow: PsfRenderWindowEx; const view: PsfView);
begin
  sfRenderWindow_setView(renderWindow.Handle, view);
end;

function  sfRenderWindow_getViewEx(const renderWindow: PsfRenderWindowEx): PsfView;
begin
  Result := sfRenderWindow_getView(renderWindow.Handle);
end;

function  sfRenderWindow_getDefaultViewEx(const renderWindow: PsfRenderWindowEx): PsfView;
begin
  Result := sfRenderWindow_getDefaultView(renderWindow.Handle);
end;

function  sfRenderWindow_getViewportEx(const renderWindow: PsfRenderWindowEx; const view: PsfView): sfIntRect;
begin
  Result := sfRenderWindow_getViewport(renderWindow.Handle, view);
end;

function  sfRenderWindow_mapPixelToCoordsEx(const renderWindow: PsfRenderWindowEx; point: sfVector2i; const view: PsfView): sfVector2f;
begin
  Result := sfRenderWindow_mapPixelToCoords(renderWindow.Handle, point, view);
end;

function  sfRenderWindow_mapCoordsToPixelEx(const renderWindow: PsfRenderWindowEx; point: sfVector2f; const view: PsfView): sfVector2i;
begin
  Result := sfRenderWindow_mapCoordsToPixel(renderWindow.Handle, point, view);
end;

procedure sfRenderWindow_drawSpriteEx(renderWindow: PsfRenderWindowEx; const &object: PsfSprite; const states: PsfRenderStates);
begin
  sfRenderWindow_drawSprite(renderWindow.Handle, &object, states);
end;

procedure sfRenderWindow_drawShapeEx(renderWindow: PsfRenderWindowEx; const &object: PsfShape; const states: PsfRenderStates);
begin
  sfRenderWindow_drawShape(renderWindow.Handle, &object, states);
end;

procedure sfRenderWindow_drawCircleShapeEx(renderWindow: PsfRenderWindowEx; const &object: PsfCircleShape; const states: PsfRenderStates);
begin
  sfRenderWindow_drawCircleShape(renderWindow.Handle, &object, states);
end;

procedure sfRenderWindow_drawConvexShapeEx(renderWindow: PsfRenderWindowEx; const &object: PsfConvexShape; const states: PsfRenderStates);
begin
  sfRenderWindow_drawConvexShape(renderWindow.Handle, &object, states);
end;

procedure sfRenderWindow_drawRectangleShapeEx(renderWindow: PsfRenderWindowEx; const &object: PsfRectangleShape; const states: PsfRenderStates);
begin
  sfRenderWindow_drawRectangleShape(renderWindow.Handle, &object, states);
end;

procedure sfRenderWindow_drawVertexArrayEx(renderWindow: PsfRenderWindowEx; const &object: PsfVertexArray; const states: PsfRenderStates);
begin
  sfRenderWindow_drawVertexArray(renderWindow.Handle, &object, states);
end;

procedure sfRenderWindow_drawVertexBufferEx(renderWindow: PsfRenderWindowEx; const &object: PsfVertexBuffer; const states: PsfRenderStates);
begin
  sfRenderWindow_drawVertexBuffer(renderWindow.Handle, &object, states);
end;

procedure sfRenderWindow_drawVertexBufferRangeEx(renderWindow: PsfRenderWindowEx; const &object: PsfVertexBuffer; firstVertex: NativeUInt; vertexCount: NativeUInt; const states: PsfRenderStates);
begin
  sfRenderWindow_drawVertexBufferRange(renderWindow.Handle, &object, firstVertex, vertexCount, states);
end;

procedure sfRenderWindow_drawPrimitivesEx(renderWindow: PsfRenderWindowEx; const vertices: PsfVertex; vertexCount: NativeUInt; &type: sfPrimitiveType; const states: PsfRenderStates);
begin
  sfRenderWindow_drawPrimitives(renderWindow.Handle, vertices, vertexCount, &type, states);
end;

procedure sfRenderWindow_pushGLStatesEx(renderWindow: PsfRenderWindowEx);
begin
  sfRenderWindow_pushGLStates(renderWindow.Handle);
end;

procedure sfRenderWindow_popGLStatesEx(renderWindow: PsfRenderWindowEx);
begin
  sfRenderWindow_popGLStates(renderWindow.Handle);
end;

procedure sfRenderWindow_resetGLStatesEx(renderWindow: PsfRenderWindowEx);
begin
  sfRenderWindow_resetGLStates(renderWindow.Handle);
end;

function  sfRenderWindow_captureEx(const renderWindow: PsfRenderWindowEx): PsfImage;
var
  LSize: sfVector2u;
  LTexture: PsfTexture;
  LOffset: sfVector2u;
begin
  Result := nil;
  if not Assigned(renderWindow) then Exit;

  LSize := sfRenderWindow_getSizeEx(renderWindow);
  LTexture := sfTexture_create(LSize);
  if not Assigned(LTexture)  then Exit;

  LOffset.x := 0;
  LOffset.y := 0;
  sfTexture_updateFromWindow(LTexture, renderWindow, LOffset);
  Result := sfTexture_copyToImage(LTexture);
  sfTexture_destroy(LTexture);
end;

function sfRenderWindow_getDPIEx(const AWindow: PsfRenderWindowEx): Cardinal;
begin
  Result := 0;
  if not Assigned(AWindow) then Exit;
  if not Assigned(AWindow.Handle) then Exit;
  Result := GetDpiForWindow(HWND(sfRenderWindow_getSystemHandleEx(AWindow)));
end;

function sfRenderWindow_scaleToDPIEx(const AWindow: PsfRenderWindowEx; const ABaseWidth, ABaseHeight: Cardinal; const ACenter: Boolean; const ADefaultDPI: Integer=96): Boolean;
var
  LDpi: UINT;
  LSize: sfVector2u;
  LScaleSize: sfVector2u;
  LPos: sfVector2i;
  LScreenSize: sfVector2i;
begin
  Result := False;
  if not Assigned(AWindow) then Exit;
  if not Assigned(AWindow.Handle) then Exit;

  // get window DPI
  LDpi := GetDpiForWindow(HWND(sfRenderWindow_getSystemHandleEx(AWindow)));

  // get window size
  LSize.x := ABaseWidth;
  LSize.y := ABaseHeight;

  // get scaled widow size
  LScaleSize.x := MulDiv(LSize.x, LDPI, ADefaultDPI);
  LScaleSize.y := MulDiv(LSize.y, LDpi, ADefaultDPI);

  if ACenter then
  begin
    // get center window position
    LScreenSize := GetScreenWorkAreaSize;

    LPos.x := (Cardinal(LScreenSize.X) - LScaleSize.x) div 2;
    LPos.y := (Cardinal(LScreenSize.Y) - LScaleSize.y) div 2;

    // set new postion
    sfRenderWindow_setPositionEx(AWindow, LPos);

    AWindow.Size.x := ABaseWidth;
    AWindow.Size.y := ABaseHeight;

    AWindow.ScaleSize.x := LScaleSize.x;
    AWindow.ScaleSize.y := LScaleSize.y;
  end;

  // set new scale
  sfRenderWindow_setSizeEx(AWindow, LScaleSize);

  // update scale & DPI
  AWindow.Scale := LDpi / ADefaultDPI;
  AWindow.Dpi := LDpi;

  Result := True;
end;

procedure sfRenderWindow_scaleOnDPIChangeEx(const AWindow: PsfRenderWindowEx);
begin
  if sfRenderWindow_getDPIEx(AWindow) <> AWindow.Dpi then
  begin
    sfRenderWindow_scaleToDPIEx(AWindow, Round(AWindow.Size.x), Round(AWindow.Size.y), False, 96);
  end;
end;

procedure sfRenderWindow_setDefaultIconEx(const AWindow: PsfRenderWindowEx);
var
  IconHandle: HICON;
begin
  if not Assigned(AWindow) then Exit;
  if not Assigned(AWindow.Handle) then Exit;

  IconHandle := LoadIcon(HInstance, 'MAINICON');
  if IconHandle <> 0 then
  begin
    SendMessage(HWND(sfRenderWindow_getSystemHandleEx(AWindow)), WM_SETICON, ICON_BIG, IconHandle);
  end;
end;

procedure sfRenderWindow_drawLineEx(const AWindow: PsfRenderWindowEx; const X1, Y1, X2, Y2: Single; const AColor: sfColor; const AThickness: Single);
var
  length, angle: Single;
  rectangle: PsfRectangleShape;
begin
  if not Assigned(AWindow) then Exit;
  if not Assigned(AWindow.Handle) then Exit;

  length := Sqrt(Sqr(X2 - X1) + Sqr(Y2 - Y1));
  angle := ArcTan2(Y2 - Y1, X2 - X1) * (180 / Pi);

  rectangle := sfRectangleShape_create();
  try
    sfRectangleShape_setPosition(rectangle, sfVector2f_create(X1, Y1));
    sfRectangleShape_setSize(rectangle, sfVector2f_create(length, AThickness));
    sfRectangleShape_setFillColor(rectangle, AColor);
    sfRectangleShape_setRotation(rectangle, angle);

    sfRenderWindow_drawRectangleShapeEx(AWindow, rectangle, nil);
  finally
    sfRectangleShape_destroy(rectangle);
  end;
end;

procedure sfRenderWindow_drawRectEx(const AWindow: PsfRenderWindowEx; const X, Y, AWidth, AHeight, AThickness: Single; const AColor: sfColor);
var
  top, bottom, left, right: PsfRectangleShape;
begin
  if not Assigned(AWindow) then Exit;
  if not Assigned(AWindow.Handle) then Exit;

  // Top
  top := sfRectangleShape_create();
  sfRectangleShape_setPosition(top, sfVector2f_create(X, Y));
  sfRectangleShape_setSize(top, sfVector2f_create(AWidth, AThickness));
  sfRectangleShape_setFillColor(top, AColor);
  sfRenderWindow_drawRectangleShapeEx(AWindow, top, nil);
  sfRectangleShape_destroy(top);

  // Bottom
  bottom := sfRectangleShape_create();
  sfRectangleShape_setPosition(bottom, sfVector2f_create(X, Y + AHeight - AThickness));
  sfRectangleShape_setSize(bottom, sfVector2f_create(AWidth, AThickness));
  sfRectangleShape_setFillColor(bottom, AColor);
  sfRenderWindow_drawRectangleShapeEx(AWindow, bottom, nil);
  sfRectangleShape_destroy(bottom);

  // Left
  left := sfRectangleShape_create();
  sfRectangleShape_setPosition(left, sfVector2f_create(X, Y + AThickness));
  sfRectangleShape_setSize(left, sfVector2f_create(AThickness, AHeight - 2 * AThickness));
  sfRectangleShape_setFillColor(left, AColor);
  sfRenderWindow_drawRectangleShapeEx(AWindow, left, nil);
  sfRectangleShape_destroy(left);

  // Right
  right := sfRectangleShape_create();
  sfRectangleShape_setPosition(right, sfVector2f_create(X + AWidth - AThickness, Y + AThickness));
  sfRectangleShape_setSize(right, sfVector2f_create(AThickness, AHeight - 2 * AThickness));
  sfRectangleShape_setFillColor(right, AColor);
  sfRenderWindow_drawRectangleShapeEx(AWindow, right, nil);
  sfRectangleShape_destroy(right);
end;

procedure sfRenderWindow_drawFilledRectEx(const ARenderWindow: PsfRenderWindowEx; const X, Y, AWidth, AHeight: Single; const AColor: sfColor);
var
  rectangle: PsfRectangleShape;
begin
  if not Assigned(ARenderWindow) then Exit;
  if not Assigned(ARenderWindow.Handle) then Exit;

  rectangle := sfRectangleShape_create();
  sfRectangleShape_setPosition(rectangle, sfVector2f_create(X, Y));
  sfRectangleShape_setSize(rectangle, sfVector2f_create(AWidth, AHeight));
  sfRectangleShape_setFillColor(rectangle, AColor);
  sfRenderWindow_drawRectangleShapeEx(ARenderWindow, rectangle, nil);
  sfRectangleShape_destroy(rectangle);
end;

procedure sfRenderWindow_drawTextEx(const AWindow: PsfRenderWindowEx; const AText: PsfText; const X, Y: Single; const AColor: sfColor; const AMsg: string; const AArgs: array of const);
var
  LText: string;
begin
  if not Assigned(AWindow) then Exit;
  if not Assigned(AWindow.Handle) then Exit;
  if not Assigned(AText) then Exit;

  LText := Format(AMsg, AArgs);
  sfText_setUnicodeStringEx(AText, LText);
  sfText_setFillColor(AText, AColor);
  sfText_setPosition(AText, sfVector2f_create(X, Y));
  sfRenderWindow_drawText(AWindow.Handle, AText, nil);
end;

procedure sfRenderWindow_drawTextVarYEx(const AWindow: PsfRenderWindowEx; const AText: PsfText; const X: Single; var Y: Single; const AColor: sfColor; const AMsg: WideString; const AArgs: array of const);
var
  LFont: PsfFont;
  LSize: Cardinal;
begin
  sfRenderWindow_drawTextEx(AWindow, AText, X, Y, AColor, AMsg, AArgs);

  LFont := sfText_GetFont(AText);
  LSize := sfText_GetCharacterSize(AText);

  Y := Y + sfFont_GetLineSpacing(LFont, LSize);
end;

procedure sfRenderWindow_drawCircleEx(const AWindow: PsfRenderWindowEx; const X, Y, ARadius, AThickness: Single; const AColor: sfColor);
var
  circle: PsfCircleShape;
begin
  if not Assigned(AWindow) then Exit;
  if not Assigned(AWindow.Handle) then Exit;

  circle := sfCircleShape_create();
  sfCircleShape_setPosition(circle, sfVector2f_create(X - ARadius, Y - ARadius));
  sfCircleShape_setRadius(circle, ARadius);
  sfCircleShape_setFillColor(circle, TRANSPARENT);
  sfCircleShape_setOutlineThickness(circle, AThickness);
  sfCircleShape_setOutlineColor(circle, AColor);
  sfRenderWindow_drawCircleShapeEx(AWindow, circle, nil);
  sfCircleShape_destroy(circle);
end;

procedure sfRenderWindow_drawFilledCircleEx(const AWindow: PsfRenderWindowEx; const X, Y, ARadius: Single; const AColor: sfColor);
var
  circle: PsfCircleShape;
begin
  if not Assigned(AWindow) then Exit;
  if not Assigned(AWindow.Handle) then Exit;

  circle := sfCircleShape_create();
  sfCircleShape_setPosition(circle, sfVector2f_create(X - ARadius, Y - ARadius));
  sfCircleShape_setRadius(circle, ARadius);
  sfCircleShape_setFillColor(circle, AColor);
  sfRenderWindow_drawCircleShapeEx(AWindow, circle, nil);
  sfCircleShape_destroy(circle);
end;

procedure sfRenderWindow_drawTriangleEx(const AWindow: PsfRenderWindowEx; const X1, Y1, X2, Y2, X3, Y3, AThickness: Single; const AColor, AOutlineColor: sfColor);
var
  triangle: PsfConvexShape;
begin
  if not Assigned(AWindow) then Exit;
  if not Assigned(AWindow.Handle) then Exit;

  triangle := sfConvexShape_create();
  sfConvexShape_setPointCount(triangle, 3);
  sfConvexShape_setPoint(triangle, 0, sfVector2f_create(X1, Y1));
  sfConvexShape_setPoint(triangle, 1, sfVector2f_create(X2, Y2));
  sfConvexShape_setPoint(triangle, 2, sfVector2f_create(X3, Y3));
  sfConvexShape_setFillColor(triangle, TRANSPARENT);
  sfConvexShape_setOutlineThickness(triangle, AThickness);
  sfConvexShape_setOutlineColor(triangle, AOutlineColor);
  sfRenderWindow_drawConvexShapeEx(AWindow, triangle, nil);
  sfConvexShape_destroy(triangle);
end;

procedure sfRenderWindow_drawFilledTriangleEx(const AWindow: PsfRenderWindowEx; const X1, Y1, X2, Y2, X3, Y3: Single; const AColor: sfColor);
var
  triangle: PsfConvexShape;
begin
  if not Assigned(AWindow) then Exit;
  if not Assigned(AWindow.Handle) then Exit;

  triangle := sfConvexShape_create();
  sfConvexShape_setPointCount(triangle, 3);
  sfConvexShape_setPoint(triangle, 0, sfVector2f_create(X1, Y1));
  sfConvexShape_setPoint(triangle, 1, sfVector2f_create(X2, Y2));
  sfConvexShape_setPoint(triangle, 2, sfVector2f_create(X3, Y3));
  sfConvexShape_setFillColor(triangle, AColor);
  sfRenderWindow_drawConvexShapeEx(AWindow, triangle, nil);
  sfConvexShape_destroy(triangle);
end;

procedure sfRenderWindow_drawPolygonEx(const AWindow: PsfRenderWindowEx; const APoints: array of sfVector2f; const AThickness: Single; const AColor, AOutlineColor: sfColor);
var
  polygon: PsfConvexShape;
  i: Integer;
begin
  if not Assigned(AWindow) then Exit;
  if not Assigned(AWindow.Handle) then Exit;

  polygon := sfConvexShape_create();
  sfConvexShape_setPointCount(polygon, Length(APoints));
  for i := 0 to Length(APoints) - 1 do
    sfConvexShape_setPoint(polygon, i, APoints[i]);
  sfConvexShape_setFillColor(polygon, Transparent);
  sfConvexShape_setOutlineThickness(polygon, AThickness);
  sfConvexShape_setOutlineColor(polygon, AOutlineColor);
  sfRenderWindow_drawConvexShapeEx(AWindow, polygon, nil);
  sfConvexShape_destroy(polygon);
end;

procedure sfRenderWindow_drawFilledPolygonEx(const AWindow: PsfRenderWindowEx; const APoints: array of sfVector2f; const AColor: sfColor);
var
  polygon: PsfConvexShape;
  i: Integer;
begin
  if not Assigned(AWindow) then Exit;
  if not Assigned(AWindow.Handle) then Exit;

  polygon := sfConvexShape_create();
  sfConvexShape_setPointCount(polygon, Length(APoints));
  for i := 0 to Length(APoints) - 1 do
    sfConvexShape_setPoint(polygon, i, APoints[i]);
  sfConvexShape_setFillColor(polygon, AColor);
  sfRenderWindow_drawConvexShapeEx(AWindow, polygon, nil);
  sfConvexShape_destroy(polygon);
end;

procedure sfRenderWindow_drawPolylineEx(const AWindow: PsfRenderWindowEx; const APoints: array of sfVector2f; const AThickness: Single; const AColor: sfColor);
var
  line: PsfVertexArray;
  i: Integer;
  vertex: sfVertex;
begin
  if not Assigned(AWindow) then Exit;
  if not Assigned(AWindow.Handle) then Exit;

  line := sfVertexArray_create();
  sfVertexArray_setPrimitiveType(line, sfLineStrip);
  for i := 0 to Length(APoints) - 1 do
  begin
    vertex.position := APoints[i];
    vertex.color := AColor;
    vertex.texCoords.x := 0;
    vertex.texCoords.y := 0;
    sfVertexArray_append(line, vertex);
  end;
  sfRenderWindow_drawVertexArrayEx(AWindow, line, nil);
  sfVertexArray_destroy(line);
end;

procedure sfRenderWindow_drawEllipseEx(const AWindow: PsfRenderWindowEx; const X, Y, AWidth, AHeight, AThickness: Single; const AColor: sfColor);
var
  ellipse: PsfCircleShape;
begin
  if not Assigned(AWindow) then Exit;
  if not Assigned(AWindow.Handle) then Exit;

  ellipse := sfCircleShape_create();
  sfCircleShape_setRadius(ellipse, 0.5);
  sfCircleShape_setOutlineThickness(ellipse, AThickness / AWidth);
  sfCircleShape_setFillColor(ellipse, Transparent);
  sfCircleShape_setOutlineColor(ellipse, AColor);
  sfCircleShape_setScale(ellipse, sfVector2f_create(AWidth, AHeight));
  sfCircleShape_setPosition(ellipse, sfVector2f_create(X, Y));
  sfRenderWindow_drawCircleShapeEx(AWindow, ellipse, nil);
  sfCircleShape_destroy(ellipse);
end;

procedure sfRenderWindow_drawFilledEllipseEx(const AWindow: PsfRenderWindowEx; const X, Y, AWidth, AHeight: Single; const AColor: sfColor);
var
  ellipse: PsfCircleShape;
begin
  if not Assigned(AWindow) then Exit;
  if not Assigned(AWindow.Handle) then Exit;

  ellipse := sfCircleShape_create();
  sfCircleShape_setRadius(ellipse, 0.5);
  sfCircleShape_setFillColor(ellipse, AColor);
  sfCircleShape_setScale(ellipse, sfVector2f_create(AWidth, AHeight));
  sfCircleShape_setPosition(ellipse, sfVector2f_create(X, Y));
  sfRenderWindow_drawCircleShapeEx(AWindow, ellipse, nil);
  sfCircleShape_destroy(ellipse);
end;

{ sfView }
procedure sfView_setLetterBox(const AView: PsfView; const AWindowWidth, AWindowHeight: Integer);
var
  LWindowRatio: Single;
  LViewRatio: Single;
  LViewPort: sfFloatRect;
  LHorizontalSpacing: Boolean;
begin
  LWindowRatio:= AWindowWidth / AWindowHeight;
  LViewRatio := sfView_getSize(AView).x / sfView_getSize(AView).y;
  LHorizontalSpacing := True;

  LViewPort.position.x := 0;
  LViewPort.position.y := 0;
  LViewPort.size.x := 1;
  LViewPort.size.y := 1;

  if LWindowRatio < LViewRatio then
    LHorizontalSpacing := false;

  if LHorizontalSpacing then
    begin
      LViewPort.size.x := LViewRatio / LWindowRatio;
      LViewPort.position.x := (1 - LViewPort.size.x) / 2.0;
    end
  else
    begin
      LViewPort.size.y := LWindowRatio / LViewRatio;
      LViewPort.position.y := (1 - LViewPort.size.y) / 2.0;
    end;

  sfView_setViewport(AView, LViewPort);
end;

function  sfView_createLetterBox(const AWindowWidth, AWindowHeight: Integer): PsfView;
begin
  Result := sfView_create;
  sfView_setSize(Result, sfVector2f_create(AWindowWidth, AWindowHeight));
  sfView_setCenter(Result, sfVector2f_create(sfView_getSize(Result).x/2, sfView_getSize(Result).y/2));
  sfView_setLetterBox(Result, AWindowWidth, AWindowHeight);
end;

{ sfFont }
function sfFont_createFromRes(const AInstance: HINST; const AResName: string): PsfFont;
var
  LResStream: TResourceStream;
begin
  Result := nil;
  if not ResourceExists(AInstance, AResName) then Exit;
  LResStream := TResourceStream.Create(AInstance, AResName, RT_RCDATA);
  try
    Result := sfFont_createFromMemory(LResStream.Memory, LResStream.Size);
  finally
    LResStream.Free;
  end;
end;

function sfFont_createDefaultFont: PsfFont;
begin
  Result := sfFont_createFromRes(HInstance, 'db1184eec13447cb8cceb28a1052bd96');
end;

function sfFont_createFromStreamEx(stream: PsfInputStreamEx): PsfFont;
begin
  Result := sfFont_createFromStream(@stream.Base);
end;

{ sfText }
procedure sfText_setCharacterSizeEx(const AWindow: PsfRenderWindowEx; const AText: PsfText; const ASize: Cardinal);
var
  LSize: Cardinal;
begin
  if not Assigned(AWindow) then Exit;
  if not Assigned(AWindow.Handle) then Exit;

  if not Assigned(AText) then Exit;

  LSize := Round(ASize * AWindow.Scale);
  sfText_setCharacterSize(AText, LSize);
end;

procedure sfText_setUnicodeStringEx(const AText: PsfText; const AString: string);
begin
  if not Assigned(AText) then Exit;
  sfText_setUnicodeString(AText, PsfChar32(WideStringToUCS4String(AString)));
end;

{ sfTexture }
function sfTexture_createFromRes(const AInstance: HINST; const AResName: string; const AArea: PsfIntRect): PsfTexture;
var
  LResStream: TResourceStream;
begin
  Result := nil;
  if not ResourceExists(AInstance, AResName) then Exit;
  LResStream := TResourceStream.Create(AInstance, AResName, RT_RCDATA);
  try
    Result := sfTexture_createFromMemory(LResStream.Memory, LResStream.Size, AArea);
  finally
    LResStream.Free;
  end;
end;

function sfTexture_createFromStreamEx(stream: PsfInputStreamEx; const area: PsfIntRect): PsfTexture;
begin
  Result := sfTexture_createFromStream(@stream.Base, area);
end;

function sfTexture_createSrgbFromStreamEx(stream: PsfInputStreamEx; const area: PsfIntRect): PsfTexture;
begin
  Result := sfTexture_createSrgbFromStream(@stream.Base, area);
end;

{ sfImage }
function sfImage_createFromStreamEx(stream: PsfInputStreamEx): PsfImage;
begin
  Result := sfImage_createFromStream(@stream.Base);
end;

{ sfMusic }
function sfMusic_createFromStreamEx(stream: PsfInputStreamEx): PsfMusic;
begin
  Result := sfMusic_createFromStream(@stream.Base);
end;

{ sfSoundBuffer }
function sfSoundBuffer_createFromStreamEx(stream: PsfInputStreamEx): PsfSoundBuffer;
begin
  Result := sfSoundBuffer_createFromStream(@stream.Base);
end;


{ sfTime }
var
  sfTimeFrequency: Int64 = 0; // Global variable to store the frequency

procedure sfTime_sleep(const AMilliseconds: Integer);
var
  LStartTime, LCurrentTime: Int64;
  LDelayTicks: Int64;
begin
  if AMilliseconds = 0 then Exit;

  // Initialize the frequency only once
  if sfTimeFrequency = 0 then
    QueryPerformanceFrequency(sfTimeFrequency);

  QueryPerformanceCounter(LStartTime);
  LDelayTicks := (AMilliseconds * sfTimeFrequency) div 1000;

  repeat
    SleepEx(1, True); // SleepEx in alertable mode to allow background tasks
    QueryPerformanceCounter(LCurrentTime);
  until (LCurrentTime - LStartTime) >= LDelayTicks;
end;

{ sfSoundStream }
procedure sfSoundStream_destroyEx(const soundStream: PsfSoundStream);
begin
  sfSoundStream_destroy(soundStream);
end;

procedure sfSoundStream_pauseEx(soundStream: PsfSoundStream);
begin
  sfSoundStream_pause(soundStream);
end;

procedure sfSoundStream_stopEx(soundStream: PsfSoundStream);
begin
  sfSoundStream_stop(soundStream);
end;

{ sfShader }
function sfShader_createFromStreamEx(vertexShaderStream: PsfInputStreamEx; geometryShaderStream: PsfInputStreamEx; fragmentShaderStream: PsfInputStreamEx): PsfShader;
begin
  Result := sfShader_createFromStream(@vertexShaderStream.Base, @geometryShaderStream.Base, @fragmentShaderStream.Base);
end;

{ sfVideo }
type
  PsfVideo = ^TsfVideo;
  TsfVideo = record
  public const
    CPlmBufferSize = 1024*1;
    CSampleBuffSize  = 2304;
    Channels = 2;
    BufferSize = 44100;
  public
    Image: PsfImage;
    Texture: PsfTexture;
    Sprite: PsfSprite;
    AudioStream:  PsfSoundStream;
    InputStream: PsfInputStreamEx;
    Handle: Pplm_t;
    RingBuffer: TRingBuffer<Byte>;
    TextureWidth,TextureHeight: integer;
    Loop: Boolean;
    SampleRate: Integer;
    FrameRate: Integer;
    Volume: Single;
    Status: sfVideoStatus;
    StopFlag: Boolean;
    Sender: Pointer;
    Handler: sfVideoStatusCallback;
    Name: string;
    DataBuffer: array[0..CPlmBufferSize-1] of Byte;
    SampleBuffer: array[0..CSampleBuffSize-1] of Byte;
    AudioDecodeBuffer1: array[0..CSampleBuffSize-1] of smallint;
    AudioDecodeBuffer2: array[0..(CSampleBuffSize*sizeof(smallint))-1] of Byte;
  end;

var
  sfVideo: TsfVideo;

procedure Video_OnGetVideoData(buffer: Pplm_buffer_t; user: Pointer); cdecl;
var
  LVideo: PsfVideo;

  LBytesRead: Int64;
begin
  LVideo := user;

  LBytesRead := sfInputStream_readEx(LVideo.InputStream, @LVideo.DataBuffer[0], LVideo.CPlmBufferSize);
  if LBytesRead > 0 then
    begin
      plm_buffer_write(Buffer, @LVideo.DataBuffer[0], LBytesRead);
    end
  else
    begin
      LVideo.StopFlag := True;
    end;
end;

function Video_OnGetSampleData(Data: PsfSoundStreamChunk; UserData: Pointer): Boolean; cdecl;
var
  LVideo: PsfVideo;
  LReadCount: Int64;
begin
  Result := False;
  LVideo := UserData;
  if LVideo.Status = vsStopped then Exit;
  if LVideo.RingBuffer = nil then Exit;
  Data.samples := @LVideo.SampleBuffer;
  LReadCount := LVideo.RingBuffer.Read(LVideo.SampleBuffer, LVideo.CSampleBuffSize);
  Data.sampleCount := LReadcount div LVideo.Channels;
  Result := True;
end;

procedure Video_OnDecodeAudio(plm: Pplm_t; samples: Pplm_samples_t; user: Pointer); cdecl;
var
  LVideo: PsfVideo;
  i: Integer;
begin
  LVideo := user;

  for i := 0 to LVideo.CSampleBuffSize-1 do
  begin
    LVideo.AudioDecodeBuffer1[i] := FloatToSmallInt(samples.interleaved[i]);
  end;

  Move(LVideo.AudioDecodeBuffer1, LVideo.AudioDecodeBuffer2, Sizeof(LVideo.AudioDecodeBuffer1));
  LVideo.ringBuffer.Write(LVideo.AudioDecodeBuffer2, LVideo.CSampleBuffSize*sizeof(smallint));
end;

procedure Video_OnDecodeVideo(plm: pplm_t; frame: pplm_frame_t; user: pointer); cdecl;
var
  LVideo: PsfVideo;
  LOffset: sfVector2u;
begin
  LVideo := user;

  plm_frame_to_rgba(Frame, PUInt8(sfImage_getPixelsPtr(LVideo.Image)), 4*LVideo.Texturewidth);
  LOffset := sfVector2u_create(0, 0);
  sfTexture_updateFromImage(LVideo.Texture, LVideo.Image, LOffset);
end;

function  sfVideo_playFromStream(const AStream: PsfInputStreamEx; const AVolume: Single; const ALoop: Boolean; const AName: string; const ASender: Pointer; const AHandler: sfVideoStatusCallback): Boolean;
var
  LDataBuffer: Pplm_buffer_t;
  LSize: sfVector2u;
begin
  Result := False;

  sfVideo_destroy();

  sfVideo.Volume := AVolume;
  sfVideo.Loop := ALoop;
  sfVideo.Status := vsStopped;
  sfVideo.InputStream := AStream;

  LDataBuffer := plm_buffer_create_with_capacity(sfVideo.CPlmBufferSize);
  if not Assigned(LDataBuffer) then Exit;

  plm_buffer_set_load_callback(LDataBuffer, Video_OnGetVideoData, @sfVideo);

  sfVideo.Handle := plm_create_with_buffer(LDataBuffer, 1);
  if not Assigned(sfVideo.Handle) then
  begin
    plm_buffer_destroy(LDataBuffer);
    Exit;
  end;

  plm_set_loop(sfVideo.Handle, 0);

  sfVideo.TextureWidth := plm_get_width(sfVideo.Handle);
  sfVideo.TextureHeight := plm_get_height(sfVideo.Handle);
  sfVideo.SampleRate := plm_get_samplerate(sfVideo.Handle);

  LSize := sfVector2u_create(sfVideo.TextureWidth, sfVideo.TextureHeight);
  sfVideo.Image := sfImage_createFromColor(LSize, WHITE);
  if not Assigned(sfVideo.Image) then
  begin
    sfVideo_destroy();
    Exit;
  end;

  LSize := sfVector2u_create(sfVideo.TextureWidth, sfVideo.TextureHeight);
  sfVideo.Texture := sfTexture_create(LSize);
  if not Assigned(sfVideo.Texture) then
  begin
    sfVideo_destroy();
    Exit;
  end;

  sfVideo.Sprite := sfSprite_create(sfVideo.Texture);
  if not Assigned(sfVideo.Sprite) then
  begin
    sfVideo_destroy();
    Exit;
  end;
  sfSprite_setTexture(sfVideo.Sprite, sfVideo.Texture, True);

  sfVideo.RingBuffer := TRingBuffer<byte>.Create(sfVideo.BufferSize);
  if not Assigned(sfVideo.RingBuffer) then
  begin
    sfVideo_destroy();
    Exit;
  end;

  sfVideo.AudioStream := sfSoundStream_create(Video_OnGetSampleData, nil, 2, 44100, nil, 0, @sfVideo);
  if not Assigned(sfVideo.AudioStream) then
  begin
    sfVideo_destroy();
    Exit;
  end;

  sfVideo.Sender := ASender;
  sfVideo.Handler := AHandler;
  sfVideo.Name := AName;
  sfVideo.Status := vsPlaying;

  if Assigned(sfVideo.Handler) then
  begin
    sfVideo.Handler(sfVideo.Sender, sfVideo.Status, sfVideo.Name);
  end;

  plm_set_audio_decode_callback(sfVideo.Handle, @Video_OnDecodeAudio, @sfVideo);
  plm_set_video_decode_callback(sfVideo.Handle, @Video_OnDecodeVideo, @sfVideo);
  plm_set_audio_lead_time(sfVideo.Handle, sfVideo.CSampleBuffSize/sfVideo.SampleRate);

  sfSoundStream_play(sfVideo.AudioStream);
  sfVideo_setVolume(AVolume);

  Result := True;
end;

function  sfVideo_playFromFile(const AFilename: string; const AVolume: Single; const ALoop: Boolean; const ASender: Pointer; const AHandler: sfVideoStatusCallback): Boolean;
var
  LStream: PsfInputStreamEx;
begin
  Result := False;
  LStream := sfInputStream_createFromFileEx(AFilename);
  if not Assigned(LStream) then Exit;

  Result := sfVideo_playFromStream(LStream, AVolume, ALoop, AFilename, ASender, aHandler);
end;

function  sfVideo_playFromZipFile(const AZipFilename, AFilename: string; const AVolume: Single; const ALoop: Boolean; const ASender: Pointer; const AHandler: sfVideoStatusCallback; const APassword: string): Boolean;
var
  LStream: PsfInputStreamEx;
begin
  Result := False;
  LStream := sfInputStream_createFromZipFileEx(AZipFilename, AFilename, APassword);
  if not Assigned(LStream) then Exit;

  Result := sfVideo_playFromStream(LStream, AVolume, ALoop, AFilename, ASender, aHandler);
end;

procedure sfVideo_destroy();
begin
  sfVideo.Status := vsStopped;

  if Assigned(sfVideo.AudioStream) then
  begin
    sfSoundStream_stopEx(sfVideo.AudioStream);
    sfSoundStream_destroyEx(sfVideo.AudioStream);
    sfVideo.RingBuffer.Clear();
  end;

  if Assigned(sfVideo.InputStream) then
  begin
    sfInputStream_closeEx(sfVideo.InputStream);
    sfVideo.InputStream := nil;
  end;

  if Assigned(sfVideo.Sprite) then
  begin
    sfSprite_destroy(sfVideo.Sprite);
    sfVideo.Sprite := nil;
  end;

  if Assigned(sfVideo.Texture) then
  begin
    sfTexture_destroy(sfVideo.Texture);
    sfVideo.Texture := nil;
  end;

  if Assigned(sfVideo.Image) then
  begin
    sfImage_destroy(sfVideo.Image);
    sfVideo.Image := nil;
  end;

  if Assigned(sfVideo.RingBuffer) then
  begin
    sfVideo.RingBuffer.Free;
    sfVideo.RingBuffer := nil;
  end;

  if Assigned(sfVideo.Handle) then
  begin
    plm_destroy(sfVideo.Handle);
    sfVideo.Handle := nil;
  end;

  sfVideo := Default(TsfVideo);
end;

function sfVideo_update(const AWindow: PsfRenderWindowEx): sfVideoStatus;
begin
  Result := sfVideo.Status;

  if not Assigned(sfVideo.Handle) then Exit;
  if not Assigned(sfVideo.AudioStream) then Exit;
  if not Assigned(sfVideo.InputStream) then Exit;
  if sfVideo.Status <> vsPlaying then Exit;

  if sfVideo.StopFlag then
    begin
      if sfVideo.Loop then
        begin
          sfSoundStream_stopEx(sfVideo.AudioStream);
          sfVideo.RingBuffer.Clear;
          plm_rewind(sfVideo.Handle);
          sfInputStream_seekEx(sfVideo.InputStream, 0);
          sfSoundStream_play(sfVideo.AudioStream);
          sfVideo.Status := vsPlaying;
          sfVideo.StopFlag := False;
        end
      else
        begin
          sfVideo.Status := vsStopped;
          sfSoundStream_stopEx(sfVideo.AudioStream);
          sfVideo.RingBuffer.Clear;
          if Assigned(sfVideo.Handler) then
          begin
            sfVideo.Handler(sfVideo.Sender, sfVideo.Status, sfVideo.Name);
          end;
        end;
    end
  else
    begin
      plm_decode(sfVideo.Handle, 1.0/AWindow.Timing.Limit);
    end;

  Result := sfVideo.Status;
end;

procedure sfVideo_render(const AWindow: PsfRenderWindowEx; const X, Y, AScale: Single);
begin
  if not Assigned(AWindow) then Exit;
  if not Assigned(AWindow.Handle) then Exit;

  if not Assigned(sfVideo.Handle) then Exit;
  if sfVideo.Status <> vsPlaying then Exit;
  sfSprite_setScale(sfVideo.Sprite, sfVector2f_create(AScale, AScale));
  sfRenderWindow_drawSpriteEx(AWindow, sfVideo.Sprite, nil);
end;

function  sfVideo_getStatus(): sfVideoStatus;
begin
  Result := sfVideo.Status;
end;

function  sfVideo_isLooping(): Boolean;
begin
  Result := sfVideo.Loop;
end;

procedure sfVideo_setLooping(const ALoop: Boolean);
begin
  sfVideo.Loop := ALoop;
end;

function  sfVideo_getVolume(): Single;
begin
  Result := sfVideo.Volume;
end;

procedure sfVideo_setVolume(const AVolume: Single);
begin
  if not Assigned(sfVideo.AudioStream) then Exit;
  sfVideo.Volume := EnsureRange(AVolume, 0, 1);
  sfSoundStream_setVolume(sfVideo.AudioStream, UnitToScalarValue(sfVideo.Volume, 100));
end;

{$ENDREGION}

{$REGION ' Pyro.Math '}
type
  TsfMath = record
    FCosTable: array [0..360] of Single;
    FSinTable: array [0..360] of Single;
  end;

var
  sfMath: TsfMath;

function  sfVector_fromVector2f(const A: sfVector2f): sfVector;
begin
  Result := Default(sfVector);
  Result.x := A.x;
  Result.y := A.y;
end;

function  sfVector_fromVector2u(const A: sfVector2u): sfVector;
begin
  Result := Default(sfVector);
  Result.x := A.x;
  Result.y := A.y;
end;

procedure sfVector_assignXY(var A: sfVector; const X, Y: Single);
begin
  A := Default(sfVector);
  A.x := X;
  A.y := Y;
end;

procedure sfVector_assigneXYZ(var A: sfVector; const X, Y, Z: Single);
begin
  A := Default(sfVector);
  A.x := X;
  A.y := Y;
  A.z := Z;
end;

procedure sfVector_assignXYZW(var A: sfVector; const X, Y, Z, W: Single);
begin
  A := Default(sfVector);
  A.x := X;
  A.y := Y;
  A.z := Z;
  A.w := W;
end;

procedure sfVector_assignVector(var A: sfVector; const B: sfVector);
begin
  A := B;
end;

procedure sfVector_clear(var A: sfVector);
begin
  A := Default(sfVector);
end;

procedure sfVector_add(var A: sfVector;  const B: sfVector);
begin
  A.x := A.x + B.x;
  A.y := A.y + B.y;
end;

procedure sfVector_subtract(var A: sfVector; const B: sfVector);
begin
  A.x := A.x - B.x;
  A.y := A.y - B.y;
end;

procedure sfVector_multiply(var A: sfVector; const B: sfVector);
begin
  A.x := A.x * B.x;
  A.y := A.y * B.y;
end;

procedure sfVector_divide(var A: sfVector; const B: sfVector);
begin
  A.x := A.x / B.x;
  A.y := A.y / B.y;
end;

function sfVector_magnitude(const A: sfVector): Single;
begin
  Result := Sqrt((A.x * A.x) + (A.y * A.y));
end;

function sfVector_magnitudeTruncate(const A: sfVector; const AMaxMagnitude: Single): sfVector;
var
  LMaxMagSqrd: Single;
  LVecMagSqrd: Single;
  LTruc: Single;
begin
  Result := Default(sfVector);
  Result.x := A.x;
  Result.y := A.y;

  LMaxMagSqrd := AMaxMagnitude * AMaxMagnitude;
  LVecMagSqrd := sfVector_magnitude(Result);
  if LVecMagSqrd > LMaxMagSqrd then
  begin
    LTruc := (AMaxMagnitude / Sqrt(LVecMagSqrd));
    Result.x := Result.x * LTruc;
    Result.y := Result.y * LTruc;
  end;
end;

function sfVector_distance(const A, B: sfVector): Single;
var
  LDirVec: sfVector;
begin
  LDirVec.x := A.x - B.x;
  LDirVec.y := A.y - B.y;
  Result := sfVector_magnitude(LDirVec);
end;

procedure sfVector_normalize(var A: sfVector);
var
  LLen, LOOL: Single;
begin
  LLen := sfVector_magnitude(A);
  if LLen <> 0 then
  begin
    LOOL := 1.0 / LLen;
    A.x := A.x * LOOL;
    A.y := A.y * LOOL;
  end;
end;

function sfVector_angle(const A, B: sfVector): Single;
var
  LXOY: Single;
  LR: sfVector;
begin
  sfVector_assignVector(LR, A);
  sfVector_subtract(LR, B);
  sfVector_normalize(LR);

  if LR.y = 0 then
  begin
    LR.y := 0.001;
  end;

  LXOY := LR.x / LR.y;

  Result := ArcTan(LXOY) * sfRadToDeg;
  if LR.y < 0 then
    Result := Result + 180.0;
end;

procedure sfVector_thrust(var A: sfVector; const AAngle, ASpeed: Single);
var
  LA: Single;
begin
  LA := AAngle + 90.0;
  sfClipValue_float(LA, 0, 360, True);

  A.x := A.x + sfAngle_cos(Round(LA)) * -(aSpeed);
  A.y := A.y + sfAngle_sin(Round(LA)) * -(aSpeed);
end;

function sfVector_magnitudeSquared(const A: sfVector): Single;
begin
  Result := (A.x * A.x) + (A.y * A.y);
end;

function sfVector_dotProduct(const A, B: sfVector): Single;
begin
  Result := (A.x * B.x) + (A.y * B.y);
end;

procedure sfVector_scalerBy(var A: sfVector; const AValue: Single);
begin
  A.x := A.x * AValue;
  A.y := A.y * AValue;
end;

procedure sfVector_divideBy(var A: sfVector; const AValue: Single);
begin
  A.x := A.x / AValue;
  A.y := A.y / AValue;
end;

function sfVector_project(const A, B: sfVector): sfVector;
var
  LDP: Single;
begin
  LDP :=  sfVector_dotProduct(A, B);
  Result.x := (LDP / (B.x * B.x + B.y * B.y)) * B.x;
  Result.y := (LDP / (B.x * B.x + B.y * B.y)) * B.y;
end;

procedure sfVector_negate(var A: sfVector);
begin
  A.x := -A.x;
  A.y := -A.y;
end;

function  sfPoint_create(const X, Y: Single): sfPoint;
begin
  Result.x := X;
  Result.y := Y;
end;

function  sfVector_create(const X, Y: Single): sfVector;
begin
  Result.x := X;
  Result.y := Y;
end;

function  sfSize_create(const AWidth, AHeight: Single): sfSize;
begin
  Result.w := AWidth;
  Result.h := AHeight;
end;

function  sfRect_create(const X, Y, AWidth, AHeight: Single): sfRect;
begin
  Result.x := X;
  Result.y := Y;
  Result.w := AWidth;
  Result.h := AHeight;
end;

function  sfExtent_create(const AMinX, AMinY, AMaxX, AMaxY: Single): sfExtent;
begin
  Result.minx := AMinX;
  Result.miny := AMinY;
  Result.maxx := AMaxX;
  Result.maxy := AMaxY;
end;

function  sfAngle_cos(const AAngle: Cardinal): Single;
var
  LAngle: Cardinal;
begin
  LAngle := EnsureRange(AAngle, 0, 360);
  Result := sfMath.FCosTable[LAngle];
end;

function  sfAngle_sin(const AAngle: Cardinal): Single;
var
  LAngle: Cardinal;
begin
  LAngle := EnsureRange(AAngle, 0, 360);
  Result := sfMath.FSinTable[LAngle];
end;

function _RandomRange(const aFrom, aTo: Integer): Integer;
var
  LFrom: Integer;
  LTo: Integer;
begin
  LFrom := aFrom;
  LTo := aTo;

  if AFrom > ATo then
    Result := Random(LFrom - LTo) + ATo
  else
    Result := Random(LTo - LFrom) + AFrom;
end;

function  sfRandom_rangeInt(const AMin, AMax: Integer): Integer;
begin
  Result := _RandomRange(AMin, AMax + 1);
end;

function  sfRandom_rangeFloat(const AMin, AMax: Single): Single;
var
  LNum: Single;
begin
  LNum := _RandomRange(0, MaxInt) / MaxInt;
  Result := AMin + (LNum * (AMax - AMin));
end;

function  sfRandom_bool(): Boolean;
begin
  Result := Boolean(_RandomRange(0, 2) = 1);
end;

function  sfRandom_getSeed(): Integer;
begin
  Result := System.RandSeed;
end;

procedure sfRandom_setSeed(const AVaLue: Integer);
begin
  System.RandSeed := AVaLue;
end;

function  sfClipValue_float(var AVaLue: Single; const AMin, AMax: Single; const AWrap: Boolean): Single;
begin
  if AWrap then
    begin
      if (AVaLue > AMax) then
      begin
        AVaLue := AMin + Abs(AVaLue - AMax);
        if AVaLue > AMax then
          AVaLue := AMax;
      end
      else if (AVaLue < AMin) then
      begin
        AVaLue := AMax - Abs(AVaLue - AMin);
        if AVaLue < AMin then
          AVaLue := AMin;
      end
    end
  else
    begin
      if AVaLue < AMin then
        AVaLue := AMin
      else if AVaLue > AMax then
        AVaLue := AMax;
    end;

  Result := AVaLue;
end;

function  sfClipValue_int(var AVaLue: Integer; const aMin, AMax: Integer; const AWrap: Boolean): Integer;
begin
  if AWrap then
    begin
      if (AVaLue > AMax) then
      begin
        AVaLue := aMin + Abs(AVaLue - AMax);
        if AVaLue > AMax then
          AVaLue := AMax;
      end
      else if (AVaLue < aMin) then
      begin
        AVaLue := AMax - Abs(AVaLue - aMin);
        if AVaLue < aMin then
          AVaLue := aMin;
      end
    end
  else
    begin
      if AVaLue < aMin then
        AVaLue := aMin
      else if AVaLue > AMax then
        AVaLue := AMax;
    end;

  Result := AVaLue;
end;

function  sfSameSign_int(const AVaLue1, AVaLue2: Integer): Boolean;
begin
  if Sign(AVaLue1) = Sign(AVaLue2) then
    Result := True
  else
    Result := False;
end;

function  sfSameSign_float(const AVaLue1, AVaLue2: Single): Boolean;
begin
  if System.Math.Sign(AVaLue1) = System.Math.Sign(AVaLue2) then
    Result := True
  else
    Result := False;
end;

function  sfSameValue_double(const A, B: Double; const AEpsilon: Double = 0): Boolean;
begin
  Result := System.Math.SameVaLue(A, B, AEpsilon);
end;

function  sfSameValue_float(const A, B: Single; const AEpsilon: Single = 0): Boolean;
begin
  Result := System.Math.SameVaLue(A, B, AEpsilon);
end;

function  sfAngle_difference(const ASrcAngle, ADestAngle: Single): Single;
var
  C: Single;
begin
  C := ADestAngle-ASrcAngle-(Floor((ADestAngle-ASrcAngle)/360.0)*360.0);

  if C >= (360.0 / 2) then
  begin
    C := C - 360.0;
  end;
  Result := C;
end;

procedure sfAngle_rotatePos(const AAngle: Single; var AX, AY: Single);
var
  nx,ny: Single;
  ia: Integer;
  LAngle: Single;
begin
  LAngle := EnsureRange(AAngle, 0, 360);

  ia := Round(LAngle);

  nx := AX*sfMath.FCosTable[ia] - AY*sfMath.FSinTable[ia];
  ny := AY*sfMath.FCosTable[ia] + AX*sfMath.FSinTable[ia];

  AX := nx;
  AY := ny;
end;

procedure sfMove_smooth(var AVaLue: Single; const AAmount, AMax, ADrag: Single);
var
  LAmt: Single;
begin
  LAmt := AAmount;

  if LAmt > 0 then
  begin
    AVaLue := AVaLue + LAmt;
    if AVaLue > AMax then
      AVaLue := AMax;
  end else if LAmt < 0 then
  begin
    AVaLue := AVaLue + LAmt;
    if AVaLue < -AMax then
      AVaLue := -AMax;
  end else
  begin
    if AVaLue > 0 then
    begin
      AVaLue := AVaLue - ADrag;
      if AVaLue < 0 then
        AVaLue := 0;
    end else if AVaLue < 0 then
    begin
      AVaLue := AVaLue + ADrag;
      if AVaLue > 0 then
        AVaLue := 0;
    end;
  end;
end;

function  sfLerp(const AFrom, ATo, ATime: Double): Double;
begin
  if ATime <= 0.5 then
    Result := AFrom + (ATo - AFrom) * ATime
  else
    Result := ATo - (ATo - AFrom) * (1.0 - ATime);
end;

function  sfCollision_pointInRectangle(const APoint: sfVector; const ARect: sfRect): Boolean;
begin
  if ((APoint.x >= ARect.x) and (APoint.x <= (ARect.x + ARect.w)) and
    (APoint.y >= ARect.y) and (APoint.y <= (ARect.y + ARect.h))) then
    Result := True
  else
    Result := False;
end;

function  sfCollision_pointInCircle(const APoint, ACenter: sfVector; const ARadius: Single): Boolean;
begin
  Result := sfCollision_circlesOverlap(APoint, 0, ACenter, ARadius);
end;

function  sfCollision_pointInTriangle(const APoint, P1, P2, P3: sfVector): Boolean;
var
  LAlpha, LBeta, LGamma: Single;
begin
  LAlpha := ((P2.y - P3.y) * (APoint.x - P3.x) + (P3.x - P2.x) *
    (APoint.y - P3.y)) / ((P2.y - P3.y) * (P1.x - P3.x) + (P3.x - P2.x) *
    (P1.y - P3.y));

  LBeta := ((P3.y - P1.y) * (APoint.x - P3.x) + (P1.x - P3.x) *
    (APoint.y - P3.y)) / ((P2.y - P3.y) * (P1.x - P3.x) + (P3.x - P2.x) *
    (P1.y - P3.y));

  LGamma := 1.0 - LAlpha - LBeta;

  if ((LAlpha > 0) and (LBeta > 0) and (LGamma > 0)) then
    Result := True
  else
    Result := False;
end;

function  sfCollision_circlesOverlap(const ACenter1: sfVector; const ARadius1: Single; const ACenter2: sfVector; const ARadius2: Single): Boolean;
var
  LDX, LDY, LDistance: Single;
begin
  LDX := ACenter2.x - ACenter1.x; // X distance between centers
  LDY := ACenter2.y - ACenter1.y; // Y distance between centers

  LDistance := sqrt(LDX * LDX + LDY * LDY); // Distance between centers

  if (LDistance <= (ARadius1 + ARadius2)) then
    Result := True
  else
    Result := False;
end;

function  sfCollision_circleInRectangle(const ACenter: sfVector; const ARadius: Single; const ARect: sfRect): Boolean;
var
  LDX, LDY: Single;
  LCornerDistanceSq: Single;
  LRecCenterX: Integer;
  LRecCenterY: Integer;
begin
  LRecCenterX := Round(ARect.x + ARect.w / 2);
  LRecCenterY := Round(ARect.y + ARect.h / 2);

  LDX := abs(ACenter.x - LRecCenterX);
  LDY := abs(ACenter.y - LRecCenterY);

  if (LDX > (ARect.w / 2.0 + ARadius)) then
  begin
    Result := False;
    Exit;
  end;

  if (LDY > (ARect.h / 2.0 + ARadius)) then
  begin
    Result := False;
    Exit;
  end;

  if (LDX <= (ARect.w / 2.0)) then
  begin
    Result := True;
    Exit;
  end;
  if (LDY <= (ARect.h / 2.0)) then
  begin
    Result := True;
    Exit;
  end;

  LCornerDistanceSq := (LDX - ARect.w / 2.0) * (LDX - ARect.w / 2.0) +
    (LDY - ARect.h / 2.0) * (LDY - ARect.h / 2.0);

  Result := Boolean(LCornerDistanceSq <= (ARadius * ARadius));
end;

function  sfCollision_rectanglesOverlap(const ARect1, ARect2: sfRect): Boolean;
var
  LDX, LDY: Single;
begin
  LDX := abs((ARect1.x + ARect1.w / 2) - (ARect2.x + ARect2.w / 2));
  LDY := abs((ARect1.y + ARect1.h / 2) - (ARect2.y + ARect2.h / 2));

  if ((LDX <= (ARect1.w / 2 + ARect2.w / 2)) and
    ((LDY <= (ARect1.h / 2 + ARect2.h / 2)))) then
    Result := True
  else
    Result := False;
end;

function  sfCollision_rectangleIntersection(const ARect1, ARect2: sfRect): sfRect;
var
  LDXX, LDYY: Single;
begin
  //Result.Assign(0, 0, 0, 0);
  Result := Default(sfRect);

  if sfCollision_rectanglesOverlap(ARect1, ARect2) then
  begin
    LDXX := abs(ARect1.x - ARect2.x);
    LDYY := abs(ARect1.y - ARect2.y);

    if (ARect1.x <= ARect2.x) then
    begin
      if (ARect1.y <= ARect2.y) then
      begin
        Result.x := ARect2.x;
        Result.y := ARect2.y;
        Result.w := ARect1.w - LDXX;
        Result.h := ARect1.h - LDYY;
      end
      else
      begin
        Result.x := ARect2.x;
        Result.y := ARect1.y;
        Result.w := ARect1.w - LDXX;
        Result.h := ARect2.h - LDYY;
      end
    end
    else
    begin
      if (ARect1.y <= ARect2.y) then
      begin
        Result.x := ARect1.x;
        Result.y := ARect2.y;
        Result.w := ARect2.w - LDXX;
        Result.h := ARect1.h - LDYY;
      end
      else
      begin
        Result.x := ARect1.x;
        Result.y := ARect1.y;
        Result.w := ARect2.w - LDXX;
        Result.h := ARect2.h - LDYY;
      end
    end;

    if (ARect1.w > ARect2.w) then
    begin
      if (Result.w >= ARect2.w) then
        Result.w := ARect2.w;
    end
    else
    begin
      if (Result.w >= ARect1.w) then
        Result.w := ARect1.w;
    end;

    if (ARect1.h > ARect2.h) then
    begin
      if (Result.h >= ARect2.h) then
        Result.h := ARect2.h;
    end
    else
    begin
      if (Result.h >= ARect1.h) then
        Result.h := ARect1.h;
    end
  end;
end;

function  sfCollision_lineIntersection(const X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer; var X: Integer; var Y: Integer): UInt32;
var
  LAX, LBX, LCX, LAY, LBY, LCY, LD, LE, LF, LNum: Integer;
  LOffset: Integer;
  LX1Lo, LX1Hi, LY1Lo, LY1Hi: Integer;
begin
  Result := Ord(sfLineIntersecNone);

  LAX := X2 - X1;
  LBX := X3 - X4;

  if (LAX < 0) then // X bound box test
  begin
    LX1Lo := X2;
    LX1Hi := X1;
  end
  else
  begin
    LX1Hi := X2;
    LX1Lo := X1;
  end;

  if (LBX > 0) then
  begin
    if (LX1Hi < X4) or (X3 < LX1Lo) then
      Exit;
  end
  else
  begin
    if (LX1Hi < X3) or (X4 < LX1Lo) then
      Exit;
  end;

  LAY := Y2 - Y1;
  LBY := Y3 - Y4;

  if (LAY < 0) then // Y bound box test
  begin
    LY1Lo := Y2;
    LY1Hi := Y1;
  end
  else
  begin
    LY1Hi := Y2;
    LY1Lo := Y1;
  end;

  if (LBY > 0) then
  begin
    if (LY1Hi < Y4) or (Y3 < LY1Lo) then
      Exit;
  end
  else
  begin
    if (LY1Hi < Y3) or (Y4 < LY1Lo) then
      Exit;
  end;

  LCX := X1 - X3;
  LCY := Y1 - Y3;
  LD := LBY * LCX - LBX * LCY; // alpha numerator
  LF := LAY * LBX - LAX * LBY; // both denominator

  if (LF > 0) then // alpha tests
  begin
    if (LD < 0) or (LD > LF) then
      Exit;
  end
  else
  begin
    if (LD > 0) or (LD < LF) then
      Exit
  end;

  LE := LAX * LCY - LAY * LCX; // beta numerator
  if (LF > 0) then // beta tests
  begin
    if (LE < 0) or (LE > LF) then
      Exit;
  end
  else
  begin
    if (LE > 0) or (LE < LF) then
      Exit;
  end;

  // compute intersection coordinates

  if (LF = 0) then
  begin
    Result := Ord(sfLineIntersecParallel);
    Exit;
  end;

  LNum := LD * LAX; // numerator
  // if SameSigni(num, f) then
  if Sign(LNum) = Sign(LF) then

    LOffset := LF div 2
  else
    LOffset := -LF div 2;
  X := X1 + (LNum + LOffset) div LF; // intersection x

  LNum := LD * LAY;
  // if SameSigni(num, f) then
  if Sign(LNum) = Sign(LF) then
    LOffset := LF div 2
  else
    LOffset := -LF div 2;

  Y := Y1 + (LNum + LOffset) div LF; // intersection y

  Result := Ord(sfLineIntersecTrue);
end;

function  sfCollision_radiusOverlap(const ARadius1, X1, Y1, ARadius2, X2, Y2, AShrinkFactor: Single): Boolean;
var
  LDist: Single;
  LR1, LR2: Single;
  LV1, LV2: sfVector;
begin
  LR1 := ARadius1 * AShrinkFactor;
  LR2 := ARadius2 * AShrinkFactor;

  LV1.x := X1;
  LV1.y := Y1;
  LV2.x := X2;
  LV2.y := Y2;

  //LDist := LV1.distance(LV2);
  LDist := sfVector_distance(LV1, LV2);

  if (LDist < LR1) or (LDist < LR2) then
    Result := True
  else
    Result := False;
end;

function  sfEase_Value(ACurrentTime: Double; AStartValue: Double; AChangeInValue: Double; ADuration: Double; AEaseType: UInt32): Double;
begin
  Result := 0;
  case sfEase(AEaseType) of
    sfEaseLinearTween:
      begin
        Result := AChangeInValue * ACurrentTime / ADuration + AStartValue;
      end;

    sfEaseInQuad:
      begin
        ACurrentTime := ACurrentTime / ADuration;
        Result := AChangeInValue * ACurrentTime * ACurrentTime + AStartValue;
      end;

    sfEaseOutQuad:
      begin
        ACurrentTime := ACurrentTime / ADuration;
        Result := -AChangeInValue * ACurrentTime * (ACurrentTime-2) + AStartValue;
      end;

    sfEaseInOutQuad:
      begin
        ACurrentTime := ACurrentTime / (ADuration / 2);
        if ACurrentTime < 1 then
          Result := AChangeInValue / 2 * ACurrentTime * ACurrentTime + AStartValue
        else
        begin
          ACurrentTime := ACurrentTime - 1;
          Result := -AChangeInValue / 2 * (ACurrentTime * (ACurrentTime - 2) - 1) + AStartValue;
        end;
      end;

    sfEaseInCubic:
      begin
        ACurrentTime := ACurrentTime / ADuration;
        Result := AChangeInValue * ACurrentTime * ACurrentTime * ACurrentTime + AStartValue;
      end;

    sfEaseOutCubic:
      begin
        ACurrentTime := (ACurrentTime / ADuration) - 1;
        Result := AChangeInValue * ( ACurrentTime * ACurrentTime * ACurrentTime + 1) + AStartValue;
      end;

    sfEaseInOutCubic:
      begin
        ACurrentTime := ACurrentTime / (ADuration/2);
        if ACurrentTime < 1 then
          Result := AChangeInValue / 2 * ACurrentTime * ACurrentTime * ACurrentTime + AStartValue
        else
        begin
          ACurrentTime := ACurrentTime - 2;
          Result := AChangeInValue / 2 * (ACurrentTime * ACurrentTime * ACurrentTime + 2) + AStartValue;
        end;
      end;

    sfEaseInQuart:
      begin
        ACurrentTime := ACurrentTime / ADuration;
        Result := AChangeInValue * ACurrentTime * ACurrentTime * ACurrentTime * ACurrentTime + AStartValue;
      end;

    sfEaseOutQuart:
      begin
        ACurrentTime := (ACurrentTime / ADuration) - 1;
        Result := -AChangeInValue * (ACurrentTime * ACurrentTime * ACurrentTime * ACurrentTime - 1) + AStartValue;
      end;

    sfEaseInOutQuart:
      begin
        ACurrentTime := ACurrentTime / (ADuration / 2);
        if ACurrentTime < 1 then
          Result := AChangeInValue / 2 * ACurrentTime * ACurrentTime * ACurrentTime * ACurrentTime + AStartValue
        else
        begin
          ACurrentTime := ACurrentTime - 2;
          Result := -AChangeInValue / 2 * (ACurrentTime * ACurrentTime * ACurrentTime * ACurrentTime - 2) + AStartValue;
        end;
      end;

    sfEaseInQuint:
      begin
        ACurrentTime := ACurrentTime / ADuration;
        Result := AChangeInValue * ACurrentTime * ACurrentTime * ACurrentTime * ACurrentTime * ACurrentTime + AStartValue;
      end;

    sfEaseOutQuint:
      begin
        ACurrentTime := (ACurrentTime / ADuration) - 1;
        Result := AChangeInValue * (ACurrentTime * ACurrentTime * ACurrentTime * ACurrentTime * ACurrentTime + 1) + AStartValue;
      end;

    sfEaseInOutQuint:
      begin
        ACurrentTime := ACurrentTime / (ADuration / 2);
        if ACurrentTime < 1 then
          Result := AChangeInValue / 2 * ACurrentTime * ACurrentTime * ACurrentTime * ACurrentTime * ACurrentTime + AStartValue
        else
        begin
          ACurrentTime := ACurrentTime - 2;
          Result := AChangeInValue / 2 * (ACurrentTime * ACurrentTime * ACurrentTime * ACurrentTime * ACurrentTime + 2) + AStartValue;
        end;
      end;

    sfEaseInSine:
      begin
        Result := -AChangeInValue * Cos(ACurrentTime / ADuration * (PI / 2)) + AChangeInValue + AStartValue;
      end;

    sfEaseOutSine:
      begin
        Result := AChangeInValue * Sin(ACurrentTime / ADuration * (PI / 2)) + AStartValue;
      end;

    sfEaseInOutSine:
      begin
        Result := -AChangeInValue / 2 * (Cos(PI * ACurrentTime / ADuration) - 1) + AStartValue;
      end;

    sfEaseInExpo:
      begin
        Result := AChangeInValue * Power(2, 10 * (ACurrentTime/ADuration - 1) ) + AStartValue;
      end;

    sfEaseOutExpo:
      begin
        Result := AChangeInValue * (-Power(2, -10 * ACurrentTime / ADuration ) + 1 ) + AStartValue;
      end;

    sfEaseInOutExpo:
      begin
        ACurrentTime := ACurrentTime / (ADuration/2);
        if ACurrentTime < 1 then
          Result := AChangeInValue / 2 * Power(2, 10 * (ACurrentTime - 1) ) + AStartValue
        else
         begin
           ACurrentTime := ACurrentTime - 1;
           Result := AChangeInValue / 2 * (-Power(2, -10 * ACurrentTime) + 2 ) + AStartValue;
         end;
      end;

    sfEaseInCircle:
      begin
        ACurrentTime := ACurrentTime / ADuration;
        Result := -AChangeInValue * (Sqrt(1 - ACurrentTime * ACurrentTime) - 1) + AStartValue;
      end;

    sfEaseOutCircle:
      begin
        ACurrentTime := (ACurrentTime / ADuration) - 1;
        Result := AChangeInValue * Sqrt(1 - ACurrentTime * ACurrentTime) + AStartValue;
      end;

    sfEaseInOutCircle:
      begin
        ACurrentTime := ACurrentTime / (ADuration / 2);
        if ACurrentTime < 1 then
          Result := -AChangeInValue / 2 * (Sqrt(1 - ACurrentTime * ACurrentTime) - 1) + AStartValue
        else
        begin
          ACurrentTime := ACurrentTime - 2;
          Result := AChangeInValue / 2 * (Sqrt(1 - ACurrentTime * ACurrentTime) + 1) + AStartValue;
        end;
      end;
  end;
end;

function  sfEase_position(AStartPos: Double; AEndPos: Double; ACurrentPos: Double; AEaseType: UInt32): Double;
var
  LT, LB, LC, LD: Double;
begin
  LC := AEndPos - AStartPos;
  LD := 100;
  LT := ACurrentPos;
  LB := AStartPos;
  Result := sfEase_Value(LT, LB, LC, LD, AEaseType);
  if Result > 100 then
    Result := 100;
end;

function  sfCollision_oBBIntersect(const AObbA, AObbB: sfOBB): Boolean;
var
  LAxes: array[0..3] of sfPoint;
  I: Integer;
  LProjA, LProjB: sfPoint;

  function Dot(const A, B: sfPoint): Single;
  begin
    Result := A.x * B.x + A.y * B.y;
  end;

  function Rotate(const V: sfPoint; AAngle: Single): sfPoint;
  var
    s, c: Single;
    LAngle: Cardinal;
  begin
    LAngle := Abs(Round(AAngle));
    s := sfAngle_sin(LAngle);
    c := sfAngle_cos(LAngle);
    Result.x := V.x * c - V.y * s;
    Result.y := V.x * s + V.y * c;
  end;

  function Project(const AObb: sfOBB; const AAxis: sfPoint): sfPoint;
  var
    LCorners: array[0..3] of sfPoint;
    I: Integer;
    LDot: Single;
  begin
    LCorners[0] := Rotate(sfPoint_create(AObb.Extents.x, AObb.Extents.y), AObb.Rotation);
    LCorners[1] := Rotate(sfPoint_create(-AObb.Extents.x, AObb.Extents.y), AObb.Rotation);
    LCorners[2] := Rotate(sfPoint_create(AObb.Extents.x, -AObb.Extents.y), AObb.Rotation);
    LCorners[3] := Rotate(sfPoint_create(-AObb.Extents.x, -AObb.Extents.y), AObb.Rotation);

    Result.x := Dot(AAxis, sfPoint_create(AObb.Center.x + LCorners[0].x, AObb.Center.y + LCorners[0].y));
    Result.y := Result.x;

    for I := 1 to 3 do
    begin
      LDot := Dot(AAxis, sfPoint_create(AObb.Center.x + LCorners[I].x, AObb.Center.y + LCorners[I].y));
      if LDot < Result.x then Result.x := LDot;
      if LDot > Result.y then Result.y := LDot;
    end;
  end;


begin
  LAxes[0] := Rotate(sfPoint_create(1, 0), AObbA.Rotation);
  LAxes[1] := Rotate(sfPoint_create(0, 1), AObbA.Rotation);
  LAxes[2] := Rotate(sfPoint_create(1, 0), AObbB.Rotation);
  LAxes[3] := Rotate(sfPoint_create(0, 1), AObbB.Rotation);

  for I := 0 to 3 do
  begin
    LProjA := Project(AObbA, LAxes[I]);
    LProjB := Project(AObbB, LAxes[I]);
    if (LProjA.y < LProjB.x) or (LProjB.y < LProjA.x) then Exit(False);
  end;

  Result := True;
end;

function  sfUnit_toScalarValue(const AValue, AMaxValue: Double): Double;
var
  LGain: Double;
  LFactor: Double;
  LVolume: Double;
begin
  LGain := (EnsureRange(AValue, 0.0, 1.0) * 50) - 50;
  LFactor := Power(10, LGain * 0.05);
  LVolume := EnsureRange(AMaxValue * LFactor, 0, AMaxValue);
  Result := LVolume;
end;

{$ENDREGION}

{$REGION ' Pyro.Audio '}
type
  { TsfAudio }
  TsfAudio = record
  type
    { TMusicItem }
    TMusicItem = record
      Handle: PsfMusic;
      Stream: PsfInputStreamEx;
      Size: Int64;
      Filename: string;
    end;

    { TAudioChannel }
    TAudioChannel = record
      Sound: PsfSound;
      Reserved: Boolean;
      Priority: Byte;
    end;

    { TAudioBuffer }
    TAudioBuffer = record
      Buffer: PsfSoundBuffer;
      Filename: string;
    end;
  var
    FMusicList: TList<TMusicItem>;
    FBuffer: array [0 .. sfAudioBufferCount - 1] of TAudioBuffer;
    FChannel: array [0 .. sfAudioChannelCount - 1] of TAudioChannel;
    FOpened: Boolean;
  end;

var
  sfAudio: TsfAudio;

function TimeAsSeconds(aValue: Single): sfTime;
begin
  Result.MicroSeconds := Round(aValue * 1000000);
end;

function GetMusicItem(var aMusicItem: TsfAudio.TMusicItem; aMusic: Integer): Boolean;
begin
  // assume false
  Result := False;

  // check for valid music id
  if (aMusic < 0) or (aMusic > sfAudio.FMusicList.Count-1) then Exit;

  // get item
  aMusicItem := sfAudio.FMusicList.Items[aMusic];

  // check if valid
  if aMusicItem.Handle = nil then
    Result := False
  else
    // return true
    Result := True;
end;

function AddMusicItem(var aMusicItem: TsfAudio.TMusicItem): Integer;
var
  LIndex: Integer;
  LItem: TsfAudio.TMusicItem;
begin
  Result := sfAudioInvalidIndex;
  for LIndex := 0 to sfAudio.FMusicList.Count-1 do
  begin
    LItem := sfAudio.FMusicList.Items[LIndex];
    if LItem.Handle = nil then
    begin
      sfAudio.FMusicList.Items[LIndex] := aMusicItem;
      Result := LIndex;
      Exit;
    end;
  end;

  if Result = sfAudioInvalidIndex then
  begin
    Result := sfAudio.FMusicList.Add(aMusicItem);
  end;
end;

function FindFreeBuffer(aFilename: string): Integer;
var
  LI: Integer;
begin
  Result := sfAudioInvalidIndex;
  for LI := 0 to sfAudioBufferCount - 1 do
  begin
    if sfAudio.FBuffer[LI].Filename = aFilename then
    begin
      Exit;
    end;

    if sfAudio.FBuffer[LI].Buffer = nil then
    begin
      Result := LI;
      Break;
    end;
  end;
end;

function FindFreeChannel: Integer;
var
  I: Integer;
begin
  Result := sfAudioInvalidIndex;
  for I := 0 to sfAudioChannelCount - 1 do
  begin
    if not Assigned(sfAudio.FChannel[I].Sound) then
      begin
        if not sfAudio.FChannel[I].Reserved then
        begin
          Result := I;
          Exit;
        end;
      end
    else
      if sfSound_getStatus(sfAudio.FChannel[I].Sound) = sfStopped then
      begin
        if not sfAudio.FChannel[I].Reserved then
        begin
          Result := I;
          Exit;
        end;
      end;
  end;
end;

procedure sfAudio_open();
var
  I: Integer;
  LVec: sfVector3f;
begin
  if sfAudio.FOpened then Exit;

  FillChar(sfAudio.FBuffer, SizeOf(sfAudio.FBuffer), 0);
  FillChar(sfAudio.FChannel, SizeOf(sfAudio.FChannel), 0);
  sfAudio.FOpened := False;

  // init music list
  sfAudio.FMusicList := TList<TsfAudio.TMusicItem>.Create;

  // init channels
  for I := 0 to sfAudioChannelCount - 1 do
  begin
    sfAudio.FChannel[I].Sound := nil;
    sfAudio.FChannel[I].Reserved := False;
    sfAudio.FChannel[I].Priority := 0;
  end;

  // init buffers
  for I := 0 to sfAudioBufferCount - 1 do
  begin
    sfAudio.FBuffer[I].Buffer := nil;
  end;

  sfListener_setGlobalVolume(100);

  LVec.X := 0; LVec.Y := 0; LVec.Z := 0;
  sfListener_setPosition(LVec);

  LVec.X := 0; LVec.Y := 0; LVec.Z := -1;
  sfListener_setDirection(LVec);

  LVec.X := 0; LVec.Y := 1; LVec.Z := 0;
  sfListener_setUpVector(LVec);

  sfAudio.FOpened := True;

end;

procedure sfAudio_close();
var
  I: Integer;
begin
  if not sfAudio.FOpened then Exit;

  // shutdown music
  sfAudio_unloadAllMusic();
  FreeAndNil(sfAudio.FMusicList);

  // shutdown channels
  for I := 0 to sfAudioChannelCount - 1 do
  begin
    if sfAudio.FChannel[I].Sound <> nil then
    begin
      sfSound_destroy(sfAudio.FChannel[I].Sound);
      sfAudio.FChannel[I].Reserved := False;
      sfAudio.FChannel[I].Priority := 0;
      sfAudio.FChannel[I].Sound := nil;
    end;
  end;

  // shutdown buffers
  for I := 0 to sfAudioBufferCount - 1 do
  begin
    if sfAudio.FBuffer[I].Buffer <> nil then
    begin
      sfSoundBuffer_destroy(sfAudio.FBuffer[I].Buffer);
      sfAudio.FBuffer[I].Buffer := nil;
    end;
  end;

  FillChar(sfAudio.FBuffer, SizeOf(sfAudio.FBuffer), 0);
  FillChar(sfAudio.FChannel, SizeOf(sfAudio.FChannel), 0);
  sfAudio.FOpened := False;

end;

procedure sfAudio_pause(aPause: Boolean);
var
  I: Integer;
begin
  if not sfAudio.FOpened then Exit;

  sfAudio_pauseAllMusic(aPause);

  // pause channel
  for I := 0 to sfAudioChannelCount - 1 do
  begin
    sfAudio_PauseChannel(I, aPause);
  end;
end;

procedure sfAudio_reset();
begin
end;

//TODO: check of music is already loaded
function sfAudio_loadMusic(var AInputStream: PsfInputStreamEx; const AFilename: string): Integer;
var
  LItem: TsfAudio.TMusicItem;
begin
  Result := sfAudioInvalidIndex;

  if not sfAudio.FOpened then
  begin
    sfInputStream_closeEx(AInputStream);
    Exit;
  end;

  if AFilename.IsEmpty then
  begin
    sfInputStream_closeEx(AInputStream);
    Exit;
  end;

  if not Assigned(AInputStream) then
  begin
    sfInputStream_closeEx(AInputStream);
    Exit;
  end;

  LItem.Stream := AInputStream;
  LItem.Handle := sfMusic_createFromStreamEx(LItem.Stream);
  if not Assigned(LItem.Handle) then
  begin
    sfInputStream_closeEx(AInputStream);
    Exit;
  end;
  LItem.Size := sfInputStream_getSizeEx(LItem.Stream);
  LItem.Filename := AFilename;

  // add to list
  Result := AddMusicItem(LItem);

  AInputStream := nil;
end;

function  sfAudio_loadMusic(const AZipFilename, AFilename: string; const APassword: string): Integer;
var
  LInputStream: PsfInputStreamEx;
begin
  Result := sfAudioInvalidIndex;
  LInputStream := sfInputStream_createFromZipFileEx(AZipFilename, AFilename, APassword);
  if not Assigned(LInputStream) then Exit;
  Result := sfAudio_loadMusic(LInputStream, AFilename);
end;

procedure sfAudio_unloadMusic(var AMusic: Integer);
var
  LItem: TsfAudio.TMusicItem;
begin
  if not sfAudio.FOpened then Exit;

  // check for valid music id
  if not GetMusicItem(LItem, AMusic) then Exit;

  // stop music
  sfAudio_stopMusic(AMusic);

  // free music handle
  sfMusic_destroy(LItem.Handle);

  // free music buffer
  if Assigned(LItem.Stream) then
    sfInputStream_closeEx(LItem.Stream);

  // clear item data
  LItem.Handle := nil;
  LItem.Size := 0;
  LItem.Stream := nil;
  LItem.Filename := '';
  sfAudio.FMusicList.Items[AMusic] := LItem;

  // return handle as invalid
  AMusic := sfAudioInvalidIndex;
end;

procedure sfAudio_unloadAllMusic();
var
  LIndex: Integer;
  LMusic: Integer;
begin
  if not sfAudio.FOpened then Exit;

  for LIndex := 0 to sfAudio.FMusicList.Count-1 do
  begin
    LMusic := LIndex;
    sfAudio_stopMusic(LMusic);
    sfAudio_unloadMusic(LMusic);
  end;
end;

procedure sfAudio_playMusic(const AMusic: Integer);
var
  LItem: TsfAudio.TMusicItem;
begin
  if not sfAudio.FOpened then Exit;

  // check for valid music id
  if not GetMusicItem(LItem, AMusic) then Exit;

  // play music
  sfMusic_play(LItem.Handle);
end;

procedure sfAudio_playMusic(const AMusic: Integer; const AVolume: Single; const ALoop: Boolean);
begin
  if not sfAudio.FOpened then Exit;
  sfAudio_playMusic(AMusic);
  sfAudio_setMusicVolume(AMusic, AVolume);
  sfAudio_setMusicLoop(AMusic, ALoop);
end;

procedure sfAudio_stopMusic(const AMusic: Integer);
var
  LItem: TsfAudio.TMusicItem;
begin
  if not sfAudio.FOpened then Exit;

  // check for valid music id
  if not GetMusicItem(LItem, AMusic) then Exit;

  // stop music playing
  sfMusic_stop(LItem.Handle);
end;

procedure sfAudio_pauseMusic(const AMusic: Integer);
var
  LItem: TsfAudio.TMusicItem;
begin
  if not sfAudio.FOpened then Exit;

  // check for valid music id
  if not GetMusicItem(LItem, AMusic) then Exit;

  // pause audio
  sfMusic_pause(LItem.Handle);
end;

procedure sfAudio_pauseAllMusic(const APause: Boolean);
var
  LItem: TsfAudio.TMusicItem;
  LIndex: Integer;
begin
  if not sfAudio.FOpened then Exit;

  for LIndex := 0 to sfAudio.FMusicList.Count-1 do
  begin
    if GetMusicItem(LItem, LIndex) then
    begin
      if APause then
        sfAudio_pauseMusic(LIndex)
      else
        sfAudio_playMusic(LIndex);
    end;
  end;
end;

procedure sfAudio_setMusicLoop(const AMusic: Integer; const ALoop: Boolean);
var
  LItem: TsfAudio.TMusicItem;
begin
  if not sfAudio.FOpened then Exit;

  // check for valid music id
  if not GetMusicItem(LItem, AMusic) then Exit;

  // set music loop status
  sfMusic_setLooping(LItem.Handle, ALoop);
end;

function sfAudio_getMusicLoop(const AMusic: Integer): Boolean;
var
  LItem: TsfAudio.TMusicItem;
begin
  Result := False;

  if not sfAudio.FOpened then Exit;

  // check for valid music id
  if not GetMusicItem(LItem, AMusic) then Exit;

  // get music loop status
  Result := sfMusic_isLooping(LItem.Handle);
end;

procedure sfAudio_setMusicVolume(const AMusic: Integer; const AVolume: Single);
var
  LVol: Single;
  LItem: TsfAudio.TMusicItem;
begin
  if not sfAudio.FOpened then Exit;

  // check for valid music id
  if not GetMusicItem(LItem, AMusic) then Exit;

  LVol := sfUnit_toScalarValue(AVolume, 100);

  // set music volume
  sfMusic_setVolume(LItem.Handle, LVol);
end;

function sfAudio_getMusicVolume(const AMusic: Integer): Single;
var
  LItem: TsfAudio.TMusicItem;
begin
  Result := 0;
  if not sfAudio.FOpened then Exit;
  if not GetMusicItem(LItem, AMusic) then Exit;
  Result := sfMusic_getVolume(LItem.Handle);
  Result := Result / 100;
end;

function sfAudio_getMusicStatus(const AMusic: Integer): sfSoundStatus;
var
  LItem: TsfAudio.TMusicItem;
begin
  Result := sfStopped;
  if not sfAudio.FOpened then Exit;
  if not GetMusicItem(LItem, AMusic) then Exit;
  Result := sfMusic_getStatus(LItem.Handle);
end;

procedure sfAudio_setMusicOffset(const AMusic: Integer; const ASeconds: Single);
var
  LItem: TsfAudio.TMusicItem;
begin
  if not sfAudio.FOpened then Exit;
  if not GetMusicItem(LItem, AMusic) then Exit;
  sfMusic_setPlayingOffset(LItem.Handle, TimeAsSeconds(ASeconds));
end;

procedure sfAudio_setChannelReserved(const AChannel: Integer; const AReserve: Boolean);
begin
  if not sfAudio.FOpened then Exit;
  if (AChannel < 0) or (AChannel > sfAudioChannelCount - 1) then Exit;
  sfAudio.FChannel[AChannel].Reserved := AReserve;
end;

function sfAudio_getChannelReserved(const AChannel: Integer): Boolean;
begin
  Result := False;
  if not sfAudio.FOpened then Exit;
  if (AChannel < 0) or (AChannel > sfAudioChannelCount - 1) then  Exit;
  Result := sfAudio.FChannel[AChannel].Reserved;
end;

function sfAudio_loadSound(var AInputStream: PsfInputStreamEx; const AFilename: string): Integer;
var
  I: Integer;
begin
  Result := sfAudioInvalidIndex;
   if not sfAudio.FOpened then
   begin
     sfInputStream_closeEx(AInputStream);
     Exit;
   end;

  if AFilename.IsEmpty then
  begin
     sfInputStream_closeEx(AInputStream);
    Exit;
  end;

  if not Assigned(AInputStream) then
  begin
     sfInputStream_closeEx(AInputStream);
    Exit;
  end;

  I := FindFreeBuffer(AFilename);
  if I = sfAudioInvalidIndex then
  begin
    sfInputStream_closeEx(AInputStream);
    Exit;
  end;
  sfAudio.FBuffer[I].Buffer := sfSoundBuffer_createFromStreamEx(AInputStream);

  if sfAudio.FBuffer[I].Buffer = nil then
  begin
    sfInputStream_closeEx(AInputStream);
    Exit;
  end;

  sfAudio.FBuffer[I].Filename := AFilename;

  sfInputStream_closeEx(AInputStream);

  Result := I;
end;

function  sfAudio_loadSound(const AZipFilename, AFilename: string; const APassword: string): Integer;
var
  LInputStream: PsfInputStreamEx;
begin
  Result := sfAudioInvalidIndex;
  LInputStream := sfInputStream_createFromZipFileEx(AZipFilename, AFilename, APassword);
  if not Assigned(LInputStream) then Exit;
  Result := sfAudio_loadSound(LInputStream, AFilename);
end;

procedure sfAudio_unloadSound(const ASound: Integer);
var
  LBuff: PsfSoundBuffer;
  LSnd: PsfSound;
  I: Integer;
begin
  if not sfAudio.FOpened then Exit;

  if (ASound < 0) or (ASound > sfAudioBufferCount - 1) then  Exit;
  LBuff := sfAudio.FBuffer[ASound].Buffer;
  if LBuff = nil then Exit;

  // stop all channels playing this buffer
  for I := 0 to sfAudioChannelCount - 1 do
  begin
    LSnd := sfAudio.FChannel[I].Sound;
    if LSnd <> nil then
    begin
      if sfSound_getBuffer(LSnd) = LBuff then
      begin
        sfSound_stop(LSnd);
        sfSound_destroy(LSnd);
        sfAudio.FChannel[I].Sound := nil;
        sfAudio.FChannel[I].Reserved := False;
        sfAudio.FChannel[I].Priority := 0;
      end;
    end;
  end;

  // destroy this buffer
  sfSoundBuffer_destroy(LBuff);
  sfAudio.FBuffer[ASound].Buffer := nil;
  sfAudio.FBuffer[ASound].Filename := '';
end;

function sfAudio_playSound(const AChannel, ASound: Integer): Integer;
var
  I: Integer;
  LVec: sfVector3f;
begin
  Result := sfAudioInvalidIndex;
  if not sfAudio.FOpened then Exit;

  // check if sound is in range
  if (ASound < 0) or (ASound > sfAudioBufferCount - 1) then Exit;

  // check if channel is in range
  I := AChannel;
  if I = sfAudioDynamicChannel then I := FindFreeChannel
  else if (I < 0) or (I > sfAudioChannelCount - 1) then Exit;

  // play sound

  if not Assigned(sfAudio.FChannel[I].Sound) then
    sfAudio.FChannel[I].Sound := sfSound_create(sfAudio.FBuffer[ASound].Buffer)
  else
    sfSound_setBuffer(sfAudio.FChannel[I].Sound, sfAudio.FBuffer[ASound].Buffer);

  sfSound_play(sfAudio.FChannel[I].Sound);

  sfSound_setLooping(sfAudio.FChannel[I].Sound, False);
  sfSound_setPitch(sfAudio.FChannel[I].Sound, 1);
  sfSound_setVolume(sfAudio.FChannel[I].Sound, 100);

  LVec.X := 0; LVec.Y := 0; LVec.Z := 0;
  sfSound_setPosition(sfAudio.FChannel[I].Sound, LVec);

  sfSound_setRelativeToListener(sfAudio.FChannel[I].Sound, False);
  sfSound_setMinDistance(sfAudio.FChannel[I].Sound, 1);
  sfSound_setAttenuation(sfAudio.FChannel[I].Sound, 0);

  Result := I;
end;

function sfAudio_playSound(const AChannel, ASound: Integer; const AVolume: Single; const ALoop: Boolean): Integer;
begin
  Result := sfAudioInvalidIndex;
  if not sfAudio.FOpened then Exit;

  Result := sfAudio_PlaySound(AChannel, ASound);
  sfAudio_setChannelVolume(Result, AVolume);
  sfAudio_setChannelLoop(Result, ALoop);
end;

procedure sfAudio_pauseChannel(const AChannel: Integer; const APause: Boolean);
var
  LStatus: sfSoundStatus;
begin
  if not sfAudio.FOpened then Exit;
  if (AChannel < 0) or (AChannel > sfAudioChannelCount - 1) then Exit;
  if not Assigned(sfAudio.FChannel[AChannel].Sound) then Exit;

  LStatus := sfSound_getStatus(sfAudio.FChannel[AChannel].Sound);

  case APause of
    False:
      begin
        if LStatus = sfPaused then
          sfSound_play(sfAudio.FChannel[AChannel].Sound);
      end;
    True:
      begin
        if LStatus = sfPlaying then
          sfSound_pause(sfAudio.FChannel[AChannel].Sound);
      end;
  end;
end;

function sfAudio_getChannelStatus(const AChannel: Integer): sfSoundStatus;
begin
  Result := sfStopped;
  if not sfAudio.FOpened then Exit;
  if (AChannel < 0) or (AChannel > sfAudioChannelCount - 1) then Exit;
  if not Assigned(sfAudio.FChannel[AChannel].Sound) then Exit;
  Result := sfSound_getStatus(sfAudio.FChannel[AChannel].Sound);
end;

procedure sfAudio_setChannelVolume(const AChannel: Integer; const AVolume: Single);
var
  LVolume: Single;
begin
  if not sfAudio.FOpened then Exit;
  if (AChannel < 0) or (AChannel > sfAudioChannelCount - 1) then Exit;
  if not Assigned(sfAudio.FChannel[AChannel].Sound) then Exit;

  LVolume := sfUnit_toScalarValue(AVolume, 100);

  sfSound_setVolume(sfAudio.FChannel[AChannel].Sound, LVolume);
end;

function sfAudio_getChannelVolume(const AChannel: Integer): Single;
begin
  Result := 0;
  if not sfAudio.FOpened then Exit;
  if (AChannel < 0) or (AChannel > sfAudioChannelCount - 1) then Exit;
  if not Assigned(sfAudio.FChannel[AChannel].Sound) then Exit;

  Result := sfSound_getVolume(sfAudio.FChannel[AChannel].Sound);
  Result := Result / 100;
end;

procedure sfAudio_setChannelLoop(const AChannel: Integer; const ALoop: Boolean);
begin
  if not sfAudio.FOpened then Exit;
  if (AChannel < 0) or (AChannel > sfAudioChannelCount - 1) then Exit;
  if not Assigned(sfAudio.FChannel[AChannel].Sound) then Exit;

  sfSound_setLooping(sfAudio.FChannel[AChannel].Sound, ALoop);
end;

function sfAudio_getChannelLoop(const AChannel: Integer): Boolean;
begin
  Result := False;
  if not sfAudio.FOpened then Exit;
  if (AChannel < 0) or (AChannel > sfAudioChannelCount - 1) then Exit;
  if not Assigned(sfAudio.FChannel[AChannel].Sound) then Exit;

  Result := sfSound_isLooping(sfAudio.FChannel[AChannel].Sound);
end;

procedure sfAudio_setChannelPitch(const AChannel: Integer; const APitch: Single);
begin
  if not sfAudio.FOpened then Exit;
  if (AChannel < 0) or (AChannel > sfAudioChannelCount - 1) then Exit;
  if not Assigned(sfAudio.FChannel[AChannel].Sound) then Exit;

  sfSound_setPitch(sfAudio.FChannel[AChannel].Sound, APitch);
end;

function sfAudio_getChannelPitch(const AChannel: Integer): Single;
begin
  Result := 0;
  if not sfAudio.FOpened then Exit;
  if (AChannel < 0) or (AChannel > sfAudioChannelCount - 1) then  Exit;
  if not Assigned(sfAudio.FChannel[AChannel].Sound) then Exit;

  Result := sfSound_getPitch(sfAudio.FChannel[AChannel].Sound);
end;

procedure sfAudio_setChannelPosition(const AChannel: Integer; const X, Y: Single);
var
  LVec: sfVector3f;
begin
  if not sfAudio.FOpened then Exit;
  if (AChannel < 0) or (AChannel > sfAudioChannelCount - 1) then Exit;
  if not Assigned(sfAudio.FChannel[AChannel].Sound) then Exit;

  LVec.X := X;
  LVec.Y := 0;
  LVec.Z := Y;
  sfSound_setPosition(sfAudio.FChannel[AChannel].Sound, LVec);
end;

procedure sfAudio_getChannelPosition(const AChannel: Integer; var X: Single; var Y: Single);
var
  LVec: sfVector3f;
begin
  if not sfAudio.FOpened then Exit;
  if (AChannel < 0) or (AChannel > sfAudioChannelCount - 1) then Exit;
  if not Assigned(sfAudio.FChannel[AChannel].Sound) then Exit;

  LVec := sfSound_getPosition(sfAudio.FChannel[AChannel].Sound);
  X := LVec.X;
  Y := LVec.Z;
end;

procedure sfAudio_setChannelMinDistance(const AChannel: Integer; const ADistance: Single);
var
  LDistance: Single;
begin
  if not sfAudio.FOpened then Exit;
  if (AChannel < 0) or (AChannel > sfAudioChannelCount - 1) then Exit;
  LDistance := ADistance;
  if LDistance < 1 then  LDistance := 1;
  if not Assigned(sfAudio.FChannel[AChannel].Sound) then Exit;
  sfSound_setMinDistance(sfAudio.FChannel[AChannel].Sound, LDistance);
end;

function sfAudio_getChannelMinDistance(const AChannel: Integer): Single;
begin
  Result := 0;
  if not sfAudio.FOpened then Exit;
  if (AChannel < 0) or (AChannel > sfAudioChannelCount - 1) then Exit;
  if not Assigned(sfAudio.FChannel[AChannel].Sound) then Exit;
  Result := sfSound_getMinDistance(sfAudio.FChannel[AChannel].Sound);
end;

procedure sfAudio_setChannelRelativeToListener(const AChannel: Integer; const ARelative: Boolean);
begin
  if not sfAudio.FOpened then Exit;
  if (AChannel < 0) or (AChannel > sfAudioChannelCount - 1) then Exit;
  if not Assigned(sfAudio.FChannel[AChannel].Sound) then Exit;
  sfSound_setRelativeToListener(sfAudio.FChannel[AChannel].Sound, ARelative);
end;

function sfAudio_getChannelRelativeToListener(const AChannel: Integer): Boolean;
begin
  Result := False;
  if not sfAudio.FOpened then Exit;
  if (AChannel < 0) or (AChannel > sfAudioChannelCount - 1) then Exit;
  if not Assigned(sfAudio.FChannel[AChannel].Sound) then Exit;
  Result := Boolean(sfSound_isRelativeToListener(sfAudio.FChannel[AChannel].Sound));
end;

procedure sfAudio_setChannelAttenuation(const AChannel: Integer; const AAttenuation: Single);
begin
  if not sfAudio.FOpened then Exit;
  if (AChannel < 0) or (AChannel > sfAudioChannelCount - 1) then  Exit;
  if not Assigned(sfAudio.FChannel[AChannel].Sound) then Exit;
  sfSound_setAttenuation(sfAudio.FChannel[AChannel].Sound, AAttenuation);
end;

function sfAudio_getChannelAttenuation(const AChannel: Integer): Single;
begin
  Result := 0;
  if not sfAudio.FOpened then Exit;
  if (AChannel < 0) or (AChannel > sfAudioChannelCount - 1) then Exit;
  if not Assigned(sfAudio.FChannel[AChannel].Sound) then Exit;
  Result := sfSound_getAttenuation(sfAudio.FChannel[AChannel].Sound);
end;

procedure sfAudio_stopChannel(const AChannel: Integer);
begin
  if not sfAudio.FOpened then Exit;
  if (AChannel < 0) or (AChannel > sfAudioChannelCount - 1) then Exit;
  if not Assigned(sfAudio.FChannel[AChannel].Sound) then Exit;
  sfSound_stop(sfAudio.FChannel[AChannel].Sound);
end;

procedure sfAudio_stopAllChannels;
var
  I: Integer;
begin
  if not sfAudio.FOpened then Exit;
  for I := 0 to sfAudioChannelCount-1 do
  begin
    if Assigned(sfAudio.FChannel[I].Sound) then
      sfSound_stop(sfAudio.FChannel[I].Sound);
  end;
end;

procedure sfAudio_setListenerGlobalVolume(const AVolume: Single);
var
  LVolume: Single;
begin
  if not sfAudio.FOpened then Exit;

  LVolume := sfUnit_toScalarValue(AVolume, 100);

  sfListener_setGlobalVolume(LVolume);
end;

function sfAudio_getListenerGlobalVolume: Single;
begin
  Result := 0;
  if not sfAudio.FOpened then Exit;
  Result := sfListener_getGlobalVolume();
  Result := Result / 100;
end;

procedure sfAudio_setListenerPosition(const X, Y: Single);
var
  LVec: sfVector3f;
begin
  if not sfAudio.FOpened then Exit;
  LVec.X := X;
  LVec.Y := 0;
  LVec.Z := Y;
  sfListener_setPosition(LVec);
end;

procedure sfAudio_getListenerPosition(var X: Single; var Y: Single);
var
  LVec: sfVector3f;
begin
  if not sfAudio.FOpened then Exit;
  LVec := sfListener_getPosition;
  X := LVec.X;
  Y := LVec.Z;
end;

{$ENDREGION}

{$REGION ' Pyro.Lua '}
{ compatibility }
function lua_istable(L: Plua_State; N: Integer): Boolean;
begin
  Result := lua_type(L, N) = LUA_TTABLE;
end;

function lua_isfunction(aState: Pointer; n: Integer): Boolean;
begin
  Result := Boolean(lua_type(aState, n) = LUA_TFUNCTION);
end;

function lua_isvariable(aState: Pointer; n: Integer): Boolean;
var
  aType: Integer;
begin
  aType := lua_type(aState, n);

  if (aType = LUA_TBOOLEAN) or (aType = LUA_TLIGHTUSERDATA) or (aType = LUA_TNUMBER) or (aType = LUA_TSTRING) then
    Result := True
  else
    Result := False;
end;

procedure lua_newtable(aState: Pointer);
begin
  lua_createtable(aState, 0, 0);
end;

procedure lua_pop(aState: Pointer; n: Integer);
begin
  lua_settop(aState, -n - 1);
end;

function lua_getglobal(L: Plua_State; const AName: PAnsiChar): Integer;
begin
  // Get the value directly from the globals table
  lua_getfield(L, LUA_GLOBALSINDEX, AName);

  // Return the type of the value
  Result := lua_type(L, -1);
end;

procedure lua_setglobal(aState: Pointer; aName: PAnsiChar);
begin
  lua_setfield(aState, LUA_GLOBALSINDEX, aName);
end;

procedure lua_pushcfunction(aState: Pointer; aFunc: lua_CFunction);
begin
  lua_pushcclosure(aState, aFunc, 0);
end;

function lua_isnil(aState: Pointer; n: Integer): Boolean;
begin
  Result := Boolean(lua_type(aState, n) = LUA_TNIL);
end;

function lua_tostring(aState: Pointer; idx: Integer): string;
begin
  Result := string(lua_tolstring(aState, idx, nil));
end;

function luaL_dofile(aState: Pointer; aFilename: PAnsiChar): Integer;
Var
  Res: Integer;
begin
  Res := luaL_loadfile(aState, aFilename);
  if Res = 0 then
    Res := lua_pcall(aState, 0, 0, 0);
  Result := Res;
end;

function luaL_dostring(aState: Pointer; aStr: PAnsiChar): Integer;
Var
  Res: Integer;
begin
  Res := luaL_loadstring(aState, aStr);
  if Res = 0 then
    Res := lua_pcall(aState, 0, 0, 0);
  Result := Res;
end;

function luaL_dobuffer(aState: Pointer; aBuffer: Pointer; aSize: NativeUInt;
  aName: PAnsiChar): Integer;
var
  Res: Integer;
begin
  Res := luaL_loadbuffer(aState, aBuffer, aSize, aName);
  if Res = 0 then
    Res := lua_pcall(aState, 0, 0, 0);
  Result := Res;
end;

function lua_upvalueindex(i: Integer): Integer;
begin
  Result := LUA_GLOBALSINDEX - i;
end;

function luaL_checkstring(L: Plua_State; n: Integer): PAnsiChar;
begin
  Result := luaL_checklstring(L, n, nil);
end;

procedure luaL_requiref(L: Plua_State; modname: PAnsiChar; openf: lua_CFunction; glb: Integer);
begin
  lua_pushcfunction(L, openf);  // Push the module loader function
  lua_pushstring(L, modname);   // Push module name as argument

  // Use pcall instead of call for error handling
  if lua_pcall(L, 1, 1, 0) <> 0 then
  begin
    // Get error message and raise
    raise ELuaException.CreateFmt('Error loading module "%s": %s',
      [modname, string(lua_tostring(L, -1))]);
  end;

  // Get _LOADED table from registry
  lua_getfield(L, LUA_REGISTRYINDEX, '_LOADED');
  if not lua_istable(L, -1) then
  begin
    lua_pop(L, 2);  // Pop module and non-table value
    raise ELuaException.Create('_LOADED is not a table');
  end;

  // Store module in _LOADED[modname]
  lua_pushvalue(L, -2);        // Copy the module
  lua_setfield(L, -2, modname);
  lua_pop(L, 1);              // Pop _LOADED table

  // If global is requested, set it
  if glb <> 0 then
  begin
    lua_pushvalue(L, -1);     // Copy the module again
    lua_setglobal(L, modname);
  end;
end;

function luaL_getmetatable(L: Plua_State; const ATableName: PAnsiChar): Boolean;
begin
  // Get the metatable directly from the registry
  lua_getfield(L, LUA_REGISTRYINDEX, ATableName);

  // Check if the field exists and is a table
  Result := lua_type(L, -1) = LUA_TTABLE;
  if not Result then
    lua_pop(L, 1); // Remove the nil value from the stack if not found
end;

procedure lua_updateargs(L: Plua_State; StartIndex: Integer);
var
  I: Integer;
begin
  // Delete the existing 'arg' table by assigning nil to it
  lua_pushnil(L);
  lua_setglobal(L, 'arg');

  // Create a new 'arg' table
  lua_newtable(L);

  // Populate the 'arg' table starting from StartIndex
  for I := StartIndex to ParamCount do
  begin
    lua_pushstring(L, PAnsiChar(UTF8Encode(ParamStr(I)))); // Push each argument as UTF-8 string
    lua_rawseti(L, -2, I - StartIndex);                    // Set table index (starting from 0)
  end;

  // Assign the new table to the global 'arg'
  lua_setglobal(L, 'arg');
end;

{$HINTS OFF}
function LuaPanic(L: Plua_State): Integer; cdecl;
begin
  // Get the error message from the Lua stack
  if LongBool(lua_isstring(L, -1)) then
    raise ELuaException.Create('Lua panic: ' + string(lua_tostring(L, -1)))
  else
    raise ELuaException.Create('Lua panic occurred without error message.');

  // Return value to conform to the Lua API; this will not be executed
  Result := 0;
end;
{$HINTS ON}

const
  DEBUGGER_LUA =
'''
--[[---------------------------------------------------------------------------
Acknowledgment:
   This code is based on the original debugger.lua project by
   slembcke, available at:
     https://github.com/slembcke/debugger.lua
   Credit goes to the original developer for their foundational work, which
   this unit builds upon.
-----------------------------------------------------------------------------]]

local dbg = {}

-- ANSI Colors
local COLOR_GRAY = string.char(27) .. "[90m"
local COLOR_RED = string.char(27) .. "[91m"
local COLOR_BLUE = string.char(27) .. "[94m"
local COLOR_YELLOW = string.char(27) .. "[33m"
local COLOR_RESET = string.char(27) .. "[0m"
local GREEN_CARET = string.char(27) .. "[92m => " .. COLOR_RESET

-- Check for Windows
local function is_windows()
    return package.config:sub(1,1) == '\\'
end

-- Check if colors are supported
local function supports_colors()
    if is_windows() then
        -- Windows 10+ supports ANSI colors
        local version = os.getenv("WINVER") or os.getenv("VERSION")
        return version ~= nil
    else
        -- Unix-like systems
        return os.getenv("TERM") and os.getenv("TERM") ~= "dumb"
    end
end

-- Disable colors if terminal doesn't support them
if not supports_colors then
    COLOR_GRAY = ""
    COLOR_RED = ""
    COLOR_BLUE = ""
    COLOR_YELLOW = ""
    COLOR_RESET = ""
    GREEN_CARET = " => "
end

-- State tracking
local current_frame = 0
local step_mode = nil
local current_func = nil
local last_cmd = "h"  -- Move last_cmd to file scope

-- Source cache
local source_cache = {}

local function pretty(obj, max_depth)
    max_depth = max_depth or 3
    local function pp(obj, depth)
        if depth > max_depth then return tostring(obj) end
        if type(obj) == "string" then return string.format("%q", obj) end
        if type(obj) ~= "table" then return tostring(obj) end
        local mt = getmetatable(obj)
        if mt and mt.__tostring then return tostring(obj) end

        local parts = {}
        for k, v in pairs(obj) do
            local key = type(k) == "string" and k or "[" .. pp(k, depth) .. "]"
            table.insert(parts, key .. " = " .. pp(v, depth + 1))
        end
        return "{" .. table.concat(parts, ", ") .. "}"
    end
    return pp(obj, 1)
end

local function get_locals(level)
    local vars = {}
    local i = 1
    while true do
        local name, value = debug.getlocal(level, i)
        if not name then break end
        if name:sub(1, 1) ~= "(" then  -- Skip internal variables
            vars[name] = value
        end
        i = i + 1
    end
    return vars
end

local function get_upvalues(func)
    local vars = {}
    local i = 1
    while true do
        local name, value = debug.getupvalue(func, i)
        if not name then break end
        vars[name] = value
        i = i + 1
    end
    return vars
end

local function get_source_lines(info)
    if source_cache[info.source] then
        return source_cache[info.source]
    end

    local lines = {}
    if info.source:sub(1, 1) == "@" then
        local file = io.open(info.source:sub(2))
        if file then
            for line in file:lines() do
                table.insert(lines, line)
            end
            file:close()
        end
    else
        for line in info.source:gmatch("[^\n]+") do
            table.insert(lines, line)
        end
    end
    source_cache[info.source] = lines
    return lines
end

local function get_short_src(source)
    if source:sub(1, 1) == "@" then
        return source:sub(2)  -- Remove @ prefix
    end
    -- For non-file sources, return just "[string]"
    return "[string]"
end

local function print_break_location(info, reason)
    reason = reason or "dbg()"
    local short_src = get_short_src(info.source)
    local prefix = reason and (COLOR_YELLOW .. "break via " .. COLOR_RED .. reason .. GREEN_CARET) or ""
    print(string.format("%s%s%s:%s%d%s in %s",
        prefix,
        COLOR_BLUE, short_src,
        COLOR_YELLOW, info.currentline,
        COLOR_RESET,
        info.name or "main chunk"
    ))
end

local function print_frame_source(info, context_lines)
    context_lines = context_lines or 2
    local lines = get_source_lines(info)
    if not lines then return end

    local line_num = info.currentline
    for i = math.max(1, line_num - context_lines),
             math.min(#lines, line_num + context_lines) do
        local marker = i == line_num and GREEN_CARET or "    "
        print(string.format(COLOR_GRAY .. "% 4d%s%s",
            i, marker, lines[i] .. COLOR_RESET))
    end
end

local function evaluate_expression(expr, level)
    if not expr or expr == "" then
        print(COLOR_RED .. "Usage: p <expression>" .. COLOR_RESET)
        return
    end

    local locals = get_locals(level)
    local info = debug.getinfo(level, "f")
    local upvalues = get_upvalues(info.func)

    -- Create environment with locals, upvalues, and globals
    local env = setmetatable(locals, {__index = _G})
    for k, v in pairs(upvalues) do env[k] = v end

    local chunk, err = load("return " .. expr, "=expr", "t", env)
    if not chunk then
        print(COLOR_RED .. "Error: " .. err .. COLOR_RESET)
        return
    end

    local success, result = pcall(chunk)
    if not success then
        print(COLOR_RED .. "Error: " .. result .. COLOR_RESET)
        return
    end

    print(COLOR_BLUE .. expr .. GREEN_CARET .. pretty(result))
end

local function print_locals(level)
    local locals = get_locals(level)
    local info = debug.getinfo(level, "f")
    local upvalues = get_upvalues(info.func)

    print(COLOR_BLUE .. "Local variables:" .. COLOR_RESET)
    local sorted_locals = {}
    for name, value in pairs(locals) do
        table.insert(sorted_locals, {name = name, value = value})
    end
    table.sort(sorted_locals, function(a, b) return a.name < b.name end)

    for _, var in ipairs(sorted_locals) do
        print(string.format("  %s = %s", var.name, pretty(var.value)))
    end

    if next(upvalues) then
        print(COLOR_BLUE .. "\nUpvalues:" .. COLOR_RESET)
        local sorted_upvalues = {}
        for name, value in pairs(upvalues) do
            table.insert(sorted_upvalues, {name = name, value = value})
        end
        table.sort(sorted_upvalues, function(a, b) return a.name < b.name end)

        for _, var in ipairs(sorted_upvalues) do
            print(string.format("  %s = %s", var.name, pretty(var.value)))
        end
    end
end

local function print_help()
    local help = {
        {cmd = "<return>", desc = "re-run last command"},
        {cmd = "c(ontinue)", desc = "continue execution"},
        {cmd = "s(tep)", desc = "step forward by one line (into functions)"},
        {cmd = "n(ext)", desc = "step forward by one line (skipping over functions)"},
        {cmd = "f(inish)", desc = "step forward until exiting the current function"},
        {cmd = "u(p)", desc = "move up the stack by one frame"},
        {cmd = "d(own)", desc = "move down the stack by one frame"},
        {cmd = "w(here) [count]", desc = "print source code around the current line"},
        {cmd = "p(rint) [expr]", desc = "evaluate expression and print the result"},
        {cmd = "t(race)", desc = "print the stack trace"},
        {cmd = "l(ocals)", desc = "print the function arguments, locals and upvalues"},
        {cmd = "h(elp)", desc = "print this message"},
        {cmd = "q(uit)", desc = "halt execution"},
    }

    for _, item in ipairs(help) do
        print(string.format("%s%s%s%s%s",
            COLOR_BLUE, item.cmd,
            COLOR_YELLOW, GREEN_CARET, item.desc))
    end
end

local function print_stack_trace()
    local level = 1
    print(COLOR_BLUE .. "Stack trace:" .. COLOR_RESET)
    while true do
        local info = debug.getinfo(level, "Snl")
        if not info then break end

        local is_current = level == current_frame + 2
        local marker = is_current and GREEN_CARET or "    "
        local name = info.name or "<unknown>"
        local source = get_short_src(info.source)

        print(string.format(COLOR_GRAY .. "% 4d%s%s:%d in %s",
            level - 1, marker, source, info.currentline, name))

        level = level + 1
    end
end

-- Debug hook
local function debug_hook(event, line)

    if event ~= "line" then return end

    if step_mode == "over" and current_func then
        local info = debug.getinfo(2, "f")
        if info.func ~= current_func then return end
    end

    local info = debug.getinfo(2, "Snl")
    if not info then return end

    print_break_location(info)
    print_frame_source(info)

    while true do
        io.write(COLOR_RED .. "dbg> " .. COLOR_RESET)
        local input = io.read()
        if not input then return end

        -- Handle empty input - reuse last command
        if input == "" then
            input = last_cmd
        else
            last_cmd = input  -- Update last_cmd only for non-empty input
        end

        local cmd, args = input:match("^(%S+)%s*(.*)")
        cmd = cmd or ""

        if cmd == "c" then
            step_mode = nil
            debug.sethook()
            return
        elseif cmd == "s" then
            step_mode = "into"
            return
        elseif cmd == "n" then
            step_mode = "over"
            current_func = debug.getinfo(2, "f").func
            return
        elseif cmd == "f" then
            step_mode = "out"
            current_func = debug.getinfo(2, "f").func
            return
        elseif cmd == "l" then
            print_locals(2 + current_frame)
        elseif cmd == "t" then
            print_stack_trace()
        elseif cmd == "w" then
            local count = tonumber(args) or 5
            print_frame_source(info, count)
        elseif cmd == "u" then
            local new_frame = current_frame + 1
            local frame_info = debug.getinfo(new_frame + 2, "Snl")
            if frame_info then
                current_frame = new_frame
                print_break_location(frame_info)
                print_frame_source(frame_info)
            else
                print("Already at top of stack")
            end
        elseif cmd == "d" then
            if current_frame > 0 then
                current_frame = current_frame - 1
                local frame_info = debug.getinfo(current_frame + 2, "Snl")
                print_break_location(frame_info)
                print_frame_source(frame_info)
            else
                print("Already at bottom of stack")
            end
        elseif cmd == "p" then
            evaluate_expression(args, 2 + current_frame)
        elseif cmd == "h" then
            print_help()
        elseif cmd == "q" then
            os.exit(0)
        else
            print(COLOR_RED .. "Unknown command. Type 'h' for help." .. COLOR_RESET)
        end
    end
end

-- Make dbg callable
setmetatable(dbg, {
    __call = function(_, condition)
        if condition then return end
        current_frame = 0
        step_mode = "into"
        debug.sethook(debug_hook, "l")
    end
})

-- Expose API
dbg.pretty = pretty
dbg.pretty_depth = 3
dbg.auto_where = false

return dbg
''';

function luaopen_debugger(lua: Plua_State): Integer; cdecl;
begin
  if (luaL_loadbufferx(lua, DEBUGGER_LUA, Length(DEBUGGER_LUA), '<debugger.lua>', nil) <> 0) or
     (lua_pcall(lua, 0, LUA_MULTRET, 0) <> 0) then
    lua_error(lua);
  Result := 1;
end;

const
  MODULE_NAME: PAnsiChar = 'DEBUGGER_LUA_MODULE';
  MSGH: PAnsiChar = 'DEBUGGER_LUA_MSGH';

procedure dbg_setup(lua: Plua_State; name: PAnsiChar; globalName: PAnsiChar; readFunc: lua_CFunction; writeFunc: lua_CFunction); cdecl;
begin
  // Check that the module name was not already defined.
  lua_getfield(lua, LUA_REGISTRYINDEX, MODULE_NAME);
  Assert(lua_isnil(lua, -1) or (System.AnsiStrings.StrComp(name, luaL_checkstring(lua, -1)) = 0));
  lua_pop(lua, 1);

  // Push the module name into the registry.
  lua_pushstring(lua, name);
  lua_setfield(lua, LUA_REGISTRYINDEX, MODULE_NAME);

  // Preload the module
  luaL_requiref(lua, name, luaopen_debugger, 0);

  // Insert the msgh function into the registry.
  lua_getfield(lua, -1, 'msgh');
  lua_setfield(lua, LUA_REGISTRYINDEX, MSGH);

  if Assigned(readFunc) then
  begin
    lua_pushcfunction(lua, readFunc);
    lua_setfield(lua, -2, 'read');
  end;

  if Assigned(writeFunc) then
  begin
    lua_pushcfunction(lua, writeFunc);
    lua_setfield(lua, -2, 'write');
  end;

  if globalName <> nil then
  begin
    lua_setglobal(lua, globalName);
  end else
  begin
    lua_pop(lua, 1);
  end;
end;

procedure dbg_setup_default(lua: Plua_State); cdecl;
begin
  dbg_setup(lua, 'debugger', 'dbg', nil, nil);
end;

function dbg_pcall(lua: Plua_State; nargs: Integer; nresults: Integer; msgh: Integer): Integer; cdecl;
begin
  // Call regular lua_pcall() if a message handler is provided.
  if msgh <> 0 then
    Exit(lua_pcall(lua, nargs, nresults, msgh));

  // Grab the msgh function out of the registry.
  lua_getfield(lua, LUA_REGISTRYINDEX, PUTF8Char(MSGH));
  if lua_isnil(lua, -1) then
    luaL_error(lua, 'Tried to call dbg_call() before calling dbg_setup().');

  // Move the error handler just below the function.
  msgh := lua_gettop(lua) - (1 + nargs);
  lua_insert(lua, msgh);

  // Call the function.
  Result := lua_pcall(lua, nargs, nresults, msgh);

  // Remove the debug handler.
  lua_remove(lua, msgh);
end;

function dbg_dofile(lua: Plua_State; filename: PAnsiChar): Integer;
begin
  Result := luaL_loadfile(lua, filename);
  if Result = 0 then
    Result := dbg_pcall(lua, 0, LUA_MULTRET, 0);
end;

const cLOADER_LUA : array[1..436] of Byte = (
$2D, $2D, $20, $55, $74, $69, $6C, $69, $74, $79, $20, $66, $75, $6E, $63, $74,
$69, $6F, $6E, $20, $66, $6F, $72, $20, $68, $61, $76, $69, $6E, $67, $20, $61,
$20, $77, $6F, $72, $6B, $69, $6E, $67, $20, $69, $6D, $70, $6F, $72, $74, $20,
$66, $75, $6E, $63, $74, $69, $6F, $6E, $0A, $2D, $2D, $20, $46, $65, $65, $6C,
$20, $66, $72, $65, $65, $20, $74, $6F, $20, $75, $73, $65, $20, $69, $74, $20,
$69, $6E, $20, $79, $6F, $75, $72, $20, $6F, $77, $6E, $20, $70, $72, $6F, $6A,
$65, $63, $74, $73, $0A, $28, $66, $75, $6E, $63, $74, $69, $6F, $6E, $28, $29,
$0A, $20, $20, $20, $20, $6C, $6F, $63, $61, $6C, $20, $73, $63, $72, $69, $70,
$74, $5F, $63, $61, $63, $68, $65, $20, $3D, $20, $7B, $7D, $3B, $0A, $20, $20,
$20, $20, $66, $75, $6E, $63, $74, $69, $6F, $6E, $20, $69, $6D, $70, $6F, $72,
$74, $28, $6E, $61, $6D, $65, $29, $0A, $20, $20, $20, $20, $20, $20, $20, $20,
$69, $66, $20, $73, $63, $72, $69, $70, $74, $5F, $63, $61, $63, $68, $65, $5B,
$6E, $61, $6D, $65, $5D, $20, $3D, $3D, $20, $6E, $69, $6C, $20, $74, $68, $65,
$6E, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $73, $63,
$72, $69, $70, $74, $5F, $63, $61, $63, $68, $65, $5B, $6E, $61, $6D, $65, $5D,
$20, $3D, $20, $6C, $6F, $61, $64, $66, $69, $6C, $65, $28, $6E, $61, $6D, $65,
$29, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $65, $6E, $64, $0A, $20, $20,
$20, $20, $20, $20, $20, $20, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $69,
$66, $20, $73, $63, $72, $69, $70, $74, $5F, $63, $61, $63, $68, $65, $5B, $6E,
$61, $6D, $65, $5D, $20, $7E, $3D, $20, $6E, $69, $6C, $20, $74, $68, $65, $6E,
$0A, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $72, $65, $74,
$75, $72, $6E, $20, $73, $63, $72, $69, $70, $74, $5F, $63, $61, $63, $68, $65,
$5B, $6E, $61, $6D, $65, $5D, $28, $29, $0A, $20, $20, $20, $20, $20, $20, $20,
$20, $65, $6E, $64, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $65, $72, $72,
$6F, $72, $28, $22, $46, $61, $69, $6C, $65, $64, $20, $74, $6F, $20, $6C, $6F,
$61, $64, $20, $73, $63, $72, $69, $70, $74, $20, $22, $20, $2E, $2E, $20, $6E,
$61, $6D, $65, $29, $0A, $20, $20, $20, $20, $65, $6E, $64, $0A, $65, $6E, $64,
$29, $28, $29, $0A
);

const cLUABUNDLE_LUA : array[1..3478] of Byte = (
$28, $66, $75, $6E, $63, $74, $69, $6F, $6E, $28, $61, $72, $67, $73, $29, $0D,
$0A, $6C, $6F, $63, $61, $6C, $20, $6D, $6F, $64, $75, $6C, $65, $73, $20, $3D,
$20, $7B, $7D, $0D, $0A, $6D, $6F, $64, $75, $6C, $65, $73, $5B, $27, $61, $70,
$70, $2F, $62, $75, $6E, $64, $6C, $65, $5F, $6D, $61, $6E, $61, $67, $65, $72,
$2E, $6C, $75, $61, $27, $5D, $20, $3D, $20, $66, $75, $6E, $63, $74, $69, $6F,
$6E, $28, $2E, $2E, $2E, $29, $0D, $0A, $2D, $2D, $20, $43, $6C, $61, $73, $73,
$20, $66, $6F, $72, $20, $63, $6F, $6C, $6C, $65, $63, $74, $69, $6E, $67, $20,
$74, $68, $65, $20, $66, $69, $6C, $65, $27, $73, $20, $63, $6F, $6E, $74, $65,
$6E, $74, $20, $61, $6E, $64, $20, $62, $75, $69, $6C, $64, $69, $6E, $67, $20,
$61, $20, $62, $75, $6E, $64, $6C, $65, $20, $66, $69, $6C, $65, $0D, $0A, $6C,
$6F, $63, $61, $6C, $20, $73, $6F, $75, $72, $63, $65, $5F, $70, $61, $72, $73,
$65, $72, $20, $3D, $20, $69, $6D, $70, $6F, $72, $74, $28, $22, $61, $70, $70,
$2F, $73, $6F, $75, $72, $63, $65, $5F, $70, $61, $72, $73, $65, $72, $2E, $6C,
$75, $61, $22, $29, $0D, $0A, $0D, $0A, $72, $65, $74, $75, $72, $6E, $20, $66,
$75, $6E, $63, $74, $69, $6F, $6E, $28, $65, $6E, $74, $72, $79, $5F, $70, $6F,
$69, $6E, $74, $29, $0D, $0A, $20, $20, $20, $20, $6C, $6F, $63, $61, $6C, $20,
$73, $65, $6C, $66, $20, $3D, $20, $7B, $7D, $0D, $0A, $20, $20, $20, $20, $6C,
$6F, $63, $61, $6C, $20, $66, $69, $6C, $65, $73, $20, $3D, $20, $7B, $7D, $0D,
$0A, $20, $20, $20, $20, $0D, $0A, $20, $20, $20, $20, $2D, $2D, $20, $53, $65,
$61, $72, $63, $68, $65, $73, $20, $74, $68, $65, $20, $67, $69, $76, $65, $6E,
$20, $66, $69, $6C, $65, $20, $72, $65, $63, $75, $72, $73, $69, $76, $65, $6C,
$79, $20, $66, $6F, $72, $20, $69, $6D, $70, $6F, $72, $74, $20, $66, $75, $6E,
$63, $74, $69, $6F, $6E, $20, $63, $61, $6C, $6C, $73, $0D, $0A, $20, $20, $20,
$20, $73, $65, $6C, $66, $2E, $70, $72, $6F, $63, $65, $73, $73, $5F, $66, $69,
$6C, $65, $20, $3D, $20, $66, $75, $6E, $63, $74, $69, $6F, $6E, $28, $66, $69,
$6C, $65, $6E, $61, $6D, $65, $29, $0D, $0A, $20, $20, $20, $20, $20, $20, $20,
$20, $6C, $6F, $63, $61, $6C, $20, $70, $61, $72, $73, $65, $72, $20, $3D, $20,
$73, $6F, $75, $72, $63, $65, $5F, $70, $61, $72, $73, $65, $72, $28, $66, $69,
$6C, $65, $6E, $61, $6D, $65, $29, $0D, $0A, $20, $20, $20, $20, $20, $20, $20,
$20, $66, $69, $6C, $65, $73, $5B, $66, $69, $6C, $65, $6E, $61, $6D, $65, $5D,
$20, $3D, $20, $70, $61, $72, $73, $65, $72, $2E, $63, $6F, $6E, $74, $65, $6E,
$74, $0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $0D, $0A, $20, $20, $20,
$20, $20, $20, $20, $20, $66, $6F, $72, $20, $5F, $2C, $20, $66, $20, $69, $6E,
$20, $70, $61, $69, $72, $73, $28, $70, $61, $72, $73, $65, $72, $2E, $69, $6E,
$63, $6C, $75, $64, $65, $73, $29, $20, $64, $6F, $0D, $0A, $20, $20, $20, $20,
$20, $20, $20, $20, $20, $20, $20, $20, $73, $65, $6C, $66, $2E, $70, $72, $6F,
$63, $65, $73, $73, $5F, $66, $69, $6C, $65, $28, $66, $29, $0D, $0A, $20, $20,
$20, $20, $20, $20, $20, $20, $65, $6E, $64, $0D, $0A, $20, $20, $20, $20, $65,
$6E, $64, $0D, $0A, $20, $20, $20, $20, $0D, $0A, $20, $20, $20, $20, $2D, $2D,
$20, $43, $72, $65, $61, $74, $65, $20, $61, $20, $62, $75, $6E, $64, $6C, $65,
$20, $66, $69, $6C, $65, $20, $77, $68, $69, $63, $68, $20, $63, $6F, $6E, $74,
$61, $69, $6E, $73, $20, $74, $68, $65, $20, $64, $65, $74, $65, $63, $74, $65,
$64, $20, $66, $69, $6C, $65, $73, $0D, $0A, $20, $20, $20, $20, $73, $65, $6C,
$66, $2E, $62, $75, $69, $6C, $64, $5F, $62, $75, $6E, $64, $6C, $65, $20, $3D,
$20, $66, $75, $6E, $63, $74, $69, $6F, $6E, $28, $64, $65, $73, $74, $5F, $66,
$69, $6C, $65, $29, $0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $6C, $6F,
$63, $61, $6C, $20, $66, $69, $6C, $65, $20, $3D, $20, $69, $6F, $2E, $6F, $70,
$65, $6E, $28, $64, $65, $73, $74, $5F, $66, $69, $6C, $65, $2C, $20, $22, $77,
$22, $29, $0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $0D, $0A, $20, $20,
$20, $20, $20, $20, $20, $20, $66, $69, $6C, $65, $3A, $77, $72, $69, $74, $65,
$28, $22, $28, $66, $75, $6E, $63, $74, $69, $6F, $6E, $28, $61, $72, $67, $73,
$29, $5C, $6E, $22, $29, $0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $66,
$69, $6C, $65, $3A, $77, $72, $69, $74, $65, $28, $22, $6C, $6F, $63, $61, $6C,
$20, $6D, $6F, $64, $75, $6C, $65, $73, $20, $3D, $20, $7B, $7D, $5C, $6E, $22,
$29, $0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $0D, $0A, $20, $20, $20,
$20, $20, $20, $20, $20, $2D, $2D, $20, $43, $72, $65, $61, $74, $65, $20, $61,
$20, $73, $6F, $72, $74, $65, $64, $20, $6C, $69, $73, $74, $20, $6F, $66, $20,
$6B, $65, $79, $73, $20, $73, $6F, $20, $74, $68, $65, $20, $6F, $75, $74, $70,
$75, $74, $20, $77, $69, $6C, $6C, $20, $62, $65, $20, $74, $68, $65, $20, $73,
$61, $6D, $65, $20, $77, $68, $65, $6E, $20, $74, $68, $65, $20, $69, $6E, $70,
$75, $74, $20, $64, $6F, $65, $73, $20, $6E, $6F, $74, $20, $63, $68, $61, $6E,
$67, $65, $0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $6C, $6F, $63, $61,
$6C, $20, $66, $69, $6C, $65, $6E, $61, $6D, $65, $73, $20, $3D, $20, $7B, $7D,
$0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $66, $6F, $72, $20, $66, $69,
$6C, $65, $6E, $61, $6D, $65, $2C, $20, $5F, $20, $69, $6E, $20, $70, $61, $69,
$72, $73, $28, $66, $69, $6C, $65, $73, $29, $20, $64, $6F, $0D, $0A, $20, $20,
$20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $74, $61, $62, $6C, $65, $2E,
$69, $6E, $73, $65, $72, $74, $28, $66, $69, $6C, $65, $6E, $61, $6D, $65, $73,
$2C, $20, $66, $69, $6C, $65, $6E, $61, $6D, $65, $29, $0D, $0A, $20, $20, $20,
$20, $20, $20, $20, $20, $65, $6E, $64, $0D, $0A, $20, $20, $20, $20, $20, $20,
$20, $20, $74, $61, $62, $6C, $65, $2E, $73, $6F, $72, $74, $28, $66, $69, $6C,
$65, $6E, $61, $6D, $65, $73, $29, $0D, $0A, $20, $20, $20, $20, $20, $20, $20,
$20, $0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $2D, $2D, $20, $41, $64,
$64, $20, $66, $69, $6C, $65, $73, $20, $61, $73, $20, $6D, $6F, $64, $75, $6C,
$65, $73, $0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $66, $6F, $72, $20,
$5F, $2C, $20, $66, $69, $6C, $65, $6E, $61, $6D, $65, $20, $69, $6E, $20, $70,
$61, $69, $72, $73, $28, $66, $69, $6C, $65, $6E, $61, $6D, $65, $73, $29, $20,
$64, $6F, $0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20,
$66, $69, $6C, $65, $3A, $77, $72, $69, $74, $65, $28, $22, $6D, $6F, $64, $75,
$6C, $65, $73, $5B, $27, $22, $29, $0D, $0A, $20, $20, $20, $20, $20, $20, $20,
$20, $20, $20, $20, $20, $66, $69, $6C, $65, $3A, $77, $72, $69, $74, $65, $28,
$66, $69, $6C, $65, $6E, $61, $6D, $65, $29, $0D, $0A, $20, $20, $20, $20, $20,
$20, $20, $20, $20, $20, $20, $20, $66, $69, $6C, $65, $3A, $77, $72, $69, $74,
$65, $28, $22, $27, $5D, $20, $3D, $20, $66, $75, $6E, $63, $74, $69, $6F, $6E,
$28, $2E, $2E, $2E, $29, $5C, $6E, $22, $29, $0D, $0A, $20, $20, $20, $20, $20,
$20, $20, $20, $20, $20, $20, $20, $66, $69, $6C, $65, $3A, $77, $72, $69, $74,
$65, $28, $66, $69, $6C, $65, $73, $5B, $66, $69, $6C, $65, $6E, $61, $6D, $65,
$5D, $29, $0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20,
$66, $69, $6C, $65, $3A, $77, $72, $69, $74, $65, $28, $22, $5C, $6E, $22, $29,
$0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $66, $69,
$6C, $65, $3A, $77, $72, $69, $74, $65, $28, $22, $65, $6E, $64, $5C, $6E, $22,
$29, $0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $65, $6E, $64, $0D, $0A,
$20, $20, $20, $20, $20, $20, $20, $20, $66, $69, $6C, $65, $3A, $77, $72, $69,
$74, $65, $28, $22, $66, $75, $6E, $63, $74, $69, $6F, $6E, $20, $69, $6D, $70,
$6F, $72, $74, $28, $6E, $29, $5C, $6E, $22, $29, $0D, $0A, $20, $20, $20, $20,
$20, $20, $20, $20, $66, $69, $6C, $65, $3A, $77, $72, $69, $74, $65, $28, $22,
$72, $65, $74, $75, $72, $6E, $20, $6D, $6F, $64, $75, $6C, $65, $73, $5B, $6E,
$5D, $28, $74, $61, $62, $6C, $65, $2E, $75, $6E, $70, $61, $63, $6B, $28, $61,
$72, $67, $73, $29, $29, $5C, $6E, $22, $29, $0D, $0A, $20, $20, $20, $20, $20,
$20, $20, $20, $66, $69, $6C, $65, $3A, $77, $72, $69, $74, $65, $28, $22, $65,
$6E, $64, $5C, $6E, $22, $29, $0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20,
$0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $66, $69, $6C, $65, $3A, $77,
$72, $69, $74, $65, $28, $22, $6C, $6F, $63, $61, $6C, $20, $65, $6E, $74, $72,
$79, $20, $3D, $20, $69, $6D, $70, $6F, $72, $74, $28, $27, $22, $20, $2E, $2E,
$20, $65, $6E, $74, $72, $79, $5F, $70, $6F, $69, $6E, $74, $20, $2E, $2E, $20,
$22, $27, $29, $5C, $6E, $22, $29, $0D, $0A, $20, $20, $20, $20, $20, $20, $20,
$20, $0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $66, $69, $6C, $65, $3A,
$77, $72, $69, $74, $65, $28, $22, $65, $6E, $64, $29, $28, $7B, $2E, $2E, $2E,
$7D, $29, $22, $29, $0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $66, $69,
$6C, $65, $3A, $66, $6C, $75, $73, $68, $28, $29, $0D, $0A, $20, $20, $20, $20,
$20, $20, $20, $20, $66, $69, $6C, $65, $3A, $63, $6C, $6F, $73, $65, $28, $29,
$0D, $0A, $20, $20, $20, $20, $65, $6E, $64, $0D, $0A, $20, $20, $20, $20, $0D,
$0A, $20, $20, $20, $20, $72, $65, $74, $75, $72, $6E, $20, $73, $65, $6C, $66,
$0D, $0A, $65, $6E, $64, $0D, $0A, $65, $6E, $64, $0D, $0A, $6D, $6F, $64, $75,
$6C, $65, $73, $5B, $27, $61, $70, $70, $2F, $6D, $61, $69, $6E, $2E, $6C, $75,
$61, $27, $5D, $20, $3D, $20, $66, $75, $6E, $63, $74, $69, $6F, $6E, $28, $2E,
$2E, $2E, $29, $0D, $0A, $2D, $2D, $20, $4D, $61, $69, $6E, $20, $66, $75, $6E,
$63, $74, $69, $6F, $6E, $20, $6F, $66, $20, $74, $68, $65, $20, $70, $72, $6F,
$67, $72, $61, $6D, $0D, $0A, $6C, $6F, $63, $61, $6C, $20, $62, $75, $6E, $64,
$6C, $65, $5F, $6D, $61, $6E, $61, $67, $65, $72, $20, $3D, $20, $69, $6D, $70,
$6F, $72, $74, $28, $22, $61, $70, $70, $2F, $62, $75, $6E, $64, $6C, $65, $5F,
$6D, $61, $6E, $61, $67, $65, $72, $2E, $6C, $75, $61, $22, $29, $0D, $0A, $0D,
$0A, $72, $65, $74, $75, $72, $6E, $20, $66, $75, $6E, $63, $74, $69, $6F, $6E,
$28, $61, $72, $67, $73, $29, $0D, $0A, $20, $20, $20, $20, $69, $66, $20, $23,
$61, $72, $67, $73, $20, $3D, $3D, $20, $31, $20, $61, $6E, $64, $20, $61, $72,
$67, $73, $5B, $31, $5D, $20, $3D, $3D, $20, $22, $2D, $76, $22, $20, $74, $68,
$65, $6E, $0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $70, $72, $69, $6E,
$74, $28, $22, $6C, $75, $61, $62, $75, $6E, $64, $6C, $65, $20, $76, $30, $2E,
$30, $31, $22, $29, $0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $6F, $73,
$2E, $65, $78, $69, $74, $28, $29, $0D, $0A, $20, $20, $20, $20, $65, $6C, $73,
$65, $69, $66, $20, $23, $61, $72, $67, $73, $20, $7E, $3D, $20, $32, $20, $74,
$68, $65, $6E, $0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $70, $72, $69,
$6E, $74, $28, $22, $75, $73, $61, $67, $65, $3A, $20, $6C, $75, $61, $62, $75,
$6E, $64, $6C, $65, $20, $69, $6E, $20, $6F, $75, $74, $22, $29, $0D, $0A, $20,
$20, $20, $20, $20, $20, $20, $20, $6F, $73, $2E, $65, $78, $69, $74, $28, $29,
$0D, $0A, $20, $20, $20, $20, $65, $6E, $64, $0D, $0A, $20, $20, $20, $20, $0D,
$0A, $20, $20, $20, $20, $6C, $6F, $63, $61, $6C, $20, $69, $6E, $66, $69, $6C,
$65, $20, $3D, $20, $61, $72, $67, $73, $5B, $31, $5D, $0D, $0A, $20, $20, $20,
$20, $6C, $6F, $63, $61, $6C, $20, $6F, $75, $74, $66, $69, $6C, $65, $20, $3D,
$20, $61, $72, $67, $73, $5B, $32, $5D, $0D, $0A, $20, $20, $20, $20, $6C, $6F,
$63, $61, $6C, $20, $62, $75, $6E, $64, $6C, $65, $20, $3D, $20, $62, $75, $6E,
$64, $6C, $65, $5F, $6D, $61, $6E, $61, $67, $65, $72, $28, $69, $6E, $66, $69,
$6C, $65, $29, $0D, $0A, $20, $20, $20, $20, $62, $75, $6E, $64, $6C, $65, $2E,
$70, $72, $6F, $63, $65, $73, $73, $5F, $66, $69, $6C, $65, $28, $69, $6E, $66,
$69, $6C, $65, $2C, $20, $62, $75, $6E, $64, $6C, $65, $29, $0D, $0A, $20, $20,
$20, $20, $0D, $0A, $20, $20, $20, $20, $62, $75, $6E, $64, $6C, $65, $2E, $62,
$75, $69, $6C, $64, $5F, $62, $75, $6E, $64, $6C, $65, $28, $6F, $75, $74, $66,
$69, $6C, $65, $29, $0D, $0A, $65, $6E, $64, $0D, $0A, $65, $6E, $64, $0D, $0A,
$6D, $6F, $64, $75, $6C, $65, $73, $5B, $27, $61, $70, $70, $2F, $73, $6F, $75,
$72, $63, $65, $5F, $70, $61, $72, $73, $65, $72, $2E, $6C, $75, $61, $27, $5D,
$20, $3D, $20, $66, $75, $6E, $63, $74, $69, $6F, $6E, $28, $2E, $2E, $2E, $29,
$0D, $0A, $2D, $2D, $20, $43, $6C, $61, $73, $73, $20, $66, $6F, $72, $20, $65,
$78, $74, $72, $61, $63, $74, $69, $6E, $67, $20, $69, $6D, $70, $6F, $72, $74,
$20, $66, $75, $6E, $63, $74, $69, $6F, $6E, $20, $63, $61, $6C, $6C, $73, $20,
$66, $72, $6F, $6D, $20, $73, $6F, $75, $72, $63, $65, $20, $66, $69, $6C, $65,
$73, $0D, $0A, $72, $65, $74, $75, $72, $6E, $20, $66, $75, $6E, $63, $74, $69,
$6F, $6E, $28, $66, $69, $6C, $65, $6E, $61, $6D, $65, $29, $0D, $0A, $20, $20,
$20, $20, $6C, $6F, $63, $61, $6C, $20, $66, $69, $6C, $65, $20, $3D, $20, $69,
$6F, $2E, $6F, $70, $65, $6E, $28, $66, $69, $6C, $65, $6E, $61, $6D, $65, $2C,
$20, $22, $72, $22, $29, $0D, $0A, $20, $20, $20, $20, $69, $66, $20, $66, $69,
$6C, $65, $20, $3D, $3D, $20, $6E, $69, $6C, $20, $74, $68, $65, $6E, $0D, $0A,
$20, $20, $20, $20, $20, $20, $20, $20, $65, $72, $72, $6F, $72, $28, $22, $46,
$69, $6C, $65, $20, $6E, $6F, $74, $20, $66, $6F, $75, $6E, $64, $3A, $20, $22,
$20, $2E, $2E, $20, $66, $69, $6C, $65, $6E, $61, $6D, $65, $29, $0D, $0A, $20,
$20, $20, $20, $65, $6E, $64, $0D, $0A, $20, $20, $20, $20, $6C, $6F, $63, $61,
$6C, $20, $66, $69, $6C, $65, $5F, $63, $6F, $6E, $74, $65, $6E, $74, $20, $3D,
$20, $66, $69, $6C, $65, $3A, $72, $65, $61, $64, $28, $22, $2A, $61, $22, $29,
$0D, $0A, $20, $20, $20, $20, $66, $69, $6C, $65, $3A, $63, $6C, $6F, $73, $65,
$28, $29, $0D, $0A, $20, $20, $20, $20, $6C, $6F, $63, $61, $6C, $20, $69, $6E,
$63, $6C, $75, $64, $65, $64, $5F, $66, $69, $6C, $65, $73, $20, $3D, $20, $7B,
$7D, $0D, $0A, $20, $20, $20, $20, $0D, $0A, $20, $20, $20, $20, $2D, $2D, $20,
$53, $65, $61, $72, $63, $68, $20, $66, $6F, $72, $20, $69, $6D, $70, $6F, $72,
$74, $28, $29, $20, $63, $61, $6C, $6C, $73, $20, $77, $69, $74, $68, $20, $64,
$6F, $62, $75, $6C, $65, $20, $71, $75, $6F, $74, $65, $73, $20, $28, $21, $29,
$0D, $0A, $20, $20, $20, $20, $66, $6F, $72, $20, $66, $20, $69, $6E, $20, $73,
$74, $72, $69, $6E, $67, $2E, $67, $6D, $61, $74, $63, $68, $28, $66, $69, $6C,
$65, $5F, $63, $6F, $6E, $74, $65, $6E, $74, $2C, $20, $27, $69, $6D, $70, $6F,
$72, $74, $25, $28, $5B, $22, $5C, $27, $5D, $28, $5B, $5E, $5C, $27, $22, $5D,
$2D, $29, $5B, $22, $5C, $27, $5D, $25, $29, $27, $29, $20, $64, $6F, $0D, $0A,
$20, $20, $20, $20, $20, $20, $20, $20, $74, $61, $62, $6C, $65, $2E, $69, $6E,
$73, $65, $72, $74, $28, $69, $6E, $63, $6C, $75, $64, $65, $64, $5F, $66, $69,
$6C, $65, $73, $2C, $20, $66, $29, $0D, $0A, $20, $20, $20, $20, $65, $6E, $64,
$0D, $0A, $20, $20, $20, $20, $0D, $0A, $20, $20, $20, $20, $73, $65, $6C, $66,
$20, $3D, $20, $7B, $7D, $0D, $0A, $20, $20, $20, $20, $73, $65, $6C, $66, $2E,
$66, $69, $6C, $65, $6E, $61, $6D, $65, $20, $3D, $20, $66, $69, $6C, $65, $6E,
$61, $6D, $65, $0D, $0A, $20, $20, $20, $20, $73, $65, $6C, $66, $2E, $63, $6F,
$6E, $74, $65, $6E, $74, $20, $3D, $20, $66, $69, $6C, $65, $5F, $63, $6F, $6E,
$74, $65, $6E, $74, $0D, $0A, $20, $20, $20, $20, $73, $65, $6C, $66, $2E, $69,
$6E, $63, $6C, $75, $64, $65, $73, $20, $3D, $20, $69, $6E, $63, $6C, $75, $64,
$65, $64, $5F, $66, $69, $6C, $65, $73, $0D, $0A, $20, $20, $20, $20, $72, $65,
$74, $75, $72, $6E, $20, $73, $65, $6C, $66, $0D, $0A, $65, $6E, $64, $0D, $0A,
$65, $6E, $64, $0D, $0A, $6D, $6F, $64, $75, $6C, $65, $73, $5B, $27, $6C, $75,
$61, $62, $75, $6E, $64, $6C, $65, $2E, $6C, $75, $61, $27, $5D, $20, $3D, $20,
$66, $75, $6E, $63, $74, $69, $6F, $6E, $28, $2E, $2E, $2E, $29, $0D, $0A, $2D,
$2D, $20, $45, $6E, $74, $72, $79, $20, $70, $6F, $69, $6E, $74, $20, $6F, $66,
$20, $74, $68, $65, $20, $70, $72, $6F, $67, $72, $61, $6D, $2E, $0D, $0A, $2D,
$2D, $20, $4F, $6E, $6C, $79, $20, $62, $61, $73, $69, $63, $20, $73, $74, $75,
$66, $66, $20, $69, $73, $20, $73, $65, $74, $20, $75, $70, $20, $68, $65, $72,
$65, $2C, $20, $74, $68, $65, $20, $61, $63, $74, $75, $61, $6C, $20, $70, $72,
$6F, $67, $72, $61, $6D, $20, $69, $73, $20, $69, $6E, $20, $61, $70, $70, $2F,
$6D, $61, $69, $6E, $2E, $6C, $75, $61, $0D, $0A, $6C, $6F, $63, $61, $6C, $20,
$61, $72, $67, $73, $20, $3D, $20, $7B, $2E, $2E, $2E, $7D, $0D, $0A, $0D, $0A,
$2D, $2D, $20, $43, $68, $65, $63, $6B, $20, $69, $66, $20, $77, $65, $20, $61,
$72, $65, $20, $61, $6C, $72, $65, $61, $64, $79, $20, $62, $75, $6E, $64, $6C,
$65, $64, $0D, $0A, $69, $66, $20, $69, $6D, $70, $6F, $72, $74, $20, $3D, $3D,
$20, $6E, $69, $6C, $20, $74, $68, $65, $6E, $0D, $0A, $20, $20, $20, $20, $64,
$6F, $66, $69, $6C, $65, $28, $22, $75, $74, $69, $6C, $2F, $6C, $6F, $61, $64,
$65, $72, $2E, $6C, $75, $61, $22, $29, $0D, $0A, $65, $6E, $64, $0D, $0A, $0D,
$0A, $69, $6D, $70, $6F, $72, $74, $28, $22, $61, $70, $70, $2F, $6D, $61, $69,
$6E, $2E, $6C, $75, $61, $22, $29, $28, $61, $72, $67, $73, $29, $0D, $0A, $65,
$6E, $64, $0D, $0A, $66, $75, $6E, $63, $74, $69, $6F, $6E, $20, $69, $6D, $70,
$6F, $72, $74, $28, $6E, $29, $0D, $0A, $72, $65, $74, $75, $72, $6E, $20, $6D,
$6F, $64, $75, $6C, $65, $73, $5B, $6E, $5D, $28, $74, $61, $62, $6C, $65, $2E,
$75, $6E, $70, $61, $63, $6B, $28, $61, $72, $67, $73, $29, $29, $0D, $0A, $65,
$6E, $64, $0D, $0A, $6C, $6F, $63, $61, $6C, $20, $65, $6E, $74, $72, $79, $20,
$3D, $20, $69, $6D, $70, $6F, $72, $74, $28, $27, $6C, $75, $61, $62, $75, $6E,
$64, $6C, $65, $2E, $6C, $75, $61, $27, $29, $0D, $0A, $65, $6E, $64, $29, $28,
$7B, $2E, $2E, $2E, $7D, $29
);

const
  cLuaAutoSetup = 'AutoSetup';

function LuaWrapperClosure(const aState: Pointer): Integer; cdecl;
var
  LMethod: TMethod;
  LClosure: TLuaFunction absolute LMethod;
  LLua: TLua;
begin
  // get lua object
  LLua := lua_touserdata(aState, lua_upvalueindex(1));

  // get lua class routine
  LMethod.Code := lua_touserdata(aState, lua_upvalueindex(2));
  LMethod.Data := lua_touserdata(aState, lua_upvalueindex(3));

  // init the context
  LLua.Context.Setup;

  // call class routines
  LClosure(LLua.Context);

  // return result count
  Result := LLua.Context.PushCount;

  // clean up stack
  LLua.Context.Cleanup;
end;

function LuaWrapperWriter(aState: Plua_State; const aBuffer: Pointer; aSize: NativeUInt; aData: Pointer): Integer; cdecl;
var
  LStream: TStream;
begin
  LStream := TStream(aData);
  try
    LStream.WriteBuffer(aBuffer^, aSize);
    Result := 0;
  except
    on E: EStreamError do
      Result := 1;
  end;
end;

{ TLuaValue }
class operator TLuaValue.Implicit(const AValue: Integer): TLuaValue;
begin
  Result.AsType := vtInteger;
  Result.AsInteger := AValue;
end;

class operator TLuaValue.Implicit(const AValue: Double): TLuaValue;
begin
  Result.AsType := vtDouble;
  Result.AsNumber := AValue;
end;

class operator TLuaValue.Implicit(const AValue: System.PChar): TLuaValue;
begin
  Result.AsType := vtString;
  Result.AsString := AValue;
end;

class operator TLuaValue.Implicit(const AValue: TLuaTable): TLuaValue;
begin
  Result.AsType := vtTable;
  Result.AsTable := AValue;
end;

class operator TLuaValue.Implicit(const AValue: Pointer): TLuaValue;
begin
  Result.AsType := vtPointer;
  Result.AsPointer := AValue;
end;

class operator TLuaValue.Implicit(const AValue: Boolean): TLuaValue;
begin
  Result.AsType := vtBoolean;
  Result.AsBoolean := AValue;
end;

class operator TLuaValue.Implicit(const AValue: TLuaValue): Integer;
begin
  Result := AValue.AsInteger;
end;

class operator TLuaValue.Implicit(const AValue: TLuaValue): Double;
begin
  Result := AValue.AsNumber;
end;

var TLuaValue_Implicit_LValue: string = '';
class operator TLuaValue.Implicit(const AValue: TLuaValue): System.PChar;
begin
  TLuaValue_Implicit_LValue := AValue.AsString;
  Result := PChar(TLuaValue_Implicit_LValue);
end;

class operator TLuaValue.Implicit(const AValue: TLuaValue): Pointer;
begin
  Result := AValue.AsPointer
end;

class operator TLuaValue.Implicit(const AValue: TLuaValue): Boolean;
begin
  Result := AValue.AsBoolean;
end;

{ Routines }
function ParseTableNames(const aNames: string): TStringDynArray;
var
  LItems: TArray<string>;
  LI: Integer;
begin
  LItems := aNames.Split(['.']);
  SetLength(Result, Length(LItems));
  for LI := 0 to High(LItems) do
  begin
    Result[LI] := LItems[LI];
  end;
end;

{ TLuaContext }
procedure TLuaContext.Setup();
begin
  FPushCount := 0;
  FPushFlag := True;
end;

procedure TLuaContext.Check();
begin
  if FPushFlag then
  begin
    FPushFlag := False;
    ClearStack;
  end;
end;

procedure TLuaContext.IncStackPushCount();
begin
  Inc(FPushCount);
end;

procedure TLuaContext.Cleanup();
begin
  if FPushFlag then
  begin
    ClearStack;
  end;
end;

function TLuaContext.PushTableForSet(const AName: array of string; const AIndex: Integer; var AStackIndex: Integer; var AFieldNameIndex: Integer): Boolean;
var
  LMarshall: TMarshaller;
  LI: Integer;
begin
  Result := False;

  // validate name array size
  AStackIndex := Length(AName);
  if AStackIndex < 1 then  Exit;

  // validate return aStackIndex and aFieldNameIndex
  if Length(AName) = 1 then
    AFieldNameIndex := 0
  else
    AFieldNameIndex := Length(AName) - 1;

  // table does not exist, exit
  if lua_type(FLua.State, AIndex) <> LUA_TTABLE then Exit;

  // process sub tables
  for LI := 0 to AStackIndex - 1 do
  begin
    // check if table at field aIndex[i] exits
    lua_getfield(FLua.State, LI + AIndex, LMarshall.AsAnsi(AName[LI]).ToPointer);

    // table field does not exists, create a new one
    if lua_type(FLua.State, -1) <> LUA_TTABLE then
    begin
      // clean up stack
      lua_pop(FLua.State, 1);

      // push new table
      lua_newtable(FLua.State);

      // set new table a field
      lua_setfield(FLua.State, LI + AIndex, LMarshall.AsAnsi(AName[LI]).ToPointer);

      // push field table back on stack
      lua_getfield(FLua.State, LI + AIndex, LMarshall.AsAnsi(AName[LI]).ToPointer);
    end;
  end;

  Result := True;
end;

function TLuaContext.PushTableForGet(const AName: array of string; const AIndex: Integer; var AStackIndex: Integer; var AFieldNameIndex: Integer): Boolean;
var
  LMarshall: TMarshaller;
  LI: Integer;
begin
  Result := False;

  // validate name array size
  AStackIndex := Length(AName);
  if AStackIndex < 1 then  Exit;

  // validate return aStackIndex and aFieldNameIndex
  if AStackIndex = 1 then
    AFieldNameIndex := 0
  else
    AFieldNameIndex := AStackIndex - 1;

  // table does not exist, exit
  if lua_type(FLua.State, AIndex) <> LUA_TTABLE then  Exit;

  // process sub tables
  for LI := 0 to AStackIndex - 2 do
  begin
    // check if table at field aIndex[i] exits
    lua_getfield(FLua.State, LI + AIndex, LMarshall.AsAnsi(AName[LI]).ToPointer);

    // table field does not exists, create a new one
    if lua_type(FLua.State, -1) <> LUA_TTABLE then Exit;
  end;

  Result := True;
end;

constructor TLuaContext.Create(const ALua: TLua);
begin
  FLua := ALua;
  FPushCount := 0;
  FPushFlag := False;
end;

destructor TLuaContext.Destroy();
begin
  FLua := nil;
  FPushCount := 0;
  FPushFlag := False;
  inherited;
end;

function TLuaContext.ArgCount(): Integer;
begin
  Result := lua_gettop(FLua.State);
end;

function TLuaContext.PushCount: Integer;
begin
  Result := FPushCount;
end;

procedure TLuaContext.ClearStack();
begin
  lua_pop(FLua.State, lua_gettop(FLua.State));
  FPushCount := 0;
  FPushFlag := False;
end;

procedure TLuaContext.PopStack(const ACount: Integer);
begin
  lua_pop(FLua.State, ACount);
end;

function TLuaContext.GetStackType(const AIndex: Integer): TLuaType;
begin
  Result := TLuaType(lua_type(FLua.State, AIndex));
end;

var TLuaContext_GetValue_LStr: string = '';
function TLuaContext.GetValue(const AType: TLuaValueType; const AIndex: Integer): TLuaValue;
begin
  Result := Default(TLuaValue);
  case AType of
    vtInteger:
      begin
        Result.AsInteger := lua_tointeger(FLua.State, AIndex);
      end;
    vtDouble:
      begin
        Result.AsNumber := lua_tonumber(FLua.State, AIndex);
      end;
    vtString:
      begin
        TLuaContext_GetValue_LStr := lua_tostring(FLua.State, AIndex);
        Result := PChar(TLuaContext_GetValue_LStr);
      end;
    vtPointer:
      begin
        Result.AsPointer := lua_touserdata(FLua.State, AIndex);
      end;
    vtBoolean:
      begin
        Result.AsBoolean := Boolean(lua_toboolean(FLua.State, AIndex));
      end;
  else
    begin

    end;
  end;
end;

procedure TLuaContext.PushValue(const AValue: TLuaValue);
var
  LMarshall: TMarshaller;
begin
  Check;

  case AValue.AsType of
    vtInteger:
      begin
        lua_pushinteger(FLua.State, AValue);
      end;
    vtDouble:
      begin
        lua_pushnumber(FLua.State, AValue);
      end;
    vtString:
      begin
        lua_pushstring(FLua.State, LMarshall.AsAnsi(AValue.AsString).ToPointer);
      end;
    vtTable:
      begin
        lua_newtable(FLua.State);
      end;
    vtPointer:
      begin
        lua_pushlightuserdata(FLua.State, AValue);
      end;
    vtBoolean:
      begin
        lua_pushboolean(FLua.State, AValue.AsBoolean.ToInteger);
      end;
  end;

  IncStackPushCount();
end;

procedure TLuaContext.SetTableFieldValue(const AName: string; const AValue: TLuaValue; const AIndex: Integer);
var
  LMarshall: TMarshaller;
  LStackIndex: Integer;
  LFieldNameIndex: Integer;
  LItems: TStringDynArray;
  LOk: Boolean;
begin
  LItems := ParseTableNames(AName);
  if not PushTableForSet(LItems, AIndex, LStackIndex, LFieldNameIndex) then Exit;
  LOk := True;

  case AValue.AsType of
    vtInteger:
      begin
        lua_pushinteger(FLua.State, AValue);
      end;
    vtDouble:
      begin
        lua_pushnumber(FLua.State, AValue);
      end;
    vtString:
      begin
        lua_pushstring(FLua.State, LMarshall.AsAnsi(AValue.AsString).ToPointer);
      end;
    vtPointer:
      begin
        lua_pushlightuserdata(FLua.State, AValue);
      end;
    vtBoolean:
      begin
        lua_pushboolean(FLua.State, AValue.AsBoolean.ToInteger);
      end;
  else
    begin
      LOk := False;
    end;
  end;

  if LOk then
  begin
    lua_setfield(FLua.State, LStackIndex + (AIndex - 1),
      LMarshall.AsAnsi(LItems[LFieldNameIndex]).ToPointer);
  end;

  PopStack(LStackIndex);
end;

var TLuaContext_GetTableFieldValue_LStr: string = '';
function TLuaContext.GetTableFieldValue(const AName: string; const AType: TLuaValueType; const AIndex: Integer): TLuaValue;
var
  LMarshall: TMarshaller;
  LStackIndex: Integer;
  LFieldNameIndex: Integer;
  LItems: TStringDynArray;
begin
  LItems := ParseTableNames(AName);
  if not PushTableForGet(LItems, AIndex, LStackIndex, LFieldNameIndex) then
    Exit;
  lua_getfield(FLua.State, LStackIndex + (AIndex - 1),
    LMarshall.AsAnsi(LItems[LFieldNameIndex]).ToPointer);

  case AType of
    vtInteger:
      begin
        Result.AsInteger := lua_tointeger(FLua.State, -1);
      end;
    vtDouble:
      begin
        Result.AsNumber := lua_tonumber(FLua.State, -1);
      end;
    vtString:
      begin
        TLuaContext_GetTableFieldValue_LStr := lua_tostring(FLua.State, -1);
        Result := PChar(TLuaContext_GetTableFieldValue_LStr);
      end;
    vtPointer:
      begin
        Result.AsPointer := lua_touserdata(FLua.State, -1);
      end;
    vtBoolean:
      begin
        Result.AsBoolean := Boolean(lua_toboolean(FLua.State, -1));
      end;
  end;

  PopStack(LStackIndex);
end;

procedure TLuaContext.SetTableIndexValue(const AName: string; const AValue: TLuaValue; const AIndex: Integer; const AKey: Integer);
var
  LMarshall: TMarshaller;
  LStackIndex: Integer;
  LFieldNameIndex: Integer;
  LItems: TStringDynArray;
  LOk: Boolean;

  procedure LPushValue;
  begin
    LOk := True;

    case AValue.AsType of
      vtInteger:
        begin
          lua_pushinteger(FLua.State, AValue);
        end;
      vtDouble:
        begin
          lua_pushnumber(FLua.State, AValue);
        end;
      vtString:
        begin
          lua_pushstring(FLua.State, LMarshall.AsAnsi(AValue.AsString).ToPointer);
        end;
      vtPointer:
        begin
          lua_pushlightuserdata(FLua.State, AValue);
        end;
      vtBoolean:
        begin
          lua_pushboolean(FLua.State, AValue.AsBoolean.ToInteger);
        end;
    else
      begin
        LOk := False;
      end;
    end;
  end;

begin
  LItems := ParseTableNames(AName);
  if Length(LItems) > 0 then
    begin
      if not PushTableForGet(LItems, AIndex, LStackIndex, LFieldNameIndex) then  Exit;
      LPushValue;
      if LOk then
        lua_rawseti (FLua.State, LStackIndex + (AIndex - 1), AKey);
    end
  else
    begin
      LPushValue;
      if LOk then
      begin
        lua_rawseti (FLua.State, AIndex, AKey);
      end;
      LStackIndex := 0;
    end;

    PopStack(LStackIndex);
end;

var TLuaContext_GetTableIndexValue_LStr: string = '';
function TLuaContext.GetTableIndexValue(const AName: string; const AType: TLuaValueType; const AIndex: Integer; const AKey: Integer): TLuaValue;
var
  LStackIndex: Integer;
  LFieldNameIndex: Integer;
  LItems: TStringDynArray;
begin
  LItems := ParseTableNames(AName);
  if Length(LItems) > 0 then
    begin
      if not PushTableForGet(LItems, AIndex, LStackIndex, LFieldNameIndex) then Exit;
      lua_rawgeti (FLua.State, LStackIndex + (AIndex - 1), AKey);
    end
  else
    begin
      lua_rawgeti (FLua.State, AIndex, AKey);
      LStackIndex := 0;
    end;

  case AType of
    vtInteger:
      begin
        Result.AsInteger := lua_tointeger(FLua.State, -1);
      end;
    vtDouble:
      begin
        Result.AsNumber := lua_tonumber(FLua.State, -1);
      end;
    vtString:
      begin
        TLuaContext_GetTableIndexValue_LStr := lua_tostring(FLua.State, -1);
        Result := PChar(TLuaContext_GetTableIndexValue_LStr);
      end;
    vtPointer:
      begin
        Result.AsPointer := lua_touserdata(FLua.State, -1);
      end;
    vtBoolean:
      begin
        Result.AsBoolean := Boolean(lua_toboolean(FLua.State, -1));
      end;
  end;

  PopStack(LStackIndex);
end;

function  TLuaContext.Lua(): ILua;
begin
  Result := Self.FLua;
end;


{ TLua }
function TLua.Open(): Boolean;
begin
  Result := False;
  if FState <> nil then Exit;

  FState := luaL_newstate;
  SetGCStepSize(200);
  luaL_openlibs(FState);
  LoadBuffer(@cLOADER_LUA, Length(cLOADER_LUA));
  FContext := TLuaContext.Create(Self);

  SetVariable('Pyro.luaVersion', GetVariable('jit.version', vtString));
  SetVariable('Pyro.version', PYRO_VERSION);

  dbg_setup_default(FState);

  // Set the panic handler
  lua_atpanic(FState, @LuaPanic);

  // Create the 'arg' table
  lua_updateargs(FState, 0);

  Result := True;
end;

procedure TLua.Close();
begin
  if FState = nil then Exit;
  FreeAndNil(FContext);
  lua_close(FState);
  FState := nil;
end;

procedure TLua.CheckLuaError(const AError: Integer);
var
  LErr: string;
begin
  if FState = nil then Exit;

  case AError of
    // success
    0:
      begin

      end;
    // a runtime error.
    LUA_ERRRUN:
      begin
        LErr := lua_tostring(FState, -1);
        lua_pop(FState, 1);
        raise ELuaException.CreateFmt('Runtime error [%s]', [LErr]);
      end;
    // memory allocation error. For such errors, Lua does not call the error handler function.
    LUA_ERRMEM:
      begin
        LErr := lua_tostring(FState, -1);
        lua_pop(FState, 1);
        raise ELuaException.CreateFmt('Memory allocation error [%s]', [LErr]);
      end;
    // error while running the error handler function.
    LUA_ERRERR:
      begin
        LErr := lua_tostring(FState, -1);
        lua_pop(FState, 1);
        raise ELuaException.CreateFmt
          ('Error while running the error handler function [%s]', [LErr]);
      end;
    LUA_ERRSYNTAX:
      begin
        LErr := lua_tostring(FState, -1);
        lua_pop(FState, 1);
        raise ELuaException.CreateFmt('Syntax Error [%s]', [LErr]);
      end
  else
    begin
      LErr := lua_tostring(FState, -1);
      lua_pop(FState, 1);
      raise ELuaException.CreateFmt('Unknown Error [%s]', [LErr]);
    end;
  end;
end;

function TLua.PushGlobalTableForSet(const AName: array of string; var AIndex: Integer): Boolean;
var
  LMarshall: TMarshaller;
  LI: Integer;
begin
  Result := False;

  if FState = nil then Exit;

  if Length(AName) < 2 then Exit;

  AIndex := Length(AName) - 1;

  // check if global table exists
  lua_getglobal(FState, LMarshall.AsAnsi(AName[0]).ToPointer);

  // table does not exist, create new one
  if lua_type(FState, lua_gettop(FState)) <> LUA_TTABLE then
  begin
    // clean up stack
    lua_pop(FState, 1);

    // create new table
    lua_newtable(FState);

    // make it global
    lua_setglobal(FState, LMarshall.AsAnsi(AName[0]).ToPointer);

    // push global table back on stack
    lua_getglobal(FState, LMarshall.AsAnsi(AName[0]).ToPointer);
  end;

  // process tables in global table at index 1+
  // global table on stack, process remaining tables
  for LI := 1 to AIndex - 1 do
  begin
    // check if table at field aIndex[i] exits
    lua_getfield(FState, LI, LMarshall.AsAnsi(AName[LI]).ToPointer);

    // table field does not exists, create a new one
    if lua_type(FState, -1) <> LUA_TTABLE then
    begin
      // clean up stack
      lua_pop(FState, 1);

      // push new table
      lua_newtable(FState);

      // set new table a field
      lua_setfield(FState, LI, LMarshall.AsAnsi(AName[LI]).ToPointer);

      // push field table back on stack
      lua_getfield(FState, LI, LMarshall.AsAnsi(AName[LI]).ToPointer);
    end;
  end;

  Result := True;
end;

function TLua.PushGlobalTableForGet(const AName: array of string; var AIndex: Integer): Boolean;
var
  LMarshall: TMarshaller;
  LI: Integer;
begin
  // assume false
  Result := False;

  if FState = nil then Exit;

  // check for valid table name count
  if Length(AName) < 2 then Exit;

  // init stack index
  AIndex := Length(AName) - 1;

  // lookup global table
  lua_getglobal(FState, LMarshall.AsAnsi(AName[0]).ToPointer);

  // check of global table exits
  if lua_type(FState, lua_gettop(FState)) = LUA_TTABLE then
  begin
    // process tables in global table at index 1+
    // global table on stack, process remaining tables
    for LI := 1 to AIndex - 1 do
    begin
      // get table at field aIndex[i]
      lua_getfield(FState, LI, LMarshall.AsAnsi(AName[LI]).ToPointer);

      // table field does not exists, exit
      if lua_type(FState, -1) <> LUA_TTABLE then
      begin
        // table name does not exit so we are out of here with an error
        Exit;
      end;
    end;
  end;

  // all table names exits we are good
  Result := True;
end;

procedure TLua.PushTValue(const AValue: System.RTTI.TValue);
var
  LUtf8s: RawByteString;
begin
  if FState = nil then Exit;

  case AValue.Kind of
    tkUnknown, tkChar, tkSet, tkMethod, tkVariant, tkArray, tkProcedure, tkRecord, tkInterface, tkDynArray, tkClassRef:
      begin
        lua_pushnil(FState);
      end;
    tkInteger:
      lua_pushinteger(FState, AValue.AsInteger);
    tkEnumeration:
      begin
        if AValue.IsType<Boolean> then
        begin
          if AValue.AsBoolean then
            lua_pushboolean(FState, Ord(True))
          else
            lua_pushboolean(FState, Ord(False));
        end
        else
          lua_pushinteger(FState, AValue.AsInteger);
      end;
    tkFloat:
      lua_pushnumber(FState, AValue.AsExtended);
    tkString, tkWChar, tkLString, tkWString, tkUString:
      begin
        LUtf8s := UTF8Encode(AValue.AsString);
        lua_pushstring(FState, PAnsiChar(LUtf8s));
      end;
    //tkClass:
    //  lua_pushlightuserdata(FState, Pointer(aValue.AsObject));
    tkInt64:
      lua_pushnumber(FState, AValue.AsInt64);
    //tkPointer:
    //  lua_pushlightuserdata(FState, Pointer(aValue.AsObject));
  end;
end;

function TLua.CallFunction(const AParams: array of TValue): TValue;
var
  LP: System.RTTI.TValue;
  LR: Integer;
begin
  if FState = nil then Exit;

  for LP in AParams do
    PushTValue(LP);
  LR := lua_pcall(FState, Length(AParams), 1, 0);
  CheckLuaError(LR);
  lua_pop(FState, 1);
  case lua_type(FState, -1) of
    LUA_TNIL:
      begin
        Result := nil;
      end;

    LUA_TBOOLEAN:
      begin
        Result := Boolean(lua_toboolean(FState, -1));
      end;

    LUA_TNUMBER:
      begin
        Result := lua_tonumber(FState, -1);
      end;

    LUA_TSTRING:
      begin
        Result := lua_tostring(FState, -1);
      end;
  else
    Result := nil;
  end;
end;

procedure TLua.Bundle(const AInFilename: string; const AOutFilename: string);
var
  LInFilename: string;
  LOutFilename: string;
begin
  if FState = nil then Exit;

  if AInFilename.IsEmpty then  Exit;
  if AOutFilename.IsEmpty then Exit;
  LInFilename := AInFilename.Replace('\', '/');
  LOutFilename := AOutFilename.Replace('\', '/');
  LoadBuffer(@cLUABUNDLE_LUA, Length(cLUABUNDLE_LUA), False);
  DoCall([PChar(LInFilename), PChar(LOutFilename)]);
end;

procedure TLua.OnBeforeReset();
begin
  if Assigned(FOnBeforeReset.Handler) then
  begin
    FOnBeforeReset.Handler(FOnBeforeReset.UserData);
  end;
end;

procedure TLua.OnAfterReset();
begin
  if Assigned(FOnAfterReset.Handler) then
  begin
    FOnAfterReset.Handler(FOnAfterReset.UserData);
  end;
end;

constructor TLua.Create();
begin
  inherited;

  FState := nil;
  Open;
end;

destructor TLua.Destroy();
begin
  Close();
  inherited;
end;

function  TLua.GetBeforeResetCallback(): TLuaResetCallback;
begin
  Result := FOnBeforeReset.Handler;
end;

procedure TLua.SetBeforeResetCallback(const AHandler: TLuaResetCallback; const AUserData: Pointer);
begin
  FOnBeforeReset.Handler := AHandler;
  FOnBeforeReset.UserData := AUserData;
end;

function  TLua.GetAfterResetCallback(): TLuaResetCallback;
begin
  Result := FOnAfterReset.Handler;
end;

procedure TLua.SetAfterResetCallback(const AHandler: TLuaResetCallback; const AUserData: Pointer);
begin
  FOnAfterReset.Handler := AHandler;
  FOnAfterReset.UserData := AUserData;
end;

procedure TLua.Reset();
begin
  if FState = nil then Exit;

  OnBeforeReset();
  Close;
  Open;
  OnAfterReset();
end;

procedure TLua.AddSearchPath(const APath: string);
var
  LPathToAdd: string;
  LCurrentPath: string;
begin
  if not Assigned(FState) then Exit;

  // Check if APath already ends with "?.lua"
  if APath.EndsWith('?.lua') then
    LPathToAdd := APath
  else
    LPathToAdd := IncludeTrailingPathDelimiter(APath) + '?.lua';

  // Retrieve the current package.path
  lua_getglobal(FState, 'package'); // Get the "package" table
  if not lua_istable(FState, -1) then
    raise Exception.Create('"package" is not a table in the Lua state');

  lua_getfield(FState, -1, 'path'); // Get the "package.path" field
  if LongBool(lua_isstring(FState, -1)) then
    LCurrentPath := string(lua_tostring(FState, -1))
  else
    LCurrentPath := ''; // Default to empty if "path" is not set

  lua_pop(FState, 1); // Pop the "package.path" field

  // Check if the path is already included
  if Pos(LPathToAdd, LCurrentPath) = 0 then
  begin
    // Append the new path if not already included
    LCurrentPath := LPathToAdd + ';' + LCurrentPath;

    // Update package.path
    lua_pushstring(FState, AsUTF8(LCurrentPath, [])); // Push the updated path
    lua_setfield(FState, -2, 'path'); // Update "package.path"
  end;

  lua_pop(FState, 1); // Pop the "package" table
end;

function TLua.LoadFile(const AFilename: string; const AAutoRun: Boolean): Boolean;
var
  LMarshall: TMarshaller;
  LErr: string;
  LRes: Integer;
begin
  Result := False;
  if not Assigned(FState) then Exit;

  if AFilename.IsEmpty then Exit;

  if not TFile.Exists(AFilename) then Exit;
  if AAutoRun then
    LRes := luaL_dofile(FState, LMarshall.AsUtf8(AFilename).ToPointer)
  else
    LRes := luaL_loadfile(FState, LMarshall.AsUtf8(AFilename).ToPointer);
  if LRes <> 0 then
  begin
    LErr := lua_tostring(FState, -1);
    lua_pop(FState, 1);
    raise ELuaException.Create(LErr);
  end;

  Result := True;
end;

procedure TLua.LoadString(const AData: string; const AAutoRun: Boolean);
var
  LMarshall: TMarshaller;
  LErr: string;
  LRes: Integer;
  LData: string;
begin
  if not Assigned(FState) then Exit;

  LData := AData;
  if LData.IsEmpty then Exit;

  if AAutoRun then
    LRes := luaL_dostring(FState, LMarshall.AsAnsi(LData).ToPointer)
  else
    LRes := luaL_loadstring(FState, LMarshall.AsAnsi(LData).ToPointer);

  if LRes <> 0 then
  begin
    LErr := lua_tostring(FState, -1);
    lua_pop(FState, 1);
    raise ELuaException.Create(LErr);
  end;
end;

procedure TLua.LoadStream(const AStream: TStream; const ASize: NativeUInt; const AAutoRun: Boolean);
var
  LMemStream: TMemoryStream;
  LSize: NativeUInt;
begin
  if not Assigned(FState) then Exit;

  LMemStream := TMemoryStream.Create;
  try
    if ASize = 0 then
      LSize := AStream.Size
    else
      LSize := ASize;
    LMemStream.Position := 0;
    LMemStream.CopyFrom(AStream, LSize);
    LoadBuffer(LMemStream.Memory, LMemStream.size, AAutoRun);
  finally
    FreeAndNil(LMemStream);
  end;
end;

procedure TLua.LoadBuffer(const AData: Pointer; const ASize: NativeUInt; const AAutoRun: Boolean);
var
  LMemStream: TMemoryStream;
  LRes: Integer;
  LErr: string;
  LSize: NativeUInt;
begin
  if not Assigned(FState) then Exit;

  LMemStream := TMemoryStream.Create;
  try
    LMemStream.Write(AData^, ASize);
    LMemStream.Position := 0;
    LSize := LMemStream.Size;
    if AAutoRun then
      LRes := luaL_dobuffer(FState, LMemStream.Memory, LSize, 'LoadBuffer')
    else
      LRes := luaL_loadbuffer(FState, LMemStream.Memory, LSize, 'LoadBuffer');
  finally
    FreeAndNil(LMemStream);
  end;

  if LRes <> 0 then
  begin
    LErr := lua_tostring(FState, -1);
    lua_pop(FState, 1);
    raise ELuaException.Create(LErr);
  end;
end;

procedure TLua.SaveByteCode(const AStream: TStream);
var
  LRet: Integer;
begin
  if not Assigned(FState) then Exit;

  if lua_type(FState, lua_gettop(FState)) <> LUA_TFUNCTION then Exit;

  try
    LRet := lua_dump(FState, LuaWrapperWriter, AStream);
    if LRet <> 0 then
      raise ELuaException.CreateFmt('lua_dump returned code %d', [LRet]);
  finally
    lua_pop(FState, 1);
  end;
end;

procedure TLua.LoadByteCode(const AStream: TStream; const AName: string; const AAutoRun: Boolean);
var
  LRes: NativeUInt;
  LErr: string;
  LMemStream: TMemoryStream;
  LMarshall: TMarshaller;
begin
  if not Assigned(FState) then Exit;
  if not Assigned(AStream) then Exit;
  if AStream.size <= 0 then Exit;

  LMemStream := TMemoryStream.Create;

  try
    LMemStream.CopyFrom(AStream, AStream.size);

    if AAutoRun then
    begin
      LRes := luaL_dobuffer(FState, LMemStream.Memory, LMemStream.size,
        LMarshall.AsAnsi(AName).ToPointer)
    end
    else
      LRes := luaL_loadbuffer(FState, LMemStream.Memory, LMemStream.size,
        LMarshall.AsAnsi(AName).ToPointer);
  finally
    LMemStream.Free;
  end;

  if LRes <> 0 then
  begin
    LErr := lua_tostring(FState, -1);
    lua_pop(FState, 1);
    raise ELuaException.Create(LErr);
  end;
end;

procedure TLua.PushLuaValue(const AValue: TLuaValue);
begin
  if not Assigned(FState) then Exit;

  case AValue.AsType of
    vtInteger:
      begin
        lua_pushinteger(FState, AValue.AsInteger);
      end;
    vtDouble:
      begin
        lua_pushnumber(FState, AValue.AsNumber);
      end;
    vtString:
      begin
        lua_pushstring(FState, PAnsiChar(UTF8Encode(AValue.AsString)));
      end;
    vtPointer:
      begin
        lua_pushlightuserdata(FState, AValue.AsPointer);
      end;
    vtBoolean:
      begin
        lua_pushboolean(FState, AValue.AsBoolean.ToInteger);
      end;
  else
    begin
      lua_pushnil(FState);
    end;
  end;
end;

var TLua_GetLuaValue_LStr: string = '';
function TLua.GetLuaValue(const AIndex: Integer): TLuaValue;
begin
  Result := Default(TLuaValue);

  if not Assigned(FState) then Exit;

  case lua_type(FState, AIndex) of
    LUA_TNIL:
      begin
        Result := nil;
      end;

    LUA_TBOOLEAN:
      begin
        Result.AsBoolean := Boolean(lua_toboolean(FState, AIndex));
      end;

    LUA_TNUMBER:
      begin
        Result.AsNumber := lua_tonumber(FState, AIndex);
      end;

    LUA_TSTRING:
      begin
        TLua_GetLuaValue_LStr := lua_tostring(FState, AIndex);
        Result := PChar(TLua_GetLuaValue_LStr);
      end;
  else
    begin
      Result := Default(TLuaValue);
    end;
  end;
end;

function TLua.DoCall(const AParams: array of TLuaValue): TLuaValue;
var
  LValue: TLuaValue;
  LRes: Integer;
begin
  if not Assigned(FState) then Exit;

  for LValue in AParams do
  begin
    PushLuaValue(LValue);
  end;

  LRes := lua_pcall(FState, Length(AParams), 1, 0);
  CheckLuaError(LRes);
  Result := GetLuaValue(-1);
end;

function TLua.DoCall(const AParamCount: Integer): TLuaValue;
var
  LRes: Integer;
begin
  Result := nil;
  if not Assigned(FState) then Exit;

  LRes := lua_pcall(FState, AParamCount, 1, 0);
  CheckLuaError(LRes);
  Result := GetLuaValue(-1);
  CleanStack();
end;

procedure TLua.CleanStack();
begin
  if FState = nil then Exit;

  lua_pop(FState, lua_gettop(FState));
end;

function TLua.Call(const AName: string; const AParams: array of TLuaValue): TLuaValue;
var
  LMarshall: TMarshaller;
  LIndex: Integer;
  LItems: TStringDynArray;
begin
  Result := nil;
  if not Assigned(FState) then Exit;

  if AName.IsEmpty then Exit;

  CleanStack();

  LItems := ParseTableNames(AName);

  if Length(LItems) > 1 then
    begin
      if not PushGlobalTableForGet(LItems, LIndex) then
      begin
        CleanStack;
        Exit;
      end;

      lua_getfield(FState,  LIndex, LMarshall.AsAnsi(LItems[LIndex]).ToPointer);
    end
  else
    begin
      lua_getglobal(FState, LMarshall.AsAnsi(LItems[0]).ToPointer);
    end;

  if not lua_isnil(FState, lua_gettop(FState)) then
  begin
    if lua_isfunction(FState, -1) then
    begin
      Result := DoCall(AParams);
    end;
  end;

  CleanStack();
end;

function TLua.PrepCall(const AName: string): Boolean;
var
  LMarshall: TMarshaller;
  LIndex: Integer;
  LItems: TStringDynArray;
begin
  Result := False;
  if not Assigned(FState) then Exit;

  if AName.IsEmpty then Exit;

  CleanStack;

  LItems := ParseTableNames(AName);

  if Length(LItems) > 1 then
    begin
      if not PushGlobalTableForGet(LItems, LIndex) then
      begin
        CleanStack;
        Exit;
      end;

      lua_getfield(FState,  LIndex, LMarshall.AsAnsi(LItems[LIndex]).ToPointer);
    end
  else
    begin
      lua_getglobal(FState, LMarshall.AsAnsi(LItems[0]).ToPointer);
    end;

  Result := True;
end;

function TLua.Call(const AParamCount: Integer): TLuaValue;
begin
  Result := nil;
  if not Assigned(FState) then Exit;

  if not lua_isnil(FState, lua_gettop(FState)) then
  begin
    if lua_isfunction(FState, -1) then
    begin
      Result := DoCall(AParamCount);
    end;
  end;
end;

function TLua.RoutineExist(const AName: string): Boolean;
var
  LMarshall: TMarshaller;
  LIndex: Integer;
  LItems: TStringDynArray;
  LCount: Integer;
  LName: string;
begin
  Result := False;
  if not Assigned(FState) then Exit;

  LName := AName;
  if LName.IsEmpty then  Exit;

  LItems := ParseTableNames(LName);

  LCount := Length(LItems);

  if LCount > 1 then
    begin
      if not PushGlobalTableForGet(LItems, LIndex) then
      begin
        CleanStack;
        Exit;
      end;
      lua_getfield(FState, LIndex, LMarshall.AsAnsi(LItems[LIndex]).ToPointer);
    end
  else
    begin
      lua_getglobal(FState, LMarshall.AsAnsi(LName).ToPointer);
    end;

  if not lua_isnil(FState, lua_gettop(FState)) then
  begin
    if lua_isfunction(FState, -1) then
    begin
      Result := True;
    end;
  end;

  CleanStack();
end;

procedure TLua.Run;
var
  LErr: string;
  LRes: Integer;
begin
  if not Assigned(FState) then Exit;

  // Check if the stack has any values
  if lua_gettop(FState) = 0 then
    raise ELuaException.Create('Lua stack is empty. Nothing to run.');

  // Check if the top of the stack is a function
  if lua_type(FState, lua_gettop(FState)) <> LUA_TFUNCTION then
    raise ELuaException.Create('Top of the stack is not a callable function.');

  // Call the function on the stack
  LRes := lua_pcall(FState, 0, LUA_MULTRET, 0);

  // Handle errors from pcall
  if LRes <> LUA_OK then
  begin
    LErr := lua_tostring(FState, -1);
    lua_pop(FState, 1);
    raise ELuaException.Create(LErr);
  end;
end;


function TLua.VariableExist(const AName: string): Boolean;
var
  LMarshall: TMarshaller;
  LIndex: Integer;
  LItems: TStringDynArray;
  LCount: Integer;
  LName: string;
begin
  Result := False;
  if not Assigned(FState) then Exit;

  LName := AName;
  if LName.IsEmpty then Exit;

  LItems := ParseTableNames(LName);
  LCount := Length(LItems);

  if LCount > 1 then
    begin
      if not PushGlobalTableForGet(LItems, LIndex) then
      begin
        CleanStack;
        Exit;
      end;
      lua_getfield(FState, LIndex, LMarshall.AsAnsi(LItems[LIndex]).ToPointer);
    end
  else if LCount = 1 then
    begin
      lua_getglobal(FState, LMarshall.AsAnsi(LName).ToPointer);
    end
  else
    begin
      Exit;
    end;

  if not lua_isnil(FState, lua_gettop(FState)) then
  begin
    Result := lua_isvariable(FState, -1);
  end;

  CleanStack();
end;

var TLua_GetVariable_LStr: string = '';
function TLua.GetVariable(const AName: string; const AType: TLuaValueType): TLuaValue;
var
  LMarshall: TMarshaller;
  LIndex: Integer;
  LItems: TStringDynArray;
  LCount: Integer;
  LName: string;
begin
  Result := Default(TLuaValue);
  if not Assigned(FState) then Exit;

  LName := AName;
  if LName.IsEmpty then Exit;

  LItems := ParseTableNames(LName);
  LCount := Length(LItems);

  if LCount > 1 then
    begin
      if not PushGlobalTableForGet(LItems, LIndex) then
      begin
        CleanStack;
        Exit;
      end;
      lua_getfield(FState, LIndex, LMarshall.AsAnsi(LItems[LIndex]).ToPointer);
    end
  else if LCount = 1 then
    begin
      lua_getglobal(FState, LMarshall.AsAnsi(LName).ToPointer);
    end
  else
    begin
      Exit;
    end;

  case AType of
    vtInteger:
      begin
        Result.AsInteger := lua_tointeger(FState, -1);
      end;
    vtDouble:
      begin
        Result.AsNumber := lua_tonumber(FState, -1);
      end;
    vtString:
      begin
        TLua_GetVariable_LStr := lua_tostring(FState, -1);
        Result := PChar(TLua_GetVariable_LStr);
      end;
    vtPointer:
      begin
        Result.AsPointer := lua_touserdata(FState, -1);
      end;
    vtBoolean:
      begin
        Result.AsBoolean := Boolean(lua_toboolean(FState, -1));
      end;
  end;

  CleanStack();
end;

procedure TLua.SetVariable(const AName: string; const AValue: TLuaValue);
var
  LMarshall: TMarshaller;
  LIndex: Integer;
  LItems: TStringDynArray;
  LOk: Boolean;
  LCount: Integer;
  LName: string;
begin
  if not Assigned(FState) then Exit;

  LName := AName;
  if LName.IsEmpty then Exit;

  LItems := ParseTableNames(AName);
  LCount := Length(LItems);

  if LCount > 1 then
    begin
      if not PushGlobalTableForSet(LItems, LIndex) then
      begin
        CleanStack;
        Exit;
      end;
    end
  else if LCount < 1 then
    begin
      Exit;
    end;

  LOk := True;

  case AValue.AsType of
    vtInteger:
      begin
        lua_pushinteger(FState, AValue);
      end;
    vtDouble:
      begin
        lua_pushnumber(FState, AValue);
      end;
    vtString:
      begin
        lua_pushstring(FState, LMarshall.AsUtf8(AValue).ToPointer);
      end;
    vtPointer:
      begin
        lua_pushlightuserdata(FState, AValue);
      end;
    vtBoolean:
      begin
        lua_pushboolean(FState, AValue.AsBoolean.ToInteger);
      end;
  else
    begin
      LOk := False;
    end;
  end;

  if LOk then
  begin
    if LCount > 1 then
      begin
        lua_setfield(FState, LIndex, LMarshall.AsAnsi(LItems[LIndex]).ToPointer)
      end
    else
      begin
        lua_setglobal(FState, LMarshall.AsAnsi(LName).ToPointer);
      end;
  end;

  CleanStack();
end;

procedure TLua.RegisterRoutine(const AName: string; const ARoutine: TLuaFunction);
var
  LMethod: TMethod;
  LMarshall: TMarshaller;
  LIndex: Integer;
  LNames: array of string;
  LI: Integer;
  LItems: TStringDynArray;
  LCount: Integer;
begin
  if not Assigned(FState) then Exit;
  if AName.IsEmpty then Exit;

  // parse table LNames in table.table.xxx format
  LItems := ParseTableNames(AName);

  LCount := Length(LItems);

  SetLength(LNames, Length(LItems));

  for LI := 0 to High(LItems) do
  begin
    LNames[LI] := LItems[LI];
  end;

  // init sub table LNames
  if LCount > 1 then
    begin
      // push global table to stack
      if not PushGlobalTableForSet(LNames, LIndex) then
      begin
        CleanStack;
        Exit;
      end;

      // push closure
      LMethod.Code := TMethod(ARoutine).Code;
      LMethod.Data := TMethod(ARoutine).Data;
      lua_pushlightuserdata(FState, Self);
      lua_pushlightuserdata(FState, LMethod.Code);
      lua_pushlightuserdata(FState, LMethod.Data);
      lua_pushcclosure(FState, @LuaWrapperClosure, 3);

      // add field to table
      lua_setfield(FState, -2, LMarshall.AsAnsi(LNames[LIndex]).ToPointer);

      CleanStack();
    end
  else if (LCount = 1) then
    begin
      // push closure
      LMethod.Code := TMethod(ARoutine).Code;
      LMethod.Data := TMethod(ARoutine).Data;
      lua_pushlightuserdata(FState, Self);
      lua_pushlightuserdata(FState, LMethod.Code);
      lua_pushlightuserdata(FState, LMethod.Data);
      lua_pushcclosure(FState, @LuaWrapperClosure, 3);

      // set as global
      lua_setglobal(FState, LMarshall.AsAnsi(LNames[0]).ToPointer);
    end;
end;

procedure TLua.RegisterRoutine(const AName: string; const AData: Pointer; const ACode: Pointer);
var
  LMarshall: TMarshaller;
  LIndex: Integer;
  LNames: array of string;
  LI: Integer;
  LItems: TStringDynArray;
  LCount: Integer;
begin
  if not Assigned(FState) then Exit;
  if AName.IsEmpty then Exit;

  // parse table LNames in table.table.xxx format
  LItems := ParseTableNames(AName);

  LCount := Length(LItems);

  SetLength(LNames, Length(LItems));

  for LI := 0 to High(LItems) do
  begin
    LNames[LI] := LItems[LI];
  end;

  // init sub table LNames
  if LCount > 1 then
    begin
      // push global table to stack
      if not PushGlobalTableForSet(LNames, LIndex) then
      begin
        CleanStack;
        Exit;
      end;

      // push closure
      lua_pushlightuserdata(FState, Self);
      lua_pushlightuserdata(FState, ACode);
      lua_pushlightuserdata(FState, AData);
      lua_pushcclosure(FState, @LuaWrapperClosure, 3);

      // add field to table
      lua_setfield(FState, -2, LMarshall.AsAnsi(LNames[LIndex]).ToPointer);

      CleanStack();
    end
  else if (LCount = 1) then
    begin
      // push closure
      lua_pushlightuserdata(FState, Self);
      lua_pushlightuserdata(FState, ACode);
      lua_pushlightuserdata(FState, AData);
      lua_pushcclosure(FState, @LuaWrapperClosure, 3);

      // set as global
      lua_setglobal(FState, LMarshall.AsAnsi(LNames[0]).ToPointer);
    end;
end;

procedure TLua.RegisterRoutines(const AClass: TClass);
var
  LRttiContext: TRttiContext;
  LRttiType: TRttiType;
  LRttiMethod: TRttiMethod;
  LMethodAutoSetup: TRttiMethod;

  LRttiParameters: TArray<System.Rtti.TRttiParameter>;
  LMethod: TMethod;
  LMarshall: TMarshaller;
begin
  if not Assigned(FState) then Exit;

  LRttiType := LRttiContext.GetType(AClass);
  LMethodAutoSetup := nil;

  for LRttiMethod in LRttiType.GetMethods do
  begin
    if (LRttiMethod.MethodKind <> mkClassProcedure) then continue;
    if (LRttiMethod.Visibility <> mvPublic) then continue;

    LRttiParameters := LRttiMethod.GetParameters;

    // check for public AutoSetup class function
    if SameText(LRttiMethod.Name, cLuaAutoSetup) then
    begin
      if (Length(LRttiParameters) = 1) and (Assigned(LRttiParameters[0].ParamType)) and (LRttiParameters[0].ParamType.TypeKind = tkInterface) and (TRttiInterfaceType(LRttiParameters[0].ParamType).GUID = ILua) then
      begin
        // call auto setup for this class
        // LRttiMethod.Invoke(aClass, [Self]);
        LMethodAutoSetup := LRttiMethod;
      end;
      continue;
    end;

    { Check if one parameter of type ILuaContext is present }
    if (Length(LRttiParameters) = 1) and (Assigned(LRttiParameters[0].ParamType)) and (LRttiParameters[0].ParamType.TypeKind = tkInterface) and (TRttiInterfaceType(LRttiParameters[0].ParamType).GUID = ILuaContext) then
    begin
      // push closure
      LMethod.Code := LRttiMethod.CodeAddress;
      LMethod.Data := AClass;
      lua_pushlightuserdata(FState, Self);
      lua_pushlightuserdata(FState, LMethod.Code);
      lua_pushlightuserdata(FState, LMethod.Data);
      lua_pushcclosure(FState, @LuaWrapperClosure, 3);

      // add field to table
      lua_setglobal(FState, LMarshall.AsAnsi(LRttiMethod.Name).ToPointer);
    end;
  end;

  // clean up stack
  CleanStack();

  // invoke autosetup?
  if Assigned(LMethodAutoSetup) then
  begin
    // call auto setup LMethod
    LMethodAutoSetup.Invoke(AClass, [Self]);

    // clean up stack
    CleanStack();
  end;
end;

procedure TLua.RegisterRoutines(const AObject: TObject);
var
  LRttiContext: TRttiContext;
  LRttiType: TRttiType;
  LRttiMethod: TRttiMethod;
  LMethodAutoSetup: TRttiMethod;
  LRttiParameters: TArray<System.Rtti.TRttiParameter>;
  LMethod: TMethod;
  LMarshall: TMarshaller;
begin
  if not Assigned(FState) then Exit;

  LRttiType := LRttiContext.GetType(AObject.ClassType);
  LMethodAutoSetup := nil;
  for LRttiMethod in LRttiType.GetMethods do
  begin
    if (LRttiMethod.MethodKind <> mkProcedure) then  continue;
    if (LRttiMethod.Visibility <> mvPublic) then continue;

    LRttiParameters := LRttiMethod.GetParameters;

    // check for public AutoSetup class function
    if SameText(LRttiMethod.Name, cLuaAutoSetup) then
    begin
      if (Length(LRttiParameters) = 1) and (Assigned(LRttiParameters[0].ParamType)) and (LRttiParameters[0].ParamType.TypeKind = tkInterface) and (TRttiInterfaceType(LRttiParameters[0].ParamType).GUID = ILua) then
      begin
        // call auto setup for this class
        LMethodAutoSetup := LRttiMethod;
      end;
      continue;
    end;

    { Check if one parameter of type ILuaContext is present }
    if (Length(LRttiParameters) = 1) and (Assigned(LRttiParameters[0].ParamType)) and (LRttiParameters[0].ParamType.TypeKind = tkInterface) and (TRttiInterfaceType(LRttiParameters[0].ParamType).GUID = ILuaContext) then
    begin
      // push closure
      LMethod.Code := LRttiMethod.CodeAddress;
      LMethod.Data := AObject;
      lua_pushlightuserdata(FState, Self);
      lua_pushlightuserdata(FState, LMethod.Code);
      lua_pushlightuserdata(FState, LMethod.Data);
      lua_pushcclosure(FState, @LuaWrapperClosure, 3);

      // add field to table
      lua_setglobal(FState, LMarshall.AsAnsi(LRttiMethod.Name).ToPointer);
    end;
  end;

  // clean up stack
  CleanStack();

  // invoke autosetup?
  if Assigned(LMethodAutoSetup) then
  begin
    // call auto setup LMethod
    LMethodAutoSetup.Invoke(AObject, [Self]);

    // clean up stack
    CleanStack();
  end;
end;

procedure TLua.RegisterRoutines(const ATables: string; const AClass: TClass; const ATableName: string);
var
  LRttiContext: TRttiContext;
  LRttiType: TRttiType;
  LRttiMethod: TRttiMethod;
  LMethodAutoSetup: TRttiMethod;

  LRttiParameters: TArray<System.Rtti.TRttiParameter>;
  LMethod: TMethod;
  LMarshall: TMarshaller;
  LIndex: Integer;
  LNames: array of string;
  TblName: string;
  LI: Integer;
  LItems: TStringDynArray;
  LLastIndex: Integer;
begin
  if not Assigned(FState) then Exit;

  // init the routines table name
  if ATableName.IsEmpty then
    TblName := AClass.ClassName
  else
    TblName := ATableName;

  // parse table LNames in table.table.xxx format
  LItems := ParseTableNames(ATables);

  // init sub table LNames
  if Length(LItems) > 0 then
  begin
    SetLength(LNames, Length(LItems) + 2);

    for LI := 0 to High(LItems) do
    begin
      LNames[LI] := LItems[LI];
    end;

    LLastIndex := Length(LItems);

    // set last as table name for functions
    LNames[LLastIndex] := TblName;
    LNames[LLastIndex + 1] := TblName;
  end
  else
  begin
    SetLength(LNames, 2);
    LNames[0] := TblName;
    LNames[1] := TblName;
  end;

  // push global table to stack
  if not PushGlobalTableForSet(LNames, LIndex) then
  begin
    CleanStack();
    Exit;
  end;

  LRttiType := LRttiContext.GetType(AClass);
  LMethodAutoSetup := nil;
  for LRttiMethod in LRttiType.GetMethods do
  begin
    if (LRttiMethod.MethodKind <> mkClassProcedure) then
      continue;
    if (LRttiMethod.Visibility <> mvPublic) then
      continue;

    LRttiParameters := LRttiMethod.GetParameters;

    // check for public AutoSetup class function
    if SameText(LRttiMethod.Name, cLuaAutoSetup) then
    begin
      if (Length(LRttiParameters) = 1) and (Assigned(LRttiParameters[0].ParamType)) and (LRttiParameters[0].ParamType.TypeKind = tkInterface) and (TRttiInterfaceType(LRttiParameters[0].ParamType).GUID = ILua) then
      begin
        // call auto setup for this class
        // LRttiMethod.Invoke(aClass, [Self]);
        LMethodAutoSetup := LRttiMethod;
      end;
      continue;
    end;

    { Check if one parameter of type ILuaContext is present }
    if (Length(LRttiParameters) = 1) and (Assigned(LRttiParameters[0].ParamType)) and (LRttiParameters[0].ParamType.TypeKind = tkInterface) and (TRttiInterfaceType(LRttiParameters[0].ParamType).GUID = ILuaContext) then
    begin
      // push closure
      LMethod.Code := LRttiMethod.CodeAddress;
      LMethod.Data := AClass;
      lua_pushlightuserdata(FState, Self);
      lua_pushlightuserdata(FState, LMethod.Code);
      lua_pushlightuserdata(FState, LMethod.Data);
      lua_pushcclosure(FState, @LuaWrapperClosure, 3);

      // add field to table
      lua_setfield(FState, -2, LMarshall.AsAnsi(LRttiMethod.Name).ToPointer);
    end;
  end;

  // clean up stack
  CleanStack();

  // invoke autosetup?
  if Assigned(LMethodAutoSetup) then
  begin
    // call auto setup LMethod
    LMethodAutoSetup.Invoke(AClass, [Self]);

    // clean up stack
    CleanStack();
  end;
end;

procedure TLua.RegisterRoutines(const ATables: string; const AObject: TObject; const ATableName: string);
var
  LRttiContext: TRttiContext;
  LRttiType: TRttiType;
  LRttiMethod: TRttiMethod;
  LMethodAutoSetup: TRttiMethod;
  LRttiParameters: TArray<System.Rtti.TRttiParameter>;
  LMethod: TMethod;
  LMarshall: TMarshaller;
  LIndex: Integer;
  LNames: array of string;
  TblName: string;
  LI: Integer;
  LItems: TStringDynArray;
  LLastIndex: Integer;
begin
  if not Assigned(FState) then Exit;

  // init the routines table name
  if ATableName.IsEmpty then
    TblName := AObject.ClassName
  else
    TblName := ATableName;

  // parse table LNames in table.table.xxx format
  LItems := ParseTableNames(ATables);

  // init sub table LNames
  if Length(LItems) > 0 then
    begin
      SetLength(LNames, Length(LItems) + 2);

      LLastIndex := 0;
      for LI := 0 to High(LItems) do
      begin
        LNames[LI] := LItems[LI];
        LLastIndex := LI;
      end;

      // set last as table name for functions
      LNames[LLastIndex] := TblName;
      LNames[LLastIndex + 1] := TblName;
    end
  else
    begin
      SetLength(LNames, 2);
      LNames[0] := TblName;
      LNames[1] := TblName;
    end;

  // push global table to stack
  if not PushGlobalTableForSet(LNames, LIndex) then
  begin
    CleanStack();
    Exit;
  end;

  LRttiType := LRttiContext.GetType(AObject.ClassType);
  LMethodAutoSetup := nil;
  for LRttiMethod in LRttiType.GetMethods do
  begin
    if (LRttiMethod.MethodKind <> mkProcedure) then continue;
    if (LRttiMethod.Visibility <> mvPublic) then continue;

    LRttiParameters := LRttiMethod.GetParameters;

    // check for public AutoSetup class function
    if SameText(LRttiMethod.Name, cLuaAutoSetup) then
    begin
      if (Length(LRttiParameters) = 1) and (Assigned(LRttiParameters[0].ParamType)) and (LRttiParameters[0].ParamType.TypeKind = tkInterface) and (TRttiInterfaceType(LRttiParameters[0].ParamType).GUID = ILua) then
      begin
        // call auto setup for this class
        // LRttiMethod.Invoke(aObject.ClassType, [Self]);
        LMethodAutoSetup := LRttiMethod;
      end;
      continue;
    end;

    { Check if one parameter of type ILuaContext is present }
    if (Length(LRttiParameters) = 1) and (Assigned(LRttiParameters[0].ParamType)) and (LRttiParameters[0].ParamType.TypeKind = tkInterface) and (TRttiInterfaceType(LRttiParameters[0].ParamType).GUID = ILuaContext) then
    begin
      // push closure
      LMethod.Code := LRttiMethod.CodeAddress;
      LMethod.Data := AObject;
      lua_pushlightuserdata(FState, Self);
      lua_pushlightuserdata(FState, LMethod.Code);
      lua_pushlightuserdata(FState, LMethod.Data);
      lua_pushcclosure(FState, @LuaWrapperClosure, 3);

      // add field to table
      lua_setfield(FState, -2, LMarshall.AsAnsi(LRttiMethod.Name).ToPointer);
    end;
  end;

  // clean up stack
  CleanStack();

  // invoke autosetup?
  if Assigned(LMethodAutoSetup) then
  begin
    // call auto setup LMethod
    LMethodAutoSetup.Invoke(AObject, [Self]);

    // clean up stack
    CleanStack();
  end;
end;

procedure TLua.CompileToStream(const AFilename: string; const AStream: TStream; const ACleanOutput: Boolean);
var
  LInFilename: string;
  LBundleFilename: string;
begin
  if not Assigned(FState) then Exit;

  LInFilename := AFilename;
  LBundleFilename := TPath.GetFileNameWithoutExtension(LInFilename) + '_bundle.lua';
  LBundleFilename := TPath.Combine(TPath.GetDirectoryName(LInFilename), LBundleFilename);
  Bundle(LInFilename, LBundleFilename);
  LoadFile(PChar(LBundleFilename), False);
  SaveByteCode(AStream);
  CleanStack;

  if ACleanOutput then
  begin
    if TFile.Exists(LBundleFilename) then
    begin
      TFile.Delete(LBundleFilename);
    end;
  end;
end;

const
  PAYLOADID = 'fa12d33b4ed84bc6a6dc4c2fd07a31e8';

function TLua.PayloadExist(): Boolean;
begin
  Result := False;
  if not Assigned(FState) then Exit;

  Result := ResourceExists(HInstance, PAYLOADID);
end;

function TLua.SavePayloadExe(const AFilename: string): Boolean;
  var
    LDestinationDir: string;
begin
  // Extract the directory portion of the destination path
  LDestinationDir := TPath.GetDirectoryName(AFilename);

  // Create the directory if it doesn't exist
  if not LDestinationDir.IsEmpty and not TDirectory.Exists(LDestinationDir) then
    TDirectory.CreateDirectory(LDestinationDir);

  // Perform the file copy
  TFile.Copy(ParamStr(0), AFilename, True);

  Result := TFile.Exists(AFilename);
end;

function TLua.StorePayload(const ASourceFilename, AEXEFilename: string): Boolean;
var
  LStream: TMemoryStream;
begin
  Result := False;
  if not Assigned(FState) then Exit;

  if not TFile.Exists(ASourceFilename) then Exit;
  if not TFile.Exists(AEXEFilename) then Exit;
  if not IsValidWin64PE(AEXEFilename) then Exit;

  LStream := TMemoryStream.Create();
  try
    CompileToStream(ASourceFilename, LStream, True);
    if LStream.Size > 0 then
    begin
      Result := AddResFromMemory(AEXEFilename, PAYLOADID, LStream.Memory, LStream.Size);
    end;
  finally
    LStream.Free();
  end;
end;

function TLua.UpdatePayloadIcon(const AEXEFilename, AIconFilename: string): Boolean;
begin
  Result := False;
  if not TFile.Exists(AEXEFilename) then Exit;
  if not TFile.Exists(AIconFilename) then Exit;
  if not IsValidWin64PE(AEXEFilename) then Exit;
  UpdateIconResource(AEXEFilename, AIconFilename);
  Result := True;
end;

function TLua.UpdatePayloadVersionInfo(const AEXEFilename: string; const AMajor,
  AMinor, APatch: Word; const AProductName, ADescription, AFilename,
  ACompanyName, ACopyright: string): Boolean;
begin
  Result := False;
  if not TFile.Exists(AEXEFilename) then Exit;
  if not IsValidWin64PE(AEXEFilename) then Exit;
  UpdateVersionInfoResource(AEXEFilename, AMajor, AMinor, APatch, AProductName,
    ADescription, AFilename, ACompanyName, ACopyright);
  Result := True;
end;

function TLua.RunPayload(): Boolean;
var
  LResStream: TResourceStream;
  LErr: string;
  LRes: Integer;
begin
  Result := False;
  if not Assigned(FState) then Exit;

  if not PayloadExist() then Exit;

  Reset();

  LResStream := TResourceStream.Create(HInstance, PAYLOADID, RT_RCDATA);
  try
    LoadBuffer(LResStream.Memory, LResStream.Size, False);
    LResStream.Free();
    LResStream := nil;
  finally
    if Assigned(LResStream) then
      LResStream.Free();
  end;

  // Check if the stack has any values
  if lua_gettop(FState) = 0 then
    raise ELuaException.Create('Lua stack is empty. Nothing to run.');

  // Check if the top of the stack is a function
  if lua_type(FState, lua_gettop(FState)) <> LUA_TFUNCTION then
    raise ELuaException.Create('Top of the stack is not a callable function.');

  // Call the function on the stack
  LRes := lua_pcall(FState, 0, LUA_MULTRET, 0);

  // Handle errors from pcall
  if LRes <> LUA_OK then
  begin
    LErr := lua_tostring(FState, -1);
    lua_pop(FState, 1);
    raise ELuaException.Create(LErr);
  end;

  Result := True;
end;

procedure TLua.UpdateArgs(const AStartIndex: Integer);
var
  LStartIndex: Integer;
begin
  if not Assigned(FState) then Exit;

  LStartIndex := EnsureRange(AStartIndex, 0, ParamCount-1);
  lua_updateargs(FState, LStartIndex);
end;

procedure TLua.SetGCStepSize(const AStep: Integer);
begin
  FGCStep := AStep;
end;

function TLua.GetGCStepSize(): Integer;
begin
  Result := FGCStep;
end;

function TLua.GetGCMemoryUsed(): Integer;
begin
  Result := 0;
  if not Assigned(FState) then Exit;

  Result := lua_gc(FState, LUA_GCCOUNT, FGCStep);
end;

procedure TLua.CollectGarbage();
begin
  if not Assigned(FState) then Exit;

  lua_gc(FState, LUA_GCSTEP, FGCStep);
end;

procedure TLua.Print(const AText: string; const AArgs: array of const);
begin
  if not HasConsoleOutput() then Exit;
  Write(Format(AText, AArgs));
end;

procedure TLua.PrintLn(const AText: string; const AArgs: array of const);
begin
  if not HasConsoleOutput() then Exit;
  WriteLn(Format(AText, AArgs));
end;

{$ENDREGION}

{$REGION ' Pyro '}
{$R Pyro.res}

var
  DepsDLLHandle: THandle = 0;
  DepsDLLFilename: string = '';

procedure UnloadDLL();
begin
  // unload deps DLL
  if DepsDLLHandle <> 0 then
  begin
    FreeLibrary(DepsDLLHandle);
    TFile.Delete(DepsDLLFilename);
    DepsDLLHandle := 0;
    DepsDLLFilename := '';
  end;
end;

function LoadDLL(var AError: string): Boolean;
var
  LResStream: TResourceStream;

  function ea2a82691aa248deb0edb292d942a60e(): string;
  const
    CValue = 'ba6f03d6b70b4dd5afc10255f830339e';
  begin
    Result := CValue;
  end;

  procedure SetError(const AText: string);
  begin
    AError := AText;
  end;

begin
  Result := False;
  AError := 'Failed to load Deps DLL';

  // load deps DLL
  if DepsDLLHandle <> 0 then Exit(True);
  try
    if not ResourceExists(HInstance, PChar(ea2a82691aa248deb0edb292d942a60e())) then

    begin
      SetError('Failed to find Deps DLL resource');
      Exit;
    end;
    LResStream := TResourceStream.Create(HInstance, ea2a82691aa248deb0edb292d942a60e(), RT_RCDATA);
    try
      LResStream.Position := 0;
      DepsDLLFilename := TPath.Combine(TPath.GetTempPath,
        TPath.ChangeExtension(TPath.GetGUIDFileName.ToLower, '.'));
      if not HasEnoughDiskSpace(TPath.GetDirectoryName(DepsDLLFilename), LResStream.Size) then
      begin
        AError := 'Not enough disk space to extract the Deps DLL';
        Exit;
      end;

      LResStream.SaveToFile(DepsDLLFilename);
      if not TFile.Exists(DepsDLLFilename) then
      begin
        SetError('Failed to find extracted Deps DLL');
        Exit;
      end;
      DepsDLLHandle := LoadLibrary(PChar(DepsDLLFilename));
      if DepsDLLHandle = 0 then
      begin
        SetError('Failed to load extracted Deps DLL: ' + SysErrorMessage(GetLastError));
        Exit;
      end;

      GetExports(DepsDLLHandle);

      Result := True;
    finally
      LResStream.Free();
    end;
  except
    on E: Exception do
      SetError('Unexpected error: ' + E.Message);
  end;
end;

{$ENDREGION}

{$REGION ' Unit Init & Fini '}

var
  LError: string;
  I: Integer;

initialization
begin
  ReportMemoryLeaksOnShutdown := True;

  CriticalSection := TCriticalSection.Create();
  SetConsoleCP(CP_UTF8);
  SetConsoleOutputCP(CP_UTF8);
  EnableVirtualTerminalProcessing();  

  if not LoadDLL(LError) then
  begin
    MessageBox(0, PChar(LError), 'Critical Initialization Error', MB_ICONERROR);
    Halt(1); // Exit the application with a non-zero exit code to indicate failure
  end;

  sfVideo := Default(TsfVideo);
  sfAudio := Default(TsfAudio);  

  // init random number generator
  System.Randomize;

  // init sin/cos tables
  for I := 0 to 360 do
  begin
    sfMath.FCosTable[I] := cos((I * PI / 180.0));
    sfMath.FSinTable[I] := sin((I * PI / 180.0));
  end;
end;

finalization
begin
  try
    sfAudio_close();
    sfVideo_destroy();
    UnloadDLL();
    CriticalSection.Free()    
  except
    on E: Exception do
    begin
      MessageBox(0, PChar(E.Message), 'Critical Shutdown Error', MB_ICONERROR);
    end;
  end;
end;
{$ENDREGION}

end.
