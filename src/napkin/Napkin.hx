package napkin;

typedef NapkinOtpions = {
  usePrettier: Bool,
  removedUnusedClasses: Bool
}

@:jsRequire('@lunatechs/lunatea-napkin') extern class Napkin {
  /**
   * Parses the code with prettier and applies specific transformation for the
   * output of plugins developed with LunaTea.
   *
   * @param {code} The code to transform and prettify.
   */
  public static function parse(code: String, ?options: NapkinOtpions): String;
}