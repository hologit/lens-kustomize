pkg_name=lens-kustomize
pkg_origin=holo
pkg_version="1.0"
pkg_maintainer="Chris Alfano <chris@jarv.us>"
pkg_license=("MIT")

pkg_deps=(
  core/bash
  core/node
  jarvus/kubectl
  jarvus/hologit
)

pkg_bin_dirs=(bin)


do_build() {
  return 0
}

do_build() {

  pushd "${CACHE_PATH}" > /dev/null
    build_line "Preparing bin scripts"
    mkdir -v "bin"
    cp -v "${PLAN_CONTEXT}/bin"/* "./bin/"
    fix_interpreter "bin/*" core/node bin/node
    fix_interpreter "bin/*" core/bash bin/bash

    build_line "Running: npm install"
    cp -v "${PLAN_CONTEXT}"/package{,-lock}.json ./
    npm ci
  popd > /dev/null
}

do_install() {
  cp -r "${CACHE_PATH}"/* "${pkg_prefix}/"
}

do_strip() {
  return 0
}
