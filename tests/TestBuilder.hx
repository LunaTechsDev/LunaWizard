import js.node.Path;
import utest.Assert;
import wizard.Builder;
import utest.Test;
import sys.io.File;
import sys.FileSystem;
import haxe.Json;
import utils.FileSystemExt;

class TestBuilder extends Test {
  function setupClass() {
    var path = Path.parse(Sys.getCwd());
    if (path.base != 'temp') {
      Sys.setCwd(Path.resolve('./tests/temp/'));
    }
  }

  function teardownClass() {
    FileSystemExt.deleteDirectoryContents(Sys.getCwd());
  }

  function testAddGameDirectory() {
    Builder.addGamesDirectory(Sys.getCwd());
    var exists = FileSystem.exists('${Sys.getCwd()}/games/');
    Assert.isTrue(exists, 'games directory should exist');
  }

  function testAddSrcDirectory() {
    Builder.addSrcDirectory(Sys.getCwd());
    var exists = FileSystem.exists('${Sys.getCwd()}/src/');
    Assert.isTrue(exists, 'src directory should exist');
  }

  function testAddCheckstyleJson() {
    Builder.addCheckstyleJson(Sys.getCwd());
    var exists = FileSystem.exists('${Sys.getCwd()}/checkstyle.json');
    Assert.isTrue(exists, 'checkstyle.json should exist');
  }

  function testAddFormatJson() {
    Builder.addHaxeFormatJson(Sys.getCwd());
    var exists = FileSystem.exists('${Sys.getCwd()}/hxformat.json');
    Assert.isTrue(exists, 'hxformat.json should exist');
  }

  function testCompileFromSource() {
    var hxmlPath = Path.resolve('../fixtures/compile.hxml');
    Sys.setCwd(Path.dirname(hxmlPath));
    Builder.compileFromSource(hxmlPath);
    var exists = FileSystem.exists('${Sys.getCwd()}/temp.output.js');
    Assert.isTrue(exists, 'temp.output.js should exist');
    // Cleanup
    FileSystem.deleteFile('${Sys.getCwd()}/output.js');
    FileSystem.deleteFile('${Sys.getCwd()}/temp.output.js');
  }
}
