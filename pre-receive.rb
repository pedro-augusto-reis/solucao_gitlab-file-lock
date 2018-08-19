#!/usr/bin/env ruby
  2
  3 params = gets
  4 arrayHash = params.split(" ")
  5 arrayArquivosModificados = `git diff --no-commit-id --name-only #{arrayHash[0]}..#{arrayHash[1]}`.split(" ")
  6 arrayGitLabFileLock = `git show #{arrayHash[1]}:.gitlabfilelock`.split(" ")
  7
  8 if (arrayArquivosModificados & arrayGitLabFileLock).length != 0 then
  9         puts "////////////////////////////"
 10         puts "***** GitLab File Lock *****"
 11         puts "////////////////////////////"
 12         puts "Nao modificar:"
 13         puts (arrayArquivosModificados & arrayGitLabFileLock)
 14         exit 1
 15 else
 16         exit 0
 17 end
