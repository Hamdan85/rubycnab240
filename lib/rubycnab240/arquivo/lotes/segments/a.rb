class RubyCnab240::Arquivo::Lote::Segment::A < RubyCnab240::Arquivo::Lote::Segment
  attr_accessor :codigo_do_banco_na_compensacao
  attr_accessor :lote_do_servico
  attr_accessor :tipo_de_registro
  attr_accessor :numero_sequencial_de_registro_no_lote
  attr_accessor :codigo_segmento_do_registro_detalhe
  attr_accessor :codigo_da_instrucao_para_movimento
  attr_accessor :codigo_da_camara_centralizadora
  attr_accessor :codigo_do_banco_favorecido
  attr_accessor :agencia_mantenedora_da_conta_favorecida
  attr_accessor :digito_verificador_da_agencia
  attr_accessor :numero_da_conta_corrente
  attr_accessor :digito_verificador_da_conta
  attr_accessor :digito_verificador_da_agencia_e_conta
  attr_accessor :nome_do_favorecido
  attr_accessor :numero_doc_atribuido_para_empresa
  attr_accessor :data_do_pagamento
  attr_accessor :quantidade_da_moeda
  attr_accessor :valor_do_pagamento
  attr_accessor :outras_informacoes
  attr_accessor :complemento_tipo_de_servico
  attr_accessor :complemento_finalidade_da_ted
  attr_accessor :complemento_finalidade_de_pagamento
  attr_accessor :aviso_ao_favorecido


  attr_reader :tipo_de_movimento
  attr_reader :verificacao_retorno
  attr_reader :tipo_da_moeda
  attr_reader :dec_quantidade_da_moeda
  attr_reader :numero_do_documento_atribuido_pelo_banco
  attr_reader :data_real_da_efetivacao_do_pagamento
  attr_reader :valor_real_da_efetivacao_do_pagamento
  attr_reader :dec_valor_real_da_efetivacao_do_pagamento
  attr_reader :uso_exclusivo_febraban
  attr_reader :codigo_das_ocorrencias_para_retorno

  def initialize(fields = {})
    agencia = fields[:agencia_mantenedora_da_conta_favorecida].to_s[0..4].rjust(5, '0') + fields[:digito_verificador_da_agencia].to_s[0..0].upcase.rjust(1, ' ')
    conta   = fields[:numero_da_conta_corrente].to_s[0..11].rjust(12, '0') + fields[:digito_verificador_da_conta].to_s[0..0].upcase.rjust(1, ' ')

    @codigo_do_banco_na_compensacao = fields[:codigo_do_banco_na_compensacao].to_s[0..2].rjust(3, '0') #default: 001
    @lote_do_servico = fields[:lote_do_servico].to_s[0..3].rjust(4, '0')
    @tipo_de_registro = fields[:tipo_de_registro].to_s[0..0].rjust(1, '0')
    @numero_sequencial_de_registro_no_lote = fields[:numero_sequencial_de_registro_no_lote].to_s[0..4].rjust(5, '0')
    @codigo_segmento_do_registro_detalhe = fields[:codigo_segmento_do_registro_detalhe] = 'A'
    @tipo_de_movimento = fields[:tipo_de_movimento] = '0' #“0” para inclusão de pagamento ou  “9” para exclusão. O pagamento só poderá ser excluido, quando o mesmo já estiver sendo visualizado no Gerenciador Financeiro.
    @codigo_da_instrucao_para_movimento = fields[:codigo_da_instrucao_para_movimento] = '00' #“00” para inclusão de pagamento ou “99” para exclusão.
    @codigo_da_camara_centralizadora = fields[:codigo_da_camara_centralizadora].to_s[0..2].rjust(3, '0') #Quando de lançamento no Header do Lote for igual a: '03' (DOC/TED) este campo deverá ser preenchido com '700' para DOC (valor até R$ 4.999,99) ou preencher com '018' para TED (valor igual ou acima de 5 mil reais). Quando a forma de lançamento no Header do Lote for igual a: '41' (TED Outra Titularidade) ou '43'  (TED Mesma Titularidade), este campo deverá ser preenchido com '018'. Para crédito no Banco do Brasil informar “000” (zeros).
    @codigo_do_banco_favorecido = fields[:codigo_do_banco_favorecido].to_s[0..2].rjust(3, '0')
    @agencia_mantenedora_da_conta_favorecida = agencia[0..-2]
    @digito_verificador_da_agencia = agencia[-1]
    @numero_da_conta_corrente = conta[0..-2]
    @digito_verificador_da_conta = conta[-1]
    @digito_verificador_da_agencia_e_conta = fields[:digito_verificador_da_agencia_e_conta].to_s[0..0].upcase.rjust(1, ' ') #As contas do Banco do Brasil não possuem o segundo dígito, nesse caso informar 'branco' (espaço). Para favorecidos de outros bancos que possuem contas com dois dígitos verificadores (DV), preencher este campo com o segundo dígito verificador.
    @nome_do_favorecido = fields[:nome_do_favorecido].to_s[0..29].upcase.ljust(30, ' ')
    @verificacao_retorno = '0' * 11
    @numero_doc_atribuido_para_empresa = fields[:numero_doc_atribuido_para_empresa].to_s[0..8].upcase.rjust(9, '0') #No caso de pagamento de salário, os número colocados nas posições 74 a 79 aparecerão como número do documento no extrato do favorecido, e os números das posições 80 a 85, serão utilizadas como número do documento no extrato do pagador. Obs.: Como os lançamentos ocorridos na conta do pagador são aglutinados num mesmo lote as posições 80 a 85 de todos os detalhes devem ser iguais, caso contrário será considerado apenas o número constante no primeiro registro detalhe de cada lote. As posições 86 a 93 não são tratadas pelo sistema. As informações impostas nessa posição voltarão iguais no arquivo retorno.
    @data_do_pagamento = fields[:data_do_pagamento].to_s[0..7].rjust(8, ' ')
    @tipo_da_moeda = fields[:tipo_da_moeda] = 'BRL'
    @quantidade_da_moeda = fields[:quantidade_da_moeda].to_s[0..9].rjust(10, '0') #Preencher com zeros quando a moeda for Real, no campo 18.3A
    @dec_quantidade_da_moeda = '00000'
    @valor_do_pagamento = fields[:valor_do_pagamento].to_s[0..14].upcase.rjust(15, '0')
    @numero_do_documento_atribuido_pelo_banco = ' ' * 20
    @data_real_da_efetivacao_do_pagamento = '0' * 8
    @valor_real_da_efetivacao_do_pagamento = '0' * 13
    @dec_valor_real_da_efetivacao_do_pagamento = '0' * 2
    @outras_informacoes = fields[:outras_informacoes].to_s[0..39].upcase.ljust(40, ' ')  #Para Modalidade de Ordem de Pagamento ('10' nas posições 12 e 13 do Header de Lote), poderá ser informado até dois prepostos. Neste caso, informar na posição 178 a 188 o CPF do 1º preposto e na posição 189 a 199 o CPF do 2º preposto e na posição 200 a 217 informar ZEROS. Caso não haja prepostos, preencher os campos com ZEROS.
    @complemento_tipo_de_servico = fields[:complemento_tipo_de_servico].to_s[0..1].ljust(2, ' ') #Corresponde a Finalidade do DOC. Será repassado para o Banco favorecido conforme informado, sem tratamento.
    @complemento_finalidade_da_ted = fields[:complemento_finalidade_da_ted].to_s[0..4].ljust(5, ' ')
    @complemento_finalidade_de_pagamento = fields[:complemento_finalidade_de_pagamento].to_s[0..1].ljust(2, ' ')
    @uso_exclusivo_febraban = '   '
    @aviso_ao_favorecido = ' ' #O ou 5 – o código 5 (com aviso) somente será tratado caso tenha sido negociado com a agência e conste no cadastramento do serviço a emissão de aviso.
    @codigo_das_ocorrencias_para_retorno = fields[:codigo_das_ocorrencias_para_retorno] = '          '
  end

  def to_string
    segment = String.new

    segment << self.codigo_do_banco_na_compensacao
    segment << self.lote_do_servico
    segment << self.tipo_de_registro
    segment << self.numero_sequencial_de_registro_no_lote
    segment << self.codigo_segmento_do_registro_detalhe
    segment << self.tipo_de_movimento
    segment << self.codigo_da_instrucao_para_movimento
    segment << self.codigo_da_camara_centralizadora
    segment << self.codigo_do_banco_favorecido
    segment << self.agencia_mantenedora_da_conta_favorecida
    segment << self.digito_verificador_da_agencia
    segment << self.numero_da_conta_corrente
    segment << self.digito_verificador_da_conta
    segment << self.digito_verificador_da_agencia_e_conta
    segment << self.nome_do_favorecido
    segment << self.verificacao_retorno
    segment << self.numero_doc_atribuido_para_empresa
    segment << self.data_do_pagamento
    segment << self.tipo_da_moeda
    segment << self.quantidade_da_moeda
    segment << self.dec_quantidade_da_moeda
    segment << self.valor_do_pagamento
    segment << self.numero_do_documento_atribuido_pelo_banco
    segment << self.data_real_da_efetivacao_do_pagamento
    segment << self.valor_real_da_efetivacao_do_pagamento
    segment << self.dec_valor_real_da_efetivacao_do_pagamento
    segment << self.outras_informacoes
    segment << self.complemento_tipo_de_servico
    segment << self.complemento_finalidade_da_ted
    segment << self.complemento_finalidade_de_pagamento
    segment << self.uso_exclusivo_febraban
    segment << self.aviso_ao_favorecido
    segment << self.codigo_das_ocorrencias_para_retorno

  end
end