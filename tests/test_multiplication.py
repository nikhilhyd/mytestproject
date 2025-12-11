from calculator import multiply
import pytest

@pytest.mark.parametrize("a, b, result", [
    (3, 2, 6),
    (-1, 5, -5),
    (-2, -3, 6),
    (0, 10, 0)
])
def test_multiplication(a, b, result):
    assert multiply(a, b) == result
