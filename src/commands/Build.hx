package commands;

import prompts.Prompter;
import wizard.utils.HxmlDiscovery;
import wizard.Builder;

class Build extends mcli.CommandLine {
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
          Builder.compileFromSource(path);
        }
      });
      return;
    }
    Builder.compileFromSource(hxml);
  }
}
