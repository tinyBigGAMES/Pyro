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

===============================================================================}

unit UTestbed;

interface


procedure RunTests();

implementation

uses
  System.SysUtils,
  System.Classes,
  Pyro;

const
  CZipFilename = 'data.zip';

procedure ErrorCallback(const AText: string; const AUserData: Pointer); cdecl;
begin
  sfConsole_printLn('%s%s', [sfCSIFGRed, AText]);
end;

procedure ZipFileBuildProgress(const ASender: Pointer; const AFilename: string; const AProgress: Integer; const ANewFile: Boolean); cdecl;
begin
  if ANewFile then
    sfConsole_PrintLn('', []);

  sfConsole_print(sfCR+'%sAdding %s(%d%s)...', [sfCSIFGGreen, ExtractFileName(AFilename), AProgress, '%']);
end;

procedure ZipFile01();
begin
  sfConsole_setTitle('PSFM: ZipFile #01');
  sfConsole_clearScreen();

  sfConsole_printLn(sfCRLF+'%sCreating %s...', [sfCSIFGWhite, CZipFilename]);

  if sfZipFile_build(CZipFilename, 'res', sfZipFileDefaultPassword, nil, ZipFileBuildProgress) then
  begin
    sfConsole_printLn('', []);
    sfConsole_printLn('%sSuccess!', [sfCSIBlink + sfCSIFGCyan]);
  end
  else
  begin
    sfConsole_printLn('', []);
    sfConsole_printLn('%sFailed!', [sfCSIBold + sfCSIFGRed]);
  end;

end;

procedure RenderWindow01();
var
  LWindow: PsfRenderWindowEx;
  LEvent: sfEvent;
  LFont: array[0..0] of PsfFont;
  LText: array[0..0] of PsfText;
  LHudPos: sfVector2f;
  LMousePos: sfVector2u;
begin
  LWindow := sfRenderWindow_createEx('Pyro: RenderWindow #01');

  LFont[0] := sfFont_CreateDefaultFont();
  sfFont_SetSmooth(LFont[0], True);

  LText[0] := sfText_Create(LFont[0]);
  sfText_SetCharacterSizeEx(LWindow, LText[0], 12);

  sfRenderWindow_clearEx(LWindow, BLACK);
  sfRenderWindow_clearFrameEx(LWindow, DARKSLATEBROWN);

  while sfRenderWindow_isOpenEx(LWindow) do
  begin

    while sfRenderWindow_pollEventEx(LWindow, @LEvent) do
    begin
      case LEvent.&type of
        sfEvtClosed:
        begin
          sfRenderWindow_closeEx(LWindow);
        end;

        sfEvtResized:
        begin
          sfRenderWindow_resizeFrameEx(LWindow, LEvent.size.size.x, LEvent.size.size.y);
        end;

        sfEvtKeyReleased:
        begin
          case LEvent.key.code of
            sfKeyEscape:
            begin
              sfRenderWindow_closeEx(LWindow);
            end;

            sfKeyF12:
            begin
              sfRenderWindow_toggleFullscreenEx(LWindow);
            end;
          end;
        end;
      end;
    end;

    sfRenderWindow_startFrameEx(LWindow);
      LMousePos := sfRenderWindow_getFrameMousePosEx(LWindow);

      sfRenderWindow_drawFilledRectEx(LWindow, LWindow.Size.x-50, 0, 50, 50, RED);


      sfRenderWindow_drawFilledRectEx(LWindow, 100, 100, 50, 50, RED);
      sfRenderWindow_drawFilledRectEx(LWindow, 110, 110, 50, 50, BLACK);
      sfRenderWindow_drawFilledRectEx(LWindow, 120, 120, 50, 50, GREEN);
      sfRenderWindow_drawFilledRectEx(LWindow, 130, 130, 50, 50, BLUE);


      LHudPos := sfVector2f_Create(3, 3);
      sfRenderWindow_DrawTextVarYEx(LWindow, LText[0], LHudPos.x, LHudPos.y, WHITE, '%d fps', [sfRenderWindow_GetFrameRateEx(LWindow)]);
      sfRenderWindow_DrawTextVarYEx(LWindow, LText[0], LHudPos.x, LHudPos.y, DARKGREEN, 'ESC   - Quit', []);
      sfRenderWindow_DrawTextVarYEx(LWindow, LText[0], LHudPos.x, LHudPos.y, DARKGREEN, 'F12   - Toggle fullscreen', []);
      sfRenderWindow_DrawTextVarYEx(LWindow, LText[0], LHudPos.x, LHudPos.y, DARKORANGE, 'Mouse - X: %d, Y: %d', [LMousePos.x, LMousePos.y]);

    sfRenderWindow_endFrameEx(LWindow);

    sfRenderWindow_displayEx(LWindow);
  end;

  sfText_Destroy(LText[0]);
  sfFont_Destroy(LFont[0]);

  sfRenderWindow_destroyEx(LWindow);
