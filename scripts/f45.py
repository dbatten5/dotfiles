#!/usr/bin/env python3
import random
import sys

STRENGTH = {
    "All Star": 2,
    "Angry Bird": 1,
    "GOAT": 1,
    "MKatz": 3,
    "Pegasus": 1,
    "Piston": 4,
}

CARDIO = {
    22: 2,
    "Abacus": 3,
    "Empire": 2,
    "Mont Blanc": 1,
    "MVP": 4,
    "Quarterbacks": 1,
}


def pick_random_vid(videos: dict) -> tuple[str, int]:
    key = random.choice(list(videos.keys()))
    idx = random.randint(0, videos[key] - 1)
    return key, idx


args = sys.argv

if len(args) == 2:
    arg = args[1]

    if arg == "cardio":
        video, idx = pick_random_vid(CARDIO)
        print(f"{video} video {idx + 1}")

    if arg == "strength":
        video, idx = pick_random_vid(STRENGTH)
        print(f"{video} video {idx + 1}")

else:
    video, idx = pick_random_vid({**STRENGTH, **CARDIO})
    print(f"{video} video {idx + 1}")

