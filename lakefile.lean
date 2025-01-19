import Lake
open Lake DSL

require «lean-ecs» from git "https://github.com/funexists/lean-ecs.git" @ "fbac80e3c0a3bd68361bf779a982e41b3f081603"

require raylean from git "https://github.com/funexists/raylean.git" @ "3a60f54222e06767daa93e50a8fcbc68975eee4c" with
  NameMap.empty
    |>.insert `bundle "off"
    |>.insert `resvg "disable"

package "orbital" where
  srcDir := "src"

lean_lib «Orbital» where

@[default_target]
lean_exe "orbital" where
  root := `Main
  moreLinkArgs := Id.run do
    let mut args := #[ "lib/libraylib.a"]
    if (← System.Platform.isOSX) then
      args := args ++
        #[ "-isysroot", "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk"
         , "-framework", "IOKit"
         , "-framework", "Cocoa"
         , "-framework", "OpenGL"
         ]
    args
