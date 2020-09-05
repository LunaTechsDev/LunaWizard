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
      Sys.setCwd('./tests/temp/');
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
}
