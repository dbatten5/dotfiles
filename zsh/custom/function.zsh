function fixup() {
  local current_sha="$(git rev-parse HEAD)"

  git commit --fixup $current_sha
}

function dexec() {
  docker exec -it $1 /bin/bash
}
