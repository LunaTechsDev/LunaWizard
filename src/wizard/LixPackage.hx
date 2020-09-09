package wizard;

class LixPackage {
  private static function _install(args: Array<String>) {
    args.unshift('install');
    return NodePackage.npx('lix', args);
  }

  public static function init(): Bool {
    return NodePackage.npx('lix', ['scope','create']).status;
  }

  public static function isInstalled(): Bool {
    return NodePackage.npx('lix', ['--help']).status;
  }

  public static function installFromGitlab(user: String, repo: String) {
    return _install(['gitlab:${user}/${repo}']);
  }

  public static function installFromGithub(user: String, repo: String) {
    return _install(['github:${user}/${repo}']);
  }

  public static function installFromHaxelib(name: String) {
    return _install(['haxelib:${name}']);
  }

  public static function download(name: String) {
    return NodePackage.npx('lix', ['download']);
  }
}