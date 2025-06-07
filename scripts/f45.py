#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.12"
# dependencies = [
# "typer",
# "attrs",
# ]
# ///

import enum
import pathlib
import random
import subprocess
from collections.abc import Iterable
from typing import Annotated

import attrs
import rich
import typer


WORKOUTS_DIR = pathlib.Path.home() / "Documents/Workouts"


class WorkoutName(enum.StrEnum):
    ABACUS = "Abacus"
    ALL_STAR = "All Star"
    ANGRY_BIRD = "Angry Bird"
    DOCKLANDS = "Docklands"
    EMPIRE = "Empire"
    GOAT = "Goat"
    MKATZ = "Mkatz"
    MONT_BLANC = "Mont Blanc"
    MVP = "MVP"
    PEGASUS = "Pegasus"
    PISTON = "Piston"
    QUARTERBACKS = "Quarterbacks"
    RED_DIAMOND = "Red Diamond"
    TWENTY_TWO = "22"
    VARSITY = "Varsity"


class WorkoutType(enum.StrEnum):
    CARDIO = "cardio"
    STRENGTH = "strength"
    ALL = "all"


VIDEO_MAPPING: dict[WorkoutName, WorkoutType] = {
    WorkoutName.ALL_STAR: WorkoutType.STRENGTH,
    WorkoutName.ANGRY_BIRD: WorkoutType.STRENGTH,
    WorkoutName.GOAT: WorkoutType.STRENGTH,
    WorkoutName.MKATZ: WorkoutType.STRENGTH,
    WorkoutName.PEGASUS: WorkoutType.STRENGTH,
    WorkoutName.RED_DIAMOND: WorkoutType.STRENGTH,
    WorkoutName.PISTON: WorkoutType.CARDIO,
    WorkoutName.TWENTY_TWO: WorkoutType.CARDIO,
    WorkoutName.ABACUS: WorkoutType.CARDIO,
    WorkoutName.EMPIRE: WorkoutType.CARDIO,
    WorkoutName.MONT_BLANC: WorkoutType.CARDIO,
    WorkoutName.MVP: WorkoutType.CARDIO,
    WorkoutName.QUARTERBACKS: WorkoutType.CARDIO,
    WorkoutName.VARSITY: WorkoutType.CARDIO,
    WorkoutName.DOCKLANDS: WorkoutType.CARDIO,
}


@attrs.frozen
class Video:
    name: WorkoutName
    ordinal: int
    path: pathlib.Path
    type: WorkoutType


app = typer.Typer()


def collect_videos(by_type: WorkoutType) -> Iterable[Video]:
    workouts: dict[WorkoutName, list[Video]] = {}
    workout_names = [w for w in WorkoutName]
    for path in WORKOUTS_DIR.rglob("*"):
        for workout_name in workout_names:
            if workout_name in str(path):
                video_type = VIDEO_MAPPING[workout_name]
                video = Video(
                    name=workout_name,
                    ordinal=len(workouts.get(workout_name, [])) + 1,
                    path=path,
                    type=video_type,
                )
                workouts.setdefault(workout_name, []).append(video)

    all_videos = sorted(
        [video for videos in workouts.values() for video in videos],
        key=lambda v: (v.name, v.ordinal),
    )

    if by_type == WorkoutType.ALL:
        yield from all_videos
    else:
        yield from (video for video in all_videos if video.type == by_type)


@app.command()
def choose_workout(type: Annotated[WorkoutType, typer.Argument()] = WorkoutType.ALL):
    workouts = list(collect_videos(by_type=type))
    random_video = random.choice(workouts)
    rich.print(
        f"[bold green]{random_video.name}[/bold green] video {random_video.ordinal}"
    )
    if typer.confirm("Let's go?", abort=True):
        _ = subprocess.run(["open", random_video.path])


if __name__ == "__main__":
    app()
