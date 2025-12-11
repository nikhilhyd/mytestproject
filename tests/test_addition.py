from calculator import add
import pytest

@pytest.mark.parametrize("a, b, result", [
    (1, 2, 3),
    (-1, -1, -2),
    (-5, 10, 5),
    (0, 5, 5)
])
def test_addition(a, b, result):
    assert add(a, b) == result
