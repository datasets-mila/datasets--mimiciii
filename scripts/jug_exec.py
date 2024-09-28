#!/usr/bin/env python
from jug import is_jug_running

if is_jug_running():
    from sys import argv
    from jug.utils import jug_execute
    jug_execute(argv[1:])
else:
    from sys import argv
    from jug.jug import main
    try:
        # Split and reorder jug's argv from script's argv
        argv[:] = ["jug", "execute"] + argv[1:argv.index("--")] + \
                  [__file__] + argv[argv.index("--"):]
    except ValueError:
        argv[:] = ["jug", "execute", __file__] + argv[1:]
    main(argv)
