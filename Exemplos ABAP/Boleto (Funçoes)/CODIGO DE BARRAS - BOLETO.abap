"Buscar dados da REGUH (Transa��o ZFI45 Unimarka - � Exemplo)

"Com a REGUH, buscar dados da REGUD, pela fun��o abaixo.

          CALL FUNCTION 'BOLETO_DATA'
            EXPORTING
              line_reguh = reguh
            TABLES
              itab_regup = tab_regup
            CHANGING
              line_regud = regud.


"O Codigo de barras est� no campo REGUD-TEXT8