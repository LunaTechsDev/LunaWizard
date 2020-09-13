package commands;

import prompts.Prompter;
import wizard.utils.HxmlDiscovery;
import wizard.Builder;

/**
  Build your project from the hxml file given. If no path was given
  then LunaWizard will find all .hxml files in your project and prompt you
  to use which ones for compilation.
**/
class Build extends mcli.CommandLine {
  /**
    Disable application of prettier's rules
  **/
  public var noPrettier: Bool = false;

  public function help() {
    Sys.println(this.showUsage());
    Sys.exit(0);
  }

  public function runDefault(?hxml: String) {
    // Build from source files
    if (hxml == null) {
      var hxmlPaths = HxmlDiscovery.discover();
      var choices = hxmlPaths.map(path -> {
        return {
          title: path,
          value: path,
          description: '',
          disabled: false,
          selected: false
        }
      });
      Prompter.call({
        type: 'multiselect',
        name: 'hxmlPaths',
        message: 'Choose an hxml to build from',
        choices: choices
      }).then((response: Dynamic) -> {
        var paths: Array<String> = response.hxmlPaths;
        for (path in paths) {
          Builder.compileFromSource(path, !noPrettier);
        }
      });
      return;
    }
    Builder.compileFromSource(hxml);
  }
}
