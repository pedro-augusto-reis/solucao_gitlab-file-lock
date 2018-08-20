#!/usr/bin/env ruby

params = gets
arrayHash = params.split(" ")
arrayArquivosModificados = `git diff --no-commit-id --name-only #{arrayHash[0]}..#{arrayHash[1]}`.split(" ")
arrayGitLabFileLock = `git show #{arrayHash[1]}:.gitlabfilelock`.split(" ")

if (arrayArquivosModificados & arrayGitLabFileLock).length != 0 then
  puts "////////////////////////////"
  puts "***** GitLab File Lock *****"
  puts "////////////////////////////"
  puts "Nao modificar:"
  puts (arrayArquivosModificados & arrayGitLabFileLock)
  exit 1
else
  exit 0
end
