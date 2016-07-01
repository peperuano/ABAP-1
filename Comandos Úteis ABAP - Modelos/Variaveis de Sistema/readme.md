**Uma d�vida comum para desenvolvedores ABAP Juniores �: quais vari�veis de sistema podemos utilizar e quais s�o suas funcionalidades.**
#Segue abaixo uma rela��o das principais vari�veis e descri��o das mesmas:

� SY-SUBRC � Retorna 0 se foi bem sucedido ou diferente de 0 se falhou, usada ap�s uma pesquisa, condi��o.

� SY-UNAME � Retorna o nome do usu�rio

� SY-DATUM � Retorna a data do sistema

� SY-UZEIT � Retorna a hora, minuto, segundo do sistema

� SY-TCODE � Retorna c�digo da transa��o atual

� SY-TABIX � Retorna o numero da linha da tabela atual (Normalmente usando dentro de loop.)

� SY-LANGU � Retorna o idioma de logon do usu�rio

� SY-DYNNR � Retorna o numero da tela atual

� SY-UCOMM � Retorna o nome de um bot�o pressionado (OKCODE)

� SY-REPID � Retorna o nome do programa

� SY-CPROG � Nome do programa principal

� SY-FDPOS � Utilizado na compara��o de Strings, ver compara��o strings acima.

� SY-BATCH � Indica a execu��o de um programa em background

� SY-LINNO � Retorna a linha corrente de um relat�rio

� SY-LISEL � Retorna a linha selecionada em relat�rios interativos

� SY-MANDT � Retorna o mandante do sistema

� SY-PAGNO � Retorna a pagina atual de um relat�rio

� SY-TVAR0 .. SY-TVAR9 � Retorna elementos de textos ou t�tulos de relat�rios

� SY-VLINE � Efetua a fechamento de bordas em um relat�rio

� SY-ULINE(n) � Imprime uma linha com n posi��es

� SY-TCODE � C�digo da transa��o

� SY-DBCNT � Dentro de SELECT, cont�m o contador de intera��o