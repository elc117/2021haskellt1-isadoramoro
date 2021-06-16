# Trabalho 1 - Paradigmas de Programação
Generative Art com Programação Funcional em Haskell
![Mandala](https://github.com/elc117/2021haskellt1-isadoramoro/blob/master/trab1.svg)

Mandala com parte interna formada por quadrados e contornada por círculos.

Os quadrados da imagem possuem mesmo tamanho, variam em ângulo de grau.
Para ter mais possibilidades com menos código, os círculos foram feitos utilizando o tipo elipse.

A função *angRotation* pode ter o valor de **a** modificado e alterar totalmente o resultado final da imagem.
Em *genRects* é possível mudar localização (x, y) e tamanho dos retângulos (w, h), assim como em *genEllip* para as elipses.
Funções para formação de cores: 
*bPalette* gera tons de azul. Quanto menor o valor de **a**, maior a variedade de tons.
Em *newPalette* o valor de **a** afeta os valores de r e b do (r, g, b). O valor de **b** afeta diretamente o blue, quanto maior seu valor, maior a presença de azul.
Ambos possuem **o** para definir a opacidade.
Na main podem ser alterados os valores de width e height do SVG e o número de retângulos e elipses.
