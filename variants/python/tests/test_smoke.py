from __PACKAGE_NAME__ import hello


def test_hello() -> None:
    assert hello() == "Hello from __PROJECT_NAME__."
