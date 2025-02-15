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

unit USpine;

interface

uses
  System.SysUtils,
  System.Classes,
  Pyro,
  UCommon;

procedure Spine01();

implementation

function SpineCreateTextureCallback(const APath: PAnsiChar; AUserData: Pointer): GLuint; cdecl;
var
  LFilename: string;
begin
  Result := 0;

  // Exit if APath (file path) is not provided.
  if not Assigned(APath) then Exit;

  // Convert the provided path to a Delphi string.
  LFilename := string(APath);

  // Load spint texture from zipfile
  Result := TPyTexture.Spine(TPyZipFileIO.Init(CZipFilename, LFilename));
end;

procedure SpineDisposeTextureCallback(ATexture: GLuint; AUserData: Pointer); cdecl;
begin
  // Delete spine texture
  TPyTexture.Delete(ATexture);
end;

procedure Spine01();
var
  LWindow: TPyWindow;
  LPos: TPyPoint;
  LSpAtlas: pspAtlas;
  LSpSkeletonData: pspSkeletonData;
  LSpStateData: pspAnimationStateData;
  LSpDrawable: pspSkeletonDrawable;
  LSpJson: pspSkeletonJson;
  LData: TMemoryStream;
  LHudPos: TPyPoint;
  LFont: TPyFont;
begin
  LPos.x := 0;
  LPos.y := 25;

  LWindow := TPyWindow.Init('Pyro: Spine #01');

  LFont := TPyFont.Init(LWindow, 10);

  spAtlasPage_setCallbacks(SpineCreateTextureCallback, SpineDisposeTextureCallback, nil);

  // Load spine data
  LData := TPyZipFileIO.Load(CZipFilename, 'res/spine/spineboy/spineboy-pma.atlas');
  LSpAtlas := spAtlas_create(LData.Memory, LData.Size, 'res/spine/spineboy', LWindow);
  LData.Free();

  // Load spine json data
  LSpJson := spSkeletonJson_create(LSpAtlas);
  LSpJson.scale := 0.4;

  LData := TPyZipFileIO.Load(CZipFilename, 'res/spine/spineboy/spineboy-pro.json');
  LSpSkeletonData := spSkeletonJson_readSkeletonData(LSpJson, LData.Memory);
  spSkeletonJson_dispose(LSpJson);
  LData.Free();

  LSpStateData := spAnimationStateData_create(LSpSkeletonData);
  LSpStateData.defaultMix := 0.2;

  LSpDrawable := spSkeletonDrawable_create(LSpSkeletonData, LSpStateData);

  // Set initial position
  LSpDrawable.usePremultipliedAlpha := -1;
  LSpDrawable.skeleton.x := 400;
  LSpDrawable.skeleton.y := 500;

  spSkeleton_setToSetupPose(LSpDrawable.skeleton);
  spSkeletonDrawable_update(LSpDrawable, 0, SP_PHYSICS_UPDATE);

  spAnimationState_setAnimationByName(LSpDrawable.animationState, 0, 'portal', 0);
  spAnimationState_addAnimationByName(LSpDrawable.animationState, 0, 'run', -1, 0);

  while not LWindow.ShouldClose() do
  begin
    LWindow.StartFrame();

      if LWindow.GetKey(PyKEY_ESCAPE, isWasPressed) then
        LWindow.SetShouldClose(True);

      if LWindow.GetKey(PyKEY_F11, isWasPressed) then
        LWindow.ToggleFullscreen();

      if LWindow.GetMouseButton(PyMOUSE_BUTTON_RIGHT, isWasReleased) then
        LWindow.SetShouldClose(True);


      LPos.x := LPos.x + 3.0;
      if LPos.x > LWindow.GetVirtualSize().w + 25 then
        LPos.x := -25;

      // Handle input
      if LWindow.GetKey(PyKEY_SPACE, isWasPressed) then
      begin
        spAnimationState_setAnimationByName(LSpDrawable.animationState, 0, 'jump', 0);
        spAnimationState_addAnimationByName(LSpDrawable.animationState, 0, 'walk', 1, 0);
      end;

      if LWindow.GetKey(PyKEY_R, isWasPressed) then
      begin
        spAnimationState_setAnimationByName(LSpDrawable.animationState, 0, 'jump', 0);
        spAnimationState_addAnimationByName(LSpDrawable.animationState, 0, 'run', 1, 0);
      end;

      // Update skeleton
      spSkeletonDrawable_update(LSpDrawable, LWindow.GetDeltaTime(), SP_PHYSICS_UPDATE);

      LWindow.StartDrawing();

        LWindow.Clear(PyDARKSLATEBROWN);

        glDisable(GL_POLYGON_SMOOTH);
        spSkeletonDrawable_draw(LSpDrawable, LWindow.Handle);
        glEnable(GL_POLYGON_SMOOTH);

        LWindow.DrawFilledRect(LPos.x, LPos.y, 50, 50, PyRED, 0);

        LHudPos := PyMath.Point(3, 3);

        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, PyWHITE, haLeft, '%d fps', [LWindow.GetFrameRate()]);
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, PyWHITE, haLeft, PyUtils.HudTextItem('Quit', 'ESC'));
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, PyWHITE, haLeft, PyUtils.HudTextItem('F11', 'Toggle fullscreen'));
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, PyWHITE, haLeft, PyUtils.HudTextItem('Space', 'Jump'));
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, PyWHITE, haLeft, PyUtils.HudTextItem('R', 'Run'));

        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, PyORANGE, haLeft, PyUtils.HudTextItem('Mouse Wheel','x:%3.2f, y:%3.2f', 20, ' '), [LWindow.GetMouseWheel().x, LWindow.GetMouseWheel().y]);
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, PyORANGE, haLeft, PyUtils.HudTextItem('Mouse Pos', 'x:%3.2f, y:%3.2f', 20, ' '), [LWindow.GetMousePos().x, LWindow.GetMousePos().y]);

      LWindow.EndDrawing();

    LWindow.EndFrame();
  end;

  spSkeletonDrawable_dispose(LSpDrawable);
  spSkeletonData_dispose(LSpSkeletonData);
  spAnimationStateData_dispose(LSpStateData);
  spAtlas_dispose(LSpAtlas);

  LFont.Free();

  LWindow.Free();
end;

end.
