/*
 * Two failure kinds, kept distinct (same split as pyret-lang/browser-test).
 *
 * ProceduralError: the test could not be conducted -- the site never served an
 * editor, the program never installed, the run never started. Means "look at
 * the deployment / the network", not "the starter file is wrong".
 *
 * A starter file whose program is wrong is NOT an error here: it is a normal
 * result whose outcome is `error` / `tests-failed`, compared against the
 * expectation table.
 */
class ProceduralError extends Error {
  constructor(message) {
    super(message);
    this.name = "ProceduralError";
  }
}

module.exports = { ProceduralError };
