# flake8: noqa
import os
import sys
import my_project

def very_important_function(
    template: str,
    *variables,
    file: os.PathLike,
    engine: str,
    header: bool = True,
    debug: bool = False
):
    """Applies `variables` to the `template` and writes to `file`."""
    with open(file_name, "w") as f:
        ...
    set([x for x in ["one", "two"])