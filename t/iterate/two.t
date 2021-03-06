#!/usr/bin/env _coffee
fs = require "fs"
require("./proof") 5, ({ Strata, directory, fixture: { serialize } }, _) ->
  serialize "#{__dirname}/fixtures/two.json", directory, _

  strata = new Strata directory: directory, leafSize: 3, branchSize: 3
  strata.open(_)

  cursor = strata.iterator("a", _)
  @equal cursor.index, 0, "found"
  @equal cursor.offset, 0, "found"
  @equal cursor.length, 2, "length"

  records = []
  records.push cursor.get(cursor.index, _)

  @equal cursor.index, 0, "same index"
  cursor.unlock()

  records.push cursor.get(cursor.index + 1, _)

  @deepEqual records, [ "a", "b" ], "records"
