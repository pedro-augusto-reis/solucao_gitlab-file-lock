### Para reproduzir a solução em ambiente de desenvolvimento local, realizar os seguintes passos:
1. Instalação do [GitLab CE](https://about.gitlab.com/installation/). Será utilizado o Docker, mas qualquer forma de instalação pode ser utilizada.
2. Criar e iniciar o _container_  com:
`docker run --hostname localhost --publish 443:443 --publish 80:80 --publish 22:22 --name gitlab --restart always --volume /srv/gitlab/config:/etc/gitlab:Z --volume /srv/gitlab/logs:/var/log/gitlab:Z --volume /srv/gitlab/data:/var/opt/gitlab:Z gitlab/gitlab-ce:latest`  
    2.1. O processo para iniciar o GitLab pode demorar. Após iniciado, acessar http://localhost.
3. Criar um novo repositório e adicionar o arquivo .gitlabfilelock, listando nomes de arquivos que não podem ser criados ou modificados por linha, exemplo:
    > arquivo01.txt  
    > arquivo02  
    > src/main/arquivo03.java  
    
4a. Conforme [documentação](https://docs.gitlab.com/ee/administration/custom_hooks.html) do GitLab, criar em `/var/opt/gitlab/git-data/repositories/<group>/<project>.git` novo diretório `custom_hooks` e o arquivo hook [pre-receive](pre-receive). Essa forma irá especificar o _ hook_ por projeto.  
    4a.1. Verificar se o arquivo é executável. Caso não seja, para ambiente de testes, utilizar o comando linux `chmod +x pre-receive`;   
    4a.2. Verificar se o owner do arquivo é Git. Caso não seja utilizar o comando linux `chown git.git pre-receive`.  
4b. Para criar um _hook_ global que irá afetar todos os repositórios, ajustar o arquivo _pre-receive_ de `/opt/gitlab/embedded/service/gitlab-shell/hooks`, tomando o cuidado de não remover nenhuma linha de código que já existia.
