import keyboard

def print_pressed_keys(e):
    key = e.name
    if len(key) == 1 and key.isalnum():
        print(key, end="")
    else:
        print("[", key, "]")
keyboard.on_press(print_pressed_keys)
keyboard.wait()
