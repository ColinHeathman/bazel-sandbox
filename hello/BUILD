load("@io_bazel_rules_docker//container:container.bzl", "container_image", "container_layer", "container_pull")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load("@io_bazel_rules_docker//docker/util:run.bzl", "container_run_and_commit")
load("@bazel_tools//tools/build_defs/pkg:pkg.bzl", "pkg_tar")

pkg_tar(
    name = "image_contents",
    package_dir = "/app",
    srcs = [
      "data.yaml",
      "filter.jq",
      "script.sh",
    ],
    mode = "0644",
)

container_layer(
    name = "contents_layer",
    tars = [
        ":image_contents",
    ],
)

container_image(
    name = "base",
    base = "@alpine//image",
    layers = [":contents_layer"],
)

container_run_and_commit(
    name = "alpine_install",
    commands = [
        "apk add --no-cache python3 py3-pip jq",
        "pip3 install yq",
        "chmod +x app/script.sh",
    ],
    image = ":base.tar",
)

container_image(
    name = "image",
    base = ":alpine_install",
    workdir = "/app", 
    entrypoint = [ "/bin/ash" ],
    cmd = ["script.sh"],
)

# Tests
container_test(
    name = "image_test",
    configs = ["//hello/test_configs:hello.yaml"],
    image = ":image",
    tags = ["manual", "broken"],
)
