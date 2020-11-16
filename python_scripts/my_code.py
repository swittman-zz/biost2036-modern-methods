# ./my_code.py
#
# Example for simple function to be tested
from typing import Union, List

Numeric = Union[int, float]


def increment(value: Union[Numeric, List[Numeric]]):
    if isinstance(value, list):
        return [increment(x) for x in value]
    return value + 1
