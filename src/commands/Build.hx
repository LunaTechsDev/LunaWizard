package commands;

import chokidar.Chokidar;
import prompts.Prompter;
import wizard.utils.HxmlDiscovery;
import wizard.Builder;
import wizard.utils.Logger;
/**
  Build your project from the hxml file given. If no path was given
  then LunaWizard will find all .hxml files in your project and prompt you
  to use which ones for compilation.
**/
class Build extends mcli.CommandLine {
  private var _log: Logger = new Logger();
  private var _sourceDir: String = '';
  /**
    Disable application of prettier's rules
  **/
  public var noPrettier: Bool = false;
  /**
    An option to removed unused classes
  **/
  public var unusedClasses: Bool = true;

  /** 
    Watch for changes to source files.
  **/
  public function watch(path: String) {
    _sourceDir = path;
  }

  private function _watch(sourceDir: String, hxml: String) {
    Chokidar.watch(sourceDir, {
      persistent: true,
      usePolling: true,
      ignoreInitial: false
    })
    .on('ready', () -> {
      _log.info('Watching for changes..');
    })
    .on('change', (path, stats) -> {
      _log.clearScreen();
      Builder.compileFromSource(hxml, !noPrettier);
      _log.info('Watching for changes..');
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
      if (_sourceDir != '') {
        _log.clearScreen();
        return _watch(_sourceDir, response.hxmlPath);
      }
      Builder.compileFromSource(response.hxmlPath, !noPrettier, unusedClasses);
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
