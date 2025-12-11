from calculator import divide
import pytest

@pytest.mark.parametrize("a, b, result", [
    (6, 3, 2),
    (-10, -2, 5),
    (10, 4, 2.5)
])
def test_division(a, b, result):
    assert divide(a, b) == result

def test_division_by_zero():
    with pytest.raises(ZeroDivisionError):
        divide(10, 0)
