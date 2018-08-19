### Sobre
Solução para funcionalidade da versão paga, Enterpreise - EE, do GitLab para travar mudanças em arquivos. Buscando uma alternativa _free_ pesquisou-se  outras soluções na internet, mas não foi encontrada uma fonte que desenvolvesse a solução por completo ou mesmo atendesse todos os requisitos que se buscavam.  

O funcionamento desta solução é baseado na criação de um arquivo nomeado `.gitlabfilelock`, na raiz de qualquer repositório GitLab, e com a utilização de um _hook_ customizado a ação irá validar se determinado arquivo está sendo modificado ou não ao realizarem o comando PUSH, impedindo  assim qualquer alteração.  

Conforme [documentação](https://docs.gitlab.com/ee/administration/custom_hooks.html), o arquivo `pre-receive` pode ser escrito em qualquer linguagem:
> "Write the code to make the Git hook function as expected. Hooks can be in any language. Ensure the 'shebang' at the top properly reflects the language type."

Para esta solução, utilizou-se ambas opções **Shell Script** ou **Ruby**.

### Metas
1. **OK** - ~~Trava de mudança para arquivos a partir de outro arquivo descritor~~;
2. **OK** - ~~Trava de mudança para arquivos com mesmo nome, mas em diretórios diferentes~~;
3. **OK** - ~~Informar todos os arquivos que foram modificados e estão na regra para não serem modificados de uma vez, em vez de informar o primeiro encontrado e retornar `exit 1`~~.
4. **em andamento** - Criar regra de forma global, não tendo que ajustar arquivo `pre-receive` em cada projeto; 
5. **em andamento** - Criar solução que permita que apenas usuários com determinada [permissão](https://docs.gitlab.com/ee/user/permissions.html) possam realizar mudanças no arquivo `.gitlabfilelock`;

### Para reproduzir a solução em ambiente de desenvolvimento local, realizar os seguintes passos:
1. Instalação do [GitLab CE](https://about.gitlab.com/installation/). Será utilizado o Docker, mas qualquer forma de instalação pode ser utilizada.
2. Criar e iniciar o _container_  com:
`docker run --hostname localhost --publish 443:443 --publish 80:80 --publish 22:22 --name gitlab --restart always --volume /srv/gitlab/config:/etc/gitlab:Z --volume /srv/gitlab/logs:/var/log/gitlab:Z --volume /srv/gitlab/data:/var/opt/gitlab:Z gitlab/gitlab-ce:latest`  
    2.1. O processo para iniciar o GitLab pode demorar, basta aguardar e tentar acessar a página incial com http://localhost  
3. Criar um novo repositório e adicionar o arquivo .gitlabfilelock, listando nomes de arquivos que não podem ser criados ou modificados por linha, exemplo:
    > arquivo01.txt
    > arquivo02
    > src/main/arquivo03.java
4. Conforme [documentação](https://docs.gitlab.com/ee/administration/custom_hooks.html) do GitLab, criar em `/var/opt/gitlab/git-data/repositories/<group>/<project>.git` novo diretório `custom_hooks` e o arquivo hook [pre-receive](pre-receive).  
    4.1. Verificar se o arquivo é executável. Caso não seja, para ambiente de testes, utilizar o comando linux chmod + *.  
    4.2. Verificar se o owner do arquivo é Git. Caso não seja utilizar o comando linux chown git.git pre-receive.  