end;

procedure Spine01();
var
  LWindow: PsfRenderWindowEx;
  LEvent: sfEvent;
  LFont: array[0..0] of PsfFont;
  LText: array[0..0] of PsfText;
  LHudPos: sfVector2f;
  LMousePos: sfVector2u;
  LAtlas: PspAtlas;                      // Atlas for Spine animation textures.
  LSkeletonJson: PspSkeletonJson;        // JSON parser for Spine skeleton data.
  LSkeletonData: PspSkeletonData;        // Spine skeleton data.
  LAnimationStateData: PspAnimationStateData; // State data for animation transitions.
  LDrawable: PspSkeletonDrawable;        // Drawable object for the Spine skeleton.
begin
  LWindow := sfRenderWindow_createEx('Pyro: Spine #01');

  LFont[0] := sfFont_CreateDefaultFont();
  sfFont_SetSmooth(LFont[0], True);

  LText[0] := sfText_Create(LFont[0]);
  sfText_SetCharacterSizeEx(LWindow, LText[0], 12);


  // Load the Spine animation atlas.
  LAtlas := spAtlas_createFromFile('res/spine/spineboy/spineboy-pma.atlas', LWindow.Handle);

  // Create a skeleton JSON parser and scale the skeleton.
  LSkeletonJson := spSkeletonJson_create(LAtlas);
  LSkeletonJson.scale := 0.5;

  // Read skeleton data from the JSON file.
  LSkeletonData := spSkeletonJson_readSkeletonDataFile(LSkeletonJson, 'res/spine/spineboy/spineboy-pro.json');

  // Create animation state data and set default transition mix.
  LAnimationStateData := spAnimationStateData_create(LSkeletonData);
  LAnimationStateData.defaultMix := 0.2;

  // Create a drawable skeleton object and set its initial position.
  LDrawable := spSkeletonDrawable_create(LSkeletonData, LAnimationStateData);
  LDrawable.usePremultipliedAlpha := -1; // Enable premultiplied alpha.
  LDrawable.skeleton^.x := 400;         // Set X position.
  LDrawable.skeleton^.y := 500;         // Set Y position.

  // Set the skeleton to its setup pose.
  spSkeleton_setToSetupPose(LDrawable.skeleton);

  // Perform an initial skeleton update.
  spSkeletonDrawable_update(LDrawable, 0, SP_PHYSICS_UPDATE);

  // Set initial animation state: 'portal' followed by 'run' (looped).
  spAnimationState_setAnimationByName(LDrawable.animationState, 0, 'portal', 0);
  spAnimationState_addAnimationByName(LDrawable.animationState, 0, 'run', -1, 0);

  sfRenderWindow_clearEx(LWindow, BLACK);
  sfRenderWindow_clearFrameEx(LWindow, DARKSLATEBROWN);

  while sfRenderWindow_isOpenEx(LWindow) do
  begin

    while sfRenderWindow_pollEventEx(LWindow, @LEvent) do
    begin
      case LEvent.&type of
        sfEvtClosed:
        begin
          sfRenderWindow_closeEx(LWindow);
        end;

        sfEvtResized:
        begin
          sfRenderWindow_resizeFrameEx(LWindow, LEvent.size.size.x, LEvent.size.size.y);
        end;

        sfEvtKeyReleased:
        begin
          case LEvent.key.code of
            sfKeyEscape:
            begin
              sfRenderWindow_closeEx(LWindow);
            end;

            sfKeyF12:
            begin
              sfRenderWindow_toggleFullscreenEx(LWindow);
            end;
          end;
        end;
      end;
    end;

    // Update the skeleton animation based on delta time.

    spSkeletonDrawable_update(LDrawable, LWindow.Timing.DeltaTime, SP_PHYSICS_UPDATE);

    sfRenderWindow_startFrameEx(LWindow);
      LMousePos := sfRenderWindow_getFrameMousePosEx(LWindow);

      // Draw the updated skeleton on the renderer.
      spSkeletonDrawable_draw(LDrawable, LWindow.Handle);

      sfRenderWindow_drawFilledRectEx(LWindow, LWindow.Size.x-50, 0, 50, 50, RED);

      LHudPos := sfVector2f_Create(3, 3);
      sfRenderWindow_DrawTextVarYEx(LWindow, LText[0], LHudPos.x, LHudPos.y, WHITE, '%d fps', [sfRenderWindow_GetFrameRateEx(LWindow)]);
      sfRenderWindow_DrawTextVarYEx(LWindow, LText[0], LHudPos.x, LHudPos.y, DARKGREEN, 'ESC   - Quit', []);
      sfRenderWindow_DrawTextVarYEx(LWindow, LText[0], LHudPos.x, LHudPos.y, DARKGREEN, 'F12   - Toggle fullscreen', []);
      sfRenderWindow_DrawTextVarYEx(LWindow, LText[0], LHudPos.x, LHudPos.y, DARKORANGE, 'Mouse - X: %d, Y: %d', [LMousePos.x, LMousePos.y]);

    sfRenderWindow_endFrameEx(LWindow);

    sfRenderWindow_displayEx(LWindow);
  end;

