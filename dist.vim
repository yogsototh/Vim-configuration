let s:version = join(ghcmod#version(), '.')
echo system(printf('git archive --prefix=ghcmod-vim-%s/ -o ghcmod-vim-%s.zip v%s', s:version, s:version, s:version))
