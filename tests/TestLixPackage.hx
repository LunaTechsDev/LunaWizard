import utest.utils.TestBuilder;
import js.node.Path;
import wizard.NodePackage;
import wizard.LixPackage;
import utest.Test;
import utest.Assert;
import sys.io.File;
import sys.FileSystem;
import utils.FileSystemExt;
import haxe.Json;

using StringTools;

class TestLixPackage extends Test {
  function setupClass() {
    var path = Path.parse(Sys.getCwd());
    if (path.base != 'temp') {
      Sys.setCwd(Path.resolve('./tests/temp/'));
    }
  }

  @:depends(TestBuilder.teardownClass)
  function teardownClass() {
    FileSystemExt.deleteDirectoryContents(Sys.getCwd());
  }

  function testGithubInstall() {
    var lix = NodePackage.install('lix');
    if (lix.status) {
      LixPackage.init();
      var result = LixPackage.installFromGithub('inc0der', 'hxprompts');
      if (result.status) {
        Assert.isTrue(FileSystem.exists('haxe_libraries/prompts.hxml'));
      }
      if (!result.status) {
        Assert.fail(result.message);
      }
    } else {
      Assert.fail('Lix should be installed');
    }
  }
}