// Cleanup: Dispose of Spine and SDL resources.
  spSkeletonDrawable_dispose(LDrawable);
  spAnimationStateData_dispose(LAnimationStateData);
  spSkeletonJson_dispose(LSkeletonJson);
  spAtlas_dispose(LAtlas);

  sfText_Destroy(LText[0]);
  sfFont_Destroy(LFont[0]);

  sfRenderWindow_destroyEx(LWindow);
end;

function MyCreateTextureCallback(const APath: PAnsiChar; AUserData: Pointer): PsfTexture; cdecl;
var
  LFilename: string;        // Path to the file inside the ZIP archive.
  LInputStream: PsfInputStreamEx;
begin
  Result := nil;

  // Exit if AUserData (renderer) is not provided.
  if not Assigned(AUserData) then Exit;

  // Exit if APath (file path) is not provided.
  if not Assigned(APath) then Exit;

  // Convert the provided path to a Delphi string.
  LFilename := string(APath);

  // Attempt to load the texture from the ZIP file
  LInputStream := sfInputStream_createFromZipFileEx(CZipFilename, LFilename);
  Result := sfTexture_createFromStreamEx(LInputStream, nil);
  sfInputStream_closeEx(LInputStream);
end;

procedure MyDisposeTextureCallback(ATexture: PsfTexture; AUserData: Pointer); cdecl;
begin
  // Exit if the texture pointer is not valid.
  if not Assigned(ATexture) then Exit;

  // Destroy the texture to free its resources.
  sfTexture_destroy(ATexture);
end;

procedure Spine02();
var
  LWindow: PsfRenderWindowEx;
  LEvent: sfEvent;
  LFont: array[0..0] of PsfFont;
  LText: array[0..0] of PsfText;
  LHudPos: sfVector2f;
  LMousePos: sfVector2u;
  LAtlas: PspAtlas;                      // Atlas for Spine animation textures.
  LSkeletonJson: PspSkeletonJson;        // JSON parser for Spine skeleton data.
  LSkeletonData: PspSkeletonData;        // Spine skeleton data.
  LAnimationStateData: PspAnimationStateData; // State data for animation transitions.
  LDrawable: PspSkeletonDrawable;        // Drawable object for the Spine skeleton.
  LData: Pointer;
  LDataSize: NativeUInt;
  LInputStream: PsfInputStreamEx;
