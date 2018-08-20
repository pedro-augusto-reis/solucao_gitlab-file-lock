### Sobre
Solução para funcionalidade da versão paga, Enterpreise - EE, do GitLab para travar mudanças em arquivos. Buscando uma alternativa _free_, pesquisou-se  outras soluções na internet, mas não foi encontrada uma fonte que desenvolvesse a solução por completo ou mesmo atendesse todos os requisitos que se buscavam.  

O funcionamento desta solução é baseado na criação de um arquivo nomeado `.gitlabfilelock`, na raiz de qualquer repositório GitLab, e com a utilização de um _hook_ customizado a ação irá validar se determinado arquivo está sendo modificado ou não ao realizarem o comando PUSH, impedindo  assim qualquer alteração.  

Conforme [documentação](https://docs.gitlab.com/ee/administration/custom_hooks.html), o arquivo `pre-receive` pode ser escrito em qualquer linguagem:
> "Write the code to make the Git hook function as expected. Hooks can be in any language. Ensure the 'shebang' at the top properly reflects the language type."

Para esta solução, utilizou-se ambas opções **Shell Script** ou **Ruby**.

### Metas
1. **OK** - ~~Trava de mudança para arquivos a partir de outro arquivo descritor~~;
2. **OK** - ~~Trava de mudança para arquivos com mesmo nome, mas em diretórios diferentes~~;
3. **OK** - ~~Informar todos os arquivos que foram modificados e estão na regra para não serem modificados de uma vez, em vez de informar o primeiro encontrado e retornar `exit 1`~~.
4. **OK - apenas Ruby** - ~~Criar regra de forma global, não tendo que ajustar arquivo `pre-receive` em cada projeto~~; 
5. **OK - apenas Ruby** - ~~Criar solução que permita que apenas usuários com determinada [permissão](https://docs.gitlab.com/ee/user/permissions.html) possam realizar mudanças no arquivo `.gitlabfilelock`~~;
