#!/usr/bin/awk -f
# Usage: awk -f parse-packages.awk project-map.txt package-listing.txt
#
# project-map.txt: lines of "stem=absolute/path/to/project.csproj"
# package-listing.txt: output of "dotnet list package"

FILENAME != "-" && FILENAME != "/dev/stdin" {
    # First file(s): build stem -> path map
    i = index($0, "=")
    if (i > 0) {
        stem = substr($0, 1, i - 1)
        path = substr($0, i + 1)
        projmap[stem] = path
    }
    next
}

/Project '/ {
    proj = $0
    sub(/.*Project '/, "", proj)
    sub(/' .*/, "", proj)
    if (started) close_proj()
    started = 1
    npkg = 0
    if (nproj) printf ",\n"
    nproj++
    resolved = proj
    if (proj in projmap) resolved = projmap[proj]
    printf "  {\n    \"project\": \"%s\",\n    \"packages\": [\n", resolved
}
/>[[:space:]]/ {
    if (!started) next
    pkg = $0
    sub(/.*>[[:space:]]*/, "", pkg)
    sub(/[[:space:]].*/, "", pkg)
    lpkg = tolower(pkg)
    if (lpkg !~ /[jnx]unit/) next
    if (npkg) printf ",\n"
    printf "      {\n        \"id\": \"%s\"\n      }", pkg
    npkg++
}
function close_proj() {
    printf "\n    ]\n  }"
}
BEGIN { printf "[\n" }
END   { if (started) close_proj(); printf "\n]\n" }
