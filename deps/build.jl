using UUIDs
using Scratch

const _libdummy = joinpath(get_scratch!(UUID("32aa7d10-2208-4269-9553-8a2b02007e37"), "libdummy"), "libdummy.so")

println("TRYING BUILD _libdummy")
# Build a dummy library which automatically initalises the OpenMP runtime.
if !isnothing(Sys.which("fcc"))
    println("with fcc")
    mkpath(dirname(_libdummy))
    const _fjlibdir = readchomp(`sh -c 'echo "$(dirname "$(which fcc)")/../lib64"'`)
    run(pipeline(`fcc -Nclang -x c - -Kopenmp -Knolargepage -shared -Wl,-rpath=$(_fjlibdir) -L$(_fjlibdir) -lfjlapackexsve_ilp64 -o $(_libdummy)`; stdin=IOBuffer("")))
else
    println("...NO FCC FOUND")
end
