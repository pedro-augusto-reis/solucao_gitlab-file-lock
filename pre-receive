#!/bin/bash

# variaveis utilizadas
stdIn=`cat`
IFS=' ' read -r -a arrayHash <<< "$stdIn"
IFS=' ' read -r -a arrayArquivosModificados <<< `git diff --name-only "${arrayHash[0]}" "${arrayHash[1]}"`
IFS=' ' read -r -a arrayGitLabFileLock <<< `git show "${arrayHash[1]}:.gitlabfilelock"`
arrayArquivosIdentificados=()

# logica da funcionalidade
if [ "${#arrayArquivosModificados[@]}" != 0 ] && [ "${#arrayGitLabFileLock[@]}" != 0 ] ; then
        for element in "${arrayArquivosModificados[@]}"
        do
                for elementSeg in "${arrayGitLabFileLock[@]}"
                do
                        if [ $element = $elementSeg ] ; then
                                arrayArquivosIdentificados+=($elementSeg)
                        fi
                done
        done
        if [ "${#arrayArquivosIdentificados[@]}" != 0 ] ; then
                printf "\n////////////////////////////"
                printf "\n***** GitLab File Lock *****"
                printf "\n////////////////////////////\n"
                printf "Nao modificar: \n"
                for arquivo in "${arrayArquivosIdentificados[@]}"
                do
                        echo "arquivo ->" $arquivo
                done
                printf "****************************"
                exit 1
        fi
else
        exit 0
fi
