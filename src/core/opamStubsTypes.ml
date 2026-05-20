(**************************************************************************)
(*                                                                        *)
(*    Copyright 2018 MetaStack Solutions Ltd.                             *)
(*                                                                        *)
(*  All rights reserved. This file is distributed under the terms of the  *)
(*  GNU Lesser General Public License version 2.1, with the special       *)
(*  exception on linking described in the file LICENSE.                   *)
(*                                                                        *)
(**************************************************************************)

(** Types for C stubs modules and common C stubs. *)

(** CONSOLE_SCREEN_BUFFER_INFO struct
    (see https://docs.microsoft.com/en-us/windows/console/console-screen-buffer-info-str)
 *)
type console_screen_buffer_info = {
  size: int * int;
    (** Width and height of the screen buffer *)
  cursorPosition: int * int;
    (** Current position of the console cursor (caret) *)
  attributes: int;
    (** Screen attributes; see https://docs.microsoft.com/en-us/windows/console/console-screen-buffers#_win32_character_attributes *)
}

(** CONSOLE_FONT_INFOEX struct
    (see https://docs.microsoft.com/en-us/windows/console/console-font-infoex)
 *)
type console_font_infoex = {
  fontFamily: int;
    (** Font pitch and family (low 8 bits only).
        See tmPitchAndFamily in
        https://msdn.microsoft.com/library/windows/desktop/dd145132 *)
  faceName: string;
    (** Name of the typeface *)
}

(** Win32 API handles *)
type handle

(** Standard handle constants
    (see https://docs.microsoft.com/en-us/windows/console/getstdhandle) *)
type stdhandle = STD_INPUT_HANDLE | STD_OUTPUT_HANDLE | STD_ERROR_HANDLE


(** Win32 Root Registry Hives (see
    https://msdn.microsoft.com/en-us/library/windows/desktop/ms724836.aspx) *)
type registry_root =
| HKEY_CLASSES_ROOT
| HKEY_CURRENT_CONFIG
| HKEY_CURRENT_USER
| HKEY_LOCAL_MACHINE
| HKEY_USERS

(** Win32 Registry Value Types (see
    https://msdn.microsoft.com/en-us/library/windows/desktop/ms724884.aspx *)
type _ registry_value =
| REG_SZ : string registry_value

(** Windows Messages (at least, one of them!) *)
type ('a, 'b, 'c) winmessage =
| WM_SETTINGCHANGE : (int, string, int) winmessage
  (** See https://msdn.microsoft.com/en-us/library/windows/desktop/ms725497.aspx *)

type windows_cpu_architecture = private
| AMD64   (* 0x9 *)
| ARM     (* 0x5 *)
| ARM64   (* 0xc *)
| IA64    (* 0x6 *)
| Intel   (* 0x0 *)
| Unknown (* 0xffff *)



(** Predefined version information strings (see VerQueryValueW) *)
type win32_non_fixed_version_info = {
  productVersionString: string option;
}

(** VS_FIXEDFILEINFO *)
type win32_version_info = {
  strings: ((int * int) * win32_non_fixed_version_info) list;
    (** Non-fixed string table. First field is a pair of Language and Codepage ID. *)
}

type uname = {
  sysname : string;
  release : string;
  machine : string;
}

external is_executable : string -> bool = "opam_is_executable"
(** faccessat on Unix; _waccess on Windows. Checks whether a path is executable
    for the current process. On Unix, unlike Unix.access, this is checked using
    the EUID/EGID rather than RUID/RGID. *)

external nproc : unit -> nativeint = "opam_nproc"
(** Returns the number of logical processors of the current machine.
    Any value below [1] is an error. *)
