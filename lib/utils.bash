#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/mozilla/sops"
TOOL_NAME="sops"
TOOL_TEST="sops --version"

fail() {
  echo -e "asdf-$TOOL_NAME: $*"
  exit 1
}

curl_opts=(-fsSL --create-dirs)

if [ -n "${GITHUB_API_TOKEN:-}" ]; then
  curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
  git ls-remote --tags --refs "$GH_REPO" |
    grep -o 'refs/tags/.*' | cut -d/ -f3- |
    sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_all_versions() {
  list_github_tags
}

download_release() {
  local version download_folder download_filename release_filename url
  version="$1"
  download_folder="$2"
  download_filename="$download_folder/bin/$TOOL_NAME"
  release_filename="$(get_release_filename "${version}")"

  url="$GH_REPO/releases/download/v${version}/${release_filename}"

  echo "* Downloading $TOOL_NAME release $version..."
  curl "${curl_opts[@]}" -o "$download_filename" "$url" || fail "Could not download $url"
}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="$3"
  local download_folder="$4"

  if [ "$install_type" != "version" ]; then
    fail "asdf-$TOOL_NAME supports release installs only"
  fi

  (
    local tool_cmd
    tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
    cp -r $download_folder/* $install_path
    chmod +x "$install_path/bin/$tool_cmd"
    test -x "$install_path/bin/$tool_cmd" || fail "Expected $install_path/bin/$tool_cmd to be executable."

    echo "$TOOL_NAME $version installation was successful!"
  ) || (
    rm -rf "$install_path"
    fail "An error ocurred while installing $TOOL_NAME $version."
  )
}

# Based on code from https://github.com/salasrod/asdf-cockroach
get_platform_name() {
  if [ "$(uname)" == "Darwin" ]; then
    echo "darwin"
  elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ] || [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    echo "windows"
  elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    echo "linux"
  fi
}

get_release_filename() {
  version=$1
  plat="$(get_platform_name)"
  if [[ "${plat}" == "darwin" ]]; then
    echo "sops-v${version}.darwin"
  elif [[ "${plat}" == "windows" ]]; then
    echo "sops-v${version}.exe"
  elif [[ "${plat}" == "linux" ]]; then
    echo "sops-v${version}.linux"
  else
    echo "Could not find a SOPS binary release for your platform."
    exit 1
  fi
}
