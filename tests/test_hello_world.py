from hello_world import say_hello


def test_say_hello():
    response = say_hello()
    assert response == "Hello World"
