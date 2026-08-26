# Set profile based on CPU architecture
if test (uname -m) = "arm64"
    set -gx MISE_ENV arm64
else
    set -gx MISE_ENV intel
end

# Hook activation
if status is-interactive
    mise activate fish | source
else
    mise activate fish --shims | source
end
