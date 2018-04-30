Neste repositório eu publico algumas ferramentas de linha de comando desenvolvidas por mim.
Qualquer ferramenta que não seja de muita importância a ponto de merecer um repositório próprio vai vir para cá.

## Lista de ferramentas

### lhosts.sh
Ferramenta para listar dispositivos conectados em uma rede.  
Uso: lhosts.sh faixa_de_ip  
Onde **faixa_de_ip** segue a notação CIDR: 192.168.0.0/8  
Onde o sufixo /8 se refere ao comprimento em bits da máscara de rede, que pode receber os valores 8, 12, 16 ou 24.  
Se não souber o que é isso, apenas use /8. (ou [leia isto](https://pt.wikipedia.org/wiki/Classless_Inter-Domain_Routing#Nota.C3.A7.C3.A3o_standard))

Obs.: A verificação do sistema operacional é apenas um chute baseado no TTL da resposta. Onde este é totalmente impreciso.

### wiki.py
Ferramenta para buscar e ler artigos na Wikipédia em várias línguas diferentes.  
Para ver informações de uso, execute: ./wiki.py --help

### mainsearch.py
Ferramenta para obter informações de um [executável elf](https://pt.wikipedia.org/wiki/ELF).  
Mostra informações como entry point mas principalmente a localização da função main().

### template.sh
Ferramenta para criação de templates de arquivos.  

#### Comandos básicos
> ./template.sh +nome_do_template  
Cria ou modifica um template.

> ./template.sh -nome_do_template  
Deleta um template existente.

> ./template.sh @  
Lista todos os templates existentes.

> ./template.sh nome_do_template  
Exibe o conteúdo de um template. Você pode redirecionar a saída para o nome de um arquivo para criar um novo arquivo com o template.  
Exemplo:

> ./template.sh c >main.c  

Você pode adicionar uma descrição aos templates, bastanto incluir na primeira linha do arquivo o caractere ":" seguido da descrição.  
Exemplo:

>:Template da main do C  
>#include <stdio.h>  
>
>int main(){  
>return 0;  
>}