begin
  LWindow := sfRenderWindow_createEx('Pyro: Spine #02');

  LFont[0] := sfFont_CreateDefaultFont();
  sfFont_SetSmooth(LFont[0], True);

  LText[0] := sfText_Create(LFont[0]);
  sfText_SetCharacterSizeEx(LWindow, LText[0], 12);


  // Load the Spine animation atlas from inside zipfile.
  spAtlasPage_setCallbacks(MyCreateTextureCallback, MyDisposeTextureCallback, LWindow);

  LInputStream := sfInputStream_createFromZipFileEx(CZipFilename, 'res/spine/spineboy/spineboy-pma.atlas');
  LDataSize := sfInputStream_getSizeEx(LInputStream);
  GetMem(LData, LDataSize);
  sfInputStream_readEx(LInputStream, LData, LDataSize);
  LAtlas := spAtlas_Create(LData, LDataSize, 'res/spine/spineboy/', LWindow);
  FreeMem(LData);
  sfInputStream_closeEx(LInputStream);

  // Create a skeleton JSON parser and scale the skeleton.
  LSkeletonJson := spSkeletonJson_create(LAtlas);
  LSkeletonJson.scale := 0.5;

  // Read skeleton data from the JSON file.
  LInputStream := sfInputStream_createFromZipFileEx(CZipFilename, 'res/spine/spineboy/spineboy-pro.json');
  LDataSize := sfInputStream_getSizeEx(LInputStream);
  GetMem(LData, LDataSize);
  sfInputStream_readEx(LInputStream, LData, LDataSize);
  LSkeletonData := spSkeletonJson_readSkeletonData(LSkeletonJson, LData);
  FreeMem(LData);
  sfInputStream_closeEx(LInputStream);

  // Create animation state data and set default transition mix.
  LAnimationStateData := spAnimationStateData_create(LSkeletonData);
  LAnimationStateData.defaultMix := 0.2;

  // Create a drawable skeleton object and set its initial position.
  LDrawable := spSkeletonDrawable_create(LSkeletonData, LAnimationStateData);
  LDrawable.usePremultipliedAlpha := -1; // Enable premultiplied alpha.
  LDrawable.skeleton^.x := 400;         // Set X position.
  LDrawable.skeleton^.y := 500;         // Set Y position.

  // Set the skeleton to its setup pose.
  spSkeleton_setToSetupPose(LDrawable.skeleton);

  // Perform an initial skeleton update.
  spSkeletonDrawable_update(LDrawable, 0, SP_PHYSICS_UPDATE);

  // Set initial animation state: 'portal' followed by 'run' (looped).
  spAnimationState_setAnimationByName(LDrawable.animationState, 0, 'portal', 0);
  spAnimationState_addAnimationByName(LDrawable.animationState, 0, 'run', -1, 0);

  sfRenderWindow_clearEx(LWindow, BLACK);
  sfRenderWindow_clearFrameEx(LWindow, DARKSLATEBROWN);

  while sfRenderWindow_isOpenEx(LWindow) do
  begin

    while sfRenderWindow_pollEventEx(LWindow, @LEvent) do
    begin
      case LEvent.&type of
        sfEvtClosed:
        begin
          sfRenderWindow_closeEx(LWindow);
        end;

        sfEvtResized:
        begin
          sfRenderWindow_resizeFrameEx(LWindow, LEvent.size.size.x, LEvent.size.size.y);
        end;

        sfEvtKeyReleased:
        begin
          case LEvent.key.code of
            sfKeyEscape:
            begin
              sfRenderWindow_closeEx(LWindow);
            end;

            sfKeyF12:
            begin
              sfRenderWindow_toggleFullscreenEx(LWindow);
            end;
          end;
        end;
      end;
    end;

    // Update the skeleton animation based on delta time.
    spSkeletonDrawable_update(LDrawable, LWindow.Timing.DeltaTime, SP_PHYSICS_UPDATE);

    sfRenderWindow_startFrameEx(LWindow);
      LMousePos := sfRenderWindow_getFrameMousePosEx(LWindow);

      // Draw the updated skeleton on the renderer.
      spSkeletonDrawable_draw(LDrawable, LWindow.Handle);

      sfRenderWindow_drawFilledRectEx(LWindow, LWindow.Size.x-50, 0, 50, 50, RED);

      LHudPos := sfVector2f_Create(3, 3);
      sfRenderWindow_DrawTextVarYEx(LWindow, LText[0], LHudPos.x, LHudPos.y, WHITE, '%d fps', [sfRenderWindow_GetFrameRateEx(LWindow)]);
      sfRenderWindow_DrawTextVarYEx(LWindow, LText[0], LHudPos.x, LHudPos.y, DARKGREEN, 'ESC   - Quit', []);
      sfRenderWindow_DrawTextVarYEx(LWindow, LText[0], LHudPos.x, LHudPos.y, DARKGREEN, 'F12   - Toggle fullscreen', []);
      sfRenderWindow_DrawTextVarYEx(LWindow, LText[0], LHudPos.x, LHudPos.y, DARKORANGE, 'Mouse - X: %d, Y: %d', [LMousePos.x, LMousePos.y]);

    sfRenderWindow_endFrameEx(LWindow);

    sfRenderWindow_displayEx(LWindow);
  end;

// Cleanup: Dispose of Spine and SDL resources.
  spSkeletonDrawable_dispose(LDrawable);
  spAnimationStateData_dispose(LAnimationStateData);
  spSkeletonJson_dispose(LSkeletonJson);
  spAtlas_dispose(LAtlas);

  sfText_Destroy(LText[0]);
  sfFont_Destroy(LFont[0]);

  sfRenderWindow_destroyEx(LWindow);
