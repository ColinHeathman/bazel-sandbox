
def hash(name, srcs):
    native.genrule(
        name = name,
        srcs = srcs,
        outs = [ name + ".out" ],
        executable = False,
        # cmd = "ls hello > \"$@\"",
        cmd = "cat {0} | sha256sum | cut -c1-16 > \"$@\"".format("$(rootpaths " + ") $(rootpaths ".join(srcs) + ")"),
    )
