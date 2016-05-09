Unimarka => ZSDR058



*----------------------------------------------------------------------*
* Declara��es para tabela dinamica
*----------------------------------------------------------------------*
* Essa tabela armazena o conte�do de todos os componentes (campos)
DATA: t_comp   TYPE cl_abap_structdescr=>component_table.

* Objeto utilizado para criar a estrutura din�mica
DATA: o_strtype  TYPE REF TO cl_abap_structdescr.

* Objeto utilizado para criar a tabek din�mica
DATA: o_tabtype  TYPE REF TO cl_abap_tabledescr.

* O nosso ponto de dados de refer�ncia
DATA: wa_data   TYPE REF TO data.

* �rea de trabalho para lidar com atributos e o nome de cada campo.
DATA: wa_comp      LIKE LINE OF t_comp.

* Vari�veis para construir o nome de cada campo
DATA: v_nome_campo   TYPE txt30.
DATA: v_numero_campo TYPE text10.

* Ponteiro para manipular tabela interna din�mica
FIELD-SYMBOLS: <t_tab> TYPE table.

* Ponteiro para manipular work �rea din�mica
FIELD-SYMBOLS: <wa_tab> TYPE any.

* Ponteiro para manipular campo
FIELD-SYMBOLS: <fs_campo> TYPE any.
