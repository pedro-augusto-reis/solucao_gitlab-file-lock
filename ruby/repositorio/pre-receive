#!/usr/bin/env ruby

params = gets
arrayHash = params.split(" ")
arrayArquivosModificados = `git diff --no-commit-id --name-only #{arrayHash[0]}..#{arrayHash[1]}`.split(" ")
arrayGitLabFileLock = `git show #{arrayHash[1]}:.gitlabfilelock 2> /dev/null`.split(" ")

if ((!arrayGitLabFileLock.nil?) && (arrayGitLabFileLock.length != 0) && ((arrayArquivosModificados & arrayGitLabFileLock).length != 0))
  puts "******************************************************"
  puts "****************** GitLab File Lock ******************"
  puts "1) Arquivo travado pelo ADM do repositorio."
  puts "2) Para conseguir realizar o PUSH, reverta o(s) \narquivo(s) abaixo informado(s) para a revisao anterior\nao commit que o modificou."
  puts "------------------------------------------------------"
  puts (arrayArquivosModificados & arrayGitLabFileLock)
  puts "------------------------------------------------------"
  exit 1
else
  exit 0
end
