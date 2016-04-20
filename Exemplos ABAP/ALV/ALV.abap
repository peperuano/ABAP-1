http://www.ricardobhz.com.br/search/label/REUSE_ALV_GRID_DISPLAY

http://www.consolut.com/en/s/sap-ides-access/d/s/doc/F-REUSE_ALV_GRID_DISPLAY~~~~~~~~I_SCREEN_START_COLUMN

hot_spot


Parametros:

EXPORTING

*************************************************************************************************************************************************************

	I_INTERFACE_CHECK - Na execu��o aparece varias telas com os parametros da ALV (http://saptechnical.com/Tutorials/ALV/Interface/check.htm)

		Descri��o

		Assim que o desempenho da sa�da da lista n�o � reduzido devido a um controlo de consist�ncia da interface, estas verifica��es s�o realizadas 
		em modo de chamada especial.

		Se esse par�metro est� definido para 'X', a consist�ncia da interface � verificada quando o m�dulo de fun��o � chamado e um log de erro � 
		exibida.

		Voc� s� deve definir este par�metro para fins de teste durante o processo de desenvolvimento (por exemplo, para depura��o).

		Voc� tamb�m pode executar a verifica��o de interface na lista de resultados, introduzindo o c�digo de fun��o e &SOS.

		Este par�metro n�o est� suportado no modo de tela cheia! Como alternativa, ir para a visualiza��o de impress�o a partir da lista e introduza 
		o c�digo de fun��o e &SOS l�.

		faixa de valor
	
		Default

		ESPA�O

*************************************************************************************************************************************************************

	*   I_BYPASSING_BUFFER                = ' '
 
*************************************************************************************************************************************************************
 
	*   I_BUFFER_ACTIVE                   = ' '
 
*************************************************************************************************************************************************************
 	
	i_callback_program - Programa que chamou a ALV
		
		Descri��o

		Programa a partir do qual o m�dulo de fun��o � chamado e que cont�m o programa routines.The sa�da deve ser sempre um relat�rio, o grupo de 			fun��o, piscina m�dulo ou piscina rotina formul�rio (que n�o deve ser um include).

		Aten��o: Nunca passe SY-repid diretamente na interface. Se o campo SY-repid cont�m o nome do programa desejado, voc� deve absolutamente 			atribuir este nome para uma vari�vel auxiliar e passar esta vari�vel para a interface.

		faixa de valor
	
		Default
 
*************************************************************************************************************************************************************
 
	I_CALLBACK_PF_STATUS_SET - Para criar bot�es - Configurar o status gui igual na se80

		Descri��o

		Passando uma rotina de sa�da indica ao ALV que o interlocutor quer definir um status do usu�rio auto-definida.

		Como resultado, o estado padr�o da ALV n�o est� definido.

		A interface da rotina de forma especificada deve ser definida da seguinte forma:

		FORM set_pf_status USAR rt_extab TYPE slis_t_extab

		Tabela RT_EXTAB cont�m os c�digos de fun��o que estaria escondido na interface de usu�rio padr�o.

		Se o chamador deseja usar uma interface de usu�rio auto-definida (por exemplo, a fim de fornecer fun��es adicionais da lista ou usar fun��es
		existentes), recomendamos que voc� copie STANDARD_FULLSCREEN estado padr�o da fun��o SLVC_FULLSCREEN grupo e modific�-lo de acordo. C�digos 
		de fun��o padr�o ALV sempre come�am com '&'.

		Veja tamb�m a documenta��o sobre par�metro I_CALLBACK_USER_COMMAND.

		Se uma interface de usu�rio auto-definido � usado, que inclui c�digos de fun��o de interface de usu�rio padr�o, devem ser tidos em conta os 
		c�digos de fun��o da exclus�o tabela passada.

		Isto significa que o estado do utilizador deve ser geralmente definido como se segue:

		SET PF-STATUS user status EXCLUDING rt_extab.
		Fun��es do aplicativo pode ser adicionado a exclus�o rt_extab mesa para que possam ser desativados.

		A rotina � chamado sempre que a interface de usu�rio padr�o seria definido com SET PF-STATUS.

		Default

		Se nenhuma rotina de sa�da for especificado, o ALV define um status que corresponde a STANDARD_FULLSCREEN estado da fun��o SLVC_FULLSCREEN 
		grupo.
 
*************************************************************************************************************************************************************
 
	I_CALLBACK_USER_COMMAND - Quando o usu�rio faz alguma coisa (okcode)

		Descri��o

		Passando uma rotina de sa�da indica ao ALV que a aplica��o pretende responder a certos c�digos de fun��o.

		Geralmente, estes s�o os c�digos de fun��o que s�o desconhecidos para a ALV (isto �, n�o s�o fun��es normais ALV) e que foram definidos e por 		um estado de utilizador.

		Veja tamb�m a documenta��o sobre par�metro I_CALLBACK_PF_STATUS_SET.

		A interface da rotina de forma especificada deve ser definida da seguinte forma:

		FORM user_command USING r_ucomm LIKE sy-ucomm 
					rs_selfield TYPE slis_selfield.

		Par�metro R_UCOMM cont�m o c�digo de fun��o desencadeada.

		Estrutura RS_SELFIELD cont�m as seguintes informa��es:

		tabname: Nome da tabela de sa�da interna
		tabindex: �ndice da tabela de sa�da interna
		fieldname: Nome do campo
		endsum: Cursor est� localizado na linha de totais
		sumindex: Se> 0, o cursor est� localizado em uma linha de subtotais
		value: Valor do campo na lista
		refresh: (Exporta��o) Lista deve ser criado novamente
		col_stable: (exportador) Mantenha a posi��o da coluna quando a lista � criada novamente
		row_stable: (exportador) Manter posi��o da linha quando a lista � criada novamente
		exit: (exportador) lista Exit (e ALV)
		before_action: Call antes da execu��o da a��o padr�o
		after_action: Call ap�s a execu��o da a��o padr�o, antes de configura��o lista
		ignore_multi:Uso interno
		sel_tab_field: uso interno
		A rotina de sa�da � chamado sempre uma fun��o desconhecida do ALV � desencadeada ou se a chamada de rotina antes / ap�s a execu��o de um 			c�digo de dun��o padr�o foi definido pela interface do par�metro IT_EVENT_EXIT.

		Veja tamb�m a documenta��o sobre par�metro IT_EVENT_EXIT.
	
		O c�digo de fun��o e posi��o atual do cursor s�o, ent�o, transferidos para o programa de chamada por meio da rotina de sa�da.

		Se o usu�rio tiver selecionado v�rias linhas selecionando caixas de sele��o, o campo da tabela de sa�da designada como a caixa cont�m o 			estado atual da caixa de sele��o na lista.

		faixa de valor

		Default
 
*************************************************************************************************************************************************************
 
	*   I_CALLBACK_TOP_OF_PAGE       
		
		Descri��o

		Se o chamador especifica uma rotina de sa�da, essa rotina deve ter o seguinte formato:

		FORM top_of_page.

		REUSE_ALV_COMMENTARY_WRITE m�dulo pode ent�o ser chamado dentro da rotina EXIT. Este m�dulo � respons�vel pela formata��o da informa��o do 			cabe�alho e tamb�m garante formata��o HTML online. Na visualiza��o de impress�o ou em lote, o texto passou ent�o a sa�da � no formato normal.

		Se REUSE_ALV_COMMENTARY_WRITE m�dulo n�o pode ser usado, voc� deve usar dois par�metros em seu lugar. Em I_CALLBACK_TOP_OF_PAGE voc� passar a 		rotina de forma que � respons�vel pela formata��o normal em modo batch ou no modo de visualiza��o de impress�o. A rotina de forma que � 			respons�vel pela formata��o on-line, � passada no par�metro I_CALLBACK_HTML_TOP_OF_PAGE. Se um desses par�metros n�o � preenchida, top-of-			page n�o � emitido no modo respectivo.

		faixa de valor

		Default
 
*************************************************************************************************************************************************************
 
	*   I_CALLBACK_HTML_TOP_OF_PAGE 
		Descri��o

		Se o m�dulo de fun��o REUSE_ALV_COMMENTARY_WRITE n�o � utilizado sob a forma de I_CALLBACK_TOP_OF_PAGE, a rotina de forma deve ser passado no 		par�metro I_CALLBACK_HTML_TOP_OF_PAGE para o modo on-line. O formul�rio deve ent�o ter o seguinte formato:

		form top_of_page using cl_dd type ref to cl_dd_document.

		No formul�rio, voc� pode, por exemplo, usar m�todos de classe CL_DD_DOCUMENT para exibir o texto em formato HTML.

 
*************************************************************************************************************************************************************
 
	*   I_CALLBACK_HTML_END_OF_LIST    

		Descri��o

		Neste par�metro, voc� pode passar um form on-line para o tratamento de fim-de-lista. O form deve ter o formato followiong:

		form end_of_list using cl_dd type ref to cl_dd_document.
 
*************************************************************************************************************************************************************
 
	*   I_STRUCTURE_NAME     
		Descri��o

		Se a tabela de sa�da interna � definida atrav�s de uma estrutura Dicion�rio ABAP (INCLUIR struct ESTRUTURA Ou como struct), voc� pode 				configurar automaticamente o cat�logo de campos, passando o nome da estrutura.

		O cat�logo de campo �, ent�o, definida internamente para essa estrutura da seguinte maneira:

		Todos os campos est�o na lista (NO_OUT = SPACE) exceto os campos de CLNT tipo de dados.
		Os campos-chave da estrutura Dicion�rio s�o adoptados no cat�logo de campos como campos-chave.
		As refer�ncias a campos de unidades armazenadas no dicion�rio s�o adotadas desde que os campos de refer�ncia est�o contidas na estrutura.
		Se, al�m disso passar um cat�logo de campos como par�metro, a informa��o estrutura � mesclado com este cat�logo de campos.
		Para mais informa��es sobre como configurar o cat�logo de campos automaticamente, consulte a documenta��o sobre a fun��o m�dulo 				REUSE_ALV_FIELDCATALOG_MERGE.

		faixa de valor

		Default
 
*************************************************************************************************************************************************************
 
	*   I_BACKGROUND_ID       
		
		Descri��o

		Voc� pode usar esse par�metro para passar um papel de parede para a sa�da no topo de p�gina.

		Aten��o: Uma vez que a formata��o baseada em papel de parede, n�o garante uma exposi��o baseada em padr�es da �rea de p�gina no novo design, 			voc� s� deve usar este par�metro em casos excepcionais....
 
*************************************************************************************************************************************************************
 
	I_GRID_TITLE - Titulo da ALV

		Descri��o

		Especifica o t�tulo do controlo. Esse texto � exibido acima da grade.

*************************************************************************************************************************************************************
 
	*   I_GRID_SETTINGS 

		Descri��o

		Se Top-of-p�gina ou fim-de-lista s�o enviados on-line, estas �reas s�o exibidos em um divisor acima ou abaixo na lista. Usando 				I_GRID_SETTINGS voc� pode reduzir o tamanho padr�o para 0%. Para fazer isso, voc� pode usar dois campos:

		COLL_TOP_P: Define topo de p�gina para 0%

		COLL_END_L: Conjuntos de fim-de-lista para 0%
 
*************************************************************************************************************************************************************

	is_layout - Configura��es de layout

		Descri��o

		Estrutura para descrever a lista de sa�da .

		Os par�metros s�o descritos e agrupados com base nas seguintes categorias:

		As op��es de exibi��o
		exce��es
		totais
		intera��o
		tela de detalhes
		cor
		outro
		Observe a se��o de configura��es pr�-definidas .

		As op��es de exibi��o

		colwidth_optimize
			Faixa de valor : SPACE , 'X'
			'X ' = optimiza a largura da coluna para assegurar que o conte�do seja mostrado por completo .
		no_colhead
			Faixa de valor : SPACE , 'X'
			'X' = N�o emitir t�tulos de coluna .
		zebra
			Faixa de valor : SPACE , 'X'
			'X' = padr�o listrado ( para listas de largura, por exemplo)
		no_vline
			Faixa de valor : SPACE , 'X'
			'X' = colunas separadas pelo espa�o.
		exce��es

		lights_fieldname
			Faixa de valor : SPACE , o nome do campo da tabela de sa�da interna
			
			Campo da tabela de sa�da interna que cont�m a codifica��o das excep��es a ser emitido
			Codifica��o no campo da tabela de sa�da :
			'1 ' = Sem�foro vermelho
			'2 ' = sem�foro amarelo
			'3 ' = Sem�foro verde
		lights_tabname
			Faixa de valor : SPACE , o nome da tabela da tabela de sa�da interna
			O nome da tabela da tabela de sa�da interna que cont�m o campo especificado no par�metro LIGHTS_FIELDNAME .
		lights_rollname
			Faixa de valor : SPACE , o nome do elemento de dados
			A documenta��o definida para esse elemento de dados � exibido quando a ajuda F1 para uma coluna exce��o � chamado.
		lights_condense
			Faixa de valor : SPACE , 'X'
			'X' = O sistema emite a exce��o 'm�ximo' dos itens inclu�dos no total a n�vel subtotal.
			Exemplo: Se uma linha da lista � a sa�da com um ' sinal vermelho ' , cada um subtotal inclu�do nesta linha lista tamb�m � exibido com 			um " sinal vermelho " .
		totais

		no_sumchoice
			Faixa de valor : SPACE , 'X'
			'X' = campos de valor para o qual s�o calculados os totais s�o comunicadas pelo programa de chamada ( FIELDCAT - DO_SUM = 'X' ) . O 			usu�rio n�o deve ter permiss�o para alterar essa configura��o pr�-definida de forma interativa.
		no_totalline
			Faixa de valor : SPACE , 'X'
			'X' = Nenhuma linha de total geral deve ser exibido. Se necess�rio, subtotais pode , contudo, ser calculados e exibidos . Os campos 				que s�o utilizados para o c�lculo dos subtotais s�o para ser marcada com DO_SUM = 'X' no cat�logo de campos .
		no_subchoice
			Faixa de valor : SPACE , 'X'
			'X' = Caracter�sticas em cujo subtotais n�vel de controle deve ser calculado s�o comunicadas pelo programa de chamada .
			O usu�rio n�o deve ter permiss�o para alterar essa configura��o pr�-definida de forma interativa.
			Veja tamb�m a documenta��o sobre a importa��o de par�metro IT_SORT .
		no_subtotals
			Faixa de valor : SPACE , 'X'
			'X' = Calculando subtotais n�o deve ser permitido.
		totals_only
			Faixa de valor : SPACE , 'X'
			'X' = Os dados s�o enviados em formato compactado apenas com os totais de n�vel de linha .
			Pr�-requisito: IMPORTAR par�metro IT_SORT � preenchido de acordo com os crit�rios de classifica��o eo indicador subtotais .
			Veja tamb�m a documenta��o sobre a importa��o de par�metro IT_SORT .
		totals_text
			Faixa de valor : SPACE , string ( n�o superior a 60 )
			' ' = Na primeira coluna , o sistema padr�o indica o n�vel totais , exibindo um n�mero adequado de '*' para o total global . Ap�s os 				asteriscos , o sistema exibe a string 'total' , desde que a largura da coluna da primeira coluna de sa�da � grande o suficiente . Se 				a largura da coluna n�o � suficiente , somente os asteriscos s�o exibidos .
			'string' = Ap�s a n�vel totais indicados visualmente por meio de "*" , o sistema exibir� a string passada , desde que a largura da 				coluna � suficiente.
		subtotals_text
			Faixa de valor : SPACE , string ( n�o superior a 60 )
			' ' = Na primeira coluna , o sistema padr�o indica o n�vel totais , exibindo um n�mero adequado de '*' para a linha de subtotais . 				Ap�s os asteriscos , o sistema apresenta a cadeia total * *, desde que a largura da coluna da primeira coluna de sa�da � 					suficientemente grande e a caracter�stica de a primeira coluna n�o � um crit�rio subtotal. Se a largura da coluna n�o � suficiente , 				somente os asteriscos s�o exibidos .
			' cadeia' = Ap�s o n�vel total indicada por meio de '*' , o sistema apresenta a cadeia passou desde que a largura da coluna � 					suficiente e com a caracter�stica de a primeira coluna n�o � um crit�rio subtotal.
			Se a caracter�stica � um crit�rio subtotal , o sistema retoma o valor da caracter�stica para o qual subtotais foram calculados ap�s o 			n�vel total , desde que a largura da coluna � suficiente.
		numc_sum
			Faixa de valor : SPACE , 'X'
			' ' = No sistema padr�o , n�o � poss�vel calcular os totais para campos NUMC .
			'X' = Em geral, � poss�vel calcular os totais para campos NUMC . Se este c�digo estiver definido, voc� pode usar o par�metro FIELDCAT 			- NO_SUM para controlar cada coluna NUMC se totais pode ser calculada ou n�o.
		intera��o

		box_fieldname
			Faixa de valor : SPACE , o nome do campo da tabela de sa�da interna
			Se a lista deve ter caixas no in�cio de cada linha da lista (para permitir ao usu�rio selecionar v�rias linhas de uma s� vez ) , voc� 			deve preencher este par�metro com o nome do campo da tabela de sa�da interna, que representa a coluna de sele��o para selecionar 				linhas com o ajuda de caixas de sele��o .
			O campo � sempre exibido como uma caixa de sele��o no in�cio de cada linha da lista sem t�tulo lista.
		box_tabname
			Faixa de valor : SPACE , o nome da tabela da tabela de sa�da interna
		f2code
			Faixa de valor : SPACE , o c�digo de fun��o
			Ou seja, quando a interface padr�o ALV � usado :
			Se voc� quiser atribuir um c�digo de fun��o ALV padr�o para um clique duplo (F2) , voc� deve atribuir este c�digo de fun��o para esse 			par�metro.
			Exemplo: Voc� deseja atribuir a fun��o ALV standard ' Detalhe ' ('& ETA ') para F2.
		=> LAYOUT- F2CODE = ' & ETA '
			Ou seja, se uma interface de auto -definido � usado :
			Caso 1:
			Voc� deixa o c�digo de fun��o ALV padr�o para F2 'e IC1 ' na interface copiada da aplica��o. No entanto, voc� quer ter uma fun��o 				executada com F2 que n�o � atribu�da a F2 na interface (fun��o ALV padr�o ou fun��o da aplica��o). Voc� deve comunicar este c�digo de 			fun��o para a ALV atrav�s do par�metro F2CODE .
			Caso 2:
			Voc� remove o c�digo de fun��o ALV padr�o para F2 'e IC1 ' a partir da interface do aplicativo e usar outro c�digo de fun��o em vez 				(fun��o ALV padr�o ou fun��o da aplica��o). Voc� deve comunicar este c�digo de fun��o para a ALV atrav�s do par�metro F2CODE . Isso � 			necess�rio se voc� quiser permitir que as colunas a serem selecionados.
		confirmation_prompt
			Faixa de valor : SPACE , 'X'
			'X' = Se um dos ' Back ( F03 ) " as fun��es , ' Exit ( F15 ) 'ou' Cancelar ( F12) " � acionado , o sistema pergunta ao usu�rio se ele 			quer sair da lista.
		key_hotspot
			Faixa de valor : SPACE , 'X'
			As colunas definidas como campos-chave no cat�logo de campos ( FIELDCAT -KEY = 'X' ) s�o emitidos como um hotspot. Isso significa que 			um �nico clique em um campo de chave ( em destaque na cor na lista ) aciona a fun��o atribu�da a F2.
		reprep
			Faixa de valor : SPACE , 'X'
			'X' interface = Ativar relat�rio / relat�rio
			Pr�-requisito : Sistema de Aplica��o ( => relat�rio RKKBRSTI existe).
			O m�dulo lista funciona como um emissor potencial na interface relat�rio / relat�rio ( inicializa��o da interface , se necess�rio).
			O relat�rio / m�dulo piscina chamando entrou em I_CALLBACK_PROGRAM � declarado para a interface relat�rio / relat�rio quanto o 			relat�rio remetente com o tipo de RT = Relat�rio .
			Se o relat�rio remetente � atribu�do ao receptor relat�rios na tabela TRSTI , c�digo de fun��o BEBx est� definido como ativo.
			(X = classe de c�digo de fun��o)
			Exemplo:
			Se o remetente RKTFGS15 tem uma atribui��o receptor para Report Writer 7KOI grupo de relat�rios com c�digo de fun��o de classe '3 ' 			(configura��o SAP ), este grupo relat�rio receptor � chamado atrav�s da interface relat�rio / relat�rio de c�digo de fun��o ' BEB3 . 				As sele��es do passado para a interface relat�rio / relat�rio s�o as sele��es relat�rio e as informa��es -chave da linha selecionada.
			Para mais informa��es sobre a interface relat�rio / relat�rio, consulte a documenta��o no grupo de fun��es " RSTI .
		tela de detalhes

		detail_initial_lines
			Faixa de valor : SPACE , 'X'
			' ' = Na vista de detalhes , o sistema exibe somente os campos , cujo conte�do n�o est� definido como inicial.
			'X' = conte�do do campo iniciais tamb�m s�o exibidos na tela detalhe .
		detail_titlebar
			Faixa de valor : SPACE , string ( n�o superior a 30 )
			' ' = O sistema exibe' Detalhe: Display ' como o t�tulo da tela de detalhes .
			'string' = O sistema exibe a string passada como o t�tulo da tela de detalhes .
		cor

		info_fieldname
			Faixa de valor : SPACE , o nome do campo da tabela de sa�da interna
			Voc� pode colorir toda uma linha da lista individualmente, usando um c�digo de cor que est� definido para cada linha em uma coluna da 			tabela de sa�da interna. Voc� deve atribuir o nome do campo do campo com o c�digo de cores para este par�metro .
			O campo da tabela de sa�da interna deve ser do tipo CHAR ( 3).
			O c�digo deve obedecer a seguinte sintaxe: ' Cxy ':
				C = Color ( cada c�digo deve come�ar com 'C' )
				x = n�mero de cores ( '1 ' - '9' )
				y = Intensifica��o ( '0 ' = off , 1 = on)
			Nota: A cor da coluna de chave n�o � afetado. Se voc� tamb�m quiser colorir a coluna de chave em linha ou n�vel celular, voc� pode 				usar corante complexo que � descrito abaixo para o par�metro COLTAB_FIELDNAME .
			Para obter informa��es sobre colunas de colora��o , consulte a documenta��o do par�metro cat�logo de campos FIELDCAT a �nfase de 			importar par�metro 		IT_FIELDCAT .
		coltab_fieldname
			Faixa de valor : SPACE , o nome do campo da tabela de sa�da interna
			Voc� pode colorir as c�lulas individualmente, usando um c�digo de cor que est� definido para a linha de c�lulas em uma coluna da 			tabela de sa�da interna.
			Voc� deve atribuir o nome do campo do campo com o c�digo de cores para este par�metro .
			O campo da tabela de sa�da interno deve ser do tipo SLIS_T_SPECIALCOL_ALV .
			Princ�pio: O campo do c�digo de cor � enchida na linha em que as c�lulas a serem corados est�o localizados. O campo cont�m ent�o uma 			tabela interna da estrutura acima , que inclui os nomes dos campos das c�lulas de ser colorido com o c�digo de cores . As coordenadas 			de c�lulas s�o , por conseguinte, derivados a partir da posi��o de linha no qual o c�digo de cor � escrito e a informa��o contida na 			coluna da tabela de cores .
			A estrutura da linha da mesa de cor interna de tipo SLIS_T_SPECIALCOL_ALV � como se segue :
			Farbtabelle -name = Nome do campo de c�lula para ser colorido
			Farbtabelle -COLOR -COL = N�mero Cor ( 1-9 )
			Farbtabelle -COLOR -INT = Intensifica��o (0 = off, 1 = on )
			Farbtabelle - COLOR- INV = Inverse (0 = off, 1 = on )
			Farbtabelle - NOKEYCOL = Ignorar colora��o chave ( 'X' = yes ',' = n�o)
			Se o par�metro Farbtabelle -NAME n�o � preenchido , todas as especifica��es de cores referem-se a todos os campos. Como resultado, 			toda a linha � colorida .
		faixa de valor

		Default

		Em muitos casos, as configura��es padr�o de layout pode ser mantido para que voc� muitas vezes n�o precisa passar essa estrutura com 		bandeiras modificados .

		Nota:

		Todos os outros campos n�o especificados aqui explicitamente n�o s�o relevantes para o uso com REUSE_ALV_GRID_DISPLAY ou n�o s�o liberados.
 
*************************************************************************************************************************************************************

	it_fieldcat - Campos que ser�o listados

		Descri��o

		Campo cat�logo contendo as descri��es de campo dos campos a serem considerados para a sa�da da lista (normalmente , isto � um subconjunto dos 		campos na tabela de sa�da interno).

		Basicamente, voc� precisa de um cat�logo de campos para cada sa�da da lista que usa o ALV .

		O cat�logo campo associado com a mesa de sa�da � gerado no c�digo do chamador. Voc� pode gerar o cat�logo de campos de forma autom�tica ou 			semi- automaticamente chamando a fun��o m�dulo REUSE_ALV_FIELDCATALOG_MERGE .

		Veja tamb�m a documenta��o sobre a fun��o m�dulo REUSE_ALV_FIELDCATALOG_MERGE .

		Os valores m�nimos exigidos para o cat�logo de campos est�o documentadas na se��o 'Default' . O chamador pode, opcionalmente, usar todos os 			outros par�metros para atribuir atributos de sa�da n�o-padr�o para um campo.

		� somente nos seguintes casos que n�o s�o necess�rios para gerar o cat�logo de campos e pass�-lo explicitamente :

		A estrutura da tabela interna para ser a sa�da corresponde a uma estrutura armazenada no dicion�rio de dados e � referenciado com gosto ou 			incluem a estrutura na declara��o da tabela interna.
		Todos os campos dessa estrutura deve ser a sa�da da lista.
		O nome da estrutura � declarada a ALV atrav�s do par�metro I_STRUCTURE_NAME .
		Veja tamb�m a documenta��o sobre IMPORTNG par�metro I_STRUCTURE_NAME .
		posicionamento

		col_pos ( posi��o da coluna )
			Faixa de valores : 0, 1 - 60
			S� � relevante se as posi��es relativas das colunas por padr�o n�o deve ser id�ntica � seq��ncia dos campos no cat�logo de campos .
			O par�metro determina a posi��o da coluna relativa do campo na sa�da da lista . A seq��ncia de coluna pode ser alterada de forma 				interativa pelo usu�rio. Se esse par�metro est� definido para seu valor inicial para cada entrada do cat�logo de campos , as colunas 				s�o organizadas na ordem dos campos no cat�logo de campos .
			identifica��o

		nome do campo ( nome do campo)
			Faixa de valor : Nome do campo da tabela de sa�da interna ( par�metro obrigat�rio)
			Nome do campo do campo na tabela de sa�da interno que � descrito por esta entrada cat�logo campo .
			Refer�ncia ao Dicion�rio de Dados

		ref_fieldname ( nome do campo do campo de refer�ncia)
			Faixa de valor : SPACE , o nome de um campo no Dicion�rio de Dados
			Nome do campo referenciado no Dicion�rio de Dados.
			Este par�metro � necess�rio apenas se o campo na tabela de sa�da interno que � descrito pela entrada de corrente no cat�logo campo 			tem uma refer�ncia para o dicion�rio de dados ( isto �, n�o � um campo de programa) e, se o nome do campo na sa�da interno mesa n�o � 			id�ntico ao nome de campo do campo no dicion�rio de dados . Se ambos os nomes dos campos s�o id�nticos , � suficiente para 			especificar a estrutura dicion�rio de dados ou tabela de par�metro FIELDCAT - REF_TABNAME .

		ref_tabname ( nome do campo da tabela / estrutura de refer�ncia)
			Faixa de valor : SPACE , o nome de uma estrutura ou uma tabela no Dicion�rio de Dados
			Estrutura ou na tabela nome do campo referenciado no Dicion�rio de Dados.
			Este par�metro � necess�rio apenas se o campo na tabela de sa�da interno que � descrito pela entrada de corrente no cat�logo campo 			tem uma refer�ncia para o dicion�rio de dados ( isto �, n�o � um campo de programa).
			Refer�ncia para campos com unidades monet�rias / unidades de medida

		Cada valor ou campo quantidade da tabela de sa�da interna cujo casas decimais devem ser exibidos com a unidade adequada na sa�da da lista , 		devem estar em conformidade com as seguintes conven��es:
		O campo � do tipo de dados QUAN ou CURR (tipo P interno).
( Fisicamente, o campo deve , na verdade, pertencem a este tipo de dados. Substituindo o tipo f�sico de dados com o par�metro FIELDCAT - DATATYPE n�o tem nenhum efeito . )
Existe um campo na tabela de sa�da interna que cont�m a unidade relevante.
H� tamb�m uma entrada para o campo de unidade no cat�logo de campos .
(Se a unidade n�o deve ser exibido como uma coluna na lista e que o usu�rio n�o deve ser capaz de mostrar a unidade de forma interativa , por exemplo, porque a unidade � sempre �nico e, portanto, explicitamente sa�da pelo chamador no cabe�alho da lista , ent�o voc� pode atribuir par�metro FIELDCAT -TECH = 'X' para a entrada do cat�logo de campo para o campo da unidade.
Se um campo tem um valor de refer�ncia de uma unidade, isto apresenta os seguintes efeitos , quando a lista de sa�da � :
As casas decimais s�o exibidas com a unidade adequada.
Um campo de valor inicial , com refer�ncia a uma unidade de n�o- inicial � apresentada como '0 '( desde que FIELDCAT - NO_ZERO � inicial). Se totais espec�ficos de unidade s�o calculadas para este campo de valor , a unidade � considerada na an�lise de se existem unidades homog�neos.
Um campo de valor inicial , com refer�ncia a uma unidade inicial � exibida como um espa�o . Se totais espec�ficos de unidade s�o calculadas para este campo de valor , o espa�o da unidade n�o tem efeito sobre a homogeneidade da unidade, se o campo de valor � inicial.
Para os campos de valor n�o- iniciais com a unidade inicial , o espa�o da unidade � considerada como uma unidade, quando os totais espec�ficos de unidade s�o calculados.
Refer�ncia � unidade de moeda

cfieldname ( nome de campo de campo unidade da moeda )
Faixa de valor : SPACE , o nome de um campo da tabela de sa�da
S� � relevante para atingir colunas com refer�ncia unidade.
Nome do campo do campo na tabela de sa�da interna que cont�m a unidade de moeda para o campo quantidade FIELDCAT - FIELDNAME .
Deve haver uma entrada de cat�logo campo separado para o campo especificado no FIELDCAT - CFIELDNAME .
Refer�ncia para a unidade de medida

qfieldname ( nome do campo da unidade do campo de medida)
Faixa de valor : SPACE , o nome de um campo da tabela de sa�da
S� � relevante para as colunas de quantidade , com refer�ncia unidade.
Nome do campo do campo na tabela de sa�da interna que cont�m a unidade de medida para o campo quantidade FIELDCAT - FIELDNAME .
Deve haver uma entrada de cat�logo campo separado para o campo especificado no FIELDCAT - QFIELDNAME .
Op��es de sa�da para uma coluna

outputlen ( largura da coluna )
Escala: 0 (inicial ), n
Para os campos com refer�ncia ao Dicion�rio de Dados voc� pode deixar esse par�metro definido como inicial.
Para os campos sem refer�ncia ao Dicion�rio de Dados (campos do programa) voc� deve definir o par�metro para o comprimento desejado campo de sa�da na lista ( largura da coluna ) .
= iniciais A largura da coluna � derivada a partir do comprimento do campo referenciado ( dom�nio) no dicion�rio de dados de sa�da.
n = A largura da coluna � n caracteres.
chave ( coluna de chave )
Faixa de valor : SPACE , 'X'
'X' = campo chave ( sa�da de cor para os campos -chave)
Campos-chave n�o pode ser escondido de forma interativa pelo usu�rio.
Par�metro FIELDCAT - NO_OUT deve ser deixado para definir inicial.
Para exce��es , consulte a documenta��o do par�metro FIELDCAT - KEY_SEL .
key_sel ( coluna de chave que pode ser escondido )
Faixa de valor : SPACE , 'X'
S� � relevante se FIELDCAT -KEY = 'X'
Campo de chave que pode ser escondido de forma interativa pelo usu�rio.
O usu�rio n�o pode interativamente alterar a sequ�ncia das colunas de chave .
Como em campos n�o-chave , controle de sa�da � realizada atrav�s do par�metro FIELDCAT - NO_OUT .
no_out ( campo na lista de campos dispon�veis )
Faixa de valor : SPACE , 'X'
'X' = campo n�o � exibido na lista atual .
O campo est� dispon�vel para o usu�rio na lista de campos e pode ser interativamente selecionado como um campo de exibi��o .
Ao n�vel da linha , o usu�rio pode utilizar a fun��o de detalhe para exibir o conte�do desses campos .
Veja tamb�m a documenta��o na se��o "tela Detalhe ' de par�metro IS_LAYOUT .
tecnologia ( �rea t�cnica )
Faixa de valor : SPACE , 'X'
'X ' = Campo t�cnico
O campo n�o pode ser a sa�da da lista e n�o podem ser mostrados de forma interativa pelo usu�rio.
O campo pode ser utilizado apenas no cat�logo de campo ( n�o em IT_SORT , ... ) .
enfatizar ( destacar coluna na cor)
Faixa de valor : SPACE , 'X ' ou ' Cxyz ' (x : '1 ' - '9' , y, z: '0 ' = desligado 1 = ligado)
'X' = A coluna � destaque na cor padr�o para realce de cores .
' Cxyz ' = A coluna � destaque na cor codificado :
C : Cor (codifica��o deve come�ar com C)
x: n�mero de cores
y: Intensifica��o
z: Inverse
hotspot ( coluna como hotspot )
Faixa de valor : SPACE , 'X'
'X ' = As c�lulas da coluna s�o de sa�da como um ponto de acesso .
do_sum ( calcular totais por coluna)
Faixa de valor : SPACE , 'X'
'X' = totais s�o calculadas para este campo da tabela de sa�da interno.
Esta fun��o tamb�m pode ser utilizada interactivamente pelo utilizador.
no_sum ( c�lculo de totais n�o � permitido)
Faixa de valor : SPACE , 'X'
'X ' = Sem totais podem ser calculadas para este campo , embora o tipo de campo de dados , totalizando permite .
Formatar o conte�do da coluna

icon (�cone)
Faixa de valor : SPACE , 'X'
'X' = O conte�do da coluna s�o exibidos como um �cone.
O conte�do da tabela de sa�da interna de coluna deve consistir de �cone cordas v�lidos ( xx @ @ ) .
O chamador deve considerar o problema dos �cones de impress�o.
s�mbolo (s�mbolo)
Faixa de valor : SPACE , 'X'
'X ' = O conte�do de coluna s�o produzidos como um s�mbolo.
O conte�do da tabela de sa�da interno de coluna deve consistir de caracteres de s�mbolo v�lidos.
O chamador deve considerar o problema de impress�o de s�mbolos .
Embora os s�mbolos podem geralmente ser impressos , eles n�o s�o sempre apresentados correctamente, dependendo da configura��o da impressora .
apenas (justifica��o)
Faixa de valor : SPACE , 'R ', ' L' , 'C'
Relevante apenas para campos do tipo de dados CHAR ou NUMC
' = Justificativa padr�o de acordo com o tipo de dados
'R' = sa�da justificado � direita
'L' = sa�da justificado � esquerda
'C' = sa�da Centered
A justificativa do cabe�alho da coluna depende da justificativa do conte�do da coluna. Voc� n�o pode justificar o cabe�alho da coluna , independentemente do conte�do das colunas.
lzero ( zeros � esquerda )
Faixa de valor : SPACE , 'X'
Relevante apenas para campos do tipo de dados NUMC
Por padr�o , os campos NUMC s�o emitidos no ALV alinhado � direita , sem zeros � esquerda .
'X' = sa�da com zeros � esquerda
no_sign (sem sinal + / - )
Faixa de valor : SPACE , 'X'
Relevante apenas para campos de valor
'X' = sa�da Valor sem sinais + / - .
no_zero ( suprimir zeros)
Faixa de valor : SPACE , 'X'
Relevante apenas para campos de valor
'X ' = suprimir zeros
edit_mask (formata��o de campo)
Faixa de valor : SPACE , m�scara
mask = Consulte a documenta��o sobre a op��o de formata��o WRITE
Usando m�scara m�scara de edi��o
Usando m�scara = ' == conv ' voc� pode for�ar um conv convers�o de sa�da.
textos

Os par�metros a seguir para textos s�o sempre necess�rios para os campos do programa sem refer�ncia ao Dicion�rio de Dados.
Para os campos com refer�ncia ao Dicion�rio de Dados , os textos s�o recuperados a partir do Dicion�rio de Dados. Se voc� n�o quer isso, voc� pode preencher os par�metros de texto tamb�m para campos com refer�ncia ao Dicion�rio de Dados. Se voc� fizer isso , os textos correspondentes do dicion�rio de dados ser� ignorado.
Se o usu�rio alterar a largura da coluna de forma interativa, o texto com o comprimento adequado � sempre usado como cabe�alho da coluna.
Se o usu�rio otimiza a largura da coluna de forma interativa, tanto o conte�do do campo e os t�tulos de coluna s�o consideradas para a sa�da da lista :
Se todos os conte�dos do campo s�o menores do que a menor coluna , a largura da coluna � definida com base no t�tulo da coluna .
O campo de etiqueta longa � tamb�m utilizado nas caixas de di�logo para definir a variante de exibi��o, a ordem de classifica��o , e assim por diante .
seltext_l ( r�tulo de campo de comprimento)
seltext_m ( r�tulo de campo m�dio)
seltext_s ( r�tulo do campo short)
reptext_ddic (posi��o )
Mesmo que o ' t�tulo ' para a manuten��o elemento de dados.
Quando a lista estiver de sa�da, o sistema n�o necessariamente recuperar o texto armazenado aqui, mas usa o texto que se encaixa melhor .
ddictxt ( determinar texto )
Faixa de valor : SPACE , 'L' , 'M' , 'S' , 'R'
Usando os valores poss�veis ' L' , 'M' , 'S' , 'R' voc� pode predefinir a palavra-chave que deve ser sempre recuperado como o cabe�alho da coluna. Se a largura da coluna for alterado, o sistema tenta encontrar um t�tulo que se encaixa a nova largura de sa�da.
Par�metro para os campos do programa sem refer�ncia ao Dicion�rio de Dados

Veja tamb�m o par�metro na se��o "textos" .
tipo de dados (tipo de dados )
Faixa de valor : SPACE , tipo de dados a partir do Dicion�rio de Dados (CHAR , NUMC , ... )
S� � relevante para os campos sem refer�ncia ao Dicion�rio de Dados.
Tipo de campo de dados do programa
ddic_outputlen ( comprimento de sa�da externo)
Escala: 0 (inicial ), n
S� � relevante para os campos sem refer�ncia ao Dicion�rio de Dados , cujo resultado , no entanto, ser modificado usando uma sa�da de convers�o.
Pr�-requisitos:
FIELDCAT - EDIT_MASK = ' == conv '
Veja tamb�m a documenta��o sobre par�metro FIELDCAT - EDIT_MASK
FIELDCAT - INTLEN = n
Consulte a documenta��o do par�metro FIELDCAT - INTLEN
n = Campo comprimento do display externo de sa�da
A largura da coluna FIELDCAT - OUTPUTLEN n�o deve ser equivalente ao comprimento de sa�da do monitor externo ( FIELDCAT - DDIC_OUTPUTLEN ) .
intlen ( comprimento de sa�da interna)
Escala: 0 (inicial ), n
S� � relevante para os campos sem refer�ncia ao Dicion�rio de Dados , cujo resultado , no entanto, ser modificado usando uma sa�da de convers�o.
Pr�-requisitos:
FIELDCAT - EDIT_MASK = ' == conv '
Veja tamb�m a documenta��o sobre par�metro FIELDCAT - EDIT_MASK
FIELDCAT - DDIC_OUTPUTLEN = n
Veja tamb�m a documenta��o sobre par�metro FIELDCAT - DDIC_OUTPUTLEN
n = Campo comprimento do display interno de sa�da
rollname ( elemento de dados )
Faixa de valor : SPACE , o nome de um elemento de dados a partir do Dicion�rio de Dados
Voc� pode usar esse par�metro para fornecer uma ajuda F1 para um campo de programa sem refer�ncia ao Dicion�rio de Dados ou para fornecer uma ajuda de F1 que n�o seja do dicion�rio de dados para um campo com refer�ncia ao Dicion�rio de Dados.
Quando a ajuda F1 � chamado para este campo , a documenta��o para o elemento de dados atribu�do � exibida.
Se, por campos com refer�ncia ao Dicion�rio de Dados , FIELDCAT - rollname � inicial , a documenta��o para o elemento de dados do campo referenciado no Dicion�rio de Dados � exibida.
outro

sp_group (key grupo de campos )
Faixa de valor : SPACE , CHAR (1 )
Chave para campos de agrupamento
Voc� atribui a chave para a descri��o do grupo usando IT_SPECIAL_GROUPS par�metros ( ver tamb�m a documenta��o sobre IT_SPECIAL_GROUPS par�metros) .
Se voc� definir como uma atribui��o no cat�logo de campos usando IT_SPECIAL_GROUPS , os campos na lista de campos da caixa de di�logo variante de exibi��o s�o agrupados em conformidade.
reprep ( crit�rio de sele��o da interface relat�rio / relat�rio )
Faixa de valor : SPACE , 'X'
Pr�-requisitos:
A interface relat�rio / relat�rio existe no sistema .
(grupo de fun��es RSTI , mesa TRSTI )
Par�metro LAYOUT- REPREP = 'X'
(Veja tamb�m a documenta��o do par�metro
LAYOUT- REPREP de importa��o de par�metro
IS_LAYOUT )
'X ' = Se a interface de relat�rio / relat�rio � chamado, o valor deste campo � transmitido como um crit�rio de selec��o de linha da interface ramo seleccionado.
faixa de valor

omiss�o

Para os campos da tabela interna com refer�ncia a um campo definido no Dicion�rio de Dados , que � normalmente suficiente para fazer as seguintes especifica��es:
nome do campo
ref_tabname
Nota:

Todos os campos que n�o s�o explicitamente mencionados aqui s�o ou n�o relevantes neste contexto ou n�o s�o liberados !

Todas as outras informa��es s�o recuperados pela ALV do Dicion�rio de Dados.

Se voc� n�o especificar a posi��o da coluna relativa ( COL_POS ) , os campos est�o de sa�da na lista na ordem em que foram adicionados ao cat�logo de campos .

REF_FIELDNAME s� deve ser especificado se o nome do campo do campo de tabela interna n�o � id�ntico ao nome do campo do campo referenciado no Dicion�rio de Dados.

Regra de prioridade :
Especifica��es feitas no cat�logo de campos t�m prioridade sobre as especifica��es do Dicion�rio de Dados.
Para os campos de tabela interna sem refer�ncia ao Dicion�rio de Dados (campos do programa) , que � normalmente suficiente para fazer as seguintes especifica��es:
nome do campo
outputlen
tipo de dados (sem tipo de dados , o car�ter � o padr�o)
seltext_s
seltext_l
Nota:

Se voc� atribuir um elemento de dados de par�metro rollname , voc� pode , por exemplo, implementar uma ajuda F1 para os campos do programa.

*************************************************************************************************************************************************************

	*   IT_EXCLUDING                      =
 
*************************************************************************************************************************************************************

	*   IT_SPECIAL_GROUPS                 =

*************************************************************************************************************************************************************

	it_sort - Ordenar 
 
*************************************************************************************************************************************************************
 
	*   IT_FILTER                         =
 
*************************************************************************************************************************************************************
 
	*   IS_SEL_HIDE                       =
 
*************************************************************************************************************************************************************

	*   I_DEFAULT                         = 'X'
 
*************************************************************************************************************************************************************

	I_SAVE - salvar configura��o feita pelo usu�rio - Colocar X.
 
*************************************************************************************************************************************************************
 
	*   IS_VARIANT                        =
 
*************************************************************************************************************************************************************
 
*   IT_EVENTS                         =
 
*************************************************************************************************************************************************************
 
	IT_EVENT_EXIT

		Descri��o

		Esta tabela � usada para passar os c�digos de fun��o ALV padr�o para a qual o usu�rio deseja obter o controle antes e / ou ap�s a sua 
		execu��o por meio do evento callback USER_COMMAND .

		Veja tamb�m a documenta��o sobre a importa��o de par�metro I_CALLBACK_USER_COMMAND .

		Portanto, s� faz sentido para passar esta tabela se o aplicativo tamb�m quer responder � execu��o de fun��es padr�o , sob qualquer forma .

		Este poderia ser o caso, por exemplo, se as autoriza��es de uma fun��o de padr�o devem ser verificados ou se novos dados � para ser 
		seleccionado com base na variante visor actual.

		Nota: Fun��es 'Voltar (F3) " ", Exit ( F15 ) ' e ' Cancelar ( F12) " h� fun��es padr�o ALV , mas fun��es do sistema. Se a aplica��o quer 
		para responder a essas fun��es ( por exemplo, para executar um prompt antes de sair a lista de confirma��o) , estas fun��es devem ser 
		atribu�dos os c�digos de fun��es espec�ficas do aplicativo .

		Voc� deve preencher os campos da tabela da seguinte forma:

		ucomm - C�digo de fun��o padr�o que tamb�m deve ser transmitida por meio de evento de retorno de chamada USER_COMMAND .
		Exemplo:
		ucomm = ' & OL0 ' significa que o aplicativo tamb�m obt�m o controle para o c�digo de fun��o para definir a variante de exibi��o .
		antes
		'X' = O aplicativo obt�m o controle antes da ALV executa a fun��o .
		depois
		'X ' = O pedido recebe controlo ap�s a ALV executou a fun��o , mas antes de a lista � a sa�da.
		Exemplo:
		ucomm = ' & OL0 ' e depois = ' X'.
		O aplicativo obt�m o controle ap�s o usu�rio ter deixado a caixa de di�logo para definir a variante de exibi��o.
		Na rotina formul�rio correspondente para o processamento dos c�digos de fun��o comunicadas � ALV atrav�s do par�metro 
		I_CALLBACK_USER_COMMAND , o aplicativo pode agora usar a fun��o m�dulo REUSE_ALV_LIST_LAYOUT_INFO_GET para obter o cat�logo de campos que 
		podem ter sido modificados como resultado da intera��o do usu�rio e , em seguida, selecionar os dados para o campos de sa�da recentemente 
		adicionado na tabela de sa�da interno.
		Se, ap�s a sele��o, o aplicativo define o indicador = SELFIELD -refresh 'X' ( par�metro de refer�ncia da interface de rotina de forma 
		USER_COMMAND ), a lista � a sa�da novamente. O sistema exibe os campos de sa�da adicionados pelo usu�rio e os dados rec�m-selecionados .
		faixa de valor

		Default
 
*************************************************************************************************************************************************************

	*   IS_PRINT                          =
 
*************************************************************************************************************************************************************

	*   IS_REPREP_ID                      =
 
*************************************************************************************************************************************************************

	I_SCREEN_START_COLUMN             = 0
 
*************************************************************************************************************************************************************

	*   I_SCREEN_START_LINE               = 0
 
*************************************************************************************************************************************************************

	*   I_SCREEN_END_COLUMN               = 0
 
*************************************************************************************************************************************************************

	*   I_SCREEN_END_LINE                 = 0
 
*************************************************************************************************************************************************************

	*   I_HTML_HEIGHT_TOP                 = 0
 
*************************************************************************************************************************************************************

	*   I_HTML_HEIGHT_END                 = 0
 
*************************************************************************************************************************************************************

	*   IT_ALV_GRAPHICS                   =
 
*************************************************************************************************************************************************************
 
	*   IT_HYPERLINK                      =
 
*************************************************************************************************************************************************************
 
	*   IT_ADD_FIELDCAT                   =
 
*************************************************************************************************************************************************************
 
	*   IT_EXCEPT_QINFO                   =
 
*************************************************************************************************************************************************************
 
	*   IR_SALV_FULLSCREEN_ADAPTER        =
 
*************************************************************************************************************************************************************
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

* IMPORTING
 
*************************************************************************************************************************************************************
 
	*   E_EXIT_CAUSED_BY_CALLER           =
 
*************************************************************************************************************************************************************

	*   ES_EXIT_CAUSED_BY_USER            =
 
*************************************************************************************************************************************************************
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 

TABLES
 
*************************************************************************************************************************************************************
 
	t_outtab - Nome da tabela que contem os campos a serem impressos
 
*************************************************************************************************************************************************************
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 

EXCEPTIONS

*************************************************************************************************************************************************************

	PROGRAM_ERROR                     = 1
 
*************************************************************************************************************************************************************
 
	OTHERS                            = 2.
