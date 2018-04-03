Neste repositório eu publico algumas ferramentas de linha de comando desenvolvidas por mim.
Qualquer ferramenta que não seja de muita importância a ponto de merecer um repositório próprio vai vir para cá.

## Lista de ferramentas

### lhosts.sh
Ferramenta para listar dispositivos conectados em uma rede.
Uso: lhosts.sh faixa_de_ip
Onde **faixa_de_ip** segue o formato: 192.168.0.0/8
Onde /8 se refere ao comprimento em bits da máscara de rede, que pode receber os valores 8, 12, 16 ou 24.
Se não souber o que é isso, apenas use /8. (ou [leia isto](https://pt.wikipedia.org/wiki/Classless_Inter-Domain_Routing#Nota.C3.A7.C3.A3o_standard))

Obs.: A verificação do sistema operacional é apenas um chute baseado no TTL da resposta. Onde este é totalmente impreciso.
