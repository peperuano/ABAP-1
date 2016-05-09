*Jo�o Dias => PEGAR DO SPOOL (TIPO OTF) ENVIAR VIA E-MAIL COMO ANEXO EM FORMATO PDF.


FUNCTION zdhb_send_email.
*"----------------------------------------------------------------------
*"*"Interface local:
*"  IMPORTING
*"     VALUE(EBELN) TYPE  EBELN OPTIONAL
*"----------------------------------------------------------------------

  DATA vl_sender_address TYPE soextreci1-receiver.

  CLEAR: t_nast[], t_nast.

  SELECT *
    INTO TABLE t_nast
  FROM nast
  WHERE
    kappl EQ 'EF' AND
    objky EQ ebeln AND
    kschl EQ 'ZNEU' AND
    spras EQ 'PT'.

  SORT t_nast BY erdat DESCENDING eruhr DESCENDING.
  READ TABLE t_nast INDEX 1.
  IF sy-subrc EQ 0.
    CLEAR: t_cmfp[], t_cmfp.
    SELECT *
      INTO TABLE t_cmfp
    FROM cmfp
    WHERE
      aplid EQ 'WFMC' AND
      nr EQ t_nast-cmfpnr AND
      msgnr EQ '320'.


    CLEAR: v_aux, v_spool, v_lifnr, v_adrnr, v_afnam, v_user, v_afnam, v_ekgrp.
    READ TABLE t_cmfp INDEX 1.
    v_aux = t_cmfp-msgv1.
    CONDENSE v_aux NO-GAPS.
    v_spool = v_aux.

    SELECT SINGLE lifnr ekgrp
      INTO (v_lifnr, v_ekgrp)
      FROM ekko
    WHERE
      ebeln EQ ebeln.

    IF sy-subrc EQ 0.
      SELECT SINGLE bkgrp
        INTO v_ekgrp
      FROM zdh_ekgrp
      WHERE
        bkgrp EQ v_ekgrp.
      IF sy-subrc NE 0.
        EXIT.
      ENDIF.

      SELECT SINGLE adrnr
        INTO v_adrnr
      FROM lfa1
      WHERE
        lifnr EQ v_lifnr.

      IF sy-subrc EQ 0.
        SELECT SINGLE afnam
          INTO v_afnam
        FROM ekpo
        WHERE
         ebeln EQ ebeln.
        IF sy-subrc EQ 0.
          SELECT SINGLE adr6~smtp_addr
            INTO v_user
          FROM usr21
            INNER JOIN adr6
               ON  usr21~addrnumber = adr6~addrnumber
               AND usr21~persnumber = adr6~persnumber
          WHERE
            bname EQ v_afnam.
        ENDIF.

        SELECT SINGLE smtp_addr
          INTO v_email_f
        FROM adr6
        WHERE
          addrnumber EQ v_adrnr.
      ENDIF.
    ENDIF.

    CALL FUNCTION 'CONVERT_OTFSPOOLJOB_2_PDF'
      EXPORTING
        src_spoolid              = v_spool
        no_dialog                = c_space
        dst_device               = 'ZPDF'
      IMPORTING
        pdf_bytecount            = v_size
      TABLES
        pdf                      = t_pdf
      EXCEPTIONS
        err_no_otf_spooljob      = 1
        err_no_spooljob          = 2
        err_no_permission        = 3
        err_conv_not_possible    = 4
        err_bad_dstdevice        = 5
        user_cancelled           = 6
        err_spoolerror           = 7
        err_temseerror           = 8
        err_btcjob_open_failed   = 9
        err_btcjob_submit_failed = 10
        err_btcjob_close_failed  = 11
        OTHERS                   = 12.

*    DATA: i_record    LIKE solisti1 OCCURS 0 WITH HEADER LINE.

    CLEAR: i_record, i_record[].
    CALL FUNCTION 'SX_TABLE_LINE_WIDTH_CHANGE'
      EXPORTING
        line_width_dst              = '255'
      TABLES
        content_in                  = t_pdf[]
        content_out                 = i_record[]
      EXCEPTIONS
        err_line_width_src_too_long = 1
        err_line_width_dst_too_long = 2
        err_conv_failed             = 3
        OTHERS                      = 4.


    CLEAR: i_objtxt[], i_objtxt.
