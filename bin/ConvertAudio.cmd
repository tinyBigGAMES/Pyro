:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                            ___                                          ::
::                           | _ \_  _ _ _ ___                             ::
::                           |  _/ || | '_/ _ \                            ::
::                           |_|  \_, |_| \___/                            ::
::                                |__/                                     ::
::                             Game Library™                               ::
::                                                                         ::
::               Copyright © 2024-present tinyBigGAMES™ LLC                ::
::                        All Rights Reserved.                             ::
::                                                                         ::
::                  Website: https://tinybiggames.com                      ::
::                  Email  : support@tinybiggames.com                      ::
::                                                                         ::
::               See LICENSE file for license information                  ::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

@echo off
cd /d "%~dp0"
@TITLE ConvertVideo
echo Converting audio to DSDL compatible format....
echo(
ffmpeg.exe -i "%s" -ar 48000 -vn -c:a libvorbis -b:a 64k "%s" -loglevel quiet -stats -y
pause