from calculator import subtract
import pytest

@pytest.mark.parametrize("a, b, result", [
    (5, 2, 3),
    (-1, -1, 0),
    (10, -5, 15),
    (0, 5, -5)
])
def test_subtraction(a, b, result):
    assert subtract(a, b) == result