* Obhjetos para anexar o arquivo para ser enviado por e-mail
    REFRESH: i_reclist,
    i_objtxt,
    i_objbin,
    i_objpack.
    CLEAR: wa_objhead, wa_doc_chng.
    i_objbin[] = i_record[].

    i_objtxt = 'Prezado Fornecedor,'.
    APPEND i_objtxt.
    i_objtxt = '<br/><br/>'.  APPEND i_objtxt.
    i_objtxt = 'Segue Pedido de Compras emitido pela Deere Hitachi M�quinas de Constru��o do Brasil S.A. conforme Or�amento / Proposta fechada.'.
    APPEND i_objtxt.
    i_objtxt = '<br/><br/>'.  APPEND i_objtxt.
    i_objtxt = '<b><u>IMPORTANTE, ATENTAR-SE AOS PONTOS A SEGUIR:</b></u>'.
    APPEND i_objtxt.
    i_objtxt = '<br/><br/>'.  APPEND i_objtxt.
    i_objtxt = '�	<b><u>Confirmar o recebimento deste e-mail.</b></u> Ser�o consideradas aceitas todas as condi��es descritas que n�o forem contestadas no prazo m�ximo de 24 (vinte e quatro) horas � contar da data de envio do mesmo.'.
    APPEND i_objtxt.
    i_objtxt = '<br/><br/>'.  APPEND i_objtxt.
    i_objtxt = '�	A utiliza��o do material ou servi�o adquirido ser� de acordo com o pedido anexo.'.
    APPEND i_objtxt.
    i_objtxt = '<br/><br/>'.  APPEND i_objtxt.


    i_objtxt = '<b><u>Entregas:</b></u>'.
    APPEND i_objtxt.
    i_objtxt = '<br/><br/>'.  APPEND i_objtxt.
    i_objtxt = '� <b><u>Hor�rio e recebimento de mercadorias:</b></u> De segunda � quinta-feira das 07:30 �s 16:00 hrs e de sexta-feira das 07:30 �s 15:00 hrs. <b><i>Exce��es dever�o ser alinhadas com anteced�ncia.</b></i>'.
    APPEND i_objtxt.
    i_objtxt = '<br/><br/>'.  APPEND i_objtxt.
    i_objtxt = '�	<b><u>Entregas:</b></u> Todas as entregas sem exce��o devem ser feitas pela Portaria de Recebimento (Entrada de Caminh�es).'.
    APPEND i_objtxt.

    i_objtxt = '<br/><br/>'.  APPEND i_objtxt.
    i_objtxt = '�	<b><u>Prazos:</b></u> Diverg�ncias quanto ao prazo informado no Or�amento X Pedido de Compras favor informar assim que receber o mesmo. Caso seja previsto atrasos, informar antecipadamente.'.
    APPEND i_objtxt.

    i_objtxt = '<br/><br/>'.  APPEND i_objtxt.
    i_objtxt = '�	<b><u>Fechamento fiscal:</b></u> n�o realizar entregas (materiais) e n�o faturar (servi�os) no �ltimo dia �til do m�s <font  color="red"> *(ATIVO dois (02) �ltimos dias �teis do m�s)</font>'.
    APPEND i_objtxt.
    i_objtxt = '<br/><br/>'.  APPEND i_objtxt.

    i_objtxt = '<b><u>Informa��es gerais:</b></u>'.
    APPEND i_objtxt.
    i_objtxt = '<br/><br/>'.  APPEND i_objtxt.
    i_objtxt = '�	<b><u>Diverg�ncias de NF(pre�o, imposto) vs Pedido de Compras:</b></u> Sujeito a recusa/devolu��o da NF e mercadoria ou emiss�o/envio de Nota de D�bito com o valor da diferen�a.'.
    APPEND i_objtxt.
    i_objtxt = '<br/><br/>'.  APPEND i_objtxt.
    i_objtxt = '�	O <b><u>n�mero do Pedido de Compras e os C�digos dos Materiais</b></u> (padr�o Deere-Hitachi) dever�o constar na NF, bem como todos os documentos referentes a ela. Sujeito a devolu��o/recusa da mercadoria/NF.'.
    APPEND i_objtxt.


    i_objtxt = '<br/><br/>'.  APPEND i_objtxt.
    i_objtxt = '� <b><u>Emitir a NF com o novo endere�o da Deere-Hitachi.</b></u> Sujeito a devolu��o/recusa da mercadoria/NF.'.
    APPEND i_objtxt.

    i_objtxt = '<br/><br/>'.  APPEND i_objtxt.
    i_objtxt = '� <b><u>Envio de NF e arquivo XML</b></u> para o e-mail: dhb_nfe@dhcmc.com'.
    APPEND i_objtxt.



    i_objtxt = '<br/><br/><br/>'.  APPEND i_objtxt.

    i_objtxt = '<table border=1>'.
    APPEND i_objtxt.

    i_objtxt = '<tr> <td> <font size=2> <b><u> LOCAL DE FATURAMENTO </font> </b></u> </td> </tr>'.
    APPEND i_objtxt.
    i_objtxt = '<tr> <td> <font size=2> Empresa: Deere-Hitachi M�quinas de Constru��o do Brasil </font> </td> </tr>'.
    APPEND i_objtxt.
    i_objtxt = '<tr> <td> <font size=2> Endere�o: Av Horst Frederico Jo�o Heer, 2985 � Distrito Euro Park Comercial </font> </td> </tr>'.
    APPEND i_objtxt.

    i_objtxt = '<tr> <td> <font size=2> CEP: 13348-758 - Cidade: Indaiatuba / SP </font></td> </tr>'.
    APPEND i_objtxt.

    i_objtxt = '<tr> <td> <font size=2> CNPJ: 03.982.513/0001-33                             IE: 353.124.462.114 </font></td> </tr>' .

    APPEND i_objtxt.
    i_objtxt = '</table>'.
    APPEND i_objtxt.


    CLEAR: v_destinatario.

