class RubyCnab240::Arquivo::Trailer < RubyCnab240::Arquivo
  attr_accessor :codigo_do_banco_na_compensacao
  attr_accessor :qtd_registros_de_lote
  attr_accessor :qtd_registros_do_arquivo

  attr_reader :lote_do_servico
  attr_reader :tipo_de_registro
  attr_reader :uso_exclusivo_febraban
  attr_reader :qtd_de_contas_para_conc
  attr_reader :uso_exclusivo_febraban2

  def initialize(fields = {})

    fields[:qtd_registros_de_lote] = '1'

    @codigo_do_banco_na_compensacao = fields[:codigo_do_banco_na_compensacao].to_s[0..2].rjust(3, '0') #default: 001
    @lote_do_servico = '9999'
    @tipo_de_registro = '9'
    @uso_exclusivo_febraban = ' ' * 9
    @qtd_registros_de_lote = fields[:qtd_registros_de_lote].to_s[0..5].rjust(6, '0')
    @qtd_registros_do_arquivo = fields[:qtd_registros_do_arquivo].to_s[0..5].rjust(6, '0')
    @qtd_de_contas_para_conc = ' ' * 6
    @uso_exclusivo_febraban2 = ' ' * 205
  end

  def to_string
    trailer = String.new
    trailer << self.codigo_do_banco_na_compensacao
    trailer << self.lote_do_servico
    trailer << self.tipo_de_registro
    trailer << self.uso_exclusivo_febraban
    trailer << self.qtd_registros_de_lote
    trailer << self.qtd_registros_do_arquivo
    trailer << self.qtd_de_contas_para_conc
    trailer << self.uso_exclusivo_febraban2
  end
end