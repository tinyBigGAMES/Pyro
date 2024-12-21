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

program Testbed;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  UTestbed in 'UTestbed.pas',
  Pyro in '..\..\src\Pyro.pas',
  UFunctions in 'UFunctions.pas';

begin
  try
    RunTests();
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
