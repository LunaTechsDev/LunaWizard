import utest.utils.TestBuilder;
import js.node.Path;
import wizard.NodePackage;
import utest.Test;
import utest.Assert;
import sys.io.File;
import sys.FileSystem;
import utils.FileSystemExt;
import haxe.Json;
import hx.files.*;

using StringTools;

class TestNodePackage extends Test {
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

  function testInstall() {
    NodePackage.createPackageJson();
    var result = NodePackage.install('is-sorted');
    var packageJson = File.read('${Sys.getCwd()}/package-lock.json').readAll().toString();
    var data: Dynamic = Json.parse(packageJson);
    var regex = new EReg("is-sorted", 'g');

    Assert.isTrue(data.dependencies != null, 'Dependencies should exist');
    Assert.match(regex, packageJson, 'is-sorted should exist in package-lock.json');
  }
}
