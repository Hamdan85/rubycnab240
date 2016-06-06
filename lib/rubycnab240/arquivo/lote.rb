class RubyCnab240::Arquivo::Lote < RubyCnab240::Arquivo
  require 'rubycnab240/arquivo/lotes/header'
  require 'rubycnab240/arquivo/lotes/segment'
  require 'rubycnab240/arquivo/lotes/trailer'

  attr_accessor :lot_header
  attr_accessor :lots
  attr_accessor :lot_trailer

  def initialize(fields = {})

    forma_de_lancamento = if fields[:forma_de_lancamento] == 'INTERNO'
                            '01'
                          else
                            '41'
                          end


    @lot_header = RubyCnab240::Arquivo::Lote::Header.new({
                                                         :codigo_do_banco_na_compensacao => fields[:codigo_do_banco_na_compensacao],
                                                         :lote_do_servico => '0',
                                                         :forma_de_lancamento => forma_de_lancamento,
                                                         :tipo_de_inscricao_da_empresa => @@tipo_de_inscricao_da_empresa,
                                                         :numero_de_inscricao_da_empresa => @@numero_de_inscricao_da_empresa,
                                                         :codigo_do_convenio_do_banco => @@codigo_do_convenio_do_banco,
                                                         :agencia_mantenedora_da_conta => @@agencia_mantenedora_da_conta,
                                                         :digito_verificador_da_agencia => @@digito_verificador_da_agencia,
                                                         :numero_da_conta_corrente => @@numero_da_conta_corrente,
                                                         :digito_verificador_da_conta => @@digito_verificador_da_conta,
                                                         :digito_verificador_da_agencia_e_conta => @@digito_verificador_da_agencia_e_conta,
                                                         :data_do_pagamento => @@data_dos_pagamentos,
                                                         :nome_da_empresa => @@nome_da_empresa,
                                                         :campos_opcionais_de_endereco => fields[:campos_opcionais_de_endereco]
                                                     })

    @lots = []

    @lot_trailer = RubyCnab240::Arquivo::Lote::Trailer.new({
                                                           :codigo_do_banco_na_compensacao => fields[:codigo_do_banco_na_compensacao],
                                                           :lote_do_servico => '0',
                                                           :tipo_de_registro => '5',
                                                           :qtd_registros_de_lote => '0',
                                                           :somatorio_dos_valores => '0'
                                                       })
  end

  def <<(s)
    s[:complemento_tipo_de_servico] = '1'
    s[:codigo_do_banco_na_compensacao] = '001'

     if self.lot_header.forma_de_lancamento == '01'
       #interno
       codigo_da_camara_centralizadora = '000'
       s[:outras_informacoes] = '                                        '
       s[:aviso_ao_favorecido] = ' '
     else
       #externo
       codigo_da_camara_centralizadora = '018'
       s[:outras_informacoes] = '01                                      '
       s[:aviso_ao_favorecido] = '0'
     end


    self.lots << RubyCnab240::Arquivo::Lote::Segment::A.new({
                                                        :codigo_do_banco_na_compensacao => s[:codigo_do_banco_na_compensacao],
                                                        :lote_do_servico => self.lot_header.lote_do_servico,
                                                        :tipo_de_registro => '3',
                                                        :numero_sequencial_de_registro_no_lote => (self.lots.size + 1).to_s,
                                                        :codigo_da_camara_centralizadora => codigo_da_camara_centralizadora,
                                                        :codigo_do_banco_favorecido => s[:codigo_do_banco_favorecido],
                                                        :agencia_mantenedora_da_conta_favorecida => s[:agencia_mantenedora_da_conta_favorecida],
                                                        :digito_verificador_da_agencia => s[:digito_verificador_da_agencia],
                                                        :numero_da_conta_corrente => s[:numero_da_conta_corrente],
                                                        :digito_verificador_da_conta => s[:digito_verificador_da_conta],
                                                        :digito_verificador_da_agencia_e_conta => s[:digito_verificador_da_agencia_e_conta],
                                                        :nome_do_favorecido => s[:nome_do_favorecido],
                                                        :numero_doc_atribuido_para_empresa => s[:numero_doc_atribuido_para_empresa],
                                                        :data_do_pagamento => @@data_dos_pagamentos,
                                                        :valor_do_pagamento => s[:valor_do_pagamento],
                                                        :outras_informacoes => s[:outras_informacoes],
                                                        :complemento_tipo_de_servico => s[:complemento_tipo_de_servico],
                                                        :complemento_finalidade_da_ted => s[:complemento_finalidade_da_ted],
                                                        :complemento_finalidade_de_pagamento => s[:complemento_finalidade_de_pagamento],
                                                        :aviso_ao_favorecido => s[:aviso_ao_favorecido]
                                                    })

    self.lots << RubyCnab240::Arquivo::Lote::Segment::B.new({
                                                        :codigo_do_banco_na_compensacao => s[:codigo_do_banco_na_compensacao],
                                                        :lote_do_servico => self.lot_header.lote_do_servico,
                                                        :tipo_de_registro => '3',
                                                        :numero_sequencial_de_registro_no_lote => (self.lots.size + 1).to_s,
                                                        :tipo_de_inscricao_do_favorecido => s[:tipo_de_inscricao_do_favorecido],
                                                        :numero_de_inscricao_do_favorecido => s[:numero_de_inscricao_do_favorecido],
                                                        :aviso_ao_favorecido => s[:aviso_ao_favorecido]
                                                    })

  end

  def to_string
    rubycnab240 = String.new

    qtd_registros_de_lote = self.lots.size + 2

    somatorio_dos_valores = self.lots.reject { |l| l.class == RubyCnab240::Arquivo::Lote::Segment::B }.map{|l| l.valor_do_pagamento.to_i }.inject(:+)

    self.lot_trailer.qtd_registros_de_lote = qtd_registros_de_lote.to_s[0..5].rjust(6, '0')
    self.lot_trailer.somatorio_dos_valores = somatorio_dos_valores.to_s[0..17].rjust(18, '0')

    rubycnab240 << self.lot_header.to_string + "\n"
    self.lots.each do |lot|
      rubycnab240 << lot.to_string + "\n"
    end
    rubycnab240 << self.lot_trailer.to_string
  end
end