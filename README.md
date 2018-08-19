#### Sobre
Solução para funcionalidade da versão Enterpreise do GitLab para travar mudanças em arquivo.Esse é um recurso pago do GitLab, buscando uma alternativa buscou-se outras soluções na internet, mas não foi encontrado uma única fonte que desenvolvesse a solução por completo ou mesmo atendesse todos os requisitos que precisava.
Seu funcionamento é baseado na criação de um arquivo nomeado `.gitlabfilelock` na raiz de qualquer repositório e com a utilização de hooks customizados do GitLab, validar se determinado arquivo está sendo modificado ou não na ação de PUSH, impedindo essa alteração.
Conforme documentação, o arquivo `pre-receive` pode ser escrito em qualquer linguagem:
> "Write the code to make the Git hook function as expected. Hooks can be in any language. Ensure the 'shebang' at the top properly reflects the language type."

Para esta solução, utilizou-se Shell Script.

#### Metas
1. Trava de mudança para arquivos a partir de outro arquivo descritor. **OK**
2. Trava de mudança para arquivos com mesmo nome, mas em diretórios diferentes. **OK**
3. Criar regra de forma global, não tendo que ajustar arquivo `pre-receive` em cada projeto.
4. Criar solução que permita que apenas usuários com determinada [permissão](https://docs.gitlab.com/ee/user/permissions.html)  possa realizar mudanças no arquivo `.gitlabfilelock`.

#### Para reproduzir a solução em ambiente de desenvolvimento local, realizar os seguintes passos:
1. Instalação do [GitLab CE](https://about.gitlab.com/installation/). Será utilizado o Docker, mas qualquer forma de instalação pode ser utilizada.
2. Criar e iniciar o _container_  com:
`docker run --hostname localhost --publish 443:443 --publish 80:80 --publish 22:22 --name gitlab --restart always --volume /srv/gitlab/config:/etc/gitlab:Z --volume /srv/gitlab/logs:/var/log/gitlab:Z --volume /srv/gitlab/data:/var/opt/gitlab:Z gitlab/gitlab-ce:latest`
    2.1. O processo para iniciar o GitLab pode demorar, basta aguardar e tentar acessar a página incial com http://localhost
3. Criar um novo repositório e adicionar o arquivo .gitlabfilelock, listando nomes de arquivos que não podem ser criados ou modificados por linha, exemplo:
    > arquivo01.txt
    > arquivo02
    > src/main/arquivo03.java
4. Conforme [documentação](https://docs.gitlab.com/ee/administration/custom_hooks.html) do GitLab, criar em `/var/opt/gitlab/git-data/repositories/<group>/<project>.git` novo diretório `custom_hooks` e o arquivo hook [pre-receive](pre-receive).
