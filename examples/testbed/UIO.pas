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

unit UIO;

interface

uses
  System.SysUtils,
  Pyro,
  UCommon;

procedure ZipFileIO01();

implementation

procedure Test_ZipFile01_BuildProgress(const AFilename: string; const AProgress: Integer; const ANewFile: Boolean; const AUserData: Pointer);
begin
  if aNewFile then PyConsole.PrintLn('', []);
  PyConsole.Print(PyCR+'%sAdding %s(%d%s)...', [PyCSIDim+PyCSIFGWhite, ExtractFileName(string(aFilename)), aProgress, '%']);
end;

procedure ZipFileIO01();
begin
  // Set the console title for the application window
  PyConsole.SetTitle('Pyro: ZipFile #01');

  if  TPyZipFileIO.Build(CZipFilename, 'res', Test_ZipFile01_BuildProgress, nil) then
    PyConsole.PrintLn(PyCRLF+'%sSuccess!', [PyCSIBlink+PyCSIFGCyan])
  else
    PyConsole.PrintLn(PyCRLF+'%sFailed!', [PyCSIBlink+PyCSIFGRed]);
end;

end.
