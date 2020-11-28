. "$(dirname "$0")"/common.sh

if [[ "$#" -ne "1" ]]; then
  echo "usage: $0 <version>"
  echo "e.g. $0 0.10.0"
  exit 1
fi

version=$1

echo "Setting version: $version"

versionExpr="s/version: .*/version: ${version}/g"
update pubspec.yaml "${versionExpr}"
update generator/pubspec.yaml "${versionExpr}"
update flutter_libs/pubspec.yaml "${versionExpr}"
update sync_flutter_libs/pubspec.yaml "${versionExpr}"

dependencyHigherExpr="s/objectbox: \^.*/objectbox: ^${version}/g"
update README.md "${dependencyHigherExpr}"
update example/flutter/objectbox_demo/pubspec.yaml "${dependencyHigherExpr}"
update example/flutter/objectbox_demo_desktop/pubspec.yaml "${dependencyHigherExpr}"
update example/flutter/objectbox_demo_sync/pubspec.yaml "${dependencyHigherExpr}"

dependencyExactExpr="s/objectbox: [0-9]\+.*/objectbox: ${version}/g"
update generator/pubspec.yaml "${dependencyExactExpr}"
update flutter_libs/pubspec.yaml "${dependencyExactExpr}"
update sync_flutter_libs/pubspec.yaml "${dependencyExactExpr}"

update CHANGELOG.md "s/## latest.*/## ${version} ($(date -I))/g"