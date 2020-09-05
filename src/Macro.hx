package src;

import sys.io.File;
#if macro
import haxe.macro.Context;
import haxe.macro.Compiler;
#end

class Macro {
  #if macro
  public static function shebang() {
    Context.onAfterGenerate(function() {
      var out = Compiler.getOutput();
      File.saveContent(out, '#!/usr/bin/env node\n\n' + File.getContent(out));
    });
  }
  #end
}