**********************************************************************
    v_destinatario = v_email_f.

    DESCRIBE TABLE i_objtxt LINES v_lines_txt.
    READ TABLE i_objtxt INDEX v_lines_txt.
    wa_doc_chng-obj_name = 'RAM'.
    wa_doc_chng-expiry_dat = sy-datum + 10.
    wa_doc_chng-obj_descr = 'Pedido de Compra'.
    wa_doc_chng-sensitivty = 'F'.
    wa_doc_chng-doc_size = v_lines_txt * 255.

* Texto principal
    CLEAR i_objpack-transf_bin.
    i_objpack-head_start = 1.
    i_objpack-head_num = 0.
    i_objpack-body_start = 1.
    i_objpack-body_num = v_lines_txt.
    i_objpack-doc_type = 'HTML'.
    APPEND i_objpack.

* Anexa o PDF
    CLEAR: i_objpack.
    i_objpack-transf_bin = 'X'.
    i_objpack-head_start = 1.
    i_objpack-head_num = 0.
    i_objpack-body_start = 1.
    DESCRIBE TABLE i_objbin LINES v_lines_bin.
    READ TABLE i_objbin INDEX v_lines_bin.
    i_objpack-doc_size = v_lines_bin * 255 .
    i_objpack-body_num = v_lines_bin.
    i_objpack-doc_type = 'PDF'.
    i_objpack-obj_name = 'RAM'.
*    Nome do arquivo pdf.
    i_objpack-obj_descr = 'Pedido'.
    APPEND i_objpack.

    "Recebedores, pode ser somente um ou uma lista
    CLEAR i_reclist.
    i_reclist-receiver = v_destinatario.
    i_reclist-rec_type = 'U'.
    APPEND i_reclist.

    "Recebedores, pode ser somente um ou uma lista
    CLEAR i_reclist.
    v_destinatario = v_user.
    i_reclist-receiver = v_destinatario.
    i_reclist-rec_type = 'U'.
    APPEND i_reclist.


    CLEAR: i_reclist, i_objtxt, i_objbin, i_objpack.

    CLEAR: vl_sender_address.
    SELECT SINGLE low
      INTO vl_sender_address
      FROM tvarvc
      WHERE name = 'ZMM_SENDER_PEDIDO_COMPRA'.

    IF vl_sender_address IS NOT INITIAL.

      CALL FUNCTION 'SO_DOCUMENT_SEND_API1'
        EXPORTING
          document_data              = wa_doc_chng
          put_in_outbox              = 'X'
          sender_address             = vl_sender_address       "ENDERE�O DO DESTINARIO
          sender_address_type        = 'INT'                             " TIPO DE ENDERE�O INT = INTERNET ADDRESS   B = SAP USER
          commit_work                = 'X'
        TABLES
          packing_list               = i_objpack
          object_header              = wa_objhead
          contents_bin               = i_objbin
          contents_txt               = i_objtxt
          receivers                  = i_reclist
        EXCEPTIONS
          too_many_receivers         = 1
          document_not_sent          = 2
          document_type_not_exist    = 3
          operation_no_authorization = 4
          parameter_error            = 5
          x_error                    = 6
          enqueue_error              = 7
          OTHERS                     = 8.
    ELSE.
      CALL FUNCTION 'SO_NEW_DOCUMENT_ATT_SEND_API1'
        EXPORTING
          document_data              = wa_doc_chng
          put_in_outbox              = 'X'
          commit_work                = 'X'
        TABLES
          packing_list               = i_objpack
          object_header              = wa_objhead
          contents_bin               = i_objbin
          contents_txt               = i_objtxt
          receivers                  = i_reclist
        EXCEPTIONS
          too_many_receivers         = 1
          document_not_sent          = 2
          document_type_not_exist    = 3
          operation_no_authorization = 4
          parameter_error            = 5
          x_error                    = 6
          enqueue_error              = 7
          OTHERS                     = 8.

    ENDIF.

    SUBMIT rsconn01 AND RETURN.

    COMMIT WORK AND WAIT.
  ELSE.

  ENDIF.
ENDFUNCTION.