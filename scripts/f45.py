#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.12"
# dependencies = [
# "typer",
# "attrs",
# ]
# ///

import subprocess
import rich
import random
import glob
import pathlib
from typing_extensions import Annotated
import typer
import enum
import attrs
from collections.abc import Iterable


class WorkoutName(enum.StrEnum):
    ABACUS = "Abacus"
    ALL_STAR = "All Star"
    ANGRY_BIRD = "Angry Bird"
    EMPIRE = "Empire"
    GOAT = "Goat"
    MKATZ = "Mkatz"
    MONT_BLANC = "Mont Blanc"
    MVP = "MVP"
    PEGASUS = "Pegasus"
    PISTON = "Piston"
    QUARTERBACKS = "Quarterbacks"
    TWENTY_TWO = "22"


class WorkoutType(enum.StrEnum):
    CARDIO = "cardio"
    STRENGTH = "strength"
    ALL = "all"


@attrs.frozen
class Video:
    name: WorkoutName
    ordinal: int
    path: pathlib.Path
    type: WorkoutType


VIDEO_MAPPING: dict[str, WorkoutType] = {
    WorkoutName.ALL_STAR: WorkoutType.STRENGTH,
    WorkoutName.ANGRY_BIRD: WorkoutType.STRENGTH,
    WorkoutName.GOAT: WorkoutType.STRENGTH,
    WorkoutName.MKATZ: WorkoutType.STRENGTH,
    WorkoutName.PEGASUS: WorkoutType.STRENGTH,
    WorkoutName.PISTON: WorkoutType.STRENGTH,
    WorkoutName.TWENTY_TWO: WorkoutType.CARDIO,
    WorkoutName.ABACUS: WorkoutType.CARDIO,
    WorkoutName.EMPIRE: WorkoutType.CARDIO,
    WorkoutName.MONT_BLANC: WorkoutType.CARDIO,
    WorkoutName.MVP: WorkoutType.CARDIO,
    WorkoutName.QUARTERBACKS: WorkoutType.CARDIO,
}

app = typer.Typer()


def collect_videos(by_type: WorkoutType) -> Iterable[Video]:
    workouts: dict[WorkoutName, list[Video]] = {}
    workout_names = [w for w in WorkoutName]
    for path in glob.glob("/Users/dom.batten/Documents/Workouts/*/**"):
        for workout_name in workout_names:
            if workout_name in path:
                video_type = VIDEO_MAPPING.get(workout_name)
                video = Video(
                    name=workout_name,
                    ordinal=len(workouts.get(workout_name, [])) + 1,
                    path=pathlib.Path(path),
                    type=video_type,
                )
                workouts.setdefault(workout_name, []).append(video)

    all_videos = [video for videos in workouts.values() for video in videos]

    if by_type == WorkoutType.ALL:
        yield from all_videos
    else:
        yield from (video for video in all_videos if video.type == by_type)


@app.command()
def hello(type: Annotated[WorkoutType, typer.Argument()] = WorkoutType.ALL):
    workouts = list(collect_videos(type))
    random_video = random.choice(workouts)
    rich.print(f"{random_video.name} video {random_video.ordinal}")
    if typer.confirm("Let's go?", abort=True):
        subprocess.run(["open", random_video.path])


if __name__ == "__main__":
    app()
