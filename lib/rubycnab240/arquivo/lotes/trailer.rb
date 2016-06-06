class RubyCnab240::Arquivo::Lote::Trailer < RubyCnab240::Arquivo::Lote
  attr_accessor :codigo_do_banco_na_compensacao
  attr_accessor :lote_do_servico
  attr_accessor :qtd_registros_de_lote
  attr_accessor :somatorio_dos_valores

  attr_reader :tipo_de_registro
  attr_reader :uso_exclusivo_febraban
  attr_reader :somatorio_qtd_de_moedas
  attr_reader :numero_de_aviso_debito
  attr_reader :uso_exclusivo_febraban2
  attr_reader :codigo_das_ocorrencias_para_retorno


  def initialize(fields = {})

    @codigo_do_banco_na_compensacao = fields[:codigo_do_banco_na_compensacao].to_s[0..2].rjust(3, '0') #default: 001
    @lote_do_servico = fields[:lote_do_servico].to_s[0..3].rjust(4, '0')
    @tipo_de_registro = fields[:tipo_de_registro].to_s[0..0].rjust(1, '0')
    @uso_exclusivo_febraban = ' ' * 9
    @qtd_registros_de_lote = fields[:qtd_registros_de_lote].to_s[0..5].rjust(6, '0')
    @somatorio_dos_valores = fields[:somatorio_dos_valores].to_s[0..17].rjust(18, '0')
    @somatorio_qtd_de_moedas = ' ' * 18
    @numero_de_aviso_debito = ' ' * 6
    @uso_exclusivo_febraban2 = ' ' * 165
    @codigo_das_ocorrencias_para_retorno = ' ' * 10
  end

  def to_string
    trailer = String.new

    trailer << self.codigo_do_banco_na_compensacao
    trailer << self.lote_do_servico
    trailer << self.tipo_de_registro
    trailer << self.uso_exclusivo_febraban
    trailer << self.qtd_registros_de_lote
    trailer << self.somatorio_dos_valores
    trailer << self.somatorio_qtd_de_moedas
    trailer << self.numero_de_aviso_debito
    trailer << self.uso_exclusivo_febraban2
    trailer << self.codigo_das_ocorrencias_para_retorno
  end
end