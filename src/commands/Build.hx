package commands;

import chokidar.Chokidar;
import prompts.Prompter;
import wizard.utils.HxmlDiscovery;
import wizard.Builder;

/**
  Build your project from the hxml file given. If no path was given
  then LunaWizard will find all .hxml files in your project and prompt you
  to use which ones for compilation.
**/
class Build extends mcli.CommandLine {
  private var _sourceDir: String = '';
  /**
    Disable application of prettier's rules
  **/
  public var noPrettier: Bool = false;

  /** 
    Watch for changes to source files.
  **/
  public var watch: Bool = false;

  /**
    The source directory to use when watching for file changes.
  **/
  public function sourceDir(path: String) {
    _sourceDir = path;
  }

  private function _watch(sourceDir: String, hxml: String) {
    Chokidar.watch(sourceDir, {
      persistent: true,
      usePolling: true,
      ignoreInitial: false
    })
    .on('change', (path, stats) -> {
      Builder.compileFromSource(hxml, !noPrettier);
    });
  }

  public function help() {
    Sys.println(this.showUsage());
    Sys.exit(0);
  }

  private function promptBuild(hxmlPaths) {
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
      type: 'select',
      name: 'hxmlPath',
      message: 'Choose an hxml to build from',
      choices: choices
    })
    .then((response: Dynamic) -> {
      if (watch) {
        return _watch(_sourceDir, response.hxmlPath);
      }
      Builder.compileFromSource(response.hxmlPath, !noPrettier);
    });
  }

  public function runDefault(?hxml: String) {
    // Build from source files
    if (hxml == null) {
      promptBuild(HxmlDiscovery.discover());
      return;
    }
    Builder.compileFromSource(hxml);
  }
}
