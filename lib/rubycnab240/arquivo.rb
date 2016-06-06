class RubyCnab240::Arquivo
  require 'rubycnab240/arquivo/header'
  require 'rubycnab240/arquivo/lote'
  require 'rubycnab240/arquivo/trailer'

  attr_accessor :header
  attr_accessor :lot_header
  attr_accessor :segments
  attr_accessor :lot_trailer
  attr_accessor :trailer
  attr_accessor :data_dos_pagamentos

  @@tipo_de_inscricao_da_empresa = String.new
  @@numero_de_inscricao_da_empresa = String.new
  @@codigo_do_convenio_do_banco = String.new
  @@agencia_mantenedora_da_conta = String.new
  @@digito_verificador_da_agencia = String.new
  @@numero_da_conta_corrente = String.new
  @@digito_verificador_da_conta = String.new
  @@digito_verificador_da_agencia_e_conta = String.new
  @@nome_da_empresa = String.new
  @@data_dos_pagamentos = String.new

  def initialize(fields = {})
    fields[:tipo_de_registro] = '0'
    fields[:digito_verificador_da_agencia_e_conta] = '0'

    @@data_dos_pagamentos = fields[:data_dos_pagamentos] ? fields[:data_dos_pagamentos].strftime("%d%m%Y") : Date.today.strftime("%d%m%Y")

    @@tipo_de_inscricao_da_empresa = fields[:tipo_de_inscricao_da_empresa]
    @@numero_de_inscricao_da_empresa = fields[:numero_de_inscricao_da_empresa]
    @@codigo_do_convenio_do_banco = fields[:codigo_do_convenio_do_banco]
    @@agencia_mantenedora_da_conta = fields[:agencia_mantenedora_da_conta]
    @@digito_verificador_da_agencia = fields[:digito_verificador_da_agencia]
    @@numero_da_conta_corrente = fields[:numero_da_conta_corrente]
    @@digito_verificador_da_conta = fields[:digito_verificador_da_conta]
    @@digito_verificador_da_agencia_e_conta = fields[:digito_verificador_da_agencia_e_conta]
    @@nome_da_empresa = fields[:nome_da_empresa]

    @header = RubyCnab240::Arquivo::Header.new({
                                         :codigo_do_banco_na_compensacao => fields[:codigo_do_banco_na_compensacao],
                                         :lote_do_servico => '0',
                                         :tipo_de_registro => fields[:tipo_de_registro],
                                         :tipo_de_inscricao_da_empresa => @@tipo_de_inscricao_da_empresa,
                                         :numero_de_inscricao_da_empresa => @@numero_de_inscricao_da_empresa,
                                         :codigo_do_convenio_do_banco => @@codigo_do_convenio_do_banco,
                                         :agencia_mantenedora_da_conta => @@agencia_mantenedora_da_conta,
                                         :digito_verificador_da_agencia => @@digito_verificador_da_agencia,
                                         :numero_da_conta_corrente => @@numero_da_conta_corrente,
                                         :digito_verificador_da_conta => @@digito_verificador_da_conta,
                                         :digito_verificador_da_agencia_e_conta => @@digito_verificador_da_agencia_e_conta,
                                         :nome_da_empresa => @@nome_da_empresa,
                                         :nome_do_banco => fields[:nome_do_banco],
                                         :codigo_remessa_retorno => fields[:codigo_remessa_retorno],
                                         :numero_sequencial_de_arquivo => fields[:numero_sequencial_de_arquivo],
                                         :para_uso_reservado_da_empresa => fields[:para_uso_reservado_da_empresa]
                                     })



    @segments = []

    @trailer = RubyCnab240::Arquivo::Trailer.new({
                                           :codigo_do_banco_na_compensacao => fields[:codigo_do_banco_na_compensacao],
                                           :qtd_registros_de_lote => "0",
                                           :qtd_registros_do_arquivo => "0"
                                       })
  end

  def number_of_segments
    self.segments.size + 1
  end

  def <<(lote)
    numero_do_lote = (self.segments.size + 1).to_s[0..3].rjust(4, '0')

    lote.lot_header.lote_do_servico = numero_do_lote
    lote.lot_trailer.lote_do_servico = numero_do_lote

    self.segments << lote unless lote.class.to_s != "RubyCnab240::Arquivo::Lote"
  end

  def to_string



    rubycnab240 = String.new

    qtd_registros_de_lote = self.segments.size
    qtd_registros_do_arquivo = 0

    self.segments.each do |segment|
      segment.lots.each do |lot|
        qtd_registros_do_arquivo += 1
        lot.lote_do_servico = segment.lot_header.lote_do_servico
        lot.data_do_pagamento = @@data_dos_pagamentos unless lot.class.to_s == "RubyCnab240::Arquivo::Lote::Segment::B"
      end
    end

    qtd_registros_do_arquivo = qtd_registros_do_arquivo + (2 * self.segments.size) + 2

    self.trailer.qtd_registros_de_lote = qtd_registros_de_lote.to_s[0..5].rjust(6, '0')
    self.trailer.qtd_registros_do_arquivo = qtd_registros_do_arquivo.to_s[0..5].rjust(6, '0')

    rubycnab240 << self.header.to_string + "\n"
    self.segments.each do |lot|
      rubycnab240 << lot.to_string + "\n"
    end
    rubycnab240 << self.trailer.to_string + "\n"
  end

  def save_to_file(file)
    string = self.to_string

    File.open(file, 'w') { |file| file.write(string) }
  end
end