end;

procedure OnBeforeReset(const AUserData: Pointer);
var
  LLua: TLua;
begin
  if not Assigned(AUserData) then Exit;
  LLua := TLua(AUserData);
  LLua.PrintLn('OnBeforeReset', []);
end;

procedure OnAfterReset(const AUserData: Pointer);
var
  LLua: TLua;
begin
  if not Assigned(AUserData) then Exit;
  LLua := TLua(AUserData);
  LLua.PrintLn('OnAfterReset', []);
end;

procedure Lua01();
var
  LLua: TLua; // Local variable to hold the TLua instance.
  LBuffer: TStringStream; // Memory stream used to store Lua scripts in memory.
begin
  try
    LLua := TLua.Create(); // Create a new instance of TLua.
    try
      // Register callbacks for reset events.
      LLua.SetBeforeResetCallback(OnBeforeReset, LLua);
      LLua.SetAfterResetCallback(OnAfterReset, LLua);

      // Add a search path where Lua scripts can be located.
      LLua.AddSearchPath('.\res\scripts');

      // Example 1: Load and execute a Lua script directly from a string with AutoRun enabled.
      LLua.PrintLn('LoadString, AutoRun = True', []); // Log the operation.
      LLua.PrintLn('---------------------------', []); // Separator for output clarity.
      LLua.LoadString('print("Hello World! (AutoRun)")'); // Load the script and execute automatically.

      // Example 2: Load a Lua script string without AutoRun and execute it manually.
      LLua.PrintLn('LoadString, AutoRun = False', []); // Log the operation.
      LLua.PrintLn('---------------------------', []); // Separator for output clarity.
      LLua.LoadString('print("Hello World! (No AutoRun)")', False); // Load the script without AutoRun.
      LLua.Run; // Manually execute the script.

      // Example 3: Load a Lua script from a file and execute it automatically.
      LLua.PrintLn('LoadFile, AutoRun = True', []); // Log the operation.
      LLua.PrintLn('---------------------------', []); // Separator for output clarity.
      LLua.LoadFile('Example01.lua'); // Load and execute the script from a file.

      // Example 4: Load a Lua script from a file without AutoRun and execute it manually.
      LLua.PrintLn('LoadFile, AutoRun = False', []); // Log the operation.
      LLua.PrintLn('---------------------------', []); // Separator for output clarity.
      LLua.LoadFile('.\res\scripts\Example01.lua', False); // Load the script without AutoRun.
      LLua.Run; // Manually execute the script.

      // Example 5: Load Lua script from a memory buffer.
      LBuffer := TStringStream.Create('print("Lua running from a buffer!")'); // Create a buffer with Lua code.
      try
        // Load and execute Lua script from the buffer with AutoRun enabled.
        LLua.PrintLn('LoadBuffer, AutoRun = True', []); // Log the operation.
        LLua.PrintLn('---------------------------', []); // Separator for output clarity.
        LLua.LoadBuffer(LBuffer.Memory, LBuffer.Size); // Load and execute the script from the buffer.

        // Load Lua script from the buffer without AutoRun and execute it manually.
        LLua.PrintLn('LoadBuffer, AutoRun = False', []); // Log the operation.
        LLua.PrintLn('---------------------------', []); // Separator for output clarity.
        LLua.LoadBuffer(LBuffer.Memory, LBuffer.Size, False); // Load the script without AutoRun.
        LLua.Run; // Manually execute the script.
      finally
        LBuffer.Free(); // Ensure the memory buffer is properly freed.
      end;
    finally
      LLua.Free(); // Ensure the TLua instance is properly freed.
    end;
  except
    on E: Exception do
      WriteLn('Error: ', E.Message); // Handle exceptions and display error messages.
  end;
end;


type
  TExamples = (
    exZipFile01,
    exRenderWindow01,
    exSpine01,
    exSpine02,
    exLua01
  );

procedure RunTests();
var
  LExample: TExamples;
begin
  sfError_setCallback(ErrorCallback, nil);

  LExample := exLua01;

  case LExample of
    exZipFile01     : ZipFile01();
    exRenderWindow01: RenderWindow01();
    exSpine01       : Spine01();
    exSpine02       : Spine02();
    exLua01         : Lua01();
  end;

  sfConsole_pause(True);
end;

end.
