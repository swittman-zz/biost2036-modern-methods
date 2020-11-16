# ./test_my_code.py
import math

import pytest

from . import my_code

test_data = [
    (-1, 0),
    (0, 1),
    ([0, 1], [1, 2]),
    ([], []),
]


@pytest.mark.parametrize("data,expected", test_data)
def test_increment(data, expected):
    assert my_code.increment(data) == expected


def test_increment_with_nan():
    data = [math.nan]
    assert math.isnan(my_code.increment(data)[0])